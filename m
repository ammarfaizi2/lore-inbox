Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267450AbSKQEEJ>; Sat, 16 Nov 2002 23:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267453AbSKQEEJ>; Sat, 16 Nov 2002 23:04:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41482 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267450AbSKQEEI>;
	Sat, 16 Nov 2002 23:04:08 -0500
Date: Sun, 17 Nov 2002 04:11:07 +0000
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org,
       Janitors <kernel-janitor-discuss@lists.sourceforge.net>
Subject: [PATCH] remove sched.h from i2c.h
Message-ID: <20021117041107.C20070@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i2c.h simply doesn't need sched.h

diff -urpNX dontdiff linux-2.5.47/include/linux/i2c.h linux-2.5.47-pci/include/linux/i2c.h
--- linux-2.5.47/include/linux/i2c.h	2002-10-01 03:06:20.000000000 -0400
+++ linux-2.5.47-pci/include/linux/i2c.h	2002-11-16 22:32:14.000000000 -0500
@@ -48,7 +48,6 @@ struct i2c_msg;
 #endif
 
 #include <asm/page.h>			/* for 2.2.xx 			*/
-#include <linux/sched.h>
 #include <asm/semaphore.h>
 #include <linux/config.h>
 
-- 
Revolutions do not require corporate support.
