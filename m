Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263539AbUBREQd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 23:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbUBREQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 23:16:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:36503 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263539AbUBREPV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 23:15:21 -0500
Date: Tue, 17 Feb 2004 20:15:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.3
Message-ID: <Pine.LNX.4.58.0402172013320.2686@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, it's out.

There were some minimal changes relative to the last -rc4, mostly some 
configuration and build fixes, but a few important one-liners too.

Happy testing,

		Linus


Summary of changes from v2.6.3-rc4 to v2.6.3
============================================

Alexander Viro:
  o blkdev_put() data corruption

Andrew Morton:
  o mremap NULL pointer dereference fix
  o cifs: kunmap_atomic() takes a kernel address
  o Tuner bugfix

Bartlomiej Zolnierkiewicz:
  o fix build with CONFIG_BLK_DEV_IDEDMA=n (once again)

Ben Collins:
  o [SPARC64]: Add symbols to show_stack, and make oops stack output
    work

David Mosberger:
  o fix ia64 build failure
  o Fix radeon warning on 64-bit platforms

David S. Miller:
  o [SPARC64]: Fix non-PCI build, reported by David Dillow
  o [SPARC64]: Fix warnings on non-PCI build
  o [SPARC64]: Fix build with sysctl disabled

Hideaki Yoshifuji:
  o [NETFILTER]: Fix signedness overflow in ip{,6}_tables.c

James Simmons:
  o small fbmem.c fix

Jim Paradis:
  o Fix fencepost error in x86_64 IOMMU

Linus Torvalds:
  o Fix the dependency chain for I2C_ALGOBIT from the FB drivers that
    need it. 
  o Linux 2.6.3

Roman Zippel:
  o Avoid bogus warning about recursive dependencies

