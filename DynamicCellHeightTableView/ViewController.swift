//
//  ViewController.swift
//  DynamicCellHeightTableView
//
//  Created by Yuki Sumida on 2017/06/13.
//  Copyright © 2017年 Yuki Sumida. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var table: UITableView!

    var rows:[[String]] = [
        [
            "hogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehoge",
            "fugafugafugafugafugafugafugafugafugafugafugafuga",
            "piyo"
        ],
        [
            "hoge",
            "fuga",
            "piyo"
        ]
    ]
    var rowsIndex: Int = 0
    var cellHeights: [IndexPath : CGFloat] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        table.dataSource = self
        table.delegate = self

        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        table.estimatedRowHeight = 1000
        table.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func reloadButton(_ sender: Any) {
        rowsIndex = (rowsIndex + 1) % 2
        table.reloadData()
    }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.rows.count * 1000
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.numberOfLines = 0
        let text = "\(indexPath.row) \(self.rows[rowsIndex][indexPath.row % rows[rowsIndex].count])"
        cell.textLabel?.text = text
        return cell
    }
    
    // この2つのメソッドがポイント
    // リロードでセルの高さが大きく変わってもスクロール位置が飛ばない
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeights[indexPath] = cell.frame.size.height
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let height = cellHeights[indexPath] else { return 100.0 }
        return height
    }
}
