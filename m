Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272502AbTGZOlN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272503AbTGZOec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:34:32 -0400
Received: from amsfep13-int.chello.nl ([213.46.243.24]:41274 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S272505AbTGZOcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:32:35 -0400
Date: Sat, 26 Jul 2003 16:51:42 +0200
Message-Id: <200307261451.h6QEpgRJ002328@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k module
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Add missing module_arch_cleanup()

--- linux-2.6.x/arch/m68k/kernel/module.c	Thu Feb 27 21:02:04 2003
+++ linux-m68k-2.6.x/arch/m68k/kernel/module.c	Sun Jun  8 13:06:00 2003
@@ -93,3 +93,7 @@
 {
 	return 0;
 }
+
+void module_arch_cleanup(struct module *mod)
+{
+}

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
