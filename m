Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262636AbSJBVmh>; Wed, 2 Oct 2002 17:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262637AbSJBVmh>; Wed, 2 Oct 2002 17:42:37 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:25597 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262636AbSJBVme>; Wed, 2 Oct 2002 17:42:34 -0400
Subject: PATCH: 2.5 GMX2000
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Oct 2002 22:55:38 +0100
Message-Id: <1033595738.25260.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The GMX code in your tree is unfinished stuff. You need 4.0 DRM for the
GMX2000 until 4.3 at least

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.40/drivers/char/drm/Config.in linux.2.5.40-ac1/drivers/char/drm/Config.in
--- linux.2.5.40/drivers/char/drm/Config.in	2002-07-20 20:12:19.000000000 +0100
+++ linux.2.5.40-ac1/drivers/char/drm/Config.in	2002-10-02 22:30:21.000000000 +0100
@@ -8,7 +8,7 @@
 bool 'Direct Rendering Manager (XFree86 4.1.0 and higher DRI support)' CONFIG_DRM
 if [ "$CONFIG_DRM" != "n" ]; then
     tristate '  3dfx Banshee/Voodoo3+' CONFIG_DRM_TDFX
-    tristate '  3dlabs GMX 2000' CONFIG_DRM_GAMMA
+#    tristate '  3dlabs GMX 2000' CONFIG_DRM_GAMMA
     tristate '  ATI Rage 128' CONFIG_DRM_R128
     dep_tristate '  ATI Radeon' CONFIG_DRM_RADEON $CONFIG_AGP
     dep_tristate '  Intel I810' CONFIG_DRM_I810 $CONFIG_AGP


