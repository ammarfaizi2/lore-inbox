Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267696AbUJNVg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267696AbUJNVg6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 17:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267164AbUJNV26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 17:28:58 -0400
Received: from lennier.cc.vt.edu ([198.82.162.213]:41488 "EHLO
	lennier.cc.vt.edu") by vger.kernel.org with ESMTP id S267212AbUJNVYM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 17:24:12 -0400
Message-ID: <416EFD1A.4050701@vt.edu>
Date: Thu, 14 Oct 2004 17:26:34 -0500
From: William Wolf <wwolf@vt.edu>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040919)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U1
References: <4196928A.9070103@vt.edu> <1097788119.2682.56.camel@krustophenia.net>
In-Reply-To: <1097788119.2682.56.camel@krustophenia.net>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

>On Sat, 2004-11-13 at 18:02, William Wolf wrote:
>  
>
>>Has anyone tried these patches been on x86_64?  Im trying the latest -U1 
>>patch and getting lots of compile errors.  I can send the output if needed.
>>    
>>
>
>Looks like you might be the only one.  Please post any compile errors,
>and cc: Ingo.
>
>Lee
>
>
>  
>


Here's the output of make, its pretty lengthy, hope it helps:






   CHK     include/linux/version.h
   UPD     include/linux/version.h
scripts/kconfig/conf -s arch/x86_64/Kconfig
#
# using defaults found in .config
#
*
* Restart config...
*
*
* General setup
*
Local version - append to kernel release (LOCALVERSION) []
Support for paging of anonymous memory (swap) (SWAP) [Y/n/?] y
System V IPC (SYSVIPC) [Y/n/?] y
POSIX Message Queues (POSIX_MQUEUE) [N/y/?] n
BSD Process Accounting (BSD_PROCESS_ACCT) [N/y/?] n
Sysctl support (SYSCTL) [Y/n/?] y
Auditing support (AUDIT) [N/y/?] n
Support for hot-pluggable devices (HOTPLUG) [Y/n/?] y
Kernel Userspace Events (KOBJECT_UEVENT) [Y/n/?] y
Kernel .config support (IKCONFIG) [Y/n/?] y
   Enable access to .config through /proc/config.gz (IKCONFIG_PROC) 
[Y/n/?] y
Non-preemptible critical section timing (PREEMPT_TIMING) [N/y/?] (NEW) y
   Non-preemptible critical section tracing (LATENCY_TRACE) [N/y/?] (NEW) y
Anticipatory I/O scheduler (IOSCHED_AS) [Y/n/m/?] y
Deadline I/O scheduler (IOSCHED_DEADLINE) [Y/n/m/?] y
CFQ I/O scheduler (IOSCHED_CFQ) [Y/n/m/?] y
*
* Processor type and features
*
Processor family
  > 1. AMD-Opteron/Athlon64 (MK8)
   2. Intel x86-64 (MPSC)
   3. Generic-x86-64 (GENERIC_CPU)
choice[1-3]: 1
/dev/cpu/microcode - Intel CPU microcode support (MICROCODE) [N/m/y/?] n
/dev/cpu/*/msr - Model-specific register support (X86_MSR) [N/m/y/?] n
/dev/cpu/*/cpuid - CPU information support (X86_CPUID) [N/m/y/?] n
MTRR (Memory Type Range Register) support (MTRR) [Y/n/?] y
Symmetric multi-processing support (SMP) [N/y/?] n
Preemptible Kernel (PREEMPT) [Y/n/?] y
   Preempt The Big Kernel Lock (PREEMPT_BKL) [Y/n/?] y
Voluntary Kernel Preemption (PREEMPT_VOLUNTARY) [Y/n/?] (NEW) y
Preempt Softirqs (PREEMPT_SOFTIRQS) [Y/n/?] (NEW) y
IOMMU support (GART_IOMMU) [Y/n/?] y
   SPLIT   include/linux/autoconf.h -> include/config/*
   CC      arch/x86_64/kernel/asm-offsets.s
In file included from include/linux/capability.h:45,
                  from include/linux/sched.h:7,
                  from arch/x86_64/kernel/asm-offsets.c:7:
include/linux/spinlock.h:16:23: asm/mutex.h: No such file or directory
In file included from include/linux/capability.h:45,
                  from include/linux/sched.h:7,
                  from arch/x86_64/kernel/asm-offsets.c:7:
include/linux/spinlock.h:413: error: parse error before '*' token
include/linux/spinlock.h:413: warning: function declaration isn't a
prototype
include/linux/spinlock.h:414: error: parse error before '*' token
include/linux/spinlock.h:414: warning: function declaration isn't a
prototype
include/linux/spinlock.h:415: error: parse error before '*' token
include/linux/spinlock.h:415: warning: function declaration isn't a
prototype
include/linux/spinlock.h:416: error: parse error before '*' token
include/linux/spinlock.h:416: warning: function declaration isn't a
prototype
include/linux/spinlock.h:417: error: parse error before '*' token
include/linux/spinlock.h:417: warning: function declaration isn't a
prototype
include/linux/spinlock.h:418: error: parse error before '*' token
include/linux/spinlock.h:418: warning: function declaration isn't a
prototype
include/linux/spinlock.h:419: error: parse error before '*' token
include/linux/spinlock.h:419: warning: function declaration isn't a
prototype
include/linux/spinlock.h:420: error: parse error before '*' token
include/linux/spinlock.h:420: warning: function declaration isn't a
prototype
include/linux/spinlock.h:421: error: parse error before '*' token
include/linux/spinlock.h:421: warning: function declaration isn't a
prototype
include/linux/spinlock.h:422: error: parse error before '*' token
include/linux/spinlock.h:422: warning: function declaration isn't a
prototype
include/linux/spinlock.h:423: error: parse error before '*' token
include/linux/spinlock.h:423: warning: function declaration isn't a
prototype
include/linux/spinlock.h:424: error: parse error before '*' token
include/linux/spinlock.h:424: warning: function declaration isn't a
prototype
include/linux/spinlock.h:425: error: parse error before '*' token
include/linux/spinlock.h:425: warning: function declaration isn't a
prototype
include/linux/spinlock.h:426: error: parse error before '*' token
include/linux/spinlock.h:426: warning: function declaration isn't a
prototype
include/linux/spinlock.h:462: error: parse error before '*' token
include/linux/spinlock.h:462: warning: function declaration isn't a
prototype
include/linux/spinlock.h:463: error: parse error before '*' token
include/linux/spinlock.h:463: warning: function declaration isn't a
prototype
include/linux/spinlock.h:464: error: parse error before '*' token
include/linux/spinlock.h:464: warning: function declaration isn't a
prototype
include/linux/spinlock.h:465: error: parse error before '*' token
include/linux/spinlock.h:465: warning: function declaration isn't a
prototype
include/linux/spinlock.h:466: error: parse error before '*' token
include/linux/spinlock.h:466: warning: function declaration isn't a
prototype
include/linux/spinlock.h:467: error: parse error before '*' token
include/linux/spinlock.h:467: warning: function declaration isn't a
prototype
include/linux/spinlock.h:468: error: parse error before '*' token
include/linux/spinlock.h:468: warning: function declaration isn't a
prototype
include/linux/spinlock.h:469: error: parse error before '*' token
include/linux/spinlock.h:469: warning: function declaration isn't a
prototype
include/linux/spinlock.h:470: error: parse error before '*' token
include/linux/spinlock.h:470: warning: function declaration isn't a
prototype
include/linux/spinlock.h:471: error: parse error before '*' token
include/linux/spinlock.h:471: warning: function declaration isn't a
prototype
include/linux/spinlock.h:472: error: parse error before '*' token
include/linux/spinlock.h:472: warning: function declaration isn't a
prototype
include/linux/spinlock.h:473: error: parse error before '*' token
include/linux/spinlock.h:473: warning: function declaration isn't a
prototype
include/linux/spinlock.h:474: error: parse error before '*' token
include/linux/spinlock.h:474: warning: function declaration isn't a
prototype
include/linux/spinlock.h:475: error: parse error before '*' token
include/linux/spinlock.h:475: warning: function declaration isn't a
prototype
include/linux/spinlock.h:476: error: parse error before '*' token
include/linux/spinlock.h:476: warning: function declaration isn't a
prototype
include/linux/spinlock.h:477: error: parse error before '*' token
include/linux/spinlock.h:477: warning: function declaration isn't a
prototype
include/linux/spinlock.h:478: error: parse error before '*' token
include/linux/spinlock.h:478: warning: function declaration isn't a
prototype
include/linux/spinlock.h:479: error: parse error before '*' token
include/linux/spinlock.h:479: warning: function declaration isn't a
prototype
include/linux/spinlock.h:480: error: parse error before '*' token
include/linux/spinlock.h:480: warning: function declaration isn't a
prototype
include/linux/spinlock.h:481: error: parse error before '*' token
include/linux/spinlock.h:481: warning: function declaration isn't a
prototype
In file included from include/linux/capability.h:45,
                  from include/linux/sched.h:7,
                  from arch/x86_64/kernel/asm-offsets.c:7:
include/linux/spinlock.h:655: error: parse error before "raw_spinlock_t"
include/linux/spinlock.h:655: warning: function declaration isn't a
prototype
In file included from include/linux/sched.h:7,
                  from arch/x86_64/kernel/asm-offsets.c:7:
include/linux/capability.h:47: error: parse error before
"task_capability_lock"
include/linux/capability.h:47: warning: type defaults to `int' in
declaration of `task_capability_lock'
include/linux/capability.h:47: warning: data definition has no type or
storage class
In file included from include/linux/time.h:7,
                  from include/linux/timex.h:58,
                  from include/linux/sched.h:11,
                  from arch/x86_64/kernel/asm-offsets.c:7:
include/linux/seqlock.h:35: error: parse error before "spinlock_t"
include/linux/seqlock.h:35: warning: no semicolon at end of struct or union
include/linux/seqlock.h:36: warning: type defaults to `int' in
declaration of `__seqlock_t'
include/linux/seqlock.h:36: warning: data definition has no type or
storage class
include/linux/seqlock.h:40: error: parse error before "raw_spinlock_t"
include/linux/seqlock.h:40: warning: no semicolon at end of struct or union
include/linux/seqlock.h:41: warning: type defaults to `int' in
declaration of `__raw_seqlock_t'
include/linux/seqlock.h:41: warning: data definition has no type or
storage class
include/linux/seqlock.h:46: error: parse error before "seqlock_t"
include/linux/seqlock.h:46: warning: type defaults to `int' in
declaration of `seqlock_t'
include/linux/seqlock.h:46: warning: data definition has no type or
storage class
include/linux/seqlock.h:50: error: parse error before "raw_seqlock_t"
include/linux/seqlock.h:50: warning: type defaults to `int' in
declaration of `raw_seqlock_t'
include/linux/seqlock.h:50: warning: data definition has no type or
storage class
include/linux/seqlock.h:72: error: parse error before '*' token
include/linux/seqlock.h:73: warning: function declaration isn't a prototype
include/linux/seqlock.h: In function `__write_seqlock':
include/linux/seqlock.h:74: error: `sl' undeclared (first use in this
function)
include/linux/seqlock.h:74: error: (Each undeclared identifier is
reported only once
include/linux/seqlock.h:74: error: for each function it appears in.)
include/linux/seqlock.h:74: error: parse error before "raw_spinlock_t"
include/linux/seqlock.h:74: error: `raw_spinlock_t' undeclared (first
use in this function)
include/linux/seqlock.h:74: error: parse error before ')' token
include/linux/seqlock.h: At top level:
include/linux/seqlock.h:74: error: parse error before "while"
include/linux/seqlock.h:79: error: parse error before '*' token
include/linux/seqlock.h:80: warning: function declaration isn't a prototype
include/linux/seqlock.h: In function `__write_sequnlock':
include/linux/seqlock.h:82: error: `sl' undeclared (first use in this
function)
include/linux/seqlock.h:83: error: parse error before "raw_spinlock_t"
include/linux/seqlock.h: At top level:
include/linux/seqlock.h:83: error: parse error before "while"
include/linux/seqlock.h:86: error: parse error before '*' token
include/linux/seqlock.h:87: warning: function declaration isn't a prototype
include/linux/seqlock.h: In function `__write_tryseqlock':
include/linux/seqlock.h:88: error: `sl' undeclared (first use in this
function)
include/linux/seqlock.h:88: error: parse error before "raw_spinlock_t"
include/linux/seqlock.h:88: warning: unused variable `__ret'
include/linux/seqlock.h:88: error: parse error before "while"
include/linux/seqlock.h:88: error: `raw_spinlock_t' undeclared (first
use in this function)
include/linux/seqlock.h:88: error: parse error before ')' token
include/linux/seqlock.h:88: warning: left-hand operand of comma
expression has no effect
include/linux/seqlock.h:88: warning: unused variable `ret'
include/linux/seqlock.h:88: warning: no return statement in function
returning non-void
include/linux/seqlock.h: At top level:
include/linux/seqlock.h:88: error: parse error before ')' token
include/linux/seqlock.h:88: warning: type defaults to `int' in
declaration of `__ret'
include/linux/seqlock.h:88: warning: data definition has no type or
storage class
include/linux/seqlock.h:88: error: parse error before '}' token
include/linux/seqlock.h:98: warning: type defaults to `int' in
declaration of `seqlock_t'
include/linux/seqlock.h:98: error: parse error before '*' token
include/linux/seqlock.h:99: warning: function declaration isn't a prototype
include/linux/seqlock.h: In function `__read_seqbegin':
include/linux/seqlock.h:100: error: `sl' undeclared (first use in this
function)
include/linux/seqlock.h: At top level:
include/linux/seqlock.h:113: warning: type defaults to `int' in
declaration of `seqlock_t'
include/linux/seqlock.h:113: error: parse error before '*' token
include/linux/seqlock.h:114: warning: function declaration isn't a prototype
include/linux/seqlock.h: In function `__read_seqretry':
include/linux/seqlock.h:116: error: `iv' undeclared (first use in this
function)
include/linux/seqlock.h:116: error: `sl' undeclared (first use in this
function)
include/linux/seqlock.h: At top level:
include/linux/seqlock.h:119: error: parse error before '*' token
include/linux/seqlock.h:120: warning: function declaration isn't a prototype
include/linux/seqlock.h: In function `__write_seqlock_raw':
include/linux/seqlock.h:121: error: `sl' undeclared (first use in this
function)
include/linux/seqlock.h:121: error: parse error before "raw_spinlock_t"
include/linux/seqlock.h:121: error: `raw_spinlock_t' undeclared (first
use in this function)
include/linux/seqlock.h:121: error: parse error before ')' token
include/linux/seqlock.h: At top level:
include/linux/seqlock.h:121: error: parse error before "while"
include/linux/seqlock.h:126: error: parse error before '*' token
include/linux/seqlock.h:127: warning: function declaration isn't a prototype
include/linux/seqlock.h: In function `__write_sequnlock_raw':
include/linux/seqlock.h:129: error: `sl' undeclared (first use in this
function)
include/linux/seqlock.h:130: error: parse error before "raw_spinlock_t"
include/linux/seqlock.h: At top level:
include/linux/seqlock.h:130: error: parse error before "while"
include/linux/seqlock.h:133: error: parse error before '*' token
include/linux/seqlock.h:134: warning: function declaration isn't a prototype
include/linux/seqlock.h: In function `__write_tryseqlock_raw':
include/linux/seqlock.h:135: error: `sl' undeclared (first use in this
function)
include/linux/seqlock.h:135: error: parse error before "raw_spinlock_t"
include/linux/seqlock.h:135: warning: unused variable `__ret'
include/linux/seqlock.h:135: error: parse error before "while"
include/linux/seqlock.h:135: error: `raw_spinlock_t' undeclared (first
use in this function)
include/linux/seqlock.h:135: error: parse error before ')' token
include/linux/seqlock.h:135: warning: left-hand operand of comma
expression has no effect
include/linux/seqlock.h:135: warning: unused variable `ret'
include/linux/seqlock.h:135: warning: no return statement in function
returning non-void
include/linux/seqlock.h: At top level:
include/linux/seqlock.h:135: error: parse error before ')' token
include/linux/seqlock.h:135: warning: type defaults to `int' in
declaration of `__ret'
include/linux/seqlock.h:135: warning: data definition has no type or
storage class
include/linux/seqlock.h:135: error: parse error before '}' token
include/linux/seqlock.h:144: warning: type defaults to `int' in
declaration of `raw_seqlock_t'
include/linux/seqlock.h:144: error: parse error before '*' token
include/linux/seqlock.h:145: warning: function declaration isn't a prototype
include/linux/seqlock.h: In function `__read_seqbegin_raw':
include/linux/seqlock.h:146: error: `sl' undeclared (first use in this
function)
include/linux/seqlock.h: At top level:
include/linux/seqlock.h:151: warning: type defaults to `int' in
declaration of `raw_seqlock_t'
include/linux/seqlock.h:151: error: parse error before '*' token
include/linux/seqlock.h:152: warning: function declaration isn't a prototype
include/linux/seqlock.h: In function `__read_seqretry_raw':
include/linux/seqlock.h:154: error: `iv' undeclared (first use in this
function)
include/linux/seqlock.h:154: error: `sl' undeclared (first use in this
function)
In file included from include/linux/timex.h:58,
                  from include/linux/sched.h:11,
                  from arch/x86_64/kernel/asm-offsets.c:7:
include/linux/time.h: At top level:
include/linux/time.h:83: error: parse error before "xtime_lock"
include/linux/time.h:83: warning: type defaults to `int' in declaration
of `xtime_lock'
include/linux/time.h:83: warning: data definition has no type or storage
class
In file included from include/asm/timex.h:12,
                  from include/linux/timex.h:61,
                  from include/linux/sched.h:11,
                  from arch/x86_64/kernel/asm-offsets.c:7:
include/asm/vsyscall.h:48: error: parse error before "__xtime_lock"
include/asm/vsyscall.h:48: warning: type defaults to `int' in
declaration of `__xtime_lock'
include/asm/vsyscall.h:48: warning: data definition has no type or
storage class
include/asm/vsyscall.h:55: error: parse error before "xtime_lock"
include/asm/vsyscall.h:55: warning: type defaults to `int' in
declaration of `xtime_lock'
include/asm/vsyscall.h:55: warning: data definition has no type or
storage class
In file included from include/asm/semaphore.h:42,
                  from include/linux/sched.h:19,
                  from arch/x86_64/kernel/asm-offsets.c:7:
include/linux/wait.h:82: error: parse error before '*' token
include/linux/wait.h:83: warning: function declaration isn't a prototype
include/linux/wait.h: In function `init_waitqueue_head':
include/linux/wait.h:84: error: `q' undeclared (first use in this function)
include/linux/wait.h:84: error: `RAW_SPIN_LOCK_UNLOCKED' undeclared
(first use in this function)
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
include/linux/wait.h:123: error: `new' undeclared (first use in this
function)
include/linux/wait.h:123: error: `head' undeclared (first use in this
function)
include/linux/wait.h: At top level:
include/linux/wait.h:129: error: parse error before '*' token
include/linux/wait.h:131: warning: function declaration isn't a prototype
include/linux/wait.h: In function `__add_wait_queue_tail':
include/linux/wait.h:132: error: `new' undeclared (first use in this
function)
include/linux/wait.h:132: error: `head' undeclared (first use in this
function)
include/linux/wait.h: At top level:
include/linux/wait.h:135: error: parse error before '*' token
include/linux/wait.h:137: warning: function declaration isn't a prototype
include/linux/wait.h: In function `__remove_wait_queue':
include/linux/wait.h:138: error: `old' undeclared (first use in this
function)
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
include/linux/wait.h:145: error: `__wait_on_bit' declared as function
returning a function
include/linux/wait.h:145: warning: function declaration isn't a prototype
include/linux/wait.h:145: error: parse error before "unsigned"
include/linux/wait.h:146: error: parse error before '*' token
include/linux/wait.h:146: error: `__wait_on_bit_lock' declared as
function returning a function
include/linux/wait.h:146: warning: function declaration isn't a prototype
include/linux/wait.h:146: error: parse error before "unsigned"
include/linux/wait.h:150: error: parse error before '*' token
include/linux/wait.h:150: warning: type defaults to `int' in declaration
of `bit_waitqueue'
include/linux/wait.h:150: warning: data definition has no type or
storage class
include/linux/wait.h:288: error: parse error before '*' token
include/linux/wait.h:290: warning: function declaration isn't a prototype
include/linux/wait.h: In function `add_wait_queue_exclusive_locked':
include/linux/wait.h:291: error: `wait' undeclared (first use in this
function)
include/linux/wait.h:292: error: `q' undeclared (first use in this function)
include/linux/wait.h: At top level:
include/linux/wait.h:298: error: parse error before '*' token
include/linux/wait.h:300: warning: function declaration isn't a prototype
include/linux/wait.h: In function `remove_wait_queue_locked':
include/linux/wait.h:301: error: `q' undeclared (first use in this function)
include/linux/wait.h:301: error: `wait' undeclared (first use in this
function)
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
In file included from include/linux/rwsem.h:27,
                  from include/asm/semaphore.h:43,
                  from include/linux/sched.h:19,
                  from arch/x86_64/kernel/asm-offsets.c:7:
include/linux/rwsem-spinlock.h:33: error: parse error before "spinlock_t"
include/linux/rwsem-spinlock.h:33: warning: no semicolon at end of
struct or union
include/linux/rwsem-spinlock.h:38: error: parse error before '}' token
In file included from include/linux/sched.h:19,
                  from arch/x86_64/kernel/asm-offsets.c:7:
include/asm/semaphore.h:49: error: parse error before "wait_queue_head_t"
include/asm/semaphore.h:49: warning: no semicolon at end of struct or union
include/asm/semaphore.h: In function `sema_init':
include/asm/semaphore.h:76: error: dereferencing pointer to incomplete type
include/asm/semaphore.h:77: error: dereferencing pointer to incomplete type
include/asm/semaphore.h:78: error: dereferencing pointer to incomplete type
include/asm/semaphore.h: In function `down':
include/asm/semaphore.h:119: error: dereferencing pointer to incomplete type
include/asm/semaphore.h: In function `down_interruptible':
include/asm/semaphore.h:144: error: dereferencing pointer to incomplete type
include/asm/semaphore.h: In function `down_trylock':
include/asm/semaphore.h:168: error: dereferencing pointer to incomplete type
include/asm/semaphore.h: In function `up':
include/asm/semaphore.h:191: error: dereferencing pointer to incomplete type
In file included from include/linux/sched.h:22,
                  from arch/x86_64/kernel/asm-offsets.c:7:
include/asm/mmu.h: At top level:
include/asm/mmu.h:15: error: parse error before "rwlock_t"
include/asm/mmu.h:15: warning: no semicolon at end of struct or union
include/asm/mmu.h:18: error: parse error before '}' token
include/asm/mmu.h:18: warning: type defaults to `int' in declaration of
`mm_context_t'
include/asm/mmu.h:18: warning: data definition has no type or storage class
In file included from include/linux/sem.h:4,
                  from include/linux/sched.h:58,
                  from arch/x86_64/kernel/asm-offsets.c:7:
include/linux/ipc.h:59: error: parse error before "raw_spinlock_t"
include/linux/ipc.h:59: warning: no semicolon at end of struct or union
include/linux/ipc.h:69: error: parse error before '}' token
In file included from include/linux/sched.h:58,
                  from arch/x86_64/kernel/asm-offsets.c:7:
include/linux/sem.h:90: error: field `sem_perm' has incomplete type
include/linux/sem.h:129: error: parse error before "raw_spinlock_t"
include/linux/sem.h:129: warning: no semicolon at end of struct or union
include/linux/sem.h:131: error: parse error before '}' token
In file included from include/linux/sched.h:59,
                  from arch/x86_64/kernel/asm-offsets.c:7:
include/linux/signal.h:19: error: parse error before "spinlock_t"
include/linux/signal.h:19: warning: no semicolon at end of struct or union
include/linux/signal.h:23: error: parse error before '}' token
In file included from include/linux/sched.h:61,
                  from arch/x86_64/kernel/asm-offsets.c:7:
include/linux/fs_struct.h:9: error: parse error before "rwlock_t"
include/linux/fs_struct.h:9: warning: no semicolon at end of struct or union
include/linux/fs_struct.h:13: error: parse error before '}' token
In file included from include/linux/sched.h:63,
                  from arch/x86_64/kernel/asm-offsets.c:7:
include/linux/completion.h:15: error: parse error before "wait_queue_head_t"
include/linux/completion.h:15: warning: no semicolon at end of struct or
union
include/linux/completion.h: In function `init_completion':
include/linux/completion.h:26: error: dereferencing pointer to
incomplete type
include/linux/completion.h:27: error: dereferencing pointer to
incomplete type
In file included from include/linux/gfp.h:4,
                  from include/linux/slab.h:15,
                  from include/linux/percpu.h:4,
                  from include/linux/sched.h:65,
                  from arch/x86_64/kernel/asm-offsets.c:7:
include/linux/mmzone.h: At top level:
include/linux/mmzone.h:113: error: parse error before "raw_spinlock_t"
include/linux/mmzone.h:113: warning: no semicolon at end of struct or union
include/linux/mmzone.h:132: error: parse error before "lru_lock"
include/linux/mmzone.h:132: warning: type defaults to `int' in
declaration of `lru_lock'
include/linux/mmzone.h:132: warning: data definition has no type or
storage class
include/linux/mmzone.h:193: error: parse error before '*' token
include/linux/mmzone.h:193: warning: type defaults to `int' in
declaration of `wait_table'
include/linux/mmzone.h:193: warning: data definition has no type or
storage class
include/linux/mmzone.h:215: error: parse error before '}' token
include/linux/mmzone.h:254: error: field `node_zones' has incomplete type
include/linux/mmzone.h:265: error: parse error before "wait_queue_head_t"
include/linux/mmzone.h:265: warning: no semicolon at end of struct or union
include/linux/mmzone.h:267: error: parse error before '}' token
include/linux/mmzone.h:267: warning: type defaults to `int' in
declaration of `pg_data_t'
include/linux/mmzone.h:267: warning: data definition has no type or
storage class
include/linux/mmzone.h: In function `next_zone':
include/linux/mmzone.h:307: error: `pgdat' undeclared (first use in this
function)
include/linux/mmzone.h:307: error: dereferencing pointer to incomplete type
include/linux/mmzone.h:310: error: increment of pointer to unknown structure
include/linux/mmzone.h:310: error: arithmetic on pointer to an
incomplete type
include/linux/mmzone.h: In function `is_highmem':
include/linux/mmzone.h:355: error: dereferencing pointer to incomplete type
include/linux/mmzone.h: In function `is_normal':
include/linux/mmzone.h:360: error: dereferencing pointer to incomplete type
In file included from include/linux/slab.h:15,
                  from include/linux/percpu.h:4,
                  from include/linux/sched.h:65,
                  from arch/x86_64/kernel/asm-offsets.c:7:
include/linux/gfp.h: In function `alloc_pages_node':
include/linux/gfp.h:91: error: invalid use of undefined type `struct
pglist_data'
include/linux/gfp.h: At top level:
include/linux/gfp.h:124: error: 'free_pages' redeclared as different
kind of symbol
include/linux/mmzone.h:114: error: previous declaration of 'free_pages'
was here
In file included from include/linux/sched.h:136,
                  from arch/x86_64/kernel/asm-offsets.c:7:
include/linux/timer.h:15: error: parse error before "raw_spinlock_t"
include/linux/timer.h:15: warning: no semicolon at end of struct or union
include/linux/timer.h:22: error: parse error before '}' token
include/linux/timer.h: In function `init_timer':
include/linux/timer.h:44: error: dereferencing pointer to incomplete type
include/linux/timer.h:45: error: dereferencing pointer to incomplete type
include/linux/timer.h:46: error: dereferencing pointer to incomplete type
include/linux/timer.h:46: error: parse error before "raw_spinlock_t"
include/linux/timer.h:46: error: parse error before "else"
include/linux/timer.h: In function `timer_pending':
include/linux/timer.h:61: error: dereferencing pointer to incomplete type
include/linux/timer.h: In function `add_timer':
include/linux/timer.h:87: error: dereferencing pointer to incomplete type
In file included from arch/x86_64/kernel/asm-offsets.c:7:
include/linux/sched.h: At top level:
include/linux/sched.h:179: error: parse error before "tasklist_lock"
include/linux/sched.h:179: warning: type defaults to `int' in
declaration of `tasklist_lock'
include/linux/sched.h:179: warning: data definition has no type or
storage class
include/linux/sched.h:180: error: parse error before "mmlist_lock"
include/linux/sched.h:180: warning: type defaults to `int' in
declaration of `mmlist_lock'
include/linux/sched.h:180: warning: data definition has no type or
storage class
In file included from include/linux/aio.h:5,
                  from include/linux/sched.h:225,
                  from arch/x86_64/kernel/asm-offsets.c:7:
include/linux/workqueue.h:20: error: field `timer' has incomplete type
In file included from include/linux/sched.h:225,
                  from arch/x86_64/kernel/asm-offsets.c:7:
include/linux/aio.h:122: error: parse error before "spinlock_t"
include/linux/aio.h:122: warning: no semicolon at end of struct or union
include/linux/aio.h:128: error: parse error before '}' token
include/linux/aio.h:139: error: parse error before "wait_queue_head_t"
include/linux/aio.h:139: warning: no semicolon at end of struct or union
include/linux/aio.h:141: warning: type defaults to `int' in declaration
of `ctx_lock'
include/linux/aio.h:141: warning: data definition has no type or storage
class
include/linux/aio.h:152: error: parse error before '}' token
In file included from arch/x86_64/kernel/asm-offsets.c:7:
include/linux/sched.h:252: error: field `mmap_sem' has incomplete type
include/linux/sched.h:253: error: parse error before "spinlock_t"
include/linux/sched.h:253: warning: no semicolon at end of struct or union
include/linux/sched.h:268: error: parse error before ':' token
include/linux/sched.h:272: error: parse error before "context"
include/linux/sched.h:272: warning: type defaults to `int' in
declaration of `context'
include/linux/sched.h:272: warning: data definition has no type or
storage class
include/linux/sched.h:283: error: parse error before "ioctx_list_lock"
include/linux/sched.h:283: warning: type defaults to `int' in
declaration of `ioctx_list_lock'
include/linux/sched.h:283: warning: data definition has no type or
storage class
include/linux/sched.h:287: error: parse error before '}' token
include/linux/sched.h:292: error: parse error before "spinlock_t"
include/linux/sched.h:292: warning: no semicolon at end of struct or union
include/linux/sched.h:611: error: parse error before "wait_queue_head_t"
include/linux/sched.h:611: warning: no semicolon at end of struct or union
include/linux/sched.h:630: error: parse error before ':' token
include/linux/sched.h:671: error: parse error before "alloc_lock"
include/linux/sched.h:671: warning: type defaults to `int' in
declaration of `alloc_lock'
include/linux/sched.h:671: warning: data definition has no type or
storage class
include/linux/sched.h:673: error: parse error before "proc_lock"
include/linux/sched.h:673: warning: type defaults to `int' in
declaration of `proc_lock'
include/linux/sched.h:673: warning: data definition has no type or
storage class
include/linux/sched.h:675: error: parse error before "switch_lock"
include/linux/sched.h:675: warning: type defaults to `int' in
declaration of `switch_lock'
include/linux/sched.h:675: warning: data definition has no type or
storage class
include/linux/sched.h:709: error: parse error before '}' token
include/linux/sched.h: In function `process_group':
include/linux/sched.h:713: error: dereferencing pointer to incomplete type
include/linux/sched.h: In function `dequeue_signal_lock':
include/linux/sched.h:848: error: dereferencing pointer to incomplete type
include/linux/sched.h:848: error: parse error before "raw_spinlock_t"
include/linux/sched.h:848: error: `__flags' undeclared (first use in
this function)
include/linux/sched.h:848: error: `raw_spinlock_t' undeclared (first use
in this function)
include/linux/sched.h:848: error: parse error before ')' token
include/linux/sched.h:848: error: dereferencing pointer to incomplete type
include/linux/sched.h:848: warning: unused variable `__ret'
include/linux/sched.h:848: error: parse error before "else"
include/linux/sched.h:846: warning: unused variable `ret'
include/linux/sched.h:848: warning: no return statement in function
returning non-void
include/linux/sched.h: At top level:
include/linux/sched.h:848: error: parse error before ')' token
include/linux/sched.h:849: warning: type defaults to `int' in
declaration of `ret'
include/linux/sched.h:849: error: `tsk' undeclared here (not in a function)
include/linux/sched.h:849: error: `mask' undeclared here (not in a function)
include/linux/sched.h:849: error: incompatible type for argument 3 of
`dequeue_signal'
include/linux/sched.h:849: error: initializer element is not constant
include/linux/sched.h:849: warning: data definition has no type or
storage class
include/linux/sched.h:850: error: parse error before "do"
include/linux/sched.h:850: error: parse error before numeric constant
include/linux/sched.h:850: warning: type defaults to `int' in
declaration of `sub_preempt_count'
include/linux/sched.h:850: warning: function declaration isn't a prototype
include/linux/sched.h:850: error: conflicting types for 'sub_preempt_count'
include/linux/preempt.h:14: error: previous declaration of
'sub_preempt_count' was here
include/linux/sched.h:850: error: conflicting types for 'sub_preempt_count'
include/linux/preempt.h:14: error: previous declaration of
'sub_preempt_count' was here
include/linux/sched.h:850: warning: data definition has no type or
storage class
include/linux/sched.h: In function `on_sig_stack':
include/linux/sched.h:890: error: dereferencing pointer to incomplete type
include/linux/sched.h:890: error: dereferencing pointer to incomplete type
include/linux/sched.h: In function `sas_ss_flags':
include/linux/sched.h:895: error: dereferencing pointer to incomplete type
include/linux/sched.h: In function `capable':
include/linux/sched.h:906: error: dereferencing pointer to incomplete type
include/linux/sched.h:907: error: dereferencing pointer to incomplete type
include/linux/sched.h: In function `mmdrop':
include/linux/sched.h:923: error: dereferencing pointer to incomplete type
include/linux/sched.h: In function `thread_group_empty':
include/linux/sched.h:1004: error: dereferencing pointer to incomplete type
include/linux/sched.h: In function `task_lock':
include/linux/sched.h:1025: error: dereferencing pointer to incomplete type
include/linux/sched.h:1025: error: parse error before "raw_spinlock_t"
include/linux/sched.h:1025: error: `raw_spinlock_t' undeclared (first
use in this function)
include/linux/sched.h:1025: error: parse error before ')' token
include/linux/sched.h:1025: error: dereferencing pointer to incomplete type
include/linux/sched.h: At top level:
include/linux/sched.h:1025: error: parse error before "while"
include/linux/sched.h: In function `task_unlock':
include/linux/sched.h:1030: error: dereferencing pointer to incomplete type
include/linux/sched.h:1030: error: parse error before "raw_spinlock_t"
include/linux/sched.h: At top level:
include/linux/sched.h:1030: error: parse error before "while"
include/linux/sched.h: In function `set_tsk_thread_flag':
include/linux/sched.h:1038: error: dereferencing pointer to incomplete type
include/linux/sched.h: In function `clear_tsk_thread_flag':
include/linux/sched.h:1043: error: dereferencing pointer to incomplete type
include/linux/sched.h: In function `test_and_set_tsk_thread_flag':
include/linux/sched.h:1048: error: dereferencing pointer to incomplete type
include/linux/sched.h: In function `test_and_clear_tsk_thread_flag':
include/linux/sched.h:1053: error: dereferencing pointer to incomplete type
include/linux/sched.h: In function `test_tsk_thread_flag':
include/linux/sched.h:1058: error: dereferencing pointer to incomplete type
include/linux/sched.h: At top level:
include/linux/sched.h:1096: error: parse error before '*' token
include/linux/sched.h:1097: warning: function declaration isn't a prototype
include/linux/sched.h: In function `hardirq_need_resched':
include/linux/sched.h:1112: error: dereferencing pointer to incomplete type
include/linux/sched.h: At top level:
include/linux/sched.h:1125: error: parse error before '*' token
include/linux/sched.h:1125: warning: function declaration isn't a prototype
include/linux/sched.h:1126: error: parse error before '*' token
include/linux/sched.h:1126: warning: function declaration isn't a prototype
include/linux/sched.h: In function `arch_pick_mmap_layout':
include/linux/sched.h:1187: error: dereferencing pointer to incomplete type
include/linux/sched.h:1187: error: dereferencing pointer to incomplete type
include/linux/sched.h:1188: error: dereferencing pointer to incomplete type
include/linux/sched.h:1189: error: dereferencing pointer to incomplete type
In file included from include/asm/hardirq.h:6,
                  from include/linux/hardirq.h:6,
                  from arch/x86_64/kernel/asm-offsets.c:10:
include/linux/irq.h: At top level:
include/linux/irq.h:79: error: parse error before "wait_queue_head_t"
include/linux/irq.h:79: warning: no semicolon at end of struct or union
include/linux/irq.h:80: warning: type defaults to `int' in declaration
of `lock'
include/linux/irq.h:80: warning: data definition has no type or storage
class
include/linux/irq.h:81: warning: type defaults to `int' in declaration
of `irq_desc_t'
include/linux/irq.h:83: error: parse error before "irq_desc"
include/linux/irq.h:83: warning: type defaults to `int' in declaration
of `irq_desc'
include/linux/irq.h:83: warning: data definition has no type or storage
class
In file included from include/asm/hardirq.h:6,
                  from include/linux/hardirq.h:6,
                  from arch/x86_64/kernel/asm-offsets.c:10:
include/linux/irq.h:97: error: parse error before "irq_desc_t"
include/linux/irq.h:97: warning: function declaration isn't a prototype
include/linux/irq.h:98: error: parse error before "irq_desc_t"
include/linux/irq.h:98: warning: function declaration isn't a prototype
In file included from include/linux/compat.h:15,
                  from include/asm/ia32.h:8,
                  from arch/x86_64/kernel/asm-offsets.c:15:
include/asm/compat.h: In function `compat_alloc_user_space':
include/asm/compat.h:196: error: dereferencing pointer to incomplete type
arch/x86_64/kernel/asm-offsets.c: In function `main':
arch/x86_64/kernel/asm-offsets.c:25: error: dereferencing pointer to
incomplete type
arch/x86_64/kernel/asm-offsets.c:26: error: dereferencing pointer to
incomplete type
arch/x86_64/kernel/asm-offsets.c:27: error: dereferencing pointer to
incomplete type
arch/x86_64/kernel/asm-offsets.c:28: error: dereferencing pointer to
incomplete type
arch/x86_64/kernel/asm-offsets.c: At top level:
include/asm/mmu.h:17: error: storage size of `sem' isn't known
include/linux/aio.h:149: error: storage size of `ring_info' isn't known
include/linux/sched.h:280: error: storage size of `core_done' isn't known
include/linux/sched.h:286: error: storage size of `default_kioctx' isn't
known
include/linux/sched.h:619: error: storage size of `real_timer' isn't known
make[1]: *** [arch/x86_64/kernel/asm-offsets.s] Error 1
make: *** [arch/x86_64/kernel/asm-offsets.s] Error 2


