Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265287AbUGCXbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265287AbUGCXbF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 19:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265288AbUGCXbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 19:31:05 -0400
Received: from mail-relay-2.tiscali.it ([212.123.84.92]:45955 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S265287AbUGCXa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 19:30:58 -0400
Date: Sun, 4 Jul 2004 01:30:53 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.23aa3
Message-ID: <20040703233053.GA7281@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This includes only the pending important fixes (I started this on 31
May, and I finished it now that all needed fixes are already public).
Some user asked for an update like this. If you're still using 2.4.23aa2
you're recommended to upgrade to 2.6 or 2.4.23aa3 or the latest mainline
2.4.

Marcelo you may want to look into merging for
9999_z-get_user_pages_pte_pin-1, that's one relevant bugfix suitable for
mainline 2.4 too. It it rejects badly or you need more info on it please
don't hesitate to ask. Normally this bug goes unnoticed since most
people does rawio on shm where there are no COWs.

Thanks.

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.23aa3.gz
	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.23aa3/

Changelog diff between 2.4.23aa2 and 2.4.23aa3:

Only in 2.4.23aa3: 00_acpi-bridge-swizzle-1
Only in 2.4.23aa3: 00_airo-proc-write-overflow-1
Only in 2.4.23aa3: 00_asus-acpi-sscanf-1
Only in 2.4.23aa3: 00_cgc-x86_64-transform-2
Only in 2.4.23aa3: 00_chown-DAC-check-missing-1
Only in 2.4.23aa3: 00_decnet-check-pointers-1
Only in 2.4.23aa3: 00_eql-check-dev-1
Only in 2.4.23aa3: 00_fix-e1000-infoleak-1
Only in 2.4.23aa3: 00_fix-ext3-infoleak-1
Only in 2.4.23aa3: 00_fix-fork-memleak-1
Only in 2.4.23aa3: 00_fix-hotplug-allocation-1
Only in 2.4.23aa3: 00_fix-jfs-infoleak-1
Only in 2.4.23aa3: 00_fix-soundblaster-dos-1
Only in 2.4.23aa3: 00_fwait-exceptions-1
Only in 2.4.23aa3: 00_gdth-pci-dma-2
Only in 2.4.23aa3: 00_highuid16-1
Only in 2.4.23aa3: 00_i810_dma-buf_count-1
Only in 2.4.23aa3: 00_iso9660-fix-1
Only in 2.4.23aa3: 00_lvm-vmalloc-1
Only in 2.4.23aa3: 00_mcast-msfilter-int-overflow-1
Only in 2.4.23aa3: 00_mpu401-user-pointer-1
Only in 2.4.23aa3: 00_nfs-autofs-umount-crash-1
Only in 2.4.23aa3: 00_nfsd-no-tcp-mixup-1
Only in 2.4.23aa3: 00_nfs-invalidate_inode_pages2-1
Only in 2.4.23aa3: 00_pss-user-pointer-1
Only in 2.4.23aa3: 00_r128-size-check-1
Only in 2.4.23aa2: 00_rawio-crash-1
Only in 2.4.23aa3: 00_rawio-crash-2
Only in 2.4.23aa3: 00_rtc-initialize-1
Only in 2.4.23aa3: 00_scsi-req-q-ptr-stall-1
Only in 2.4.23aa3: 00_sctp-fix-1
Only in 2.4.23aa3: 00_smbfs-uid32-1
Only in 2.4.23aa3: 00_sound-copy-to-user-1
Only in 2.4.23aa3: 00_sunrpc-svcsock-drop-1
Only in 2.4.23aa3: 00_symbios-fullspeed-1
Only in 2.4.23aa3: 00_tg3-sn2-1
Only in 2.4.23aa3: 00_usb-storage-ioerror_ohci-locking-1
Only in 2.4.23aa3: 00_x86_64-compute-csum-1
Only in 2.4.23aa3: 00_x86_64-erratum93-1
Only in 2.4.23aa3: 00_x86_64-iommu-fencepost-1
Only in 2.4.23aa3: 00_x86_64-iommu-fullflush-1
Only in 2.4.23aa3: 00_x86_64-ldt-limit-1
Only in 2.4.23aa3: 00_x86_64-mtrr-1
Only in 2.4.23aa3: 00_x86_64-node-limit-1
Only in 2.4.23aa3: 00_x86_64-ptrace32-1
Only in 2.4.23aa3: 00_x86_64-tiocgdev-fix-1
Only in 2.4.23aa3: 20_ext3-direct-io-fix-1
Only in 2.4.23aa3: 73_fix-xfs-infoleak-1
Only in 2.4.23aa3: 9999900_panic-overflow-1
Only in 2.4.23aa3: 9999900_qla-mknod-1
Only in 2.4.23aa3: 9999_fault-handler-infoleak-1

	New fixes.

Only in 2.4.23aa3: 00_coredump-lfs-1

	Allow >2G coredumps (mostly for 64bit archs).

Only in 2.4.23aa2: 00_extraversion-34
Only in 2.4.23aa3: 00_extraversion-35
Only in 2.4.23aa2: 90_proc-mapped-base-6
Only in 2.4.23aa3: 90_proc-mapped-base-7

	Rediffed.

Only in 2.4.23aa2: 20_pte-highmem-32.gz
Only in 2.4.23aa3: 20_pte-highmem-33.gz

	Fix unlikely to trigger vmalloc race.

Only in 2.4.23aa2: 9900_aio-25.gz
Only in 2.4.23aa3: 9900_aio-26.gz

	Fix wtd semaphore race condition (I think it comes from some redhat
	kernel).

Only in 2.4.23aa3: 9999900_pte-dirty-1

	s390 will not mark the pte dirty during page fault (it works
	with physical pages dirty flags not ptes dirty flags).

Only in 2.4.23aa3: 9999_z-get_user_pages_pte_pin-1

	This is a major fix for mm corruption during COW with rawio.
	I got convinced it was safe to leave pages not pinned into the
	pte during the rawio, but it broke off with COWs that executes
	copy-on-write while we write to the user page, and then the write
	is lost since the copy happend in the middle of the I/O. In 2.6
	I fixed it in a more elegant way that doesn't introduce any locking
	thanks to the mapcount information (in 2.4 there's only the page->count)
	and I used a bitflag to pin the pages, but this means the I/O is
	serialized page against page, that's fine for 2.4.

Only in 2.4.23aa2: 9999_zzz-dynamic-hz-4.gz
Only in 2.4.23aa3: 9999_zzz-dynamic-hz-5.gz

	Fix a silly (luckily minor) bug in the kernel-user hz conversion
	routines (if you had any problem with the floppy or with timings with
	some HZ value this will fix it).
