Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262560AbTI1N1v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 09:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262573AbTI1NGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 09:06:52 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:36436 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S262571AbTI1NGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 09:06:23 -0400
Date: Sun, 28 Sep 2003 14:55:35 +0200
Message-Id: <200309281255.h8SCtZDM005624@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 325] Sun-3/3x frame buffer device is broken
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sun-3/3x frame buffer device is broken (needs update to new fbdev and sbuslib
frameworks)

--- linux-2.6.0-test6/drivers/video/Kconfig	Tue Sep  9 10:13:11 2003
+++ linux-m68k-2.6.0-test6/drivers/video/Kconfig	Fri Sep 19 14:32:14 2003
@@ -374,7 +374,7 @@
 
 config FB_SUN3
 	bool "Sun3 framebuffer support"
-	depends on FB && (SUN3 || SUN3X)
+	depends on FB && (SUN3 || SUN3X) && BROKEN
 
 config FB_BW2
 	bool "BWtwo support"

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
