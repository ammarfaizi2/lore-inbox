Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265513AbSLPGg7>; Mon, 16 Dec 2002 01:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265564AbSLPGg7>; Mon, 16 Dec 2002 01:36:59 -0500
Received: from wiprom2mx2.wipro.com ([203.197.164.42]:52408 "EHLO
	wiprom2mx2.wipro.com") by vger.kernel.org with ESMTP
	id <S265513AbSLPGg6> convert rfc822-to-8bit; Mon, 16 Dec 2002 01:36:58 -0500
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [BENCHMARK] not so good performance of 2.5.52 on TIO bench
Date: Mon, 16 Dec 2002 12:14:35 +0530
Message-ID: <94F20261551DC141B6B559DC4910867201DFBB@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] not so good performance of 2.5.52 on TIO bench
Thread-Index: AcKkzpiGwMh7xY5dT4qE6ckHItSyOQ==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 16 Dec 2002 06:44:35.0922 (UTC) FILETIME=[9922FB20:01C2A4CE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Here are the results of comparison of kernel 2.5.51 and 2.5.52 on TIObench.
key findings. 

-------------------------------------------------------------
test					2.5.52 (as compared to
					2.5.51) APPRXIMATE % change
-------------------------------------------------------------
rate (megabytes per second)	5% decrease
CPU % utilization			5% decrease
Average Latency			less than 2% increase
Maximum latency			15 % increase		
CPU efficiency			less than 2% increase
-------------------------------------------------------------

-------------------------------------------------------------
			Linux kernel 2.5.52
			TIO bench results
			Date 16th december 2002
-------------------------------------------------------------
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
2.5.52                        252   4096   10    8.48 5.251%    12.152     1825.07   0.00000  0.00000   161

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.52                        252   4096   10    0.50 0.729%   211.130     1079.20   0.00000  0.00000    69

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.52                        252   4096   10   16.17 30.00%     4.525    29226.70   0.06094  0.00625    54

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.52                        252   4096   10    0.78 1.084%     0.675      992.39   0.00000  0.00000    72

regards,
Aniruddha Marathe
WIPRO Technologies, India
aniruddha.marathe@wipro.com
