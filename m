Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262808AbSLaJhK>; Tue, 31 Dec 2002 04:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262812AbSLaJhK>; Tue, 31 Dec 2002 04:37:10 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:21665 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S262808AbSLaJhJ> convert rfc822-to-8bit; Tue, 31 Dec 2002 04:37:09 -0500
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [BENCHMARK] 5.53 - mm2 TIObench results.
Date: Tue, 31 Dec 2002 15:13:51 +0530
Message-ID: <94F20261551DC141B6B559DC491086720445B8@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] 5.53 - mm2 TIObench results.
Thread-Index: AcKwsR+O4MO7t60zRsKPAWJ8b+0G/g==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 31 Dec 2002 09:45:16.0871 (UTC) FILETIME=[530AC570:01C2B0B1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Here are the results of comparison of kernel 2.5.53-mm2 and 2.5.53-mm1. 
on TIObench. key findings are listed in the table. Values in the table indicate approximate percentage change with respect to previous result. Please see the mail in full window to see the formatted results.


-------------------------------------------------------------
test					2.5.53 with mm2 (as compared to
					2.5.53-mm1) APPRXIMATE % change
-------------------------------------------------------------
rate (megabytes per second)	7to 8% decrease
CPU % utilization			apprx 10 % decrease
Average Latency			15% increase
Maximum latency			10% increase 
CPU efficiency			10% decrease
-------------------------------------------------------------

Here are the complete results.
***************************************************************
			TIObench
			kernel 2.5.53-mm2
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
2.5.53                        252   4096   10    8.27 6.104%    13.685     1395.01   0.00000  0.00000   136

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.53                        252   4096   10    0.42 0.773%   260.404     1529.97   0.00000  0.00000    54

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.53                        252   4096   10   16.58 32.85%     4.373    17555.17   0.05469  0.00000    50

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.53                        252   4096   10    0.76 1.148%     2.491     1969.71   0.00000  0.00000    66
