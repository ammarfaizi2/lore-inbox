Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267455AbTANFPj>; Tue, 14 Jan 2003 00:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267456AbTANFPj>; Tue, 14 Jan 2003 00:15:39 -0500
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:53955 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S267455AbTANFPe> convert rfc822-to-8bit; Tue, 14 Jan 2003 00:15:34 -0500
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [BENCHMARK] Lmbench results for 2.5.57
Date: Tue, 14 Jan 2003 10:54:13 +0530
Message-ID: <94F20261551DC141B6B559DC49108672044F34@blr-m3-msg.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BENCHMARK] Lmbench results for 2.5.57
Thread-Index: AcK7jSwrCgF5RTmvSpG8Cp2gtFyc/w==
From: "Aniruddha M Marathe" <aniruddha.marathe@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 14 Jan 2003 05:24:13.0687 (UTC) FILETIME=[2CD71070:01C2BB8D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Here is a comparison of results of 2.5.57. There are no significant differences in the result as compared to 2.5.56


                L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------
		 (Alpha software, do not distribute)

Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz
                                                    
--------- ------------- ----------------------- ----
benchtest  Linux 2.5.57       i686-pc-linux-gnu  790
benchtest  Linux 2.5.57       i686-pc-linux-gnu  790
benchtest  Linux 2.5.57       i686-pc-linux-gnu  790
benchtest  Linux 2.5.57       i686-pc-linux-gnu  790
benchtest  Linux 2.5.57       i686-pc-linux-gnu  790

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh  
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
benchtest  Linux 2.5.57  790 0.46 0.81 6.92 8.23       1.22 3.64  320 1304 6634
benchtest  Linux 2.5.57  790 0.46 0.83 7.03 8.33    39 1.24 3.64  295 1258 6545
benchtest  Linux 2.5.57  790 0.44 0.80 6.91 8.22    42 1.25 3.63  289 1289 6566
benchtest  Linux 2.5.57  790 0.46 0.81 6.93 8.22    39 1.25 3.67  260 1246 6607
benchtest  Linux 2.5.57  790 0.44 0.81 6.99 8.32    41 1.25 3.65  307 1261 6540

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
benchtest  Linux 2.5.57 1.480 4.7600     14 9.7600    175      38     176
benchtest  Linux 2.5.57 1.330 5.1000     14 6.9900    177      41     180
benchtest  Linux 2.5.57 1.390 4.7900     14     11    181      37     181
benchtest  Linux 2.5.57 1.310 4.8100     16 5.9200    178      42     179
benchtest  Linux 2.5.57 1.330 4.7500     14 6.8400    179      39     180

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
benchtest  Linux 2.5.57 1.480 8.372   13    21    46    30    57  101
benchtest  Linux 2.5.57 1.330 8.335   14    24    46    30    57  102
benchtest  Linux 2.5.57 1.390 8.192   13    24    47    30    58  102
benchtest  Linux 2.5.57 1.310 8.417   13    24    46    30    58  102
benchtest  Linux 2.5.57 1.330 8.632   14    24    47    30    57  102

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
benchtest  Linux 2.5.57     90     29    319     81      625 0.969 4.00000
benchtest  Linux 2.5.57     90     30    347     85      650 2.505 4.00000
benchtest  Linux 2.5.57     90     30    322     78      627 2.546 4.00000
benchtest  Linux 2.5.57     90     30    324     82      617 0.939 4.00000
benchtest  Linux 2.5.57     90     30    326     82      614 0.962 4.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
benchtest  Linux 2.5.57  544  332   54    301    355    124    113  355   171
benchtest  Linux 2.5.57  562  357   53    297    352    123    112  353   169
benchtest  Linux 2.5.57  565  537   51    293    352    123    112  353   169
benchtest  Linux 2.5.57  571  400   53    296    352    123    112  352   169
benchtest  Linux 2.5.57  569  611   52    262    352    123    112  352   169

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
benchtest  Linux 2.5.57   790 3.798 8.8730    175
benchtest  Linux 2.5.57   790 3.797     55    176
benchtest  Linux 2.5.57   790 3.798 8.8820    176
benchtest  Linux 2.5.57   790 3.801     61    176
benchtest  Linux 2.5.57   790 3.807 8.8710    176

-Aniruddha Marathe
WIPRO
