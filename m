Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264465AbTFIPWV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 11:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264471AbTFIPWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 11:22:21 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:29654 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264465AbTFIPWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 11:22:16 -0400
Date: Mon, 9 Jun 2003 17:35:35 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Greg Kroah-Hartman <greg@kroah.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] Root Plug depends on USB
Message-ID: <Pine.GSO.4.21.0306091734180.1347-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is this OK?

---

Root Plug sample LSM module depends on USB

--- linux-2.5.x/security/Kconfig	Mon Feb 10 21:59:35 2003
+++ linux-m68k-2.5.x/security/Kconfig	Sun Jun  8 11:52:52 2003
@@ -33,7 +33,7 @@
 
 config SECURITY_ROOTPLUG
 	tristate "Root Plug Support"
-	depends on SECURITY!=n
+	depends on SECURITY!=n && USB
 	help
 	  This is a sample LSM module that should only be used as such.
 	  It prevents any programs running with egid == 0 if a specific

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

