Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265856AbTFVTs6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 15:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265863AbTFVTs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 15:48:58 -0400
Received: from p68.rivermarket.wintek.com ([208.13.56.68]:4992 "EHLO
	dust.p68.rivermarket.wintek.com") by vger.kernel.org with ESMTP
	id S265856AbTFVTsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 15:48:55 -0400
Date: Sun, 22 Jun 2003 15:06:17 -0500 (EST)
From: Alex Goddard <agoddard@purdue.edu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.73
In-Reply-To: <Pine.LNX.4.44.0306221150440.17823-100000@old-penguin.transmeta.com>
Message-ID: <Pine.LNX.4.56.0306221453010.1455@dust>
References: <Pine.LNX.4.44.0306221150440.17823-100000@old-penguin.transmeta.com>
X-GPG-PUBLIC_KEY: N/a
X-GPG-FINGERPRINT: BCBC 0868 DB78 22F3 A657 785D 6E3B 7ACB 584E B835
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Jun 2003, Linus Torvalds wrote:

> 
> Various updates all over the map here. Lots of ia64 updates, and Andrew 
> merged the ext3 locking cleanups/fixes that have been in the -mm tree for 
> a while.

The ehci-hid compile error from .72 is still there.  A fix was posted by 
akpm in the lkml thread [patch] ehci_hcd.c linkage fix.

Death of compilation output:

CC      drivers/usb/host/ehci-hcd.o
drivers/usb/host/ehci-hcd.c:977: error: pci_ids causes a section type 
conflict
make[3]: *** [drivers/usb/host/ehci-hcd.o] Error 1
make[2]: *** [drivers/usb/host] Error 2
make[1]: *** [drivers/usb] Error 2
make: *** [drivers] Error 2

-- 
Alex Goddard
agoddard@purdue.edu
