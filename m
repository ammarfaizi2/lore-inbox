Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266160AbSKQECq>; Sat, 16 Nov 2002 23:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266161AbSKQECp>; Sat, 16 Nov 2002 23:02:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39178 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S266160AbSKQECp>;
	Sat, 16 Nov 2002 23:02:45 -0500
Date: Sun, 17 Nov 2002 04:09:43 +0000
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org,
       Janitors <kernel-janitor-discuss@lists.sourceforge.net>
Subject: [PATCH] remove sched.h from if_pppox.h
Message-ID: <20021117040943.B20070@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


if_pppox simply doesn't need sched.h

diff -urpNX dontdiff linux-2.5.47/include/linux/if_pppox.h linux-2.5.47-pci/include/linux/if_pppox.h
--- linux-2.5.47/include/linux/if_pppox.h	2002-10-01 03:06:19.000000000 -0400
+++ linux-2.5.47-pci/include/linux/if_pppox.h	2002-11-16 22:38:08.000000000 -0500
@@ -24,7 +24,6 @@
 #include <linux/if_ether.h>
 #include <linux/if.h>
 #include <linux/netdevice.h>
-#include <linux/sched.h>
 #include <asm/semaphore.h>
 #include <linux/ppp_channel.h>
 #endif /* __KERNEL__ */

-- 
Revolutions do not require corporate support.
