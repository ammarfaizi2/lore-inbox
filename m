Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbWCHLZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbWCHLZk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 06:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbWCHLZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 06:25:40 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6920 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932485AbWCHLZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 06:25:39 -0500
Date: Wed, 8 Mar 2006 12:25:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: lethal@linux-sh.org, kkojima@rr.iij4u.or.jp,
       linuxsh-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] arch/sh/Kconfig: don't source non-existing Kconfig files
Message-ID: <20060308112538.GE4006@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/sh/Kconfig shouldn't source non-existing Kconfig files.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 4 Mar 2006

--- linux-2.6.16-rc5-sh/arch/sh/Kconfig.old	2006-03-04 00:34:36.000000000 +0100
+++ linux-2.6.16-rc5-sh/arch/sh/Kconfig	2006-03-04 00:44:02.000000000 +0100
@@ -392,9 +392,9 @@
 
 endmenu
 
-source "arch/sh/boards/renesas/hs7751rvoip/Kconfig"
+#source "arch/sh/boards/renesas/hs7751rvoip/Kconfig"
 
-source "arch/sh/boards/renesas/rts7751r2d/Kconfig"
+#source "arch/sh/boards/renesas/rts7751r2d/Kconfig"
 
 config SH_PCLK_FREQ
 	int "Peripheral clock frequency (in Hz)"

