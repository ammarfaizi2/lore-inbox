Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265442AbUAAVGu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 16:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264901AbUAAVAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 16:00:55 -0500
Received: from amsfep14-int.chello.nl ([213.46.243.22]:10302 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S264902AbUAAUD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:03:29 -0500
Date: Thu, 1 Jan 2004 21:03:27 +0100
Message-Id: <200401012003.i01K3Rip031888@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 375] Mac II VIA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mac II VIA: Don't include <asm/init.h> directly

--- linux-2.6.0/drivers/macintosh/via-macii.c	2003-05-27 19:02:53.000000000 +0200
+++ linux-m68k-2.6.0/drivers/macintosh/via-macii.c	2003-11-12 13:48:31.000000000 +0100
@@ -22,13 +22,13 @@
 #include <linux/sched.h>
 #include <linux/adb.h>
 #include <linux/interrupt.h>
+#include <linux/init.h>
 #include <asm/macintosh.h>
 #include <asm/macints.h>
 #include <asm/machw.h>
 #include <asm/mac_via.h>
 #include <asm/io.h>
 #include <asm/system.h>
-#include <asm/init.h>
 
 static volatile unsigned char *via;
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
