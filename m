Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267439AbSKQDMB>; Sat, 16 Nov 2002 22:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267440AbSKQDMB>; Sat, 16 Nov 2002 22:12:01 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34824 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267439AbSKQDMB>;
	Sat, 16 Nov 2002 22:12:01 -0500
Date: Sun, 17 Nov 2002 03:18:55 +0000
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org,
       Janitors <kernel-janitor-discuss@lists.sourceforge.net>
Subject: [PATCH] remove sched.h from blkdev.h
Message-ID: <20021117031855.U20070@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


blkdev.h simply doesn't need sched.h

diff -urpNX dontdiff linux-2.5.47/include/linux/blkdev.h linux-2.5.47-pci/include/linux/blkdev.h
--- linux-2.5.47/include/linux/blkdev.h	2002-11-14 10:52:17.000000000 -0500
+++ linux-2.5.47-pci/include/linux/blkdev.h	2002-11-16 22:01:32.000000000 -0500
@@ -2,7 +2,6 @@
 #define _LINUX_BLKDEV_H
 
 #include <linux/major.h>
-#include <linux/sched.h>
 #include <linux/genhd.h>
 #include <linux/list.h>
 #include <linux/pagemap.h>

-- 
Revolutions do not require corporate support.
