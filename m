Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbTDENjW (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 08:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262199AbTDENjW (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 08:39:22 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:59055 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S262198AbTDENjV (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 08:39:21 -0500
Date: Sat, 5 Apr 2003 15:50:52 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Cc: kjahds@kjahds.com, alan@lxorguk.ukuu.org.uk
Subject: [PATCH] Typo fixes in drivers/video/68328fb.c
Message-ID: <Pine.LNX.4.51.0304051547060.32063@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while looking for code to convert to C99 i found that there are typos
in drivers/video/68328fb.c that will cause errors on compilation.

Regards,
Maciej Soltysiak

diff -Nru linux-2.5.64.orig/drivers/video/68328fb.c linux-2.5.64/drivers/video/68328fb.c
--- linux-2.5.64.orig/drivers/video/68328fb.c	2003-03-05 04:29:31.000000000 +0100
+++ linux-2.5.64/drivers/video/68328fb.c	2003-04-05 15:40:11.000000000 +0200
@@ -401,12 +401,12 @@
                                               ((1<<(width))-1)) : 0))

 static struct fb_ops mc68328_fb_ops = {
-	.owner:		THIS_MODULE,
-	.fb_setcolreg:	mc68328fb_setcolreg,
-	.fb_fillrect:	cfbfillrect,
-	.fb_copyarea:	cfbcopyarea,
-	.fb_imageblit:	cfbimgblt,
-	.fb_cursor:	softcursor,
+	.owner		= THIS_MODULE,
+	.fb_setcolreg	= mc68328fb_setcolreg,
+	.fb_fillrect	= cfbfillrect,
+	.fb_copyarea	= cfbcopyarea,
+	.fb_imageblit	= cfbimgblt,
+	.fb_cursor	= softcursor,
 };
