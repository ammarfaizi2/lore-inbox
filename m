Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263088AbUFJVhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbUFJVhX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 17:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbUFJVhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 17:37:22 -0400
Received: from gate.crashing.org ([63.228.1.57]:53674 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263093AbUFJVhD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 17:37:03 -0400
Subject: [PATCH] ppc64: Add definition for Apple Xserve G5 motherboard
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1086903304.3559.149.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 10 Jun 2004 16:35:05 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch adds the definition for Apple XServe G5 motherboard
to the pmac_feature support file. Please apply.

Ben.

===== arch/ppc64/kernel/pmac_feature.c 1.2 vs edited =====
--- 1.2/arch/ppc64/kernel/pmac_feature.c	2004-03-11 05:49:03 -06:00
+++ edited/arch/ppc64/kernel/pmac_feature.c	2004-06-10 16:33:43 -05:00
@@ -343,6 +343,10 @@
 		PMAC_TYPE_POWERMAC_G5,		g5_features,
 		0,
 	},
+	{       "RackMac3,1",                   "XServe G5",
+		PMAC_TYPE_POWERMAC_G5,          g5_features,
+		0,
+	},
 };
 
 /*


