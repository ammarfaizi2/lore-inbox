Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290827AbSBZQPf>; Tue, 26 Feb 2002 11:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290841AbSBZQPZ>; Tue, 26 Feb 2002 11:15:25 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:15537 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S290827AbSBZQPQ>; Tue, 26 Feb 2002 11:15:16 -0500
Message-Id: <200202261527.IAA22696@tstac.esa.lanl.gov>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: [PATCH] 2.5.5-dj1, add 1 more help text to drivers/video/Config.help
Date: Tue, 26 Feb 2002 09:13:27 -0700
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@suse.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a help text for CONFIG_FB_TRIDENT to drivers/video/Config.help.

Steven

--- linux-2.5.5-dj1/drivers/video/Config.help.orig      Mon Feb 25 14:32:31 2002
+++ linux-2.5.5-dj1/drivers/video/Config.help   Tue Feb 26 09:05:20 2002
@@ -516,6 +516,19 @@
   Please read the file Documentation/fb/README-sstfb.txt for supported
   options and other important info  support.

+CONFIG_FB_TRIDENT
+  This driver is supposed to support graphics boards with the
+  Trident CyberXXXX/Image/CyberBlade chips mostly found in laptops
+  but also on some motherboards. For more information, read
+  <file:Documentation/fb/tridentfb.txt>
+
+  Say Y if you have such a graphics board.
+
+  The driver is also available as a module ( = code which can be
+  inserted and removed from the running kernel whenever you want). The
+  module will be called rivafb.o. If you want to compile it as a
+  module, say M here and read <file:Documentation/modules.txt>.
+
 CONFIG_FB_SBUS
   Say Y if you want support for SBUS or UPA based frame buffer device.
