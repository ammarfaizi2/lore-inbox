Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263454AbVCEAhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263454AbVCEAhP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263425AbVCEATT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:19:19 -0500
Received: from mail.dif.dk ([193.138.115.101]:38582 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S263429AbVCEAFC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 19:05:02 -0500
Date: Sat, 5 Mar 2005 01:06:02 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Antonino Daplas <adaplas@pol.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH][Trivial] Kconfig help text update for config FB_NVIDIA
Message-ID: <Pine.LNX.4.62.0503050101580.2794@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tiny trivial patch to fix up the help text for config FB_NVIDIA, cut 
against 2.6.11-mm1


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.11-mm1-orig/drivers/video/Kconfig	2005-03-05 00:39:33.000000000 +0100
+++ linux-2.6.11-mm1/drivers/video/Kconfig	2005-03-05 00:56:36.000000000 +0100
@@ -619,12 +619,11 @@ config FB_NVIDIA
 	help
 	  This driver supports graphics boards with the nVidia chips, TNT
 	  and newer. For very old chipsets, such as the RIVA128, then use
-	  the the rivafb.
+	  the rivafb.
 	  Say Y if you have such a graphics board.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called nvidiafb.
-          none yet
 
 config FB_NVIDIA_I2C
        bool "Enable DDC Support"


