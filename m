Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280725AbRLHOeG>; Sat, 8 Dec 2001 09:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280825AbRLHOd4>; Sat, 8 Dec 2001 09:33:56 -0500
Received: from datela-1-4-13.dialup.vol.cz ([212.20.98.47]:56328 "HELO
	ghost.btnet.cz") by vger.kernel.org with SMTP id <S280725AbRLHOdt>;
	Sat, 8 Dec 2001 09:33:49 -0500
Date: Sat, 8 Dec 2001 16:43:30 +0100 (MET)
From: <brain@artax.karlin.mff.cuni.cz>
To: <linux-kernel@vger.kernel.org>
Subject: 119.5% CPU load
Message-ID: <Pine.LNX.4.30.0112081433280.1658-100000@ghost>
X-Echelon: GRU Vatutinki Chodynka Khodinka Putin Suvorov USA Aquarium Russia Ladygin Lybia China Moscow missile reconnaissance agent spetsnaz security tactical target operation military nuclear force defense spy attack bomb explode tap MI5 IRS KGB CIA FBI NSA AK-47 MOSSAD M16 plutonium smuggle intercept plan intelligence war analysis president
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Look at this "top" snapshot:

-----------------------------------------------------------------------------
  2:30pm  up  3:46, 10 users,  load average: 2.96, 1.50, 0.84
49 processes: 44 sleeping, 4 running, 0 zombie, 1 stopped
CPU states:  0.1% user, 119.4% system,  0.0% nice,  0.0% idle
Mem:   63208K av,  62004K used,   1204K free,  24556K shrd,  34892K buff
Swap:  34236K av,    140K used,  34096K free                  7056K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT  LIB %CPU %MEM   TIME COMMAND
 1632 brain     20   0  1724 1724   992 R       0 33.4  2.7   1:19 mc
 1654 brain     20   0   784  784   576 R       0 32.2  1.2   0:49 mpg123
 1652 root      14   0   500  500   368 R       0 21.4  0.7   0:40 top
   84 root       0   0   244  224   192 S       0 15.7  0.3   0:03 gpm
 1655 root      20   0   624  624   476 R       0 10.6  0.9   0:02 vi
    3 root       0   0     0    0     0 SW      0  5.0  0.0   0:18 kupdate
  121 root       2   0   844  844   588 S       0  0.6  1.3   0:00 bash
    4 root       0   0     0    0     0 SW      0  0.2  0.0   0:08 kswapd
-----------------------------------------------------------------------------

That's not a joke, it WAS on my machine on very busy network. I've got 2.2.19
kernel and single AMD K6-2/400. I don't have any turbocharger, so I suppose my
CPU is able to perform mere 100% of the load. Can you explain it?

Thanx

Brain

--------------------------------
Petr `Brain' Kulhavy
<brain@artax.karlin.mff.cuni.cz>
http://artax.karlin.mff.cuni.cz/~brain
Faculty of Mathematics and Physics, Charles University Prague, Czech Republic

---
Promising costs nothing, it's the delivering that kills you.



