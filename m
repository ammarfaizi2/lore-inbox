Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131174AbRBIXgW>; Fri, 9 Feb 2001 18:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131172AbRBIXgM>; Fri, 9 Feb 2001 18:36:12 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:59150 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131118AbRBIXf6>; Fri, 9 Feb 2001 18:35:58 -0500
Date: Fri, 9 Feb 2001 15:35:21 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.2-pre3
Message-ID: <Pine.LNX.4.10.10102091531550.22341-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nothing too radical here..

		Linus

----
-pre3:
 - Jens: better ordering of requests when unable to merge
 - Neil Brown: make md work as a module again (we cannot autodetect
   in modules, not enough background information)
 - Neil Brown: raid5 SMP locking cleanups
 - Neil Brown: nfsd: handle Irix NFS clients named pipe behavior and
   dentry leak fix
 - maestro3 shutdown fix
 - fix dcache hash calculation that could cause bad hashes under certain
   circumstances (Dean Gaudet)
 - David Miller: networking and sparc updates
 - Jeff Garzik: include file cleanups
 - Andy Grover: ACPI update
 - Coda-fs error return fixes
 - rth: alpha Jensen update

-pre2:
 - driver sync up with Alan
 - Andrew Morton: wakeup cleanup and race fix
 - Paul Mackerras: macintosh driver updates.
 - don't trust "page_count()" on reserved pages!
 - Russell King: fix serious IDE multimode write bug!
 - me, Jens, others: fix elevator problem
 - ARM, MIPS and cris architecture updates
 - alpha updates: better page clear/copy, avoid kernel lock in execve
 - USB and firewire updates
 - ISDN updates
 - Irda updates

-pre1:
 - XMM: don't allow illegal mxcsr values
 - ACPI: handle non-existent battery strings gracefully
 - Compaq Smart Array driver update
 - Kanoj Sarcar: serial console hardware flow control support
 - ide-cs: revert toc-valid cache checking in 2.4.1
 - Vojtech Pavlik: update via82cxxx driver to handle the vt82c686
 - raid5 graceful failure handling fix
 - ne2k-pci: enable device before asking the irq number
 - sis900 driver update
 - riva FB driver update
 - fix silly inode hashing pessimization
 - add SO_ACCEPTCONN for SuS
 - remove modinfo hack workaround, all newer modutils do it correctly
 - datagram socket shutdown fix
 - mark process as running when it takes a page-fault

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
