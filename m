Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbTDHNvm (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 09:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbTDHNvm (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 09:51:42 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:13745 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id S261440AbTDHNvk convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 09:51:40 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [BENCHMARK] Lmbench performance 2.5.67
Date: Tue, 8 Apr 2003 19:33:01 +0530
Message-ID: <94F20261551DC141B6B559DC4910867238D7BD@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] Lmbench performance 2.5.67
Thread-Index: AcL915CoYuEwi3+ITYqOOBYCLqSBTQ==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Apr 2003 14:03:01.0702 (UTC) FILETIME=[91483660:01C2FDD7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary:
--------------------------------------------------------------------------------------------------------
			2.5.67		2.5.64
--------------------------------------------------------------------------------------------------------
Processor, Processes - times in microseconds - smaller is better
Exec proc		1150		1292
--------------------------------------------------------------------------------------------------------
Context switching - times in microseconds - smaller is better
2p/0k ctxsw		0.940		1.420
8p/16k ctxsw		9.04		15
--------------------------------------------------------------------------------------------------------
File & VM system latencies in microseconds - smaller is better
Mmap latency		494		609
--------------------------------------------------------------------------------------------------------

                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------
		 (Alpha software, do not distribute)

Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz
                                                    
--------- ------------- ----------------------- ----
benchtest  Linux 2.5.67       i686-pc-linux-gnu  790
benchtest  Linux 2.5.67       i686-pc-linux-gnu  790
benchtest  Linux 2.5.67       i686-pc-linux-gnu  790
benchtest  Linux 2.5.67       i686-pc-linux-gnu  790
benchtest  Linux 2.5.67       i686-pc-linux-gnu  790

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh  
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
benchtest  Linux 2.5.67  790 0.44 0.77 6.50 8.04    31 1.23 3.85  263 1117 6097
benchtest  Linux 2.5.67  790 0.44 0.76 6.63 8.14    31 1.23 3.86  267 1127 6049
benchtest  Linux 2.5.67  790 0.44 0.77 6.61 8.15    30 1.23 3.87  285 1150 6077
benchtest  Linux 2.5.67  790 0.46 0.76 6.62 8.17    30 1.23 3.86  345 1197 6128
benchtest  Linux 2.5.67  790 0.44 0.78 6.67 8.19    32 1.23 3.86  292 1189 6084

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
benchtest  Linux 2.5.67 0.940 4.6100     66 9.0400    176      39     176
benchtest  Linux 2.5.67 0.920 4.6100     16 9.8600    175      39     175
benchtest  Linux 2.5.67 0.910 4.5800     14 7.0800    173      37     175
benchtest  Linux 2.5.67 1.290 4.6100     14     15    177      42     176
benchtest  Linux 2.5.67 0.940 4.6400     14 8.9400    176      40     176

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
benchtest  Linux 2.5.67 0.940 8.335   12    23    48    30    56  104
benchtest  Linux 2.5.67 0.920 8.315   12    23    63    30    56  103
benchtest  Linux 2.5.67 0.910 8.137   12    23    45    30    55  102
benchtest  Linux 2.5.67 1.290 8.178   12    23    45    30    56  103
benchtest  Linux 2.5.67 0.940 8.383   12    23    45    30    56  102

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
benchtest  Linux 2.5.67     87     27    294     76      487 0.583 5.00000
benchtest  Linux 2.5.67     87     27    291     75      498 0.625 4.00000
benchtest  Linux 2.5.67     88     27    296     75      502 0.595 4.00000
benchtest  Linux 2.5.67     88     27    294     75      491 0.582 4.00000
benchtest  Linux 2.5.67     87     27    297     75      494 0.581 4.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
benchtest  Linux 2.5.67  624  562   50    309    357    125    114  358   172
benchtest  Linux 2.5.67  598  482   51    301    358    125    114  359   171
benchtest  Linux 2.5.67  616  340   49    308    358    125    114  358   171
benchtest  Linux 2.5.67  598  539   51    310    357    125    113  358   171
benchtest  Linux 2.5.67  623  314   50    307    355    125    114  356   171

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
benchtest  Linux 2.5.67   790 3.798 8.8800    173
benchtest  Linux 2.5.67   790 3.799 8.8830    173
benchtest  Linux 2.5.67   790 3.799 8.8820    173
benchtest  Linux 2.5.67   790 3.800 8.8810    173
benchtest  Linux 2.5.67   790 3.798 8.8730    174
