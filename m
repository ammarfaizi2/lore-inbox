Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261594AbTANFW3>; Tue, 14 Jan 2003 00:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261615AbTANFW3>; Tue, 14 Jan 2003 00:22:29 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:56261 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S261594AbTANFW2> convert rfc822-to-8bit; Tue, 14 Jan 2003 00:22:28 -0500
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [BENCHMARK] TIObench  performance for 2.5.57
Date: Tue, 14 Jan 2003 11:01:06 +0530
Message-ID: <94F20261551DC141B6B559DC49108672044F37@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] TIObench  performance for 2.5.57
Thread-Index: AcK7jiLz8ZcU5LSSR32P5T/uxGfUcw==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 14 Jan 2003 05:31:07.0520 (UTC) FILETIME=[2380F800:01C2BB8E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the results for kernel 2.5.57. There is no significant change from 2.5.56

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
2.5.57                        252   4096   10    8.67 5.301%    11.945     1657.01   0.00000  0.00000   164

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.57                        252   4096   10    0.53 0.951%   200.566     1024.79   0.00000  0.00000    55

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.57                        252   4096   10   17.48 29.32%     3.808    24865.88   0.05156  0.00313    60

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.57                        252   4096   10    0.75 1.012%     0.577     1103.55   0.00000  0.00000    74

-Aniruddha Marathe
WIPRO
