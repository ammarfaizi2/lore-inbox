Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262812AbSLZJE6>; Thu, 26 Dec 2002 04:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262808AbSLZJDw>; Thu, 26 Dec 2002 04:03:52 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:26810 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S262807AbSLZJDm> convert rfc822-to-8bit; Thu, 26 Dec 2002 04:03:42 -0500
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [BENCHMARK] TIObench results for 5.53-mm1
Date: Thu, 26 Dec 2002 10:55:18 +0530
Message-ID: <94F20261551DC141B6B559DC4910867204425E@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] TIObench results for 5.53-mm1
Thread-Index: AcKsny0nBY5zYrmfQB+MBM4Opvha0g==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Dec 2002 05:25:18.0455 (UTC) FILETIME=[2D98A070:01C2AC9F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Here are the results of comparison of kernel 2.5.53 and 2.5.52. 
on TIObench. key findings are listed in the table. Values in the table indicate approximate percentage change with respect to previous result. Please see the mail in full window to see the formatted results.


-------------------------------------------------------------
test					2.5.53 with mm1 (as compared to
					2.5.53) APPRXIMATE % change
-------------------------------------------------------------
rate (megabytes per second)	less than 5% decrease
CPU % utilization			almost no change
Average Latency			10% increase
Maximum latency			5% increase 
CPU efficiency			5% decrease
-------------------------------------------------------------

Here are the complete results.
***************************************************************
			TIObench
			kernel 2.5.53-mm1
***************************************************************
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
2.5.53                        252   4096   10    8.65 5.570%    12.661     1436.10   0.00000  0.00000   155

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.53                        252   4096   10    0.51 0.945%   214.733     1728.76   0.00000  0.00000    54

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.53                        252   4096   10   19.76 35.57%     3.560    14057.64   0.05937  0.00000    56

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.53                        252   4096   10    0.79 1.123%     9.356     7500.90   0.10000  0.00000    70

Aniruddha Marathe
WIPRO Technologies, India
aniruddha.marathe@wipro.com
+91-80-5502001 to 2008 extn 5092 
