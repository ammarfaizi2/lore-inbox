Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266132AbTFWUDz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 16:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266133AbTFWUDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 16:03:54 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:44989 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S266132AbTFWUDy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 16:03:54 -0400
Date: Mon, 23 Jun 2003 22:16:49 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] vgastate warning
Message-ID: <Pine.GSO.4.21.0306232215511.28300-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


vgastate: add missing include for v{malloc,free}() prototypes

--- linux-2.5.72/drivers/video/vgastate.c.orig	Wed Jun 18 12:16:26 2003
+++ linux-2.5.72/drivers/video/vgastate.c	Mon Jun 23 21:45:31 2003
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/fb.h>
+#include <linux/vmalloc.h>
 #include <video/vga.h>
 
 struct regstate {

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

