Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267476AbTACJDN>; Fri, 3 Jan 2003 04:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267478AbTACJDN>; Fri, 3 Jan 2003 04:03:13 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:4843 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S267476AbTACJDH> convert rfc822-to-8bit; Fri, 3 Jan 2003 04:03:07 -0500
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [BENCHMARK] TIObench 2.5.54 mm2
Date: Fri, 3 Jan 2003 14:41:25 +0530
Message-ID: <94F20261551DC141B6B559DC49108672044922@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] TIObench 2.5.54 mm2
Thread-Index: AcKzCBbp8tKA/b9hT8Kd5e9LJuHQeA==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 03 Jan 2003 09:11:25.0579 (UTC) FILETIME=[178975B0:01C2B308]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Here are the results of comparison of kernel 2.5.54mm2 and 2.5.54. 
on TIObench. key findings are listed in the table. 
Values in the table indicate approximate percentage change with 
respect to previous result. Please see the mail in full window to see 
the formatted results.

-------------------------------------------------------------
test					2.5.54mm2 (as compared to
					2.5.54) APPROXIMATE % change
-------------------------------------------------------------
rate (megabytes per second)	15% increase
CPU % utilization			almost no change
Average Latency			15 % decrease
Maximum latency			around 10% increase 
CPU efficiency			10% increase
-------------------------------------------------------------

Full results
****************************************************************
			2.5.54 mm2
****************************************************************

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
2.5.54                        252   4096   10    8.63 5.345%    12.366     1410.18   0.00000  0.00000   161

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.54                        252   4096   10    0.52 0.951%   202.232     1218.11   0.00000  0.00000    54

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.54                        252   4096   10   19.36 39.17%     3.193    17212.21   0.05312  0.00000    49

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.54                        252   4096   10    0.79 0.958%     1.478     1684.34   0.00000  0.00000    82

Aniruddha Marathe
WIPRO Technologies, India
aniruddha.marathe@wipro.com
+91-80-5502001 to 2008 extn 5092 

