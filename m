Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264878AbTBJP7Y>; Mon, 10 Feb 2003 10:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264903AbTBJP7Y>; Mon, 10 Feb 2003 10:59:24 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:42197 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S264878AbTBJP7V>; Mon, 10 Feb 2003 10:59:21 -0500
Date: Mon, 10 Feb 2003 17:08:54 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre4
Message-ID: <20030210160854.GB1973@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.53L.0301290143350.27119@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.53L.0301290143350.27119@freak.distro.conectiva>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I got the following compile error on i386. Config is rather long.
http://wh.fh-wedel.de/~joern/.config

make[1]: Entering directory `/home/joern/i386/linux-2.4.21-pre4/kernel'
make all_targets
make[2]: Entering directory `/home/joern/i386/linux-2.4.21-pre4/kernel'
gcc -D__KERNEL__ -I/home/joern/i386/linux-2.4.21-pre4/include -Wall -Wstrict-pro
totypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-st
ack-boundary=2 -march=i686   -nostdinc -iwithprefix include -DKBUILD_BASENAME=sc
hed  -fno-omit-frame-pointer -c -o sched.o sched.c
beam_compile  -DKBUILD_BASENAME=sched  -fno-omit-frame-pointer -c sched.c
In file included from /usr/include/linux/timex.h:152,
                 from /usr/include/linux/sched.h:14,
                 from /usr/include/linux/mm.h:4,
                 from sched.c:23:
/usr/include/asm/timex.h:10:21: asm/msr.h: No such file or directory
In file included from /usr/include/linux/sched.h:14,
                 from /usr/include/linux/mm.h:4,
                 from sched.c:23:
/usr/include/linux/timex.h:173: field `time' has incomplete type
In file included from /usr/include/linux/bitops.h:69,
                 from /usr/include/asm/system.h:7,
                 from /usr/include/linux/sched.h:16,
                 from /usr/include/linux/mm.h:4,
                 from sched.c:23:
/usr/include/asm/bitops.h:333:2: warning: #warning This includefile is not avail
able on all architectures.
/usr/include/asm/bitops.h:334:2: warning: #warning Using kernel headers in users
pace.
In file included from /usr/include/linux/signal.h:4,
                 from /usr/include/linux/sched.h:25,
                 from /usr/include/linux/mm.h:4,
                 from sched.c:23:
/usr/include/asm/signal.h:107: parse error before "sigset_t"
/usr/include/asm/signal.h:110: parse error before '}' token
In file included from /usr/include/linux/timer.h:18,
                 from /usr/include/linux/sched.h:81,
                 from /usr/include/linux/mm.h:4,
                 from sched.c:23:
/usr/include/linux/spinlock.h:131: parse error before '*' token
In file included from /usr/include/linux/sched.h:81,
                 from /usr/include/linux/mm.h:4,
                 from sched.c:23:
/usr/include/linux/timer.h:32: field `vec' has incomplete type
/usr/include/linux/timer.h:37: field `vec' has incomplete type
/usr/include/linux/timer.h:63: field `list' has incomplete type
/usr/include/linux/timer.h:121: confused by earlier errors, bailing out
make[2]: *** [sched.o] Error 1
make[2]: Leaving directory `/home/joern/i386/linux-2.4.21-pre4/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/home/joern/i386/linux-2.4.21-pre4/kernel'
make: *** [_dir_kernel] Error 2


Jörn

-- 
Optimizations always bust things, because all optimizations are, in
the long haul, a form of cheating, and cheaters eventually get caught.
-- Larry Wall 
