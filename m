Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263049AbUKTFOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263049AbUKTFOR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 00:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbUKTCia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:38:30 -0500
Received: from baikonur.stro.at ([213.239.196.228]:22169 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S263043AbUKTC3h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:29:37 -0500
Subject: [patch 4/8]  to arch/sh/drivers/pci/Kconfig
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, james4765@gmail.com
From: janitor@sternwelten.at
Date: Sat, 20 Nov 2004 03:29:36 +0100
Message-ID: <E1CVL0K-0000UD-GI@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Description: Remove x86-specific help in arch/sh/drivers/pci/Kconfig.
Apply against 2.6.9.

Signed-off by: James Nelson <james4765@gmail.com>


Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.10-rc2-bk4-max/arch/sh/drivers/pci/Kconfig |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN arch/sh/drivers/pci/Kconfig~kconfig-arch_sh_drivers_pci arch/sh/drivers/pci/Kconfig
--- linux-2.6.10-rc2-bk4/arch/sh/drivers/pci/Kconfig~kconfig-arch_sh_drivers_pci	2004-11-20 03:04:49.000000000 +0100
+++ linux-2.6.10-rc2-bk4-max/arch/sh/drivers/pci/Kconfig	2004-11-20 03:04:49.000000000 +0100
@@ -3,8 +3,7 @@ config PCI
 	help
 	  Find out whether you have a PCI motherboard. PCI is the name of a
 	  bus system, i.e. the way the CPU talks to the other stuff inside
-	  your box. Other bus systems are ISA, EISA, MicroChannel (MCA) or
-	  VESA. If you have PCI, say Y, otherwise N.
+	  your box. If you have PCI, say Y, otherwise N.
 
 	  The PCI-HOWTO, available from
 	  <http://www.tldp.org/docs.html#howto>, contains valuable
_
