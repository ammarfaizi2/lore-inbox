Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267368AbTBUKoF>; Fri, 21 Feb 2003 05:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267370AbTBUKoF>; Fri, 21 Feb 2003 05:44:05 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:48512 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S267368AbTBUKoA> convert rfc822-to-8bit; Fri, 21 Feb 2003 05:44:00 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Subject: [BENCHMARK] 2.5.62 Lmbench performance
Date: Fri, 21 Feb 2003 16:23:47 +0530
Message-ID: <94F20261551DC141B6B559DC4910867217CCC7@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] 2.5.62 Lmbench performance
Thread-Index: AcLZl4HtL8tbCaLyQ+afMfDrscfXvA==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Feb 2003 10:53:47.0204 (UTC) FILETIME=[8278D040:01C2D997]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Here are results of Lmbench for 2.5.62. Results don't differ much from 2.5.60.

*********************************************************************************************
		LMBENCH for kernel 2.5.62
*********************************************************************************************

                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------
		 (Alpha software, do not distribute)

Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz
                                                    
--------- ------------- ----------------------- ----
benchtest  Linux 2.5.62       i686-pc-linux-gnu  790
benchtest  Linux 2.5.62       i686-pc-linux-gnu  790
benchtest  Linux 2.5.62       i686-pc-linux-gnu  790
benchtest  Linux 2.5.62       i686-pc-linux-gnu  790
benchtest  Linux 2.5.62       i686-pc-linux-gnu  790

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh  
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
benchtest  Linux 2.5.62  790 0.46 0.82 6.63 8.58    33 1.26 3.93  335 1332 6685
benchtest  Linux 2.5.62  790 0.44 0.83 6.55 8.53    36 1.24 4.35  261 1301 6685
benchtest  Linux 2.5.62  790 0.44 0.83 6.57 8.50    35 1.23 3.92  282 1267 6608
benchtest  Linux 2.5.62  790 0.44 0.80 6.59 8.52    34 1.24 3.93  297 1289 6622
benchtest  Linux 2.5.62  790 0.46 0.82 6.83 8.66    32 1.26 3.92  321 1340 6669

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
benchtest  Linux 2.5.62 1.410 4.7600     15 9.6900    176      40     177
benchtest  Linux 2.5.62 1.440 4.7600     57 7.1800    180      40     178
benchtest  Linux 2.5.62 1.480 5.1600     18     13    183      39     179
benchtest  Linux 2.5.62 1.300 5.1500     14 5.9200    180      43     179
benchtest  Linux 2.5.62 1.500 4.7800     14 6.4700    181      41     178

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
benchtest  Linux 2.5.62 1.410 8.588   14    23    46    30    57  101
benchtest  Linux 2.5.62 1.440 8.374   14    32    46    31    57  102
benchtest  Linux 2.5.62 1.480 8.133   13    23    67    30    57  102
benchtest  Linux 2.5.62 1.300 8.305   14    24    46    30    58  102
benchtest  Linux 2.5.62 1.500 8.200   14    24    46    30    57  102

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
benchtest  Linux 2.5.62     93     30    323     79      594 0.591 4.00000
benchtest  Linux 2.5.62     93     30    325     82      650 0.592 4.00000
benchtest  Linux 2.5.62     91     30    355     82      642 0.593 4.00000
benchtest  Linux 2.5.62     94     30    326     82      606 0.589 4.00000
benchtest  Linux 2.5.62     93     30    327     82      617 0.623 4.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
benchtest  Linux 2.5.62  554  375   53    296    356    124    113  357   170
benchtest  Linux 2.5.62  554  371   52    294    354    123    112  355   170
benchtest  Linux 2.5.62  576  638   52    288    353    123    112  353   169
benchtest  Linux 2.5.62  489  341   52    290    353    123    112  353   169
benchtest  Linux 2.5.62  550  287   51    300    354    124    113  354   170

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
benchtest  Linux 2.5.62   790 3.803 8.8820    174
benchtest  Linux 2.5.62   790 3.796 8.8820    175
benchtest  Linux 2.5.62   790 3.808 8.8740    175
benchtest  Linux 2.5.62   790 3.797 8.9410    175
benchtest  Linux 2.5.62   790 3.808 8.8730    176

Aniruddha Marathe
Wipro technology, India.
