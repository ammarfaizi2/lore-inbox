Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264536AbTLGU6u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 15:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264535AbTLGU4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 15:56:48 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.18]:28492 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S264536AbTLGUzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 15:55:42 -0500
Date: Sun, 7 Dec 2003 21:51:28 +0100
Message-Id: <200312072051.hB7KpS98000759@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 138] Mac II VIA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mac II VIA: Don't include <asm/init.h> directly

--- linux-2.4.23/drivers/macintosh/via-macii.c	2002-05-29 10:13:10.000000000 +0200
+++ linux-m68k-2.4.23/drivers/macintosh/via-macii.c	2003-11-12 13:47:36.000000000 +0100
@@ -21,13 +21,13 @@
 #include <linux/delay.h>
 #include <linux/sched.h>
 #include <linux/adb.h>
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
