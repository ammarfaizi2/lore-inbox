Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbULQTB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbULQTB4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 14:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbULQTBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 14:01:55 -0500
Received: from amsfep18-int.chello.nl ([213.46.243.20]:35131 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S262114AbULQTBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 14:01:46 -0500
Date: Fri, 17 Dec 2004 20:01:44 +0100
Message-Id: <200412171901.iBHJ1iND011249@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 164] m68k: fix incorrect config comment in check_bugs()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Fix incorrect config comment in check_bugs()

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.4.29-pre2/arch/m68k/kernel/setup.c	2004-10-08 20:36:40.000000000 +0200
+++ linux-m68k-2.4.29-pre2/arch/m68k/kernel/setup.c	2004-10-10 16:51:05.000000000 +0200
@@ -607,7 +607,5 @@ void check_bugs(void)
 		printk( KERN_EMERG "(see http://no-fpu.linux-m68k.org)\n" );
 		panic( "no FPU" );
 	}
-
-#endif /* CONFIG_SUN3 */
-
+#endif /* !CONFIG_M68KFPU_EMU */
 }

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
