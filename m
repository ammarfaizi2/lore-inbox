Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbTDHNem (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 09:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbTDHNem (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 09:34:42 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:10411 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id S261404AbTDHNel convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 09:34:41 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [BENCHMARK] TIObench performance for 2.5.67
Date: Tue, 8 Apr 2003 19:16:05 +0530
Message-ID: <94F20261551DC141B6B559DC4910867238D7B0@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] TIObench performance for 2.5.67
Thread-Index: AcL91TNNHXl8I7j0SHyRLoz8LgiA6Q==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Apr 2003 13:46:06.0156 (UTC) FILETIME=[33F830C0:01C2FDD5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CPU utilization has gone down and hence around 6-7% improvement in CPU efficiency.
Rest of the results have not varied by more than 5% since 2.5.62

********************************
Linux 2.5.67
********************************
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
2.5.67                        252   4096   10    7.53 3.698%    14.319     1872.15   0.00000  0.00000   204

Random Reads
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.67                        252   4096   10    0.50 0.450%   206.402     1785.75   0.00000  0.00000   110

Sequential Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.67                        252   4096   10   10.99 16.23%     5.835    25371.58   0.09688  0.00000    68

Random Writes
                              File  Blk   Num                   Avg      Maximum      Lat%     Lat%    CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency    Latency      >2s      >10s    Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----------  -------- -------- -----
2.5.67                        252   4096   10    0.65 0.747%     0.625     1531.00   0.00000  0.00000    87
