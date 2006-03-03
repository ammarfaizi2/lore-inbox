Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbWCCXpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWCCXpt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 18:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbWCCXpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 18:45:49 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:27405 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751202AbWCCXps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 18:45:48 -0500
Date: Sat, 4 Mar 2006 00:45:48 +0100
From: Adrian Bunk <bunk@stusta.de>
To: lethal@linux-sh.org, kkojima@rr.iij4u.or.jp
Cc: linuxsh-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] arch/sh/Kconfig: don't source non-existing Kconfig files
Message-ID: <20060303234548.GG9295@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/sh/Kconfig shouldn't source non-existing Kconfig files.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

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

