Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272653AbTHKOZR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 10:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272635AbTHKNl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 09:41:57 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:40587 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272628AbTHKNlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 09:41:06 -0400
To: torvalds@transmeta.com
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove unneeded ; from macros in i8042
Message-Id: <E19mCuP-0003dd-00@tetrachloride>
Date: Mon, 11 Aug 2003 14:40:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/input/serio/i8042.h linux-2.5/drivers/input/serio/i8042.h
--- bk-linus/drivers/input/serio/i8042.h	2003-04-10 06:01:18.000000000 +0100
+++ linux-2.5/drivers/input/serio/i8042.h	2003-05-15 20:30:22.000000000 +0100
@@ -103,11 +103,11 @@
 
 #ifdef DEBUG
 static unsigned long i8042_start;
-#define dbg_init() do { i8042_start = jiffies; } while (0);
+#define dbg_init() do { i8042_start = jiffies; } while (0)
 #define dbg(format, arg...) printk(KERN_DEBUG __FILE__ ": " format " [%d]\n" ,\
 	 ## arg, (int) (jiffies - i8042_start))
 #else
-#define dbg_init() do { } while (0);
+#define dbg_init() do { } while (0)
 #define dbg(format, arg...) do {} while (0)
 #endif
 
