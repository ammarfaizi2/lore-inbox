Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261456AbTB0F1W>; Thu, 27 Feb 2003 00:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261451AbTB0F1W>; Thu, 27 Feb 2003 00:27:22 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:47765 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S261463AbTB0F1V> convert rfc822-to-8bit; Thu, 27 Feb 2003 00:27:21 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [BENCHMARK] TIObench 2.5.63 performance
Date: Thu, 27 Feb 2003 11:07:26 +0530
Message-ID: <94F20261551DC141B6B559DC491086721E0100@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] TIObench 2.5.63 performance
Thread-Index: AcLeIk+MdUZuASUuQleQrzkjLu4Qeg==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 Feb 2003 05:37:27.0217 (UTC) FILETIME=[4FFF2210:01C2DE22]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my machine, 2.5.63 performance almost same as 2.5.62

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
2.5.63                        252   4096   10    7.76 4.177%    13.815     2229.81   0.00000  0.00000   186

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.63                        252   4096   10    0.45 0.543%   231.653     1253.08   0.00000  0.00000    84

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.63                        252   4096   10   12.30 21.38%     5.910    35166.47   0.08594  0.00626    57

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.63                        252   4096   10    0.73 0.888%     1.308     1640.82   0.00000  0.00000    82

Aniruddha Marathe
WIPRO Technologies, India
