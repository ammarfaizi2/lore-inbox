Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314469AbSDXDLn>; Tue, 23 Apr 2002 23:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314473AbSDXDLm>; Tue, 23 Apr 2002 23:11:42 -0400
Received: from mail.mesatop.com ([208.164.122.9]:6668 "EHLO thor.mesatop.com")
	by vger.kernel.org with ESMTP id <S314469AbSDXDLm>;
	Tue, 23 Apr 2002 23:11:42 -0400
Subject: [PATCH] 2.5.9-dj1, add one help text to drivers/video/Config.help.
From: Steven Cole <elenstev@mesatop.com>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1019617610.29005.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution/1.0.2-5mdk 
Date: 23 Apr 2002 21:09:27 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a help text for CONFIG_FB_PM3 to drivers/video/Config.help
The help text was obtained from the Configure.help in 2.4.19-pre7.

Steven

--- linux-2.5.9-dj1/drivers/video/Config.help.orig	Tue Apr 23 20:32:22 2002
+++ linux-2.5.9-dj1/drivers/video/Config.help	Tue Apr 23 20:34:07 2002
@@ -68,6 +68,12 @@
   Say Y to enable support for the Amiga Phase 5 CVisionPPC BVisionPPC
   framebuffer cards.  Phase 5 is no longer with us, alas.
 
+CONFIG_FB_PM3
+  This is the frame buffer device driver for the 3DLabs Permedia3
+  chipset, used in Formac ProFormance III, 3DLabs Oxygen VX1 &
+  similar boards, 3DLabs Permedia3 Create!, Appian Jeronimo 2000
+  and maybe other boards.
+
 CONFIG_FB_AMIGA
   This is the frame buffer device driver for the builtin graphics
   chipset found in Amigas.



