Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268861AbRHaS0M>; Fri, 31 Aug 2001 14:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268897AbRHaS0F>; Fri, 31 Aug 2001 14:26:05 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:12587 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S268861AbRHaSZj>; Fri, 31 Aug 2001 14:25:39 -0400
Date: Fri, 31 Aug 2001 20:26:27 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.10pre2aa2
Message-ID: <20010831202627.A927@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Only in 2.4.10pre2aa2: 00_3.5G-address-space-1

	Add kernel configuration that allows to map up to 3.5G of ram per
	process. (disabled when PAE mode is enabled)

Only in 2.4.10pre2aa2: 00_elf-at_phdr-1

	ELF fix from Jakub Jelinek to write right data in the AT_PHDR aux entry
	for prelinked executables.

Only in 2.4.10pre2aa2: 00_io_apic-lock-1

	Add ioapic smp locking during ioapic bootup (should matter
	only against ioapic irqs). (from -ac)

Only in 2.4.10pre2aa2: 00_pagetables-alloc-none-1

	Don't allocate new pagetables if they're only non present (could been
	allocated and swapped out [non present] under us). (similar to
	the patch in tux2-c0, but this version is better because it also uses
	pgd_none in pmd_alloc)

Only in 2.4.10pre2aa2: 00_smp_build-irq-1

	Fix from John Byrne for smp irq entry points.

Only in 2.4.10pre2aa1: 00_smp_call_function-1
Only in 2.4.10pre2aa2: 00_smp_call_function-2

	Fixed typo (missing ';').

Only in 2.4.10pre2aa2: 00_tgid-1

	Fix from -ac, don't reuse a pid if some task still use it
	as its tgid (matters for thread groups with parent thread
	exited).

Only in 2.4.10pre2aa1: 10_prefetch-3
Only in 2.4.10pre2aa2: 10_prefetch-4

	Add alpha prefetch. (from tux2-c0)

Only in 2.4.10pre2aa2: 52_uml-page-offset-raw-1

	Update uml to compile with PAGE_OFFSET_RAW definintion for
	the 3.5G address space config option. BTW, I won't allow
	CONFIG_2G/3G because they're worthless and they workaround
	only the lack of no bounce buffers, since the no bounce buffer
	patch is available we don't need them any longer as workaround.

Only in 2.4.10pre2aa1: 60_tux-3
Only in 2.4.10pre2aa2: 60_tux-2.4.9-ac5-C0-4

	Upgrade to latest tux release (31-aug-01) (seems to be tux 2.1.0 according
	to the userspace packge numbering despite the kernel code still calls
	it tux 2.0) Tux is from Ingo Molnar at people.redhat.com/~mingo/TUX-patches/

Only in 2.4.10pre2aa2: 60_tux-config-stuff-1

	Separate the tux config.in/Makefile stuff to speedup future merging.

Only in 2.4.10pre2aa2: 62_tux-invalidate_inode_pages2-1
Only in 2.4.10pre2aa2: 62_tux-generic-file-read-1

	Separate a few tux -aa changes from the main patch to speedup future
	merging.

Andrea
