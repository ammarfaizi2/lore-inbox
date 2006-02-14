Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030332AbWBNAWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030332AbWBNAWG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 19:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030333AbWBNAWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 19:22:06 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4619 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030332AbWBNAWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 19:22:05 -0500
Date: Tue, 14 Feb 2006 01:22:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: lethal@linux-sh.org, kkojima@rr.iij4u.or.jp
Cc: linuxsh-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Jean-Luc Leger <reiga@dspnet.fr.eu.org>
Subject: [2.6 patch] arch/sh/Kconfig: fix the ISA_DMA_API dependencies
Message-ID: <20060214002203.GC17604@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean-Luc Leger <reiga@dspnet.fr.eu.org> found this obvious typo.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc2-mm1-full/arch/sh/Kconfig.old	2006-02-14 01:18:22.000000000 +0100
+++ linux-2.6.16-rc2-mm1-full/arch/sh/Kconfig	2006-02-14 01:19:43.000000000 +0100
@@ -446,7 +446,7 @@
 
 config ISA_DMA_API
 	bool
-	depends on MPC1211
+	depends on SH_MPC1211
 	default y
 
 menu "Kernel features"

