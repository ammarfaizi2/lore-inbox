Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261687AbSJBRig>; Wed, 2 Oct 2002 13:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261350AbSJBRig>; Wed, 2 Oct 2002 13:38:36 -0400
Received: from p508EF310.dip.t-dialin.net ([80.142.243.16]:16331 "EHLO
	oscar.local.net") by vger.kernel.org with ESMTP id <S262238AbSJBRdD>;
	Wed, 2 Oct 2002 13:33:03 -0400
Date: Wed, 2 Oct 2002 19:38:20 +0200
From: Patrick Mau <mau@oscar.prima.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: LMbench results for 2.5.40
Message-ID: <20021002173820.GB14438@oscar.dorf.de>
Reply-To: Patrick Mau <mau@oscar.prima.de>
References: <20021001220853.GA20022@oscar.dorf.de> <3D9A1EC2.2020706@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D9A1EC2.2020706@pobox.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo Jeff,

sorry for the late reply, I had to work all day. Below are five
sequencial runs of lmbench with 2.4.18 and 2.5.40. Kernel 2.5 was
compiled without CONFIG_PREEMPT.

I only rebooted between kernels, not between each run.
All numbers were obtained in single-user mode.

Patrick

                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------


Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz
                                                    
--------- ------------- ----------------------- ----
tony       Linux 2.4.18       i686-pc-linux-gnu 2400
tony       Linux 2.4.18       i686-pc-linux-gnu 2400
tony       Linux 2.4.18       i686-pc-linux-gnu 2400
tony       Linux 2.4.18       i686-pc-linux-gnu 2400
tony       Linux 2.4.18       i686-pc-linux-gnu 2400
tony       Linux 2.5.40       i686-pc-linux-gnu 2400
tony       Linux 2.5.40       i686-pc-linux-gnu 2400
tony       Linux 2.5.40       i686-pc-linux-gnu 2400
tony       Linux 2.5.40       i686-pc-linux-gnu 2400
tony       Linux 2.5.40       i686-pc-linux-gnu 2400

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh  
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
tony       Linux 2.4.18 2400 0.67 0.75 1.42 2.30 6.645 1.11 2.70 95.6 452. 6155
tony       Linux 2.4.18 2400 0.67 0.75 1.45 2.29 6.736 1.11 2.70 93.1 449. 6263
tony       Linux 2.4.18 2400 0.67 0.75 1.45 2.26 6.637 1.11 2.68 94.4 455. 6185
tony       Linux 2.4.18 2400 0.67 0.75 1.42 2.27 6.644 1.11 2.70 94.3 451. 6201
tony       Linux 2.4.18 2400 0.67 0.75 1.43 2.31  10.6 1.11 2.70 93.6 453. 6172
tony       Linux 2.5.40 2400 0.66 0.75 1.54 2.36 6.521 1.13 2.83 116. 500. 6700
tony       Linux 2.5.40 2400 0.66 0.75 1.52 2.40 6.550 1.12 2.83 115. 505. 6759
tony       Linux 2.5.40 2400 0.66 0.75 1.51 2.38 9.482 1.12 2.84 114. 508. 6549
tony       Linux 2.5.40 2400 0.66 0.75 1.51 2.42 6.608 1.12 2.85 117. 511. 6650
tony       Linux 2.5.40 2400 0.66 0.75 1.51 2.38 6.524 1.12 2.83 115. 517. 6775

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
tony       Linux 2.4.18 0.850 1.7300 4.0600 1.8700   21.4 4.57000    29.7
tony       Linux 2.4.18 0.800 1.7200 3.9100 1.9500   23.8 4.27000    29.7
tony       Linux 2.4.18 0.860 1.6800 3.8900 1.9800   22.4 3.79000    29.7
tony       Linux 2.4.18 0.830 1.7000 3.7500 2.7800   19.6 4.37000    29.6
tony       Linux 2.4.18 0.730 1.6700 4.0600 1.9500   22.0 3.84000    29.8
tony       Linux 2.5.40 1.090 1.9000 4.4700 2.3100   23.7 5.52000    30.6
tony       Linux 2.5.40 1.140 1.9000 4.4200 2.3100   22.3 4.01000    30.6
tony       Linux 2.5.40 1.100 1.8900 4.4700 2.1100   22.4 4.32000    30.6
tony       Linux 2.5.40 1.110 1.9300 4.4700 2.0500   23.5 3.87000    30.5
tony       Linux 2.5.40 1.130 1.9100 4.4400 2.1100   24.3 4.44000    30.6

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
tony       Linux 2.4.18 0.850 4.991 7.30  12.8  23.1  14.4  28.0 45.2
tony       Linux 2.4.18 0.800 4.897 7.15  12.9  23.7  14.3  29.0 43.9
tony       Linux 2.4.18 0.860 4.893 7.21  12.8  23.0  14.7  28.4 599K
tony       Linux 2.4.18 0.830 4.901 7.20  12.9  23.2  14.4  28.1 44.4
tony       Linux 2.4.18 0.730 4.909 7.20  13.0  22.7  14.4  28.1 44.6
tony       Linux 2.5.40 1.090 5.235 7.92  13.7  23.6  15.2  29.3 48.3
tony       Linux 2.5.40 1.140 5.416 7.99  13.6  24.1  15.2  29.1 48.5
tony       Linux 2.5.40 1.100 5.200 7.89  13.6  23.7  15.4  29.2 49.0
tony       Linux 2.5.40 1.110 5.280 7.91  13.5  23.8  15.2  29.2 48.5
tony       Linux 2.5.40 1.130 5.462 7.89  13.6  23.7  15.3  29.0 48.3

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
tony       Linux 2.4.18   29.2 5.6820   56.7   10.5   1196.0 1.324 2.00000
tony       Linux 2.4.18   29.3 5.7120   56.7   10.6   1187.0 1.318 2.00000
tony       Linux 2.4.18   29.2 5.7000   56.7   10.5   1187.0 1.352 2.00000
tony       Linux 2.4.18   29.2 5.6280   55.5   10.4   1187.0 1.331 2.00000
tony       Linux 2.4.18   29.2 5.6610   57.1   10.6   1186.0 1.309 2.00000
tony       Linux 2.5.40   32.1 6.5480   62.0   14.5   1442.0 1.338 2.00000
tony       Linux 2.5.40   32.1 6.5980   61.0   14.6   1445.0 1.341 2.00000
tony       Linux 2.5.40   32.1 6.5130   59.8   14.4   1451.0 1.343 2.00000
tony       Linux 2.5.40   32.3 6.5550   60.5   14.4   1450.0 1.307 2.00000
tony       Linux 2.5.40   32.2 6.5800   60.1   14.5   1451.0 1.411 2.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
tony       Linux 2.4.18 1568 2343 648. 1964.5 2007.7  840.3  907.7 2007 1078.
tony       Linux 2.4.18 1451 2326 577. 1926.7 2008.0  845.9  892.6 2004 1144.
tony       Linux 2.4.18 1575 2303 1301 1967.6 2007.8  851.6  901.4 2007 1189.
tony       Linux 2.4.18 1569 2335 1281 1966.0 2005.3  873.9  901.4 2007 1228.
tony       Linux 2.4.18 1533 2356 1118 1964.4 2007.9  887.7  913.3 2004 1272.
tony       Linux 2.5.40 1266 2120 295. 1819.4 1980.0  810.3  858.5 1975 1216.
tony       Linux 2.5.40 1366 2192 293. 1819.0 1980.8  831.4  884.1 1976 1288.
tony       Linux 2.5.40 1388 2161 278. 1815.2 1979.3  850.5  891.4 1978 1334.
tony       Linux 2.5.40 1348 2197 299. 1838.5 1979.1  842.1  904.6 1975 1360.
tony       Linux 2.5.40 1367 2192 609. 1837.7 1980.8  858.5  926.8 1975 1357.

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
tony       Linux 2.4.18  2400 0.838 7.7160  117.8
tony       Linux 2.4.18  2400 0.838 7.7160  118.1
tony       Linux 2.4.18  2400 0.889 7.7140  118.2
tony       Linux 2.4.18  2400 0.908 7.7250  118.0
tony       Linux 2.4.18  2400 0.839 7.7140  117.8
tony       Linux 2.5.40  2400 0.868 7.8170  122.5
tony       Linux 2.5.40  2400 0.838 7.8160  123.8
tony       Linux 2.5.40  2400 0.849 7.8190  124.0
tony       Linux 2.5.40  2400 0.838 7.8170  122.6
tony       Linux 2.5.40  2400 0.849 7.8220  124.0
