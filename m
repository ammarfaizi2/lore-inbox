Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267348AbTBUKdl>; Fri, 21 Feb 2003 05:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267353AbTBUKdk>; Fri, 21 Feb 2003 05:33:40 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:254 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S267348AbTBUKdj> convert rfc822-to-8bit; Fri, 21 Feb 2003 05:33:39 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Subject: [BENCHMARK] TIObench 2.5.60 performance
Date: Fri, 21 Feb 2003 16:13:32 +0530
Message-ID: <94F20261551DC141B6B559DC4910867217CCBE@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] TIObench 2.5.60 performance
Thread-Index: AcLTRCTgdbHq/5bATjGW7KpcxVtR2QGUUrzA
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Feb 2003 10:43:32.0529 (UTC) FILETIME=[1418DA10:01C2D996]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is TIObench performance of 2.5.62. Comparison of 2.5.62 and 2.5.60 is given below.



-----------------------------------------------------------------------------------------------------------------
test					2.5.62 (as compared to
					2.5.60) APPROXIMATE % change
----------------------------------------------------------------------------------------------------------------
rate (megabytes per second)		less than 5% increase
CPU % utilization			less than 5% increase
Average Latency			5 % decrease
Maximum latency			5-10 % increase
CPU efficiency				less than 5% increase
-----------------------------------------------------------------------------------------------------------------


************************************************************
		TIObench for kernel 2.5.62
************************************************************
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
2.5.62                        252   4096   10    7.93 4.271%    12.438     2841.36   0.00000  0.00000   186

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.62                        252   4096   10    0.47 0.552%   213.629     1301.68   0.00000  0.00000    84

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.62                        252   4096   10   12.39 21.14%     6.214    37150.05   0.10157  0.00782    59

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.62                        252   4096   10    0.73 0.891%     0.762     1761.34   0.00000  0.00000    81
No size specified, using 252 MB

Aniruddha Marathe
WIPRO Technologies, India.
