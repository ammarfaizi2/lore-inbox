Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265552AbRFVWgU>; Fri, 22 Jun 2001 18:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265553AbRFVWgK>; Fri, 22 Jun 2001 18:36:10 -0400
Received: from apollo.cis.from.de ([194.162.209.12]:63617 "EHLO
	apollo.cis.from.de") by vger.kernel.org with ESMTP
	id <S265552AbRFVWgC>; Fri, 22 Jun 2001 18:36:02 -0400
Mime-Version: 1.0
Message-Id: <p05100321b759772d397f@[194.162.209.20]>
Date: Sat, 23 Jun 2001 00:35:13 +0200
To: linux-kernel@vger.kernel.org
From: Ingo Ciechowski <ciechowski@cis-computer.com>
Subject: High system CPU% in dual CPU System
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm experiencing very high system CPU% indications on my new dual 
Pentium III machine (SuSE Linux 7.1, Kernel 2.4.4-SMP):

  12:26am  up 1 day,  8:34,  9 users,  load average: 1.44, 2.74, 3.26
116 processes: 113 sleeping, 3 running, 0 zombie, 0 stopped
CPU0 states: 19.2% user, 32.0% system,  0.0% nice, 48.2% idle
CPU1 states: 20.4% user, 40.1% system,  0.0% nice, 38.3% idle
Mem:   512180K av,  498144K used,   14036K free,       0K shrd,  145360K buff
Swap: 1024120K av,    8504K used, 1015616K free                   39976K cache

   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
20308 root       9   0 21056  20M  1744 S     2.7  4.1   6:14 X
30471 capicall  12   0  1020 1020   772 R     0.7  0.1   0:36 top
   594 root       9   0   628  628   480 S     0.5  0.1   6:59 nscd
22072 ingo      17   0  1484 1484   576 R     0.5  0.2   0:00 ps
   596 root       9   0   628  628   480 S     0.3  0.1   6:36 nscd
22467 ingo       9   0  3940 3940  2812 R     0.3  0.7  11:03 gkrellm
22978 ingo       9   0  1380 1380  1132 S     0.3  0.2   0:04 ssh
   597 root       9   0   628  628   480 S     0.1  0.1   6:31 nscd
   598 root       9   0   628  628   480 S     0.1  0.1   6:35 nscd
22071 ingo      17   0  1036 1036   852 S     0.1  0.2   0:00 sh
...


After the initial Installation everything was fine - it must be 
caused by some additonal package, but I have no clue.

What can I do to find out what the CPUs are doing during "system" time?

-- 

Ingo
ciechowski@cis-computer.com

