Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269311AbUJKWmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269311AbUJKWmq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 18:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269313AbUJKWmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 18:42:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:57760 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S269311AbUJKWm3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 18:42:29 -0400
X-Authenticated: #4399952
Date: Tue, 12 Oct 2004 00:57:54 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mark_H_Johnson@Raytheon.com, Andrew Morton <akpm@osdl.org>,
       Daniel Walker <dwalker@mvista.com>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [patch] VP-2.6.9-rc4-mm1-T5
Message-ID: <20041012005754.1d49a074@mango.fruits.de>
In-Reply-To: <20041011215909.GA20686@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
	<20041011215909.GA20686@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2004 23:59:09 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> i've uploaded -T5 which should fix most of the build issues:
> 
>  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-T5
> 

hi,

i still can't build it. Fist i reverse applied T4, then applied T5 and tried
a make bzImage. I'll try from scratch though to make sure, cause these
errors look identical to the T4 ones.

  CLEAN   .tmp_versions
  CHK     include/linux/version.h
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/basic/split-include
  HOSTCC  scripts/basic/docproc
  HOSTCC  scripts/genksyms/genksyms.o
  HOSTCC  scripts/genksyms/lex.o
  HOSTCC  scripts/genksyms/parse.o
  HOSTLD  scripts/genksyms/genksyms
  CC      scripts/mod/empty.o
  HOSTCC  scripts/mod/mk_elfconfig
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/file2alias.o
  HOSTCC  scripts/mod/modpost.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTLD  scripts/mod/modpost
  HOSTCC  scripts/kallsyms
  HOSTCC  scripts/conmakehash
  HOSTCC  scripts/bin2c
  CC      arch/i386/kernel/asm-offsets.s
In file included from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
                 from arch/i386/kernel/asm-offsets.c:7:
include/linux/spinlock.h:419: error: parse error before '*' token
include/linux/spinlock.h:419: warning: function declaration isn't a prototype
include/linux/spinlock.h:420: error: parse error before '*' token
include/linux/spinlock.h:420: warning: function declaration isn't a prototype
include/linux/spinlock.h:421: error: parse error before '*' token
include/linux/spinlock.h:421: warning: function declaration isn't a prototype
include/linux/spinlock.h:422: error: parse error before '*' token
include/linux/spinlock.h:422: warning: function declaration isn't a prototype
include/linux/spinlock.h:423: error: parse error before '*' token
include/linux/spinlock.h:423: warning: function declaration isn't a prototype
include/linux/spinlock.h:424: error: parse error before '*' token
include/linux/spinlock.h:424: warning: function declaration isn't a prototype
include/linux/spinlock.h:425: error: parse error before '*' token
include/linux/spinlock.h:425: warning: function declaration isn't a prototype
include/linux/spinlock.h:426: error: parse error before '*' token
include/linux/spinlock.h:426: warning: function declaration isn't a prototype
include/linux/spinlock.h:427: error: parse error before '*' token
include/linux/spinlock.h:427: warning: function declaration isn't a prototype
include/linux/spinlock.h:428: error: parse error before '*' token
include/linux/spinlock.h:428: warning: function declaration isn't a prototype
include/linux/spinlock.h:429: error: parse error before '*' token
include/linux/spinlock.h:429: warning: function declaration isn't a prototype
include/linux/spinlock.h:430: error: parse error before '*' token
include/linux/spinlock.h:430: warning: function declaration isn't a prototype
include/linux/spinlock.h:431: error: parse error before '*' token
include/linux/spinlock.h:431: warning: function declaration isn't a prototype
include/linux/spinlock.h:467: error: parse error before '*' token
include/linux/spinlock.h:467: warning: function declaration isn't a prototype
include/linux/spinlock.h:468: error: parse error before '*' token
include/linux/spinlock.h:468: warning: function declaration isn't a prototype
include/linux/spinlock.h:469: error: parse error before '*' token
include/linux/spinlock.h:469: warning: function declaration isn't a prototype
include/linux/spinlock.h:470: error: parse error before '*' token
include/linux/spinlock.h:470: warning: function declaration isn't a prototype
include/linux/spinlock.h:471: error: parse error before '*' token
include/linux/spinlock.h:471: warning: function declaration isn't a prototype
include/linux/spinlock.h:472: error: parse error before '*' token
include/linux/spinlock.h:472: warning: function declaration isn't a prototype
include/linux/spinlock.h:473: error: parse error before '*' token
include/linux/spinlock.h:473: warning: function declaration isn't a prototype
include/linux/spinlock.h:474: error: parse error before '*' token
include/linux/spinlock.h:474: warning: function declaration isn't a prototype
include/linux/spinlock.h:475: error: parse error before '*' token
include/linux/spinlock.h:475: warning: function declaration isn't a prototype
include/linux/spinlock.h:476: error: parse error before '*' token
include/linux/spinlock.h:476: warning: function declaration isn't a prototype
include/linux/spinlock.h:477: error: parse error before '*' token
include/linux/spinlock.h:477: warning: function declaration isn't a prototype
include/linux/spinlock.h:478: error: parse error before '*' token
include/linux/spinlock.h:478: warning: function declaration isn't a prototype
include/linux/spinlock.h:479: error: parse error before '*' token
include/linux/spinlock.h:479: warning: function declaration isn't a prototype
include/linux/spinlock.h:480: error: parse error before '*' token
include/linux/spinlock.h:480: warning: function declaration isn't a prototype
include/linux/spinlock.h:481: error: parse error before '*' token
include/linux/spinlock.h:481: warning: function declaration isn't a prototype
include/linux/spinlock.h:482: error: parse error before '*' token
include/linux/spinlock.h:482: warning: function declaration isn't a prototype
include/linux/spinlock.h:483: error: parse error before '*' token
include/linux/spinlock.h:483: warning: function declaration isn't a prototype
include/linux/spinlock.h:484: error: parse error before '*' token
include/linux/spinlock.h:484: warning: function declaration isn't a prototype
include/linux/spinlock.h:485: error: parse error before '*' token
include/linux/spinlock.h:485: warning: function declaration isn't a prototype
include/linux/spinlock.h:486: error: parse error before '*' token
include/linux/spinlock.h:486: warning: function declaration isn't a prototype
In file included from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
                 from arch/i386/kernel/asm-offsets.c:7:
include/linux/spinlock.h:543:1: warning: "spin_lock_init" redefined
include/linux/spinlock.h:208:1: warning: this is the location of the previous definition
include/linux/spinlock.h:548:1: warning: "rwlock_init" redefined
include/linux/spinlock.h:226:1: warning: this is the location of the previous definition
include/linux/spinlock.h:553:1: warning: "spin_is_locked" redefined
include/linux/spinlock.h:210:1: warning: this is the location of the previous definition
include/linux/spinlock.h:563:1: warning: "spin_unlock_wait" redefined
include/linux/spinlock.h:212:1: warning: this is the location of the previous definition
In file included from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
                 from arch/i386/kernel/asm-offsets.c:7:
include/linux/spinlock.h:669: error: parse error before "raw_spinlock_t"
include/linux/spinlock.h:669: warning: function declaration isn't a prototype
In file included from include/linux/time.h:7,
                 from include/linux/timex.h:58,
                 from include/linux/sched.h:11,
                 from arch/i386/kernel/asm-offsets.c:7:
include/linux/seqlock.h:35: error: parse error before "raw_spinlock_t"
include/linux/seqlock.h:35: warning: no semicolon at end of struct or union
include/linux/seqlock.h:36: warning: type defaults to `int' in declaration of `seqlock_t'
include/linux/seqlock.h:36: warning: data definition has no type or storage class
include/linux/seqlock.h:50: error: parse error before '*' token
include/linux/seqlock.h:51: warning: function declaration isn't a prototype
include/linux/seqlock.h: In function `write_seqlock':
include/linux/seqlock.h:52: error: `sl' undeclared (first use in this function)
include/linux/seqlock.h:52: error: (Each undeclared identifier is reported only once
include/linux/seqlock.h:52: error: for each function it appears in.)
include/linux/seqlock.h:52: error: parse error before "raw_spinlock_t"
include/linux/seqlock.h:52: error: `raw_spinlock_t' undeclared (first use in this function)
include/linux/seqlock.h:52: error: parse error before ')' token
include/linux/seqlock.h: At top level:
include/linux/seqlock.h:52: error: parse error before "while"
include/linux/seqlock.h:57: error: parse error before '*' token
include/linux/seqlock.h:58: warning: function declaration isn't a prototype
include/linux/seqlock.h: In function `write_sequnlock':
include/linux/seqlock.h:60: error: `sl' undeclared (first use in this function)
include/linux/seqlock.h:61: error: parse error before "raw_spinlock_t"
include/linux/seqlock.h: At top level:
include/linux/seqlock.h:61: error: parse error before "while"
include/linux/seqlock.h:64: error: parse error before '*' token
include/linux/seqlock.h:65: warning: function declaration isn't a prototype
include/linux/seqlock.h: In function `write_tryseqlock':
include/linux/seqlock.h:66: error: `sl' undeclared (first use in this function)
include/linux/seqlock.h:66: error: parse error before "raw_spinlock_t"
include/linux/seqlock.h:66: warning: unused variable `__ret'
include/linux/seqlock.h:66: error: parse error before "while"
include/linux/seqlock.h:66: error: `raw_spinlock_t' undeclared (first use in this function)
include/linux/seqlock.h:66: error: parse error before ')' token
include/linux/seqlock.h:66: warning: left-hand operand of comma expression has no effect
include/linux/seqlock.h:66: warning: unused variable `ret'
include/linux/seqlock.h:66: warning: no return statement in function returning non-void
include/linux/seqlock.h: At top level:
include/linux/seqlock.h:66: error: parse error before ')' token
include/linux/seqlock.h:66: warning: type defaults to `int' in declaration of `__ret'
include/linux/seqlock.h:66: warning: data definition has no type or storage class
include/linux/seqlock.h:66: error: parse error before '}' token
include/linux/seqlock.h:76: warning: type defaults to `int' in declaration of `seqlock_t'
include/linux/seqlock.h:76: error: parse error before '*' token
include/linux/seqlock.h:77: warning: function declaration isn't a prototype
include/linux/seqlock.h: In function `read_seqbegin':
include/linux/seqlock.h:78: error: `sl' undeclared (first use in this function)
include/linux/seqlock.h: At top level:
include/linux/seqlock.h:91: warning: type defaults to `int' in declaration of `seqlock_t'
include/linux/seqlock.h:91: error: parse error before '*' token
include/linux/seqlock.h:92: warning: function declaration isn't a prototype
include/linux/seqlock.h: In function `read_seqretry':
include/linux/seqlock.h:94: error: `iv' undeclared (first use in this function)
include/linux/seqlock.h:94: error: `sl' undeclared (first use in this function)
In file included from include/linux/timex.h:58,
                 from include/linux/sched.h:11,
                 from arch/i386/kernel/asm-offsets.c:7:
include/linux/time.h: At top level:
include/linux/time.h:83: error: parse error before "xtime_lock"
include/linux/time.h:83: warning: type defaults to `int' in declaration of `xtime_lock'
include/linux/time.h:83: warning: data definition has no type or storage class
In file included from include/asm/semaphore.h:41,
                 from include/linux/sched.h:19,
                 from arch/i386/kernel/asm-offsets.c:7:
include/linux/wait.h:82: error: parse error before '*' token
include/linux/wait.h:83: warning: function declaration isn't a prototype
include/linux/wait.h: In function `init_waitqueue_head':
include/linux/wait.h:84: error: `q' undeclared (first use in this function)
include/linux/wait.h:84: error: `RAW_SPIN_LOCK_UNLOCKED' undeclared (first use in this function)
include/linux/wait.h: At top level:
include/linux/wait.h:103: error: parse error before '*' token
include/linux/wait.h:104: warning: function declaration isn't a prototype
include/linux/wait.h: In function `waitqueue_active':
include/linux/wait.h:105: error: `q' undeclared (first use in this function)
include/linux/wait.h: At top level:
include/linux/wait.h:117: error: parse error before '*' token
include/linux/wait.h:117: warning: function declaration isn't a prototype
include/linux/wait.h:118: error: parse error before '*' token
include/linux/wait.h:118: warning: function declaration isn't a prototype
include/linux/wait.h:119: error: parse error before '*' token
include/linux/wait.h:119: warning: function declaration isn't a prototype
include/linux/wait.h:121: error: parse error before '*' token
include/linux/wait.h:122: warning: function declaration isn't a prototype
include/linux/wait.h: In function `__add_wait_queue':
include/linux/wait.h:123: error: `new' undeclared (first use in this function)
include/linux/wait.h:123: error: `head' undeclared (first use in this function)
include/linux/wait.h: At top level:
include/linux/wait.h:129: error: parse error before '*' token
include/linux/wait.h:131: warning: function declaration isn't a prototype
include/linux/wait.h: In function `__add_wait_queue_tail':
include/linux/wait.h:132: error: `new' undeclared (first use in this function)
include/linux/wait.h:132: error: `head' undeclared (first use in this function)
include/linux/wait.h: At top level:
include/linux/wait.h:135: error: parse error before '*' token
include/linux/wait.h:137: warning: function declaration isn't a prototype
include/linux/wait.h: In function `__remove_wait_queue':
include/linux/wait.h:138: error: `old' undeclared (first use in this function)
include/linux/wait.h: At top level:
include/linux/wait.h:141: error: parse error before '*' token
include/linux/wait.h:141: warning: function declaration isn't a prototype
include/linux/wait.h:142: error: parse error before '*' token
include/linux/wait.h:142: warning: function declaration isn't a prototype
include/linux/wait.h:143: error: parse error before '*' token
include/linux/wait.h:143: warning: function declaration isn't a prototype
include/linux/wait.h:144: error: parse error before '*' token
include/linux/wait.h:144: warning: function declaration isn't a prototype
include/linux/wait.h:145: error: parse error before '*' token
include/linux/wait.h:145: error: `__wait_on_bit' declared as function returning a function
include/linux/wait.h:145: warning: function declaration isn't a prototype
include/linux/wait.h:145: error: parse error before "unsigned"
include/linux/wait.h:146: error: parse error before '*' token
include/linux/wait.h:146: error: `__wait_on_bit_lock' declared as function returning a function
include/linux/wait.h:146: warning: function declaration isn't a prototype
include/linux/wait.h:146: error: parse error before "unsigned"
include/linux/wait.h:150: error: parse error before '*' token
include/linux/wait.h:150: warning: type defaults to `int' in declaration of `bit_waitqueue'
include/linux/wait.h:150: warning: data definition has no type or storage class
include/linux/wait.h:288: error: parse error before '*' token
include/linux/wait.h:290: warning: function declaration isn't a prototype
include/linux/wait.h: In function `add_wait_queue_exclusive_locked':
include/linux/wait.h:291: error: `wait' undeclared (first use in this function)
include/linux/wait.h:292: error: `q' undeclared (first use in this function)
include/linux/wait.h: At top level:
include/linux/wait.h:298: error: parse error before '*' token
include/linux/wait.h:300: warning: function declaration isn't a prototype
include/linux/wait.h: In function `remove_wait_queue_locked':
include/linux/wait.h:301: error: `q' undeclared (first use in this function)
include/linux/wait.h:301: error: `wait' undeclared (first use in this function)
include/linux/wait.h: At top level:
include/linux/wait.h:309: error: parse error before '*' token
include/linux/wait.h:309: warning: function declaration isn't a prototype
include/linux/wait.h:310: error: parse error before '*' token
include/linux/wait.h:310: warning: function declaration isn't a prototype
include/linux/wait.h:312: error: parse error before '*' token
include/linux/wait.h:312: warning: function declaration isn't a prototype
include/linux/wait.h:313: error: parse error before '*' token
include/linux/wait.h:313: warning: function declaration isn't a prototype
include/linux/wait.h:319: error: parse error before '*' token
include/linux/wait.h:319: warning: function declaration isn't a prototype
include/linux/wait.h:321: error: parse error before '*' token
include/linux/wait.h:321: warning: function declaration isn't a prototype
include/linux/wait.h:323: error: parse error before '*' token
include/linux/wait.h:323: warning: function declaration isn't a prototype
In file included from include/asm/rwsem.h:42,
                 from include/linux/rwsem.h:27,
                 from include/asm/semaphore.h:42,
                 from include/linux/sched.h:19,
                 from arch/i386/kernel/asm-offsets.c:7:
include/asm/spinlock.h:26: error: `raw_spinlock_t' used prior to declaration
In file included from include/asm/rwsem.h:42,
                 from include/linux/rwsem.h:27,
                 from include/asm/semaphore.h:42,
                 from include/linux/sched.h:19,
                 from arch/i386/kernel/asm-offsets.c:7:
include/asm/spinlock.h:80:1: warning: "SPIN_LOCK_UNLOCKED" redefined
In file included from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
                 from arch/i386/kernel/asm-offsets.c:7:
include/linux/spinlock.h:199:1: warning: this is the location of the previous definition
include/asm/spinlock.h:86: error: conflicting types for `spinlock_t'
include/linux/spinlock.h:198: error: previous declaration of `spinlock_t'
In file included from include/asm/rwsem.h:42,
                 from include/linux/rwsem.h:27,
                 from include/asm/semaphore.h:42,
                 from include/linux/sched.h:19,
                 from arch/i386/kernel/asm-offsets.c:7:
include/asm/spinlock.h:93:1: warning: "RW_LOCK_UNLOCKED" redefined
In file included from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
                 from arch/i386/kernel/asm-offsets.c:7:
include/linux/spinlock.h:220:1: warning: this is the location of the previous definition
include/asm/spinlock.h:99: error: conflicting types for `rwlock_t'
include/linux/spinlock.h:219: error: previous declaration of `rwlock_t'
include/asm/spinlock.h:165: error: parse error before "do"
include/asm/spinlock.h:197: error: parse error before "void"
include/asm/spinlock.h:207: error: parse error before "do"
include/asm/spinlock.h:259: error: parse error before "do"
include/asm/spinlock.h:267: error: parse error before "do"
In file included from include/asm/rwsem.h:42,
                 from include/linux/rwsem.h:27,
                 from include/asm/semaphore.h:42,
                 from include/linux/sched.h:19,
                 from arch/i386/kernel/asm-offsets.c:7:
include/asm/spinlock.h:275:1: warning: "_raw_read_unlock" redefined
In file included from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
                 from arch/i386/kernel/asm-offsets.c:7:
include/linux/spinlock.h:228:1: warning: this is the location of the previous definition
In file included from include/asm/rwsem.h:42,
                 from include/linux/rwsem.h:27,
                 from include/asm/semaphore.h:42,
                 from include/linux/sched.h:19,
                 from arch/i386/kernel/asm-offsets.c:7:
include/asm/spinlock.h:276:1: warning: "_raw_write_unlock" redefined
In file included from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
                 from arch/i386/kernel/asm-offsets.c:7:
include/linux/spinlock.h:230:1: warning: this is the location of the previous definition
include/asm/spinlock.h:278: error: parse error before '{' token
include/asm/spinlock.h:281: warning: type defaults to `int' in declaration of `atomic_dec'
include/asm/spinlock.h:281: warning: parameter names (without types) in function declaration
include/asm/spinlock.h:281: error: conflicting types for `atomic_dec'
include/asm/atomic.h:116: error: previous declaration of `atomic_dec'
include/asm/spinlock.h:281: warning: data definition has no type or storage class
include/asm/spinlock.h:282: error: parse error before "if"
include/asm/spinlock.h:284: warning: type defaults to `int' in declaration of `atomic_inc'
include/asm/spinlock.h:284: warning: parameter names (without types) in function declaration
include/asm/spinlock.h:284: error: conflicting types for `atomic_inc'
include/asm/atomic.h:102: error: previous declaration of `atomic_inc'
include/asm/spinlock.h:284: warning: data definition has no type or storage class
include/asm/spinlock.h:285: error: parse error before "return"
include/asm/spinlock.h:288: error: parse error before '{' token
include/asm/spinlock.h:293: error: parse error before numeric constant
include/asm/spinlock.h:293: warning: type defaults to `int' in declaration of `atomic_add'
include/asm/spinlock.h:293: warning: function declaration isn't a prototype
include/asm/spinlock.h:293: error: conflicting types for `atomic_add'
include/asm/atomic.h:53: error: previous declaration of `atomic_add'
include/asm/spinlock.h:293: warning: data definition has no type or storage class
In file included from arch/i386/kernel/asm-offsets.c:7:
include/linux/sched.h:847:56: macro "_spin_lock_irqsave" requires 2 arguments, but only 1 given
In file included from arch/i386/kernel/asm-offsets.c:7:
include/linux/sched.h: In function `dequeue_signal_lock':
include/linux/sched.h:847: error: `_spin_lock_irqsave' undeclared (first use in this function)
include/linux/seqlock.h: In function `write_tryseqlock':
include/linux/seqlock.h:66: warning: statement with no effect
make[1]: *** [arch/i386/kernel/asm-offsets.s] Error 1
make: *** [arch/i386/kernel/asm-offsets.s] Error 2
