Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272604AbTHKNot (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 09:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272609AbTHKNnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 09:43:23 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:29067 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272593AbTHKNk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 09:40:56 -0400
To: torvalds@transmeta.com
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Don't refer to devel kernel in Kconfig option
Message-Id: <E19mCuO-0003d6-00@tetrachloride>
Date: Mon, 11 Aug 2003 14:40:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/Kconfig linux-2.5/arch/i386/Kconfig
--- bk-linus/arch/i386/Kconfig	2003-08-06 16:39:02.000000000 +0100
+++ linux-2.5/arch/i386/Kconfig	2003-08-08 00:38:44.000000000 +0100
@@ -276,9 +276,9 @@ config MWINCHIP3D
 	help
 	  Select this for an IDT Winchip-2A or 3.  Linux and GCC
 	  treat this chip as a 586TSC with some extended instructions
-	  and alignment reqirements.  Development kernels also enable
-	  out of order memory stores for this CPU, which can increase
-	  performance of some operations.
+	  and alignment reqirements.  Also enable out of order memory
+	  stores for this CPU, which can increase performance of some
+	  operations.
 
 config MCYRIXIII
 	bool "CyrixIII/VIA-C3"
