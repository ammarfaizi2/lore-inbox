Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755714AbWK0A7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755714AbWK0A7b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 19:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755724AbWK0A7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 19:59:31 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59657 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1755706AbWK0A7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 19:59:30 -0500
Date: Mon, 27 Nov 2006 01:59:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: chas@cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [2.6 patch] NET_SCH_ATM doesn't need ipcommon.o
Message-ID: <20061127005934.GN15364@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NET_SCH_ATM doesn't need ipcommon.o

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc6-mm1/net/atm/Makefile.old	2006-11-26 08:50:05.000000000 +0100
+++ linux-2.6.19-rc6-mm1/net/atm/Makefile	2006-11-26 08:56:29.000000000 +0100
@@ -10,7 +10,6 @@
 atm-$(subst m,y,$(CONFIG_ATM_CLIP)) += ipcommon.o
 obj-$(CONFIG_ATM_BR2684) += br2684.o
 atm-$(subst m,y,$(CONFIG_ATM_BR2684)) += ipcommon.o
-atm-$(subst m,y,$(CONFIG_NET_SCH_ATM)) += ipcommon.o
 atm-$(CONFIG_PROC_FS) += proc.o
 
 obj-$(CONFIG_ATM_LANE) += lec.o
