Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261370AbTATGLI>; Mon, 20 Jan 2003 01:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261371AbTATGLI>; Mon, 20 Jan 2003 01:11:08 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:16564 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S261370AbTATGLG> convert rfc822-to-8bit; Mon, 20 Jan 2003 01:11:06 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [BENCHMARK] TIObench performance of 2.5.59
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Date: Mon, 20 Jan 2003 11:49:56 +0530
Message-ID: <94F20261551DC141B6B559DC491086720AE9DD@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] TIObench performance of 2.5.59
Thread-Index: AcLAS/Nw9W42oBQ8RISQiFGiXB5MKQ==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 20 Jan 2003 06:19:56.0700 (UTC) FILETIME=[F3E8DDC0:01C2C04B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the results of comparison of kernel 2.5.59 and 2.5.57 
on TIObench. key findings are listed in the table. Values in the 
table indicate approximate percentage change with respect to previous result. 
Please see the mail in full window to see the formatted results.


-------------------------------------------------------------
test					2.5.59 (as compared to
					2.5.57) APPROXIMATE % change
-------------------------------------------------------------
rate (megabytes per second)	20% decrease
CPU % utilization			around 10% decrease
Average Latency			less than 15% increase
Maximum latency			less than 15% increase 
CPU efficiency			5-10% increase
-------------------------------------------------------------

No size specified, using 252 MB

Unit information
================
File size = megabytes
Blk Size  = bytes
Rate      = megabytes per second
CPU%      = percentage of CPU used during the test
Latency   = milliseconds
Lat%      = percent of requests that took longer than X seconds
CPU Eff   = Rate divided by CPU% - throughput per cpu load

Sequential Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.59                        252   4096   10    7.84 4.253%    12.545     1919.32   0.00000  0.00000   184

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.59                        252   4096   10    0.43 0.668%   234.379     1247.08   0.00000  0.00000    64

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.59                        252   4096   10   11.82 20.81%     5.935    45097.07   0.06406  0.01875    57

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.59                        252   4096   10    0.68 0.839%     1.558     2188.15   0.00000  0.00000    81

Aniruddha Marathe
WIPRO Technologies, India
