Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269093AbUJKRfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269093AbUJKRfz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 13:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269134AbUJKRfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 13:35:54 -0400
Received: from imap.gmx.net ([213.165.64.20]:62187 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S269093AbUJKRdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 13:33:33 -0400
X-Authenticated: #4399952
Date: Mon, 11 Oct 2004 19:48:50 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       "K.R. Foley" <kr@cybsft.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@raytheon.com,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Daniel Walker <dwalker@mvista.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] CONFIG_PREEMPT_REALTIME, 'Fully Preemptible Kernel',
 VP-2.6.9-rc4-mm1-T4
Message-ID: <20041011194850.1561bbf6@mango.fruits.de>
In-Reply-To: <20041011142953.GA32607@elte.hu>
References: <20040921074426.GA10477@elte.hu>
	<20040922103340.GA9683@elte.hu>
	<20040923122838.GA9252@elte.hu>
	<20040923211206.GA2366@elte.hu>
	<20040924074416.GA17924@elte.hu>
	<20040928000516.GA3096@elte.hu>
	<20041003210926.GA1267@elte.hu>
	<20041004215315.GA17707@elte.hu>
	<20041005134707.GA32033@elte.hu>
	<20041007105230.GA17411@elte.hu>
	<20041011142953.GA32607@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2004 16:29:53 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> i've released the -T4 VP patch:

Hi,

doesn't build here:

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



.config:

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.9-rc4-mm1-VP-T4
# Mon Oct 11 19:40:39 2004
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_LOCALVERSION="-LT"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_HOTPLUG is not set
CONFIG_KOBJECT_UEVENT=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_PREEMPT_TIMING=y
CONFIG_LATENCY_TRACE=y
CONFIG_MCOUNT=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SHMEM=y
# CONFIG_TINY_SHMEM is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
CONFIG_PREEMPT_VOLUNTARY=y
CONFIG_PREEMPT_SOFTIRQS=y
CONFIG_PREEMPT_HARDIRQS=y
CONFIG_PREEMPT_REALTIME=y
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_TSC=y
# CONFIG_X86_MCE is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set

#
# Firmware Drivers
#
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y

#
# Performance-monitoring counters support
#
# CONFIG_PERFCTR is not set
# CONFIG_KEXEC is not set

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
# CONFIG_ACPI is not set
CONFIG_ACPI_BLACKLIST_YEAR=0

#
# APM (Advanced Power Management) BIOS Support
#
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
CONFIG_APM_REAL_MODE_POWER_OFF=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
# CONFIG_DEBUG_DRIVER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_LBD is not set
# CONFIG_CDROM_PKTCDVD is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
CONFIG_BLK_DEV_SIS5513=y
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=m
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
# CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLOGIC_1280_1040 is not set
CONFIG_SCSI_QLA2XXX=m
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA6322 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_NETLINK_DEV=y
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
# CONFIG_IP_MULTIPLE_TABLES is not set
# CONFIG_IP_ROUTE_MULTIPATH is not set
# CONFIG_IP_ROUTE_VERBOSE is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_TUNNEL is not set

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
# CONFIG_IP_NF_CT_ACCT is not set
# CONFIG_IP_NF_CT_PROTO_SCTP is not set
# CONFIG_IP_NF_FTP is not set
# CONFIG_IP_NF_IRC is not set
# CONFIG_IP_NF_TFTP is not set
# CONFIG_IP_NF_AMANDA is not set
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_ADDRTYPE=m
CONFIG_IP_NF_MATCH_REALM=m
# CONFIG_IP_NF_MATCH_SCTP is not set
# CONFIG_IP_NF_MATCH_COMMENT is not set
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
# CONFIG_IP_NF_NAT_LOCAL is not set
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
# CONFIG_IP_NF_RAW is not set
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CLK_JIFFIES=y
# CONFIG_NET_SCH_CLK_GETTIMEOFDAY is not set
# CONFIG_NET_SCH_CLK_CPU is not set
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
# CONFIG_NET_SCH_HFSC is not set
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
# CONFIG_NET_SCH_NETEM is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
# CONFIG_CLS_U32_PERF is not set
# CONFIG_NET_CLS_IND is not set
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
# CONFIG_NET_CLS_ACT is not set
CONFIG_NET_CLS_POLICE=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_KGDBOE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_SIS900=m
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_PPP=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
CONFIG_GAMEPORT=m
CONFIG_SOUND_GAMEPORT=m
# CONFIG_GAMEPORT_NS558 is not set
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_VORTEX is not set
# CONFIG_GAMEPORT_FM801 is not set
# CONFIG_GAMEPORT_CS461x is not set
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
CONFIG_SERIO_PCIPS2=m
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
# CONFIG_INPUT_UINPUT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_CONSOLE is not set
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=y
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=m
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_INTEL_MCH is not set
# CONFIG_AGP_NVIDIA is not set
CONFIG_AGP_SIS=m
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HANGCHECK_TIMER=m

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI1563=m
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD8111=m
CONFIG_I2C_I801=m
CONFIG_I2C_I810=m
CONFIG_I2C_ISA=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_PARPORT_LIGHT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_PROSAVAGE=m
CONFIG_I2C_SAVAGE4=m
CONFIG_SCx200_ACB=m
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=m
# CONFIG_I2C_STUB is not set
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m
CONFIG_I2C_VOODOO3=m
# CONFIG_I2C_PCA_ISA is not set

#
# Hardware Sensors Chip support
#
CONFIG_I2C_SENSOR=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_FSCHER=m
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_MAX1619=m
# CONFIG_SENSORS_SMSC47M1 is not set
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83627HF=m

#
# Other I2C Chip support
#
CONFIG_SENSORS_EEPROM=m
CONFIG_SENSORS_PCF8574=m
CONFIG_SENSORS_PCF8591=m
CONFIG_SENSORS_RTC8564=m
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
# CONFIG_FB is not set
CONFIG_VIDEO_SELECT=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
# CONFIG_SND_VERBOSE_PRINTK is not set
CONFIG_SND_DEBUG=y
# CONFIG_SND_DEBUG_MEMORY is not set
# CONFIG_SND_DEBUG_DETECT is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
CONFIG_SND_AC97_CODEC=m
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VX222 is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
# CONFIG_USB is not set

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
# CONFIG_EXT2_FS_POSIX_ACL is not set
# CONFIG_EXT2_FS_SECURITY is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISER4_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
CONFIG_ROMFS_FS=y
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y

#
# Caches
#
# CONFIG_FSCACHE is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS_XATTR=y
# CONFIG_DEVPTS_FS_SECURITY is not set
CONFIG_TMPFS=y
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_EXPORTFS is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
CONFIG_AFS_FS=m
CONFIG_RXRPC=m

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
CONFIG_DEBUG_PREEMPT=y
# CONFIG_DEBUG_INFO is not set
CONFIG_EARLY_PRINTK=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_KPROBES is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_4KSTACKS is not set
# CONFIG_SCHEDSTATS is not set
# CONFIG_KGDB is not set

#
# Security options
#
# CONFIG_KEYS is not set
CONFIG_SECURITY=y
# CONFIG_SECURITY_NETWORK is not set
CONFIG_SECURITY_CAPABILITIES=m
# CONFIG_SECURITY_SECLVL is not set
# CONFIG_SECURITY_SELINUX is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_MD4 is not set
# CONFIG_CRYPTO_MD5 is not set
# CONFIG_CRYPTO_SHA1 is not set
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_WP512 is not set
# CONFIG_CRYPTO_DES is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_TWOFISH is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_AES_586 is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_CRC32C is not set
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
CONFIG_CRC_CCITT=m
CONFIG_CRC32=m
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_GENERIC_HARDIRQS=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y
