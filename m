Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267405AbTACFyI>; Fri, 3 Jan 2003 00:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267408AbTACFyI>; Fri, 3 Jan 2003 00:54:08 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:16551 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S267405AbTACFyF> convert rfc822-to-8bit; Fri, 3 Jan 2003 00:54:05 -0500
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [BENCHMARK] TIO bench result for 2.5.54 (poor performance)
Date: Fri, 3 Jan 2003 11:32:21 +0530
Message-ID: <94F20261551DC141B6B559DC491086720448C3@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] TIO bench result for 2.5.54 (poor performance)
Thread-Index: AcKy7a3J3R3yDgiURnimJamRo3rVkQ==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 03 Jan 2003 06:02:22.0100 (UTC) FILETIME=[AE4BED40:01C2B2ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Here are the results of comparison of kernel 2.5.54 and 2.5.53. 
on TIObench. key findings are listed in the table. Values in the table indicate approximate percentage change with respect to previous result. Please see the mail in full window to see the formatted results.


-------------------------------------------------------------
test					2.5.54 (as compared to
					2.5.53) APPROXIMATE % change
-------------------------------------------------------------
rate (megabytes per second)	20% decrease
CPU % utilization			15% decrease
Average Latency			40% increase
Maximum latency			20+ % increase 
CPU efficiency			less than 15% decrease
-------------------------------------------------------------

Here are the complete results.
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
2.5.54                        252   4096   10    7.83 5.349%    14.620     1226.26   0.00000  0.00000   146

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.54                        252   4096   10    0.36 1.050%   305.312     1363.70   0.00000  0.00000    35

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.54                        252   4096   10   18.42 37.67%     4.242    10048.16   0.05000  0.00000    49

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.54                        252   4096   10    0.78 1.251%     2.243     1400.69   0.00000  0.00000    63

Regards,
Aniruddha Marathe
WIPRO Technologies, India
aniruddha.marathe@wipro.com
+91-80-5502001 to 2008 extn 5092 
