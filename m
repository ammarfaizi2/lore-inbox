Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263332AbTDLQdg (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 12:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263335AbTDLQdg (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 12:33:36 -0400
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:19941 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP id S263332AbTDLQdd (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 12:33:33 -0400
Message-ID: <20030412164514.3171.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Sun, 13 Apr 2003 00:45:14 +0800
Subject: [BENCHMARK] LMbench - 2.4.19 vs 2.5.67
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please let me know if you need further informatio and 
please cc me if you want to reply this email ;)

Ciao,
           Paolo
           

cd results && make summary percent 2>/dev/null | more
make[1]: Entering directory `/usr/src/LMbench/results'

                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------


Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz
                                                    
--------- ------------- ----------------------- ----
frodo      Linux 2.5.67       i686-pc-linux-gnu  789
frodo      Linux 2.5.67       i686-pc-linux-gnu  789
frodo      Linux 2.5.67       i686-pc-linux-gnu  789
frodo      Linux 2.4.19       i686-pc-linux-gnu  789
frodo      Linux 2.4.19       i686-pc-linux-gnu  789
frodo      Linux 2.4.19       i686-pc-linux-gnu  789

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh  
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
frodo      Linux 2.5.67  789 0.39 0.61 3.97 5.39  18.1 1.17 3.36 159. 1298 4969
frodo      Linux 2.5.67  789 0.39 0.61 3.99 5.40  17.5 1.17 3.43 152. 1397 5351
frodo      Linux 2.5.67  789 0.39 0.62 3.97 5.49  20.6 1.19 3.36 154. 1413 5354
frodo      Linux 2.4.19  789 0.41 0.55 3.51 4.41  17.1 1.04 3.45 106. 956. 4446
frodo      Linux 2.4.19  789 0.38 0.55 3.52 4.38  17.1 1.02 3.45 104. 969. 4475
frodo      Linux 2.4.19  789 0.38 0.55 3.55 4.44  18.8 1.02 3.45 105. 1016 4480

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
frodo      Linux 2.5.67 1.040 4.5200   17.0   11.8  313.7    53.0   314.4
frodo      Linux 2.5.67 1.150 4.7000   15.6 6.5100  314.0    54.8   314.0
frodo      Linux 2.5.67 1.080 4.6000   15.1 7.2000  314.0    59.0   314.2
frodo      Linux 2.4.19 0.880 4.2500   14.0 7.5300  309.9    55.6   309.9
frodo      Linux 2.4.19 1.000 4.4100   14.1 7.6500  309.7    44.1   310.0
frodo      Linux 2.4.19 0.870 4.4300   14.2 5.7500  310.5    50.5   310.9

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
frodo      Linux 2.5.67 1.040 6.059 8.67  17.8  38.5  25.2  48.3 87.8
frodo      Linux 2.5.67 1.150 6.120 9.08  17.9  38.5  25.6  48.3 88.0
frodo      Linux 2.5.67 1.080 6.159 8.98  17.9  38.5  25.6  48.6 87.5
frodo      Linux 2.4.19 0.880 4.443 8.14  15.1  35.5  22.6  47.4 77.9
frodo      Linux 2.4.19 1.000 4.585 8.29  15.3  35.5  22.7  48.7 78.3
frodo      Linux 2.4.19 0.870 4.833 8.56  15.3  35.8  22.5  48.6 77.4

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
frodo      Linux 2.5.67   64.3   89.0  254.8  126.1    713.0 0.593 3.00000
frodo      Linux 2.5.67   64.3   89.1  256.3  126.2    741.0 0.565 3.00000
frodo      Linux 2.5.67   64.4   89.2  255.6  126.3    734.0 0.616 3.00000
frodo      Linux 2.4.19   58.3   87.0  238.1  119.2    413.0 0.746 2.00000
frodo      Linux 2.4.19   58.3   86.9  238.2  119.3    418.0 0.741 2.00000
frodo      Linux 2.4.19   58.3   87.0  301.9  120.0    439.0 0.741 2.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
frodo      Linux 2.5.67 486. 545. 54.1  185.4  202.5  143.5  100.4 202. 185.5
frodo      Linux 2.5.67 536. 629. 57.7  184.8  202.5  143.7  100.4 202. 185.5
frodo      Linux 2.5.67 505. 528. 56.1  184.8  202.4  145.7  100.4 202. 188.3
frodo      Linux 2.4.19 774. 329. 180.  186.6  203.7  146.0  101.6 203. 187.2
frodo      Linux 2.4.19 787. 399. 198.  187.2  203.7  145.9  101.6 203. 187.4
frodo      Linux 2.4.19 797. 647. 211.  187.1  203.7  148.3  101.6 203. 189.8

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
frodo      Linux 2.5.67   789 3.797 8.9030  160.1
frodo      Linux 2.5.67   789 3.798 8.8770  160.1
frodo      Linux 2.5.67   789 3.805 8.8770  160.1
frodo      Linux 2.4.19   789 3.767 8.7990  158.9
frodo      Linux 2.4.19   789 3.767 8.7900  158.9
frodo      Linux 2.4.19   789 3.767 8.7910  158.9
make[1]: Leaving directory `/usr/src/LMbench/results'

-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
