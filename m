Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932496AbWAJV6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbWAJV6F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 16:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932516AbWAJV6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 16:58:05 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:39434 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932459AbWAJV6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 16:58:04 -0500
Date: Tue, 10 Jan 2006 22:58:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: rmk+serial@arm.linux.org.uk
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jean-Luc Leger <reiga@dspnet.fr.eu.org>
Subject: [2.6 patch] drivers/serial/Kconfig: fix SERIAL_M32R_PLDSIO dependencies
Message-ID: <20060110215801.GF3911@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a typo in the dependencies reported by
Jean-Luc Leger <reiga@dspnet.fr.eu.org>.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-mm2-full/drivers/serial/Kconfig.old	2006-01-10 21:56:52.000000000 +0100
+++ linux-2.6.15-mm2-full/drivers/serial/Kconfig	2006-01-10 21:57:54.000000000 +0100
@@ -826,7 +826,7 @@
 
 config SERIAL_M32R_PLDSIO
 	bool "M32R SIO I/F on a PLD"
-	depends on SERIAL_M32R_SIO=y && (PLAT_OPSPUT || PALT_USRV || PLAT_M32700UT)
+	depends on SERIAL_M32R_SIO=y && (PLAT_OPSPUT || PLAT_USRV || PLAT_M32700UT)
 	default n
 	help
 	  Say Y here if you want to use the M32R serial controller

