Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263817AbTEODV7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 23:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbTEODVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 23:21:48 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:28396 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263817AbTEODS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 23:18:28 -0400
Date: Thu, 15 May 2003 04:31:16 +0100
Message-Id: <200305150331.h4F3VGA3000762@deviant.impure.org.uk>
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: shorten rclan debug output
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 2.4 long long ago.

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/net/rclanmtl.h linux-2.5/drivers/net/rclanmtl.h
--- bk-linus/drivers/net/rclanmtl.h	2003-04-22 00:40:42.000000000 +0100
+++ linux-2.5/drivers/net/rclanmtl.h	2003-04-22 01:23:14.000000000 +0100
@@ -54,10 +54,10 @@
 #include <asm/io.h>
 
 /* Debug stuff. Define for debug output */
-#define RCDEBUG
+#undef RCDEBUG
 
 #ifdef RCDEBUG
-#define dprintk(args...) printk(KERN_DEBUG "(rcpci45 driver:) " args)
+#define dprintk(args...) printk(KERN_DEBUG "rc: " args)
 #else
 #define dprintk(args...) { }
 #endif
