Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262151AbUKVQa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbUKVQa1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 11:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbUKVQ3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 11:29:44 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:58895 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262135AbUKVPvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 10:51:10 -0500
Date: Mon, 22 Nov 2004 16:51:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] make W1_DS9490_BRIDGE available
Message-ID: <20041122155102.GD19419@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems noone noted that due to a typo, the W1_DS9490_BRIDGE option 
didn't have any effect.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm3-full/drivers/w1/Kconfig.old	2004-11-22 14:34:13.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/w1/Kconfig	2004-11-22 14:34:21.000000000 +0100
@@ -30,7 +30,7 @@
 	  This support is also available as a module.  If so, the module 
 	  will be called ds9490r.ko.
 
-config W1_DS9490R_BRIDGE
+config W1_DS9490_BRIDGE
 	tristate "DS9490R USB <-> W1 transport layer for 1-wire"
 	depends on W1_DS9490
 	help

