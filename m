Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317521AbSIENn4>; Thu, 5 Sep 2002 09:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317525AbSIENn4>; Thu, 5 Sep 2002 09:43:56 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:25812 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S317521AbSIENny>;
	Thu, 5 Sep 2002 09:43:54 -0400
Date: Thu, 5 Sep 2002 15:48:30 +0200
From: bert hubert <ahu@ds9a.nl>
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: side-by-side Re: BYTE Unix Benchmarks Version 3.6
Message-ID: <20020905134830.GA16149@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Paolo Ciarrocchi <ciarrocchi@linuxmail.org>,
	linux-kernel@vger.kernel.org
References: <20020904220055.21349.qmail@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020904220055.21349.qmail@linuxmail.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Side-by-side with some marked changes highlighted:

                                        2.4.19           2.5.33
-----------------------------------------------------------------------
Dhrystone 2 without register variable   1499020.6 lps    1488327.9 lps
Dhrystone 2 using register variables    1501168.4 lps    1488265.3 lps
Arithmetic Test (type = arithoh)        3598100.4 lps    3435944.6 lps
Arithmetic Test (type = register)        201521.0 lps     197870.4 lps
Arithmetic Test (type = short)           190245.9 lps     145140.8 lps
Arithmetic Test (type = int)             201904.5 lps     104440.5 lps
Arithmetic Test (type = long)            201906.4 lps     177757.4 lps
Arithmetic Test (type = float)           210562.7 lps     208476.4 lps
Arithmetic Test (type = double)          210385.9 lps     208443.3 lps
System Call Overhead Test                407402.6 lps     397276.7 lps
>Pipe Throughput Test                    476268.6 lps     434561.9 lps
>Pipe-based Context Switching Test       218969.9 lps     148653.5 lps
>Process Creation Test                     9078.6 lps       5422.1 lps
Execl Throughput Test                       998.0 lps        771.6 lps
File Read  (10 seconds)                 1571652.0 KBps   1553289.0 KBps
File Write (10 seconds)                  109237.0 KBps    132002.0 KBps
>File Copy  (10 seconds)                  24329.0 KBps     17994.0 KBps
File Read  (30 seconds)                 1562505.0 KBps   1540682.0 KBps
File Write (30 seconds)                  113152.0 KBps    137781.0 KBps
File Copy  (30 seconds)                   14334.0 KBps     11460.0 KBps
C Compiler Test                             470.9 lpm        450.9 lpm
Shell scripts (1 concurrent)                980.4 lpm        876.7 lpm
Shell scripts (2 concurrent)                544.1 lpm        480.3 lpm
Shell scripts (4 concurrent)                287.0 lpm        251.0 lpm
Shell scripts (8 concurrent)                147.0 lpm        126.0 lpm
>Dc: sqrt(2) to 99 decimal places         42311.6 lpm      33530.4 lpm
Recursion Test--Tower of Hanoi            18915.4 lps      18514.3 lps
 
 
                      INDEX VALUES           2.4.19     2.5      
 TEST                                        INDEX      INDEX

 Arithmetic Test (type = double)              82.8       82.0
 Dhrystone 2 without register variables       67.0       66.5
 Execl Throughput Test                        60.5       46.8
 File Copy  (30 seconds)                      80.1       64.0
 Pipe-based Context Switching Test           166.1      112.7
 Shell scripts (8 concurrent)                 36.8       31.5
                                         =========  =========
      SUM of  6 items                        493.2      403.6
      AVERAGE                                 82.2       67.3

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
