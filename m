Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267905AbTAMFTk>; Mon, 13 Jan 2003 00:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267904AbTAMFTk>; Mon, 13 Jan 2003 00:19:40 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:61892 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S267905AbTAMFTf> convert rfc822-to-8bit; Mon, 13 Jan 2003 00:19:35 -0500
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [BENCHMARK] TIObench results for 2.5.56
Date: Mon, 13 Jan 2003 10:58:11 +0530
Message-ID: <94F20261551DC141B6B559DC49108672044E25@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] TIObench results for 2.5.56
Thread-Index: AcK6xI+aQPciKKIZSAazD2GbKZg7iQ==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 13 Jan 2003 05:28:11.0717 (UTC) FILETIME=[904DCF50:01C2BAC4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the results of comparison of kernel 2.5.56 and 2.5.55 
on TIObench. key findings are listed in the table. Values in the 
table indicate approximate percentage change with respect to previous result. 
Please see the mail in full window to see the formatted results.


-------------------------------------------------------------
test					2.5.56 (as compared to
					2.5.55) APPROXIMATE % change
-------------------------------------------------------------
rate (megabytes per second)	no much change
CPU % utilization			less than 5% change
Average Latency			less than 5% decrease
Maximum latency			less than 5% increase 
CPU efficiency			5-10% decrease
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
2.5.56                        252   4096   10    9.42 5.755%    10.404     1371.29   0.00000  0.00000   164

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.56                        252   4096   10    0.53 0.871%   195.144      756.86   0.00000  0.00000    60

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.56                        252   4096   10   17.81 29.78%     3.704    23828.73   0.06562  0.00000    60

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.56                        252   4096   10    0.78 1.015%     1.188     1933.62   0.00000  0.00000    77

Aniruddha Marathe
WIPRO Technologies, India
aniruddha.marathe@wipro.com
+91-80-5502001 to 2008 extn 5092 
