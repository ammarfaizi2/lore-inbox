Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135177AbRDLM7e>; Thu, 12 Apr 2001 08:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135180AbRDLM7Y>; Thu, 12 Apr 2001 08:59:24 -0400
Received: from barn.holstein.com ([198.134.143.193]:52490 "EHLO holstein.com")
	by vger.kernel.org with ESMTP id <S135177AbRDLM7Q>;
	Thu, 12 Apr 2001 08:59:16 -0400
Date: Thu, 12 Apr 2001 12:59:04 GMT
Message-Id: <200104121259.f3CCx4807684@pcx4168.holstein.com>
From: "Todd M. Roy" <troy@holstein.com>
To: linux-kernel@vger.kernel.org
Subject: compile error with 2.4.4-pre2
Reply-To: troy@holstein.com
X-MIMETrack: Itemize by SMTP Server on Imail/Holstein(Release 5.0.1b|September 30, 1999) at
 04/12/2001 08:59:06 AM,
	Serialize by Router on Imail/Holstein(Release 5.0.1b|September 30, 1999) at
 04/12/2001 08:59:06 AM,
	Serialize complete at 04/12/2001 08:59:06 AM
X-Priority: 3 (Normal)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this when I try to compile 2.4.4-pre2
(I'm assuming the list is working this morning, since I've received no
messages).
Thanks.
-- todd --

$ make bzImage
gcc -D__KERNEL__ -I/var/src/linux-2.4.3/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686   -c -o init/main.o init/main.c
In file included from /var/src/linux-2.4.3/include/asm/rwsem.h:20,
                 from /var/src/linux-2.4.3/include/asm/semaphore.h:42,
                 from /var/src/linux-2.4.3/include/linux/fs.h:199,
                 from /var/src/linux-2.4.3/include/linux/capability.h:17,
                 from /var/src/linux-2.4.3/include/linux/binfmts.h:5,
                 from /var/src/linux-2.4.3/include/linux/sched.h:9,
                 from /var/src/linux-2.4.3/include/linux/mm.h:4,
                 from /var/src/linux-2.4.3/include/linux/slab.h:14,
                 from /var/src/linux-2.4.3/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/var/src/linux-2.4.3/include/asm/spinlock.h:36: warning: `SPIN_LOCK_UNLOCKED' redefined
/var/src/linux-2.4.3/include/linux/spinlock.h:55: warning: this is the location of the previous definition
/var/src/linux-2.4.3/include/asm/spinlock.h:38: warning: `spin_lock_init' redefined
/var/src/linux-2.4.3/include/linux/spinlock.h:58: warning: this is the location of the previous definition
/var/src/linux-2.4.3/include/asm/spinlock.h:47: warning: `spin_is_locked' redefined
/var/src/linux-2.4.3/include/linux/spinlock.h:60: warning: this is the location of the previous definition
/var/src/linux-2.4.3/include/asm/spinlock.h:48: warning: `spin_unlock_wait' redefined
/var/src/linux-2.4.3/include/linux/spinlock.h:62: warning: this is the location of the previous definition
/var/src/linux-2.4.3/include/asm/spinlock.h:131: warning: `RW_LOCK_UNLOCKED' redefined
/var/src/linux-2.4.3/include/linux/spinlock.h:118: warning: this is the location of the previous definition
/var/src/linux-2.4.3/include/asm/spinlock.h:133: warning: `rwlock_init' redefined
/var/src/linux-2.4.3/include/linux/spinlock.h:121: warning: this is the location of the previous definition
/var/src/linux-2.4.3/include/asm/spinlock.h:164: warning: `read_unlock' redefined
/var/src/linux-2.4.3/include/linux/spinlock.h:123: warning: this is the location of the previous definition
/var/src/linux-2.4.3/include/asm/spinlock.h:165: warning: `write_unlock' redefined
/var/src/linux-2.4.3/include/linux/spinlock.h:125: warning: this is the location of the previous definition
In file included from /var/src/linux-2.4.3/include/asm/rwsem.h:20,
                 from /var/src/linux-2.4.3/include/asm/semaphore.h:42,
                 from /var/src/linux-2.4.3/include/linux/fs.h:199,
                 from /var/src/linux-2.4.3/include/linux/capability.h:17,
                 from /var/src/linux-2.4.3/include/linux/binfmts.h:5,
                 from /var/src/linux-2.4.3/include/linux/sched.h:9,
                 from /var/src/linux-2.4.3/include/linux/mm.h:4,
                 from /var/src/linux-2.4.3/include/linux/slab.h:14,
                 from /var/src/linux-2.4.3/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/var/src/linux-2.4.3/include/asm/spinlock.h:26: conflicting types for `spinlock_t'
/var/src/linux-2.4.3/include/linux/spinlock.h:54: previous declaration of `spinlock_t'
/var/src/linux-2.4.3/include/asm/spinlock.h:68: parse error before `{'
/var/src/linux-2.4.3/include/asm/spinlock.h:78: parse error before `void'
/var/src/linux-2.4.3/include/asm/spinlock.h:93: parse error before `do'
/var/src/linux-2.4.3/include/asm/spinlock.h:121: conflicting types for `rwlock_t'
/var/src/linux-2.4.3/include/linux/spinlock.h:117: previous declaration of `rwlock_t'
/var/src/linux-2.4.3/include/asm/spinlock.h:146: parse error before `void'
/var/src/linux-2.4.3/include/asm/spinlock.h:155: parse error before `void'
make: *** [init/main.o] Error 1
root [pcx4168] /usr/src/linux
$ 
**********************************************************************
This footnote confirms that this email message has been swept by 
MIMEsweeper for the presence of computer viruses.
**********************************************************************
