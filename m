Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314680AbSDTRn7>; Sat, 20 Apr 2002 13:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312915AbSDTRms>; Sat, 20 Apr 2002 13:42:48 -0400
Received: from [195.223.140.120] ([195.223.140.120]:21600 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S313014AbSDTRmT>; Sat, 20 Apr 2002 13:42:19 -0400
Date: Sat, 20 Apr 2002 19:42:13 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19pre7aa1
Message-ID: <20020420194213.K1291@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre7aa1.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre7aa1/

Changelog diff between 2.4.19pre6aa1 and 2.4.19pre7aa1 besides moving on
top of pre7:

Only in 2.4.19pre7aa1: 00_19pre7_x86_setup_cleanups-1

	Fix a few not optimal declarations introduced in 2.4.19pre7.

Only in 2.4.19pre7aa1: 00_387-fix-1

	Avoid signal restore to screwup mxcsr.

Only in 2.4.19pre7aa1: 00_athlon-smp-ctx-switch-gdt-1

	Avoid cacheline false sharing in the GDT tss overloading during cxt
	switching for athlon and P4. (idea from Andi)

Only in 2.4.19pre7aa1: 00_backout-kio-request-1

	Wakeup the kio waiter only after all buffers are unlocked,
	to avoid not necessary scheduling.

Only in 2.4.19pre7aa1: 00_blkdev-pagecache-alias-read_full_page-1

	Avoid blkdev read_full_page to overwrite uptodate buffercache
	used by the fs. From Stephen.

Only in 2.4.19pre6aa1: 00_blkdev-ulimit-1
Only in 2.4.19pre6aa1: 00_rawio-forward-blkdev-ioctl-1

	Merged in mainline.

Only in 2.4.19pre7aa1: 00_block-highmem-all-18b-10.gz
Only in 2.4.19pre6aa1: 00_block-highmem-all-18b-9.gz
Only in 2.4.19pre6aa1: 00_cpu-affinity-rml-2
Only in 2.4.19pre7aa1: 00_cpu-affinity-rml-3
Only in 2.4.19pre6aa1: 00_really-write-inode-1
Only in 2.4.19pre6aa1: 00_sd-cleanup-1
Only in 2.4.19pre7aa1: 00_sd-cleanup-2
Only in 2.4.19pre6aa1: 05_vm_12_drain_cpu_caches-1
Only in 2.4.19pre7aa1: 05_vm_12_drain_cpu_caches-2
Only in 2.4.19pre6aa1: 10_numa-sched-16
Only in 2.4.19pre7aa1: 10_numa-sched-17
Only in 2.4.19pre6aa1: 10_rawio-vary-io-6
Only in 2.4.19pre7aa1: 10_rawio-vary-io-7
Only in 2.4.19pre6aa1: 20_pte-highmem-20
Only in 2.4.19pre7aa1: 20_pte-highmem-22
Only in 2.4.19pre6aa1: 30_x86_setup-boot-cleanup-1
Only in 2.4.19pre7aa1: 30_x86_setup-boot-cleanup-2

	Rediffed.

Only in 2.4.19pre7aa1: 00_cpu-affinity-syscall-rml-2.4.19-pre7-1

	Merged syscall official API for SMP CPU bindings.

Only in 2.4.19pre7aa1: 00_get_pid-no-deadlock-and-boosted-1

	Avoid deadlocking into get_pid if we try to fork
	more tasks than the max number of pid available.
	This also boosts the algorithm so that it scales up to
	the max_threads. The idea of the bitmap is from Ihno Krumreich.
	In 2.5 we could do even better on top of this by keeping the
	bitmap synchronously updated, so without requiring the task list
	browsing to fill it.

Only in 2.4.19pre7aa1: 00_loop-fixes-2.4.19pre7ac2-1

	Loop fixes (wrong goto label and schedule_timeout noop)
	merged from 2.4.19pre7ac2.

Only in 2.4.19pre7aa1: 00_mmx_xmm-init-1

	Fix mmx and SSE initialization for recent CPUs. Doesn't
	matter but moved the mxcsr load before the sse xor.
	Better than using fxrestor.

Only in 2.4.19pre7aa1: 00_nfs-tcp-tweaks-4-rmv-cong-nonsense-3
Only in 2.4.19pre6aa1: 00_nfs-tcp-tweaks-4-try-new-1

	Go back to the mainline congestion control, the try-new
	is apparently slower.

Only in 2.4.19pre7aa1: 00_partition-pagemap-include-1

	Fix compile trouble suggested by Petr Vandrovec.

Only in 2.4.19pre6aa1: 00_prepare-write-fixes-2
Only in 2.4.19pre7aa1: 00_prepare-write-fixes-3

	Add a missing flush_dcache_page() to the prepare write corruption
	fixes. Noticed by Andrew Morton.

Only in 2.4.19pre7aa1: 00_std-serial-first-1

	Initialize the standard serial port first. From Khalid Aziz.

Only in 2.4.19pre6aa1: 50_uml-patch-2.4.18-12.gz
Only in 2.4.19pre7aa1: 50_uml-patch-2.4.18-18.gz
Only in 2.4.19pre6aa1: 55_uml-page_address-1
Only in 2.4.19pre7aa1: 55_uml-page_address-2

	Latest uml updates from Jeff.

Only in 2.4.19pre7aa1: 58_uml-hostfs-compile-1
Only in 2.4.19pre7aa1: 59_uml-compat-2.5-1

	Fix a few uml compile troubles. Jeff, if you would use the pre-patches
	instead of the official kernels I wouldn't need to fix those myself.
	This is just informational.

Only in 2.4.19pre6aa1: 60_tux-2.4.17-final-A1.gz
Only in 2.4.19pre7aa1: 60_tux-2.4.18-final-A3.gz
Only in 2.4.19pre6aa1: 60_tux-kstat-2
Only in 2.4.19pre7aa1: 60_tux-kstat-3

	Latest tux update from Ingo.

Only in 2.4.19pre7aa1: 70_xfs-1.1-0.gz
Only in 2.4.19pre6aa1: 70_xfs-8.gz

	Sync with xfs 1.1 release. From Eric Sandeen, SGI.

Only in 2.4.19pre7aa1: 73_xfs-blksize-PAGE_SIZE-1

	Fix blksize reported on top of md (that otherwise confuses libdb), from
	Andi.

Only in 2.4.19pre7aa1: 74_super_quotaops-1

	Fix compile trouble in 1.1.

Only in 2.4.19pre6aa1: 81_x86_64-arch-2.gz
Only in 2.4.19pre7aa1: 81_x86_64-arch-3.gz
Only in 2.4.19pre6aa1: 82_x86-64-compile-aa-2
Only in 2.4.19pre7aa1: 82_x86-64-compile-aa-4
Only in 2.4.19pre7aa1: 83_x86_64-setup64-compile-1
Only in 2.4.19pre7aa1: 84_x86_64-out_of_line_bug-1
Only in 2.4.19pre7aa1: 85_x86_64-mmx-xmm-init-1
Only in 2.4.19pre7aa1: 86_x86_64-FIOQSIZE-1
Only in 2.4.19pre7aa1: 87_x86_64-dec_and_lock-1

	Latest x86-64 tree, plus various fixes.

Only in 2.4.19pre7aa1: 90_init-survive-threaded-race-1

	Fix a race in the survive path of the page fault, harmless in practice
	because init isn't threaded, but in theory one could run a threaded
	program as init. Problem noticed by Andi.

Andrea
