Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbVIFQrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbVIFQrN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 12:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbVIFQrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 12:47:13 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:55285 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1750755AbVIFQrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 12:47:12 -0400
Date: Tue, 6 Sep 2005 11:46:58 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc32: Fix Kconfig mismerge
Message-ID: <Pine.LNX.4.61.0509061146270.2183@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like the help comment for MPC834x got merged incorrectly.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit 28806bb4f8992eb46d2d788a00d08f62b4559d61
tree de364c30cb32f279b3b01f13f683d0fd88416bb9
parent 2dcbb32c37cd71d9f4a7f5530af896a18d859ef5
author Kumar K. Gala <kumar.gala@freescale.com> Tue, 06 Sep 2005 11:24:52 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Tue, 06 Sep 2005 11:24:52 -0500

 arch/ppc/Kconfig |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -495,11 +495,6 @@ config WINCEPT
 	  MPC821 PowerPC, introduced in 1998 and designed to be used in
 	  thin-client machines.  Say Y to support it directly.
 
-	  Be aware that PCI buses can only function when SYS board is plugged
-	  into the PIB (Platform IO Board) board from Freescale which provide
-	  3 PCI slots.  The PIBs PCI initialization is the bootloader's
-	  responsiblilty.
-
 endchoice
 
 choice
@@ -675,6 +670,11 @@ config MPC834x_SYS
 	bool "Freescale MPC834x SYS"
 	help
 	  This option enables support for the MPC 834x SYS evaluation board.
+
+	  Be aware that PCI buses can only function when SYS board is plugged
+	  into the PIB (Platform IO Board) board from Freescale which provide
+	  3 PCI slots.  The PIBs PCI initialization is the bootloader's
+	  responsiblilty.
 
 config EV64360
 	bool "Marvell-EV64360BP"
