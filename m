Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129232AbRBDEZZ>; Sat, 3 Feb 2001 23:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131139AbRBDEZP>; Sat, 3 Feb 2001 23:25:15 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:13317 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129232AbRBDEY7>; Sat, 3 Feb 2001 23:24:59 -0500
Date: Sat, 3 Feb 2001 20:24:27 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.2-pre1
Message-ID: <Pine.LNX.4.10.10102032021380.1010-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mainly a number of small details and some driver updates. The socket
datagram handling one is important, and has already been posted separately
here on linux-kernel. The VIA driver update is rather important if you
have one of the newer VIA chipsets.

		Linus

----
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
