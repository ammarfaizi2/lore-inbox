Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262326AbTATIv7>; Mon, 20 Jan 2003 03:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262038AbTATIv7>; Mon, 20 Jan 2003 03:51:59 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:24024 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S262838AbTATIv5> convert rfc822-to-8bit; Mon, 20 Jan 2003 03:51:57 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [BENCHMARK] 2.5.59 Lmbench performance
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Date: Mon, 20 Jan 2003 14:30:48 +0530
Message-ID: <94F20261551DC141B6B559DC491086720AEA36@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] 2.5.59 Lmbench performance
Thread-Index: AcLAYmxy9heI6oIZTqW77JwLSZoMlA==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 20 Jan 2003 09:00:48.0659 (UTC) FILETIME=[6CECEE30:01C2C062]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since 2.5.56, the results are not varying much. Almost all the changes are less than 5%. Here are the results of 2.5.59


********************************************************************
				Kernel 2.5.59
				Lmbench results
********************************************************************

                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------
		 (Alpha software, do not distribute)

Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz
                                                    
--------- ------------- ----------------------- ----
benchtest  Linux 2.5.59       i686-pc-linux-gnu  790
benchtest  Linux 2.5.59       i686-pc-linux-gnu  790
benchtest  Linux 2.5.59       i686-pc-linux-gnu  790
benchtest  Linux 2.5.59       i686-pc-linux-gnu  790
benchtest  Linux 2.5.59       i686-pc-linux-gnu  790

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh  
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
benchtest  Linux 2.5.59  790 0.46 0.85 7.22 8.74       1.31 4.09  257 1311 6794
benchtest  Linux 2.5.59  790 0.46 0.84 7.24 8.78    34 1.25 3.66  266 1305 6708
benchtest  Linux 2.5.59  790 0.46 0.87 7.22 8.78    35 1.26 3.66  254 1314 6763
benchtest  Linux 2.5.59  790 0.46 0.87 7.26 8.84    36 1.26 3.66  261 1303 6770
benchtest  Linux 2.5.59  790 0.46 0.83 7.19 8.72    34 1.25 3.67  290 1319 6796

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
benchtest  Linux 2.5.59 1.690 5.0400     14 7.5800    175      38     178
benchtest  Linux 2.5.59 1.580 5.3700     14     10    178      44     181
benchtest  Linux 2.5.59 1.740 5.3500     14 8.8300    179      46     180
benchtest  Linux 2.5.59 1.750 5.4000     15     11    180      43     181
benchtest  Linux 2.5.59 1.660 5.3500     15 8.4100    180      41     180

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
benchtest  Linux 2.5.59 1.690 8.813   14    25    48    31    59  110
benchtest  Linux 2.5.59 1.580 8.769   14    25    48    32    59  110
benchtest  Linux 2.5.59 1.740 8.759   14    25    48    31    59  110
benchtest  Linux 2.5.59 1.750 8.717   14    24    48    31    59  111
benchtest  Linux 2.5.59 1.660 8.894   14    25    48    32    60  110

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
benchtest  Linux 2.5.59     92     31    332     82      642 1.035 4.00000
benchtest  Linux 2.5.59     94     31    331     84      641 1.029 4.00000
benchtest  Linux 2.5.59     92     32    335     86      632 1.059 4.00000
benchtest  Linux 2.5.59     91     31    332     83      638 1.061 4.00000
benchtest  Linux 2.5.59     94     31    346     85      631 1.022 4.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
benchtest  Linux 2.5.59  323  426   48    298    356    124    113  356   170
benchtest  Linux 2.5.59  375  563   48    294    353    123    112  353   169
benchtest  Linux 2.5.59  395  559   47    294    353    123    112  353   169
benchtest  Linux 2.5.59  397  538   47    293    352    123    112  353   169
benchtest  Linux 2.5.59  292  543   48    294    352    123    112  354   170

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
benchtest  Linux 2.5.59   790 3.802 8.8820    174
benchtest  Linux 2.5.59   790 3.807 8.8820    175
benchtest  Linux 2.5.59   790 3.799     55    175
benchtest  Linux 2.5.59   790 3.798     56    175
benchtest  Linux 2.5.59   790 3.808     54    175

Aniruddha Marathe
WIPRO Technologies, India
