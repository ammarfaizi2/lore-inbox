Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317171AbSF2Cc4>; Fri, 28 Jun 2002 22:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317180AbSF2Ccz>; Fri, 28 Jun 2002 22:32:55 -0400
Received: from [195.223.140.120] ([195.223.140.120]:46658 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317171AbSF2Ccy>; Fri, 28 Jun 2002 22:32:54 -0400
Date: Fri, 28 Jun 2002 22:35:00 -0400
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19rc1aa1
Message-ID: <20020629023459.GA1531@inspiron.ols.wavesec.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Only booted it on the laptop so far.

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19rc1aa1.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19rc1aa1/

Changelog:

Only in 2.4.19pre10aa4: 00_apm-idle_period-parse-1
Only in 2.4.19pre10aa4: 00_export-vmalloc_to_page-1
Only in 2.4.19pre10aa4: 00_fix-stat-irq-1
Only in 2.4.19pre10aa4: 00_scsi-error-thread-reparent-1
Only in 2.4.19pre10aa4: 00_sig_ign-discard-sigurg-1

	Merged in mainline.

Only in 2.4.19pre10aa4: 00_umem-compile-1

	Driver updated in mainline.

Only in 2.4.19rc1aa1: 00_dirty-inode-1

	Optimize away some mark_buffer_dirty_sync() from Chris Mason.

Only in 2.4.19pre10aa4: 00_drop-inetpeer-cache-1.gz
Only in 2.4.19rc1aa1: 00_drop-inetpeer-cache-2.gz
Only in 2.4.19pre10aa4: 05_vm_07_local_pages-2
Only in 2.4.19rc1aa1: 05_vm_07_local_pages-3
Only in 2.4.19pre10aa4: 05_vm_11_lru_release_check-1
Only in 2.4.19pre10aa4: 05_vm_14_block_flushpage_check-1
Only in 2.4.19rc1aa1: 05_vm_14_block_flushpage_check-2
Only in 2.4.19pre10aa4: 05_vm_17_rest-7
Only in 2.4.19rc1aa1: 05_vm_17_rest-8
Only in 2.4.19pre10aa4: 30_x86_setup-boot-cleanup-4
Only in 2.4.19rc1aa1: 30_x86_setup-boot-cleanup-5
Only in 2.4.19pre10aa4: 60_pagecache-atomic-4
Only in 2.4.19rc1aa1: 60_pagecache-atomic-5
Only in 2.4.19pre10aa4: 70_xfs-1.1-2.gz
Only in 2.4.19rc1aa1: 70_xfs-1.1-3.gz

	Rediffed.

Only in 2.4.19pre10aa4: 00_e100-2.0.30-k1.gz
Only in 2.4.19pre10aa4: 00_e1000-4.2.17-k1.gz
Only in 2.4.19rc1aa1: 07_e100-1.8.38.gz
Only in 2.4.19rc1aa1: 08_e100-includes-1
Only in 2.4.19rc1aa1: 09_e100-compilehack-1

	Got bugreport about driver in jam2 while previous was ok. So go back to
	the working version before the upgrade until this is sorted out.

Only in 2.4.19rc1aa1: 00_o_direct-read-overflow-write-locking-xfs-1

	Allow reads behind the end of the i_size with O_DIRECT, so O_DIRECT can
	be used for reading the last block too.

Only in 2.4.19rc1aa1: 00_readv-writev-1

	backout mainline semantics for alpha.

Only in 2.4.19rc1aa1: 00_scsi-largelun-1

	Scan more luns in various scsi drivers.

Only in 2.4.19rc1aa1: 00_vm-cleanups-1

	Cleanup vm bits in function of the changes in mainline
	2.4.19rc1.

Only in 2.4.19rc1aa1: 63_tux-notuxnostat-1

	Patch from Randy Hron not to show tux statistics in /proc/stat if
	TUX isn't compiled in (saves some byte of kernel image).

Only in 2.4.19rc1aa1: 90_acpi-2.5.24-1.gz

	My laptop lockups hard with the acpi in mainline, so backported
	the one in 2.5.24 to 2.4.19rc1aa1 that seems to work instead
	(besides suspend/hybernate of course).

Only in 2.4.19pre10aa4: 93_NUMAQ-2
Only in 2.4.19rc1aa1: 93_NUMAQ-3

	numaq update from Patricia Gaughen.

Only in 2.4.19pre10aa4: 94_numaq-tsc-1
Only in 2.4.19rc1aa1: 94_numaq-tsc-2

	Try #2 :).

Andrea
