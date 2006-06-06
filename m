Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWFFOyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWFFOyL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 10:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWFFOyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 10:54:11 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:52162 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932198AbWFFOyK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 10:54:10 -0400
Date: Tue, 6 Jun 2006 16:53:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.18 -mm merge plans
Message-ID: <20060606145337.GC29798@elte.hu>
References: <20060604135011.decdc7c9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060604135011.decdc7c9.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5015]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> lock-validator-floppyc-irq-release-fix.patch
> lock-validator-floppyc-irq-release-fix-fix.patch
> lock-validator-forcedethc-fix.patch
> lock-validator-mutex-section-binutils-workaround.patch
> lock-validator-add-__module_address-method.patch
> lock-validator-better-lock-debugging.patch
> lock-validator-locking-api-self-tests.patch
> lock-validator-locking-api-self-tests-self-test-fix.patch
> lock-validator-locking-init-debugging-improvement.patch
> lock-validator-beautify-x86_64-stacktraces.patch
> lock-validator-beautify-x86_64-stacktraces-fix.patch
> lock-validator-beautify-x86_64-stacktraces-fix-2.patch
> lock-validator-beautify-x86_64-stacktraces-fix-3.patch
> lock-validator-beautify-x86_64-stacktraces-fix-4.patch
> lock-validator-x86_64-document-stack-frame-internals.patch
> lock-validator-stacktrace.patch
> lock-validator-stacktrace-build-fix.patch
> lock-validator-stacktrace-warning-fix.patch
> lock-validator-stacktrace-fix-on-x86_64.patch
> lock-validator-fown-locking-workaround.patch
> lock-validator-sk_callback_lock-workaround.patch
> lock-validator-irqtrace-core.patch
> lock-validator-irqtrace-core-powerpc-fix-1.patch
> lock-validator-irqtrace-core-non-x86-fix.patch
> lock-validator-irqtrace-core-non-x86-fix-2.patch
> lock-validator-irqtrace-core-non-x86-fix-3.patch
> lock-validator-irqtrace-entrys-fix.patch
> lock-validator-irqtrace-core-remove-softirqc-warn_on.patch
> lock-validator-irqtrace-cleanup-include-asm-i386-irqflagsh.patch
> lock-validator-irqtrace-cleanup-include-asm-x86_64-irqflagsh.patch
> lock-validator-x86_64-irqflags-trace-entrys-fix.patch
> lock-validator-lockdep-add-local_irq_enable_in_hardirq-api.patch
> lock-validator-add-per_cpu_offset.patch
> lock-validator-add-per_cpu_offset-fix.patch
> lock-validator-core.patch
> lock-validator-core-early_boot_irqs_-build-fix.patch
> lock-validator-core-fix-compiler-warning.patch
> lock-validator-procfs.patch
> lock-validator-core-multichar-fix.patch
> lock-validator-core-count_matching_names-fix.patch
> lock-validator-design-docs.patch
> lock-validator-prove-rwsem-locking-correctness.patch
> lock-validator-prove-rwsem-locking-correctness-fix.patch
> lock-validator-prove-rwsem-locking-correctness-powerpc-fix.patch
> lock-validator-prove-spinlock-rwlock-locking-correctness.patch
> lock-validator-prove-mutex-locking-correctness.patch
> lock-validator-prove-mutex-locking-correctness-fix-null-type-name-bug.patch
> lock-validator-print-all-lock-types-on-sysrq-d.patch
> lock-validator-x86_64-early-init.patch
> lock-validator-smp-alternatives-workaround.patch
> lock-validator-do-not-recurse-in-printk.patch
> lock-validator-disable-nmi-watchdog-if-config_lockdep.patch
> lock-validator-disable-nmi-watchdog-if-config_lockdep-i386.patch
> lock-validator-disable-nmi-watchdog-if-config_lockdep-x86_64.patch
> lock-validator-special-locking-bdev.patch
> lock-validator-special-locking-direct-io.patch
> lock-validator-special-locking-serial.patch
> lock-validator-special-locking-serial-fix.patch
> lock-validator-special-locking-dcache.patch
> lock-validator-special-locking-i_mutex.patch
> lock-validator-special-locking-s_lock.patch
> lock-validator-special-locking-futex.patch
> lock-validator-special-locking-genirq.patch
> lock-validator-special-locking-completions.patch
> lock-validator-special-locking-waitqueues.patch
> lock-validator-special-locking-mm.patch
> lock-validator-special-locking-serio.patch
> lock-validator-special-locking-slab.patch
> lock-validator-special-locking-skb_queue_head_init.patch
> lock-validator-special-locking-net-ipv4-igmpcpatch.patch
> lock-validator-special-locking-net-ipv4-igmpc-2.patch
> lock-validator-special-locking-timerc.patch
> lock-validator-special-locking-schedc.patch
> lock-validator-special-locking-hrtimerc.patch
> lock-validator-special-locking-sock_lock_init.patch
> lock-validator-special-locking-af_unix.patch
> lock-validator-special-locking-bh_lock_sock.patch
> lock-validator-special-locking-mmap_sem.patch
> lock-validator-special-locking-sb-s_umount.patch
> lock-validator-special-locking-sb-s_umount-fix.patch
> lock-validator-special-locking-sb-s_umount-2.patch
> lock-validator-special-locking-sb-s_umount-2-fix.patch
> lockdep-annotate-rpc_populate-for.patch
> lock-validator-special-locking-jbd.patch
> lock-validator-special-locking-posix-timers.patch
> lock-validator-special-locking-sch_genericc.patch
> lock-validator-special-locking-xfrm.patch
> lockdep-add-i_mutex-ordering-annotations-to-the-sunrpc.patch
> lockdep-add-parent-child-annotations-to-usbfs.patch
> lock-validator-special-locking-sound-core-seq-seq_portsc.patch
> lock-validator-special-locking-sound-core-seq-seq_devicec.patch
> lock-validator-special-locking-sound-core-seq-seq_devicec-fix.patch
> lock-validator-fix-rt_hash_lock_sz.patch
> lock-validator-introduce-irq__lockdep.patch
> locking-validator-special-rule-8390c-disable_irq.patch
> locking-validator-special-rule-3c59xc-disable_irq.patch
> lock-validator-enable-lock-validator-in-kconfig.patch
> lock-validator-enable-lock-validator-in-kconfig-require-trace_irqflags_support.patch
> lock-validator-enable-lock-validator-in-kconfig-not-yet.patch
> lockdep-one-stacktrace-column-if-config_lockdep=y.patch
> i386-remove-multi-entry-backtraces.patch
> lockdep-further-improve-stacktrace-output.patch
> lock-validator-irqtrace-support-non-x86-architectures.patch
> lock-validator-disable-oprofile-if-lockdep=y.patch
> lock-validator-select-kallsyms_all.patch
> 
>  I'm not really sure that this has as good a bugfixes/effort ratio as 
>  would, say, working on our ever-growing bugzilla list.

well, the two sets of bugs are pretty much disjunct. Deadlocks that 
trigger (and produce an NMI watchdog output) are easy to fix. But the 
overwhelming majority of the deadlocks the lock validator found were not 
actually triggered.

>  But given that it exists, and that it'll fix (or rather prevent) 
>  future bugs at a constant-but-low rate for a long time, I guess it's 
>  something we want.
> 
>  I think it's more like 2.6.19 material.  The number of 
>  teach-lockdep-about-this-unusual-but-correct-locking-code patches 
>  continues to grow and I don't think we fully have a handle on how 
>  it'll all end up looking.

the biggest proportion of fixlets were due to out-of-order unlocking, 
which i took care of with CONFIG_DEBUG_NON_NESTED_UNLOCKS. Note that 
most of those annotations are trivial, and i think we've now got most of 
them. Also, those annotations are definitely useful in documenting 
"unusual" locking sequences - and we very much want to document the 
locking details of Linux. Also note that for example the 
local_irq_enable_in_hardirq() annotation found at least one real 
deadlock as well.

So unless something unexpected happens in -mm, i'd like to see this 
merged into 2.6.18 too.

	Ingo
