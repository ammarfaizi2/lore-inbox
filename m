Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261401AbTCGHVK>; Fri, 7 Mar 2003 02:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261402AbTCGHVK>; Fri, 7 Mar 2003 02:21:10 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:12221 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S261401AbTCGHVI> convert rfc822-to-8bit; Fri, 7 Mar 2003 02:21:08 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [BENCHMARK] 2.5.64 performance on LMbench
Date: Fri, 7 Mar 2003 13:01:24 +0530
Message-ID: <94F20261551DC141B6B559DC4910867223AAEB@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] 2.5.64 performance on LMbench
Thread-Index: AcLke45PopZD1YV0RDuyrPEMHVFBig==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 07 Mar 2003 07:31:26.0189 (UTC) FILETIME=[8FA571D0:01C2E47B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Performance is not varying much since 2.5.56. Again there is no considerable performance variation for 2.5.64

                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------
		 (Alpha software, do not distribute)

Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz
                                                    
--------- ------------- ----------------------- ----
benchtest  Linux 2.5.64       i686-pc-linux-gnu  790
benchtest  Linux 2.5.64       i686-pc-linux-gnu  790
benchtest  Linux 2.5.64       i686-pc-linux-gnu  790
benchtest  Linux 2.5.64       i686-pc-linux-gnu  790
benchtest  Linux 2.5.64       i686-pc-linux-gnu  790

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh  
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
benchtest  Linux 2.5.64  790 0.44 0.83 7.44 8.89    34 1.24 3.92  276 1277 6581
benchtest  Linux 2.5.64  790 0.44 0.81 7.20 8.65    35 1.26 3.92  285 1300 6621
benchtest  Linux 2.5.64  790 0.44 0.84 7.39 8.89    36 1.24 3.92  314 1292 6711
benchtest  Linux 2.5.64  790 0.44 0.81 7.26 8.66    35 1.24 3.92  320 1294 6608
benchtest  Linux 2.5.64  790 0.44 0.81 6.99 8.70    33 1.23 3.92  299 1289 6617

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
benchtest  Linux 2.5.64 1.420 4.8700     16     15    176      37     177
benchtest  Linux 2.5.64 1.400 4.8100     14     11    180      44     180
benchtest  Linux 2.5.64 1.450 5.2400     40     19    175      41     180
benchtest  Linux 2.5.64 1.440 4.9200     14     16    181      38     180
benchtest  Linux 2.5.64 1.380 4.9000     14 8.9200    180      44     180

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
benchtest  Linux 2.5.64 1.420 7.662   13    25    46    32    58 3.1M
benchtest  Linux 2.5.64 1.400 8.260   13    25    46    32    58 3.1M
benchtest  Linux 2.5.64 1.450 8.382   13    25    46    31    58 3.1M
benchtest  Linux 2.5.64 1.440 8.355   14    25    46    32    58 3.1M
benchtest  Linux 2.5.64 1.380 8.215   13    25    46    32    58 3.1M

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
benchtest  Linux 2.5.64     91     31    343     82      605 0.662 4.00000
benchtest  Linux 2.5.64     91     31    329     83      598 0.668 4.00000
benchtest  Linux 2.5.64     91     31    331     83      610 0.661 4.00000
benchtest  Linux 2.5.64     91     31    345     83      609 0.661 4.00000
benchtest  Linux 2.5.64     91     31    336     84      615 0.664 4.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
benchtest  Linux 2.5.64  577  436   47    297    356    124    113  355   170
benchtest  Linux 2.5.64  519  184   52    293    353    123    112  352   169
benchtest  Linux 2.5.64  585  556   55    288    353    123    112  352   169
benchtest  Linux 2.5.64  581  602   52    296    351    123    112  352   169
benchtest  Linux 2.5.64  410  451   52    290    352    123    112  352   169

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
benchtest  Linux 2.5.64   790 3.798 8.8820    175
benchtest  Linux 2.5.64   790 3.797 8.8820    176
benchtest  Linux 2.5.64   790 3.798     55    176
benchtest  Linux 2.5.64   790 3.808 8.8720    176
benchtest  Linux 2.5.64   790 3.798 8.8810    176

Aniruddha Marathe
WIPRO Technologies, India
