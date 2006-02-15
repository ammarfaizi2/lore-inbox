Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWBOWqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWBOWqW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 17:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWBOWqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 17:46:21 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:61456 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932208AbWBOWqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 17:46:21 -0500
Date: Wed, 15 Feb 2006 23:46:19 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: lethal@linux-sh.org, kkojima@rr.iij4u.or.jp,
       linuxsh-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Jean-Luc Leger <reiga@dspnet.fr.eu.org>
Subject: [2.6 patch] arch/sh/Kconfig: fix the ISA_DMA_API dependencies
Message-ID: <20060215224619.GF5066@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean-Luc Leger <reiga@dspnet.fr.eu.org> found this obvious typo.


Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: Paul Mundt <lethal@linux-sh.org>

---

This patch was already sent on:
- 14 Feb 2006

--- linux-2.6.16-rc2-mm1-full/arch/sh/Kconfig.old	2006-02-14 01:18:22.000000000 +0100
+++ linux-2.6.16-rc2-mm1-full/arch/sh/Kconfig	2006-02-14 01:19:43.000000000 +0100
@@ -446,7 +446,7 @@
 
 config ISA_DMA_API
 	bool
-	depends on MPC1211
+	depends on SH_MPC1211
 	default y
 
 menu "Kernel features"

