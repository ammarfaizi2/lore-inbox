Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261295AbTB0FWb>; Thu, 27 Feb 2003 00:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261451AbTB0FWa>; Thu, 27 Feb 2003 00:22:30 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:18580 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S261295AbTB0FW1> convert rfc822-to-8bit; Thu, 27 Feb 2003 00:22:27 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [BENCHMARK] 2.5.63 Lmbench performance
Date: Thu, 27 Feb 2003 11:02:28 +0530
Message-ID: <94F20261551DC141B6B559DC491086721E00F9@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] 2.5.63 Lmbench performance
Thread-Index: AcLeIZ2pow3DtYikTmeTC+sJyuZhUg==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 Feb 2003 05:32:28.0684 (UTC) FILETIME=[9E0E9CC0:01C2DE21]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Almost identical to 2.5.62

*************************************************************
		Kernel 2.5.62
*************************************************************
                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------
		 (Alpha software, do not distribute)

Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz
                                                    
--------- ------------- ----------------------- ----
benchtest  Linux 2.5.63       i686-pc-linux-gnu  790
benchtest  Linux 2.5.63       i686-pc-linux-gnu  790
benchtest  Linux 2.5.63       i686-pc-linux-gnu  790
benchtest  Linux 2.5.63       i686-pc-linux-gnu  790
benchtest  Linux 2.5.63       i686-pc-linux-gnu  790

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh  
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
benchtest  Linux 2.5.63  790 0.46 0.82 6.75 8.03    33 1.26 4.04  285 1322 6675
benchtest  Linux 2.5.63  790 0.44 0.82 6.66 7.99       1.23 4.04  364 1318 6776
benchtest  Linux 2.5.63  790 0.46 0.81 6.86 8.10    33 1.23 4.04  270 1338 6755
benchtest  Linux 2.5.63  790 0.46 0.85 6.77 8.07    34 1.26 4.06  315 1329 6778
benchtest  Linux 2.5.63  790 0.44 0.83 6.73 8.00    33 1.23 4.04  360 1315 6650

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
benchtest  Linux 2.5.63 1.220 4.7500     15 9.5500    182      42     178
benchtest  Linux 2.5.63 1.480 4.8200     14     25    182      44     180
benchtest  Linux 2.5.63 1.440 5.1800     14 8.3400    179      39     178
benchtest  Linux 2.5.63 1.580 5.1300     15 7.8900    181      42     179
benchtest  Linux 2.5.63 1.440 4.8200     14 8.7100    183      42     179

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
benchtest  Linux 2.5.63 1.220 8.658   13    24    47    31    57  102
benchtest  Linux 2.5.63 1.480 7.440   13    23    47    31    57  103
benchtest  Linux 2.5.63 1.440 8.366   13    23    46    30    57  103
benchtest  Linux 2.5.63 1.580 8.422   13    23    47    31    57  102
benchtest  Linux 2.5.63 1.440 8.205   13    23    47    30    57  104

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
benchtest  Linux 2.5.63     93     31    331     83      605 0.545 4.00000
benchtest  Linux 2.5.63     92     31    342     82      627 0.522 4.00000
benchtest  Linux 2.5.63     91     31    330     83      607 0.540 4.00000
benchtest  Linux 2.5.63     92     31    334     82      596 0.527 4.00000
benchtest  Linux 2.5.63     91     31    331     82      615 0.595 4.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
benchtest  Linux 2.5.63  527  435   50    294    354    123    113  156   107
benchtest  Linux 2.5.63  581  398   52    297    354    123    113  353   170
benchtest  Linux 2.5.63  536  402   52    299    354    123    113  353   170
benchtest  Linux 2.5.63  531  630   53    298    354    123    112  353   169
benchtest  Linux 2.5.63  557  432   52    298    353    123    113  352   170

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
benchtest  Linux 2.5.63   790 3.798 8.8760    174
benchtest  Linux 2.5.63   790 3.798 8.8830    175
benchtest  Linux 2.5.63   790 3.797     10    175
benchtest  Linux 2.5.63   790 3.808 8.8720    175
benchtest  Linux 2.5.63   790 3.797 8.8720    175
