Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265321AbUAZWFn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 17:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265327AbUAZWFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 17:05:43 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:18187 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265321AbUAZWFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 17:05:37 -0500
Date: Mon, 26 Jan 2004 22:05:34 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: fbdev documentation patch
Message-ID: <Pine.LNX.4.44.0401262202280.5445-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

  The below patch updates the framebuffer docs to reflect the requirement 
that all driver names must end in fb. Please apply.

--- linus-2.6/Documentation/fb/modedb.txt	2004-01-26 13:31:19.000000000 -0800
+++ fbdev-2.6/Documentation/fb/modedb.txt	2004-01-26 16:32:23.000000000 -0800
@@ -51,10 +51,10 @@
     Drivers that support modedb boot options
     Boot Name	  Cards Supported
 
-    ami		- Amiga chipset frame buffer
+    amifb	- Amiga chipset frame buffer
     aty128fb	- ATI Rage128 / Pro frame buffer
     atyfb	- ATI Mach64 frame buffer
-    tdfx	- 3D Fx frame buffer
+    tdfxfb	- 3D Fx frame buffer
     tridentfb	- Trident (Cyber)blade chipset frame buffer
 
 BTW, only a few drivers use this at the moment. Others are to follow

