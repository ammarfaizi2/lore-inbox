Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262796AbSLZJDd>; Thu, 26 Dec 2002 04:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262806AbSLZJDd>; Thu, 26 Dec 2002 04:03:33 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:21434 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S262796AbSLZJDb> convert rfc822-to-8bit; Thu, 26 Dec 2002 04:03:31 -0500
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [BENCHMARK] TIObench results for kernel 2.5.53, latency reduces
Date: Thu, 26 Dec 2002 10:19:35 +0530
Message-ID: <94F20261551DC141B6B559DC49108672044248@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] TIObench results for kernel 2.5.53, latency reduces
Thread-Index: AcKsmjABXIY96/V1QHmxJGjDOCrbvA==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Dec 2002 04:49:36.0037 (UTC) FILETIME=[309D9550:01C2AC9A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Here are the results of comparison of kernel 2.5.53 and 2.5.52. 
on TIObench. key findings are listed in the table. Values in the table indicate approximate percentage change with respect to previous result. Please see the mail in full window to see the formatted results.


-------------------------------------------------------------
test					2.5.53 (as compared to
					2.5.52) APPRXIMATE % change
-------------------------------------------------------------
rate (megabytes per second)	10% increase
CPU % utilization			10% increase
Average Latency			15% decrease
Maximum latency			20+ % decrease 
CPU efficiency			less than 5% increase
-------------------------------------------------------------

Here are the complete results.
***************************************************************
			TIObench
			kernel 2.5.53
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
2.5.53                        252   4096   10    9.79 5.844%    10.318      849.54   0.00000  0.00000   168

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.53                        252   4096   10    0.53 0.747%   199.206      829.67   0.00000  0.00000    71

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.53                        252   4096   10   18.47 34.87%     3.460    23116.35   0.05312  0.00000    53

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.53                        252   4096   10    0.80 1.154%     1.692     2037.52   0.00000  0.00000    69

Aniruddha Marathe
WIPRO Technologies, India
aniruddha.marathe@wipro.com
+91-80-5502001 to 2008 extn 5092 
