Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262982AbTDYEeR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 00:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbTDYEeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 00:34:17 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:63892 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id S262982AbTDYEeP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 00:34:15 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [BENCHMARK] 2.5.68 Lmbench performance
Date: Fri, 25 Apr 2003 10:16:08 +0530
Message-ID: <94F20261551DC141B6B559DC4910867243141A@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] 2.5.68 Lmbench performance
Thread-Index: AcMK5ZZEwhMIomoJRfWCMbfMQvVIEA==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 Apr 2003 04:46:08.0883 (UTC) FILETIME=[96B66430:01C30AE5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This result is almost identical with 2.5.67 result. No parameter has varied by more than 5%.


                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------
		 (Alpha software, do not distribute)

Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz
                                                    
--------- ------------- ----------------------- ----
benchtest  Linux 2.5.68       i686-pc-linux-gnu  790
benchtest  Linux 2.5.68       i686-pc-linux-gnu  790
benchtest  Linux 2.5.68       i686-pc-linux-gnu  790
benchtest  Linux 2.5.68       i686-pc-linux-gnu  790
benchtest  Linux 2.5.68       i686-pc-linux-gnu  790

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh  
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
benchtest  Linux 2.5.68  790 0.44 0.74 6.55 7.92    29 1.23 3.89  271 1110 6007
benchtest  Linux 2.5.68  790 0.44 0.74 6.61 7.98    30 1.23 3.89  244 1097 6032
benchtest  Linux 2.5.68  790 0.44 0.75 6.56 8.01    31 1.25 3.88  226 1123 6004
benchtest  Linux 2.5.68  790 0.44 0.73 6.54 8.01    31 1.25 3.88  231 1149 6000
benchtest  Linux 2.5.68  790 0.46 0.76 6.71 8.15    28 1.25 3.88  265 1129 6031

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
benchtest  Linux 2.5.68 1.200 4.7400     14 9.3600    176      37     178
benchtest  Linux 2.5.68 1.320 4.7400     14 7.2700    178      41     177
benchtest  Linux 2.5.68 1.100 4.6900     14 6.9700    175      41     177
benchtest  Linux 2.5.68 1.080 4.7600     14 7.9700    175      37     177
benchtest  Linux 2.5.68 0.980 4.7500     19     10    179      41     178

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
benchtest  Linux 2.5.68 1.200 8.281   12    22    45    31    56  102
benchtest  Linux 2.5.68 1.320 8.262   12    22    46    31    57  102
benchtest  Linux 2.5.68 1.100 8.449   12    22    46    31    57  102
benchtest  Linux 2.5.68 1.080 8.395   12    22    46    31    56  102
benchtest  Linux 2.5.68 0.980 8.324   12    22    46    31    56  102

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
benchtest  Linux 2.5.68     85     27    295     74      472 0.626 4.00000
benchtest  Linux 2.5.68     88     27    296     72      462 0.625 4.00000
benchtest  Linux 2.5.68     87     26    294     74      468 0.617 4.00000
benchtest  Linux 2.5.68     87     26    292     74      463 0.595 4.00000
benchtest  Linux 2.5.68     86     27    309     74      470 0.638 4.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
benchtest  Linux 2.5.68  580  423   51    308    356    124    113  355   171
benchtest  Linux 2.5.68  620  446   50    307    356    124    113  356   170
benchtest  Linux 2.5.68  615  345   52    283    355    124    113  355   170
benchtest  Linux 2.5.68  616  387   53    309    356    124    113  355   170
benchtest  Linux 2.5.68  621  436   51    308    355    124    113  355   170

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
benchtest  Linux 2.5.68   790 3.797 8.8700    174
benchtest  Linux 2.5.68   790 3.798 8.8710    174
benchtest  Linux 2.5.68   790 3.797 8.8800    174
benchtest  Linux 2.5.68   790 3.806 8.8930    174
benchtest  Linux 2.5.68   790 3.805 8.8710    174

-Aniruddha
