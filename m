Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279822AbRKXUNC>; Sat, 24 Nov 2001 15:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279846AbRKXUMw>; Sat, 24 Nov 2001 15:12:52 -0500
Received: from adsl-64-164-47-8.dsl.scrm01.pacbell.net ([64.164.47.8]:56305
	"EHLO satan.diablo.localnet") by vger.kernel.org with ESMTP
	id <S279822AbRKXUMj>; Sat, 24 Nov 2001 15:12:39 -0500
Date: Sat, 24 Nov 2001 12:12:31 -0800
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: kswapd and system response
Message-ID: <20011124121231.A2062@dirac.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
From: Peter Jay Salzman <p@dirac.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi there,

every so often, my system (2.4.13 smp) gets really sloooooow.   a typical top
looks something like:

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
    5 root      14   0     0    0     0 RW   99.9  0.0   7:52 kswapd
    7 root       9   0     0    0     0 SW    1.9  0.0   0:04 kupdated
 2053 root      13   0   984  984   776 R     0.7  0.4   0:01 top
 2063 p          9   0  2080 2080  1292 S     0.3  0.9   0:00 vim

kswapd is definitely not behaving correctly.

the thing that brought it on this time was gtv (an mpeg viewer which uses
sdl) bailed on me.   X "kind of" froze, so i killed it.  but that's only the
cause this time around.  last time, it happened between the time of going to
bed and waking up (ie- the system was pretty much idling from a user's pov).

this has been happening with the 2.4.13 kernel every couple of days.

i thought i'd post it to lkml to let someone know that there's a problem.
i'm not subscribed to the list, so if there's anything else i can do to help
diagnose what's going on next time it happens, please cc me.

i feel like such a loser when i reboot.   ;)   i heard that 2.4.15 was just
released, so i'll try upgrading to that and see if it helps any.


pete

-- 
PGP Fingerprint: B9F1 6CF3 47C4 7CD8 D33E  70A9 A3B9 1945 67EA 951D
PGP Public Key:  finger p@dirac.org
