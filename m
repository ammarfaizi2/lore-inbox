Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbUJaKev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbUJaKev (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 05:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbUJaKPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 05:15:37 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.18]:55395 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S261531AbUJaKDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 05:03:40 -0500
Date: Sun, 31 Oct 2004 11:03:39 +0100
Message-Id: <200410311003.i9VA3ddq009611@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 498] M68k: fix incorrect config comment in check_bugs()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Fix incorrect config comment in check_bugs()

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.10-rc1/arch/m68k/kernel/setup.c	2004-10-02 18:38:54.000000000 +0200
+++ linux-m68k-2.6.10-rc1/arch/m68k/kernel/setup.c	2004-10-10 16:50:33.000000000 +0200
@@ -541,7 +541,5 @@ void check_bugs(void)
 				"emulation project\n" );
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
