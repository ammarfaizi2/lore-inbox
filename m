Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264383AbTLVK5H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 05:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbTLVK5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 05:57:07 -0500
Received: from postman4.arcor-online.net ([151.189.0.189]:41885 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S264383AbTLVK5A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 05:57:00 -0500
Date: Mon, 22 Dec 2003 11:56:14 +0100
From: Juergen Quade <quade@hsnr.de>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Small copy-paste typo in floppy.c
Message-ID: <20031222105614.GA24568@hsnr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just hit a copy-paste typo in floppy.c.

       Juergen.

--- drivers/block/floppy.old.c	2003-12-22 11:42:42.000000000 +0100
+++ drivers/block/floppy.c	2003-12-22 11:44:00.000000000 +0100
@@ -2563,7 +2563,7 @@
 			       current_count_sectors);
 			if (CT(COMMAND) == FD_READ)
 				printk("read\n");
-			if (CT(COMMAND) == FD_READ)
+			if (CT(COMMAND) == FD_WRITE)
 				printk("write\n");
 			break;
 		}
@@ -2894,7 +2894,7 @@
 			       current_count_sectors);
 			if (CT(COMMAND) == FD_READ)
 				printk("read\n");
-			if (CT(COMMAND) == FD_READ)
+			if (CT(COMMAND) == FD_WRITE)
 				printk("write\n");
 			return 0;
 		}
--- drivers/block/floppy98.old.c	2003-12-22 11:42:51.000000000 +0100
+++ drivers/block/floppy98.c	2003-12-22 11:44:25.000000000 +0100
@@ -2594,7 +2594,7 @@
 			       current_count_sectors);
 			if (CT(COMMAND) == FD_READ)
 				printk("read\n");
-			if (CT(COMMAND) == FD_READ)
+			if (CT(COMMAND) == FD_WRITE)
 				printk("write\n");
 			break;
 		}
@@ -2925,7 +2925,7 @@
 			       current_count_sectors);
 			if (CT(COMMAND) == FD_READ)
 				printk("read\n");
-			if (CT(COMMAND) == FD_READ)
+			if (CT(COMMAND) == FD_WRITE)
 				printk("write\n");
 			return 0;
 		}
