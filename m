Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262977AbTDYEaO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 00:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262982AbTDYEaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 00:30:13 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:12691 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id S262977AbTDYEaM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 00:30:12 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [BENCHMARK] TIO bench performance of 2.5.68
Date: Fri, 25 Apr 2003 10:12:01 +0530
Message-ID: <94F20261551DC141B6B559DC49108672431412@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] TIO bench performance of 2.5.68
Thread-Index: AcMK5QMSsNMHzpzOSXGYlQpuqOcz1g==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 Apr 2003 04:42:01.0928 (UTC) FILETIME=[03840C80:01C30AE5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Results are not varying much since last 6 kernel releases. There is a very marginal increase in CPU efficiency.
Latencies have also risen but not by more than 5%.

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
2.5.68                        252   4096   10    6.76 3.458%    15.704     2658.86   0.00000  0.00000   196

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.68                        252   4096   10    0.47 0.441%   221.819     1993.16   0.00000  0.00000   106

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.68                        252   4096   10   10.80 16.35%     6.656    32552.30   0.10938  0.00469    66

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.68                        252   4096   10    0.66 0.773%     1.524     1265.13   0.00000  0.00000    85

-Aniruddha
