Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293632AbSCKHT3>; Mon, 11 Mar 2002 02:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293633AbSCKHTU>; Mon, 11 Mar 2002 02:19:20 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:24148 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S293632AbSCKHTG>; Mon, 11 Mar 2002 02:19:06 -0500
Date: Mon, 11 Mar 2002 08:20:31 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19pre2aa2
Message-ID: <20020311082031.B10413@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL:

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre2aa2.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre2aa2/

Only in 2.4.19pre2aa2: 00_F_DUPFD-fcntl-rlimit-1

	Return -EINVAL if F_DUPFD and arg is negative or greater than or equal
	to {OPEN_MAX} as required by SuS and LSB. -EMFILE has to be returned
	only if we couldn't find an empty fd slot in the range, but the range
	was valid. From Thorsten Kukuk.

Only in 2.4.19pre2aa2: 00_amd-viper-7441-guessed-1

	Let amd74xx recognize the 7441 amd chipset, it works and I needed it
	mainly to set ->highmem = 1 and to skip the bounce buffers on my
	desktop.  (Tried also mode 5 and it failed, so I #undef __CAN_MODE_5
	back)

Only in 2.4.19pre2aa1: 00_block-highmem-all-18b-5.gz
Only in 2.4.19pre2aa2: 00_block-highmem-all-18b-6.gz

	Set hwif->highmem = 1 also with via and amd chipsets.

Only in 2.4.19pre2aa2: 00_cpu-affinity-rml-1

	Include it for now, it's handy for specialized usages, but please don't
	rely on this API, never include it in any software until it hits some
	mainline branch first. This should be considered as an unofficial
	debugging/benchmarking trick only for now. The fact it's an API by
	name it allows to include it but that's all.

	Patch from Robert Love.

Only in 2.4.19pre2aa2: 00_dnotify-fl_owner-1

	Let only the fl_owner to drop the dnotify (otherwise
	a modprobe triggered by konqueror would lead konqueror
	not to notice any longer the directory updates).

	Based on alternate patch from Waldo Bastian.

Only in 2.4.19pre2aa2: 00_fdatasync-FIFO-1

	writepage in FIFO order (more likely to be increasing physically
	consecutive on disk). fdatawait is fine to be left LIFO, so
	it's also less likely to reschedule in wait_on_page.

	Patch from Andrew Morton, keep up the good work! :)

Only in 2.4.19pre2aa1: 00_ia64-dma-1
Only in 2.4.19pre2aa2: 00_ia64-dma-2
Only in 2.4.19pre2aa1: 00_nfs-rdplus-2
Only in 2.4.19pre2aa2: 00_nfs-rdplus-3
Only in 2.4.19pre2aa1: 10_rawio-vary-io-3
Only in 2.4.19pre2aa2: 10_rawio-vary-io-4
Only in 2.4.19pre2aa1: 60_pagecache-atomic-3
Only in 2.4.19pre2aa2: 60_pagecache-atomic-4
Only in 2.4.19pre2aa1: 60_tux-config-stuff-1
Only in 2.4.19pre2aa2: 60_tux-config-stuff-2
Only in 2.4.19pre2aa1: 60_tux-dprintk-2
Only in 2.4.19pre2aa2: 60_tux-dprintk-3
Only in 2.4.19pre2aa1: 60_tux-exports-1
Only in 2.4.19pre2aa2: 60_tux-exports-2
Only in 2.4.19pre2aa1: 60_tux-syscall-2
Only in 2.4.19pre2aa2: 60_tux-syscall-3
Only in 2.4.19pre2aa1: 60_tux-sysctl-2
Only in 2.4.19pre2aa2: 60_tux-sysctl-3

	Rediffed so that it applies cleanly with -F1.

Only in 2.4.19pre2aa1: 00_lvm-1.0.2-2.gz

	Dropped (thanks to Christoph Hellwig for noticing the silly backout of
	1.0.3 :).

Only in 2.4.19pre2aa1: 00_max_bytes-1
Only in 2.4.19pre2aa2: 00_max_bytes-2

	Fixed an (harmless) merging error due "patch" being too permissive w/o
	-F1.  Thanks to Chip Salzenberg for noticing it. I defaulted to always
	use patch -F1 in the future and I recommend the same to everybody.

Only in 2.4.19pre2aa2: 00_mprotect_msync-ENOMEM-1

	According to SuS and LSB mprotect and msync have to return -ENOMEM
	and not -EFAULT when somebody passes unmapped regions as working
	areas. Patch from Thorsten Kukuk.

Only in 2.4.19pre2aa2: 00_rawio-forward-blkdev-ioctl-1

	Allow ioctl on the rawdevices, forward them to the bd_op->ioctl
	of the bind blockdevice.

	Patch from Andi Kleen.

Only in 2.4.19pre2aa1: 10_lvm-snapshot-check-1
Only in 2.4.19pre2aa2: 10_lvm-snapshot-check-2
Only in 2.4.19pre2aa1: 70_xfs-4.gz
Only in 2.4.19pre2aa2: 70_xfs-5.gz

	Rediffed.

Only in 2.4.19pre2aa1: 10_vm-29
Only in 2.4.19pre2aa2: 10_vm-30

	Fix deadlock. 2.4.19pre2aa1 could deadlock due a missing UnlockPage().
	All previous -aa kernels was not affected by such bug, only 2.4.19pre2aa1
	could deadlock. Made some other vm change and cleanup, including the
	drop of wait_on_page and the exclusive flag to the lock_page waitqueue.

Only in 2.4.19pre2aa2: 71_xfs-blksize-1

	Advertise the fs blkszie as PAGE_SIZE, so that the db libs doesn't run
	wild when on top of MD. I think on-disk format shouldn't depend on the
	underlying device device, they should depend on the fs only. The stripe
	size hint should be used only to fill two bios of the right size etc...
	but I'd prefer if they wouldn't affect the ondisk format of files. Even
	PAGE_SIZE doesn't look completly correct, but at least it reduces the
	problem to moving an harddisk from an alpha/ia64 to an x86 (x86-64
	doesn't change the page_size), which is a bit less common.

	Patch from Andi Kleen.

Andrea
