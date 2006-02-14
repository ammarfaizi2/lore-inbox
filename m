Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030265AbWBNARi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbWBNARi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 19:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030326AbWBNARh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 19:17:37 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:267 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030265AbWBNARh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 19:17:37 -0500
Date: Tue, 14 Feb 2006 01:17:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Cc: Jean-Luc Leger <reiga@dspnet.fr.eu.org>
Subject: [2.6 patch] fix a typo in the CPU_H8300H dependencies
Message-ID: <20060214001725.GB17604@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean-Luc Leger <reiga@dspnet.fr.eu.org> found this obvious typo.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc2-mm1-full/arch/h8300/Kconfig.cpu.old	2006-02-14 01:14:34.000000000 +0100
+++ linux-2.6.16-rc2-mm1-full/arch/h8300/Kconfig.cpu	2006-02-14 01:14:57.000000000 +0100
@@ -169,7 +169,7 @@
 
 config CPU_H8300H
 	bool
-	depends on (H8002 || H83007 || H83048 || H83068)
+	depends on (H83002 || H83007 || H83048 || H83068)
 	default y
 
 config CPU_H8S

