Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281877AbRLHPlC>; Sat, 8 Dec 2001 10:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281932AbRLHPk4>; Sat, 8 Dec 2001 10:40:56 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:42500 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S281877AbRLHPko>; Sat, 8 Dec 2001 10:40:44 -0500
Date: Sat, 8 Dec 2001 09:40:37 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: brain@artax.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org
Subject: Re: 119.5% CPU load
Message-ID: <20011208094037.B1179@asooo.flowerfire.com>
In-Reply-To: <Pine.LNX.4.30.0112081433280.1658-100000@ghost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.30.0112081433280.1658-100000@ghost>; from brain@artax.karlin.mff.cuni.cz on Sat, Dec 08, 2001 at 04:43:30PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heh, that's nothing.  I see this all the time (I just chose a random
machine and voila):

  7:35am  up 172 days,  7:29,  1 user,  load average: 8.76, 9.69, 10.87
126 processes: 117 sleeping, 9 running, 0 zombie, 0 stopped
CPU states: 38.9% user, 18.9% system, 42.1% nice, 421902.3% idle
Mem:   517192K av,  514040K used,    3152K free,   78564K shrd,   84884K buff
Swap: 1025016K av,    4380K used, 1020636K free                  255572K cached

I've always assumed it's a 'top' precision issue, but I think I've only
seen this on 2.2 now that I think about it.

-- 
Ken.
brownfld@irridia.com


On Sat, Dec 08, 2001 at 04:43:30PM +0100, brain@artax.karlin.mff.cuni.cz wrote:
| Hello.
| 
| Look at this "top" snapshot:
| 
| -----------------------------------------------------------------------------
|   2:30pm  up  3:46, 10 users,  load average: 2.96, 1.50, 0.84
| 49 processes: 44 sleeping, 4 running, 0 zombie, 1 stopped
| CPU states:  0.1% user, 119.4% system,  0.0% nice,  0.0% idle
| Mem:   63208K av,  62004K used,   1204K free,  24556K shrd,  34892K buff
| Swap:  34236K av,    140K used,  34096K free                  7056K cached
| 
|   PID USER     PRI  NI  SIZE  RSS SHARE STAT  LIB %CPU %MEM   TIME COMMAND
|  1632 brain     20   0  1724 1724   992 R       0 33.4  2.7   1:19 mc
|  1654 brain     20   0   784  784   576 R       0 32.2  1.2   0:49 mpg123
|  1652 root      14   0   500  500   368 R       0 21.4  0.7   0:40 top
|    84 root       0   0   244  224   192 S       0 15.7  0.3   0:03 gpm
|  1655 root      20   0   624  624   476 R       0 10.6  0.9   0:02 vi
|     3 root       0   0     0    0     0 SW      0  5.0  0.0   0:18 kupdate
|   121 root       2   0   844  844   588 S       0  0.6  1.3   0:00 bash
|     4 root       0   0     0    0     0 SW      0  0.2  0.0   0:08 kswapd
| -----------------------------------------------------------------------------
| 
| That's not a joke, it WAS on my machine on very busy network. I've got 2.2.19
| kernel and single AMD K6-2/400. I don't have any turbocharger, so I suppose my
| CPU is able to perform mere 100% of the load. Can you explain it?
| 
| Thanx
| 
| Brain
| 
| --------------------------------
| Petr `Brain' Kulhavy
| <brain@artax.karlin.mff.cuni.cz>
| http://artax.karlin.mff.cuni.cz/~brain
| Faculty of Mathematics and Physics, Charles University Prague, Czech Republic
| 
| ---
| Promising costs nothing, it's the delivering that kills you.
| 
| 
| 
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
