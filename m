Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265140AbTAILUL>; Thu, 9 Jan 2003 06:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265236AbTAILUL>; Thu, 9 Jan 2003 06:20:11 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:14756 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S265140AbTAILUJ> convert rfc822-to-8bit; Thu, 9 Jan 2003 06:20:09 -0500
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [BENCHMARK] tiobench 2.5.55 performance
Date: Thu, 9 Jan 2003 16:58:39 +0530
Message-ID: <94F20261551DC141B6B559DC49108672044CB5@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] tiobench 2.5.55 performance
Thread-Index: AcK30kEoc4bfIN1lRHe+ZlsINqM2QQ==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Jan 2003 11:28:38.0999 (UTC) FILETIME=[41842670:01C2B7D2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Here are the results of comparison of kernel 2.5.55 and 2.5.54 
on TIObench. key findings are listed in the table. Values in the 
table indicate approximate percentage change with respect to previous result. 
Please see the mail in full window to see the formatted results.


-------------------------------------------------------------
test					2.5.55 (as compared to
					2.5.54) APPROXIMATE % change
-------------------------------------------------------------
rate (megabytes per second)	no much change
CPU % utilization			15% decrease
Average Latency			15% decrease
Maximum latency			less than 10 % increase 
CPU efficiency			10% increase
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
2.5.55                        252   4096   10    8.45 4.920%    12.947     1304.87   0.00000  0.00000   172

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.55                        252   4096   10    0.54 1.075%   200.009      925.97   0.00000  0.00000    50

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.55                        252   4096   10   19.42 28.69%     3.390    18832.14   0.06250  0.00000    68

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.55                        252   4096   10    0.78 0.949%     1.536     1792.09   0.00000  0.00000    82

Aniruddha Marathe
WIPRO Technologies, India
aniruddha.marathe@wipro.com
+91-80-5502001 to 2008 extn 5092 
