Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbTEKKXm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 06:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbTEKKXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 06:23:11 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:57443 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S261232AbTEKKVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 06:21:36 -0400
Date: Sun, 11 May 2003 12:31:04 +0200
Message-Id: <200305111031.h4BAV4tC019724@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Obsolete include/asm-ppc/linux_logo.h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to remove include/asm-ppc/linux_logo.h when integrating the new logo
code.

--- linux-2.5.x/include/asm-ppc/linux_logo.h.orig	Sun Sep 22 15:53:50 2002
+++ linux-2.5.x/include/asm-ppc/linux_logo.h	Thu Jan  1 01:00:00 1970
@@ -1,24 +0,0 @@
-/*
- * include/asm-ppc/linux_logo.h: A linux logo to be displayed on boot
- * (pinched from the sparc port).
- *
- * Copyright (C) 1996 Larry Ewing (lewing@isc.tamu.edu)
- * Copyright (C) 1996 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
- *
- * You can put anything here, but:
- * LINUX_LOGO_COLORS has to be less than 224
- * values have to start from 0x20
- * (i.e. linux_logo_{red,green,blue}[0] is color 0x20)
- */
-#ifdef __KERNEL__
- 
-#include <linux/init.h>
-
-#define linux_logo_banner "Linux/PPC version " UTS_RELEASE
-
-#define LINUX_LOGO_HEIGHT	80
-#define LINUX_LOGO_WIDTH	80
-
-#include <linux/linux_logo.h>
-
-#endif /* __KERNEL__ */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
