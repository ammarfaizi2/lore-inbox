Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133059AbRDLHOT>; Thu, 12 Apr 2001 03:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133060AbRDLHOJ>; Thu, 12 Apr 2001 03:14:09 -0400
Received: from mx1.sac.fedex.com ([199.81.208.10]:10766 "EHLO
	mx1.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S133059AbRDLHOF>; Thu, 12 Apr 2001 03:14:05 -0400
Date: Thu, 12 Apr 2001 15:14:28 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: <root@boston.corp.fedex.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: can't compile 2.4.4-pre2
Message-ID: <Pine.LNX.4.33.0104121510110.878-100000@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Below are the errors generated from "make" for 2.4.4-pre2

I've no problem compiling 2.4.4-pre1.
_______________________________________________________________________

gcc -D__KERNEL__ -I/u2/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=i586 -c -o init/main.o init/main.c
In file included from /u2/src/linux/include/asm/rwsem.h:20,
                 from /u2/src/linux/include/asm/semaphore.h:42,
                 from /u2/src/linux/include/linux/fs.h:199,
                 from /u2/src/linux/include/linux/capability.h:17,
                 from /u2/src/linux/include/linux/binfmts.h:5,
                 from /u2/src/linux/include/linux/sched.h:9,
                 from /u2/src/linux/include/linux/mm.h:4,
                 from /u2/src/linux/include/linux/slab.h:14,
                 from /u2/src/linux/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/u2/src/linux/include/asm/spinlock.h:36: warning: `SPIN_LOCK_UNLOCKED'
redefined/u2/src/linux/include/linux/spinlock.h:55: warning: this is the
location of the previous definition
/u2/src/linux/include/asm/spinlock.h:38: warning: `spin_lock_init' redefined
/u2/src/linux/include/linux/spinlock.h:58: warning: this is the location
of the previous definition
/u2/src/linux/include/asm/spinlock.h:47: warning: `spin_is_locked' redefined
/u2/src/linux/include/linux/spinlock.h:60: warning: this is the location
of the previous definition
/u2/src/linux/include/asm/spinlock.h:48: warning: `spin_unlock_wait' redefined
/u2/src/linux/include/linux/spinlock.h:62: warning: this is the location
of the previous definition
/u2/src/linux/include/asm/spinlock.h:131: warning: `RW_LOCK_UNLOCKED' redefined
/u2/src/linux/include/linux/spinlock.h:118: warning: this is the location
of the previous definition
/u2/src/linux/include/asm/spinlock.h:133: warning: `rwlock_init' redefined
/u2/src/linux/include/linux/spinlock.h:121: warning: this is the location
of the previous definition
/u2/src/linux/include/asm/spinlock.h:164: warning: `read_unlock' redefined
/u2/src/linux/include/linux/spinlock.h:123: warning: this is the location
of the previous definition
/u2/src/linux/include/asm/spinlock.h:165: warning: `write_unlock' redefined
/u2/src/linux/include/linux/spinlock.h:125: warning: this is the location
of the previous definition
In file included from /u2/src/linux/include/asm/rwsem.h:20,
                 from /u2/src/linux/include/asm/semaphore.h:42,
                 from /u2/src/linux/include/linux/fs.h:199,
                 from /u2/src/linux/include/linux/capability.h:17,
                 from /u2/src/linux/include/linux/binfmts.h:5,
                 from /u2/src/linux/include/linux/sched.h:9,
                 from /u2/src/linux/include/linux/mm.h:4,
                 from /u2/src/linux/include/linux/slab.h:14,
                 from /u2/src/linux/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/u2/src/linux/include/asm/spinlock.h:26: conflicting types for `spinlock_t'
/u2/src/linux/include/linux/spinlock.h:54: previous declaration of `spinlock_t'
/u2/src/linux/include/asm/spinlock.h:68: parse error before `{'
/u2/src/linux/include/asm/spinlock.h:78: parse error before `void'
/u2/src/linux/include/asm/spinlock.h:93: parse error before `do'
/u2/src/linux/include/asm/spinlock.h:121: conflicting types for `rwlock_t'
/u2/src/linux/include/linux/spinlock.h:117: previous declaration of `rwlock_t'
/u2/src/linux/include/asm/spinlock.h:146: parse error before `void'
/u2/src/linux/include/asm/spinlock.h:155: parse error before `void'
make: *** [init/main.o] Error 1



Thanks,
Jeff
[ jchua@fedex.com ]

