Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267998AbTBMJcg>; Thu, 13 Feb 2003 04:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267999AbTBMJcg>; Thu, 13 Feb 2003 04:32:36 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:9181 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S267998AbTBMJce> convert rfc822-to-8bit; Thu, 13 Feb 2003 04:32:34 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Subject: [BENCHMARK] TIObench 2.5.60 performance
Date: Thu, 13 Feb 2003 15:11:55 +0530
Message-ID: <94F20261551DC141B6B559DC4910867217BE3B@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] TIObench 2.5.60 performance
Thread-Index: AcLTRCTgdbHq/5bATjGW7KpcxVtR2Q==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 13 Feb 2003 09:41:56.0335 (UTC) FILETIME=[25B067F0:01C2D344]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is TIObench performance of 2.5.60. Comparison of 2.5.60 and 2.5.59 is given below.



-----------------------------------------------------------------------------------------------------------------
test					2.5.60 (as compared to
					2.5.59) APPROXIMATE % change
----------------------------------------------------------------------------------------------------------------
rate (megabytes per second)		Almost no change
CPU % utilization			less than 5% decrease
Average Latency			Almost no change
Maximum latency			less than 5 % decrease
CPU efficiency				Almost no change
-----------------------------------------------------------------------------------------------------------------


************************************************************
		TIObench for kernel 2.5.60
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
2.5.60                        252   4096   10    7.52 4.124%    14.418     1882.19   0.00000  0.00000   182

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.60                        252   4096   10    0.45 0.535%   233.128     1167.03   0.00000  0.00000    84

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.60                        252   4096   10   12.74 22.26%     5.839    31387.57   0.08282  0.00312    57

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.60                        252   4096   10    0.66 0.854%     1.304     2235.07   0.00000  0.00000    77

Aniruddha Marathe
WIPRO Technologies, India
