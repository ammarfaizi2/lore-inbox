Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261407AbTCGHGM>; Fri, 7 Mar 2003 02:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261412AbTCGHGM>; Fri, 7 Mar 2003 02:06:12 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:13753 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S261407AbTCGHGI> convert rfc822-to-8bit; Fri, 7 Mar 2003 02:06:08 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [BENCHMARK] TIObench performance of 2.5.64
Date: Fri, 7 Mar 2003 12:46:29 +0530
Message-ID: <94F20261551DC141B6B559DC4910867223AAE4@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] TIObench performance of 2.5.64
Thread-Index: AcLkeXhpqovmHmm+QH+yxScpW+KPxg==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 07 Mar 2003 07:16:30.0277 (UTC) FILETIME=[79A41F50:01C2E479]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Performance figures have not varied by more than 5% as compared to 2.5.63 performance

					KERNEL 2.5.64
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
2.5.64                        252   4096   10    8.21 4.347%    12.487     1742.45   0.00000  0.00000   189

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.64                        252   4096   10    0.43 0.538%   254.222     1645.46   0.00000  0.00000    79

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.64                        252   4096   10   13.93 22.92%     5.356    26320.44   0.09220  0.00000    61

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.64                        252   4096   10    0.74 0.888%     1.491     1937.15   0.00000  0.00000    83

Thanks,
Aniruddha Marathe
WIPRO Technologies, India
