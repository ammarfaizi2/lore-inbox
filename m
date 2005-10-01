Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbVJAWdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbVJAWdW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 18:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbVJAWdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 18:33:22 -0400
Received: from gate.crashing.org ([63.228.1.57]:34705 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750879AbVJAWdW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 18:33:22 -0400
Subject: [PATCH] ppc32: Add new iBook 12" to PowerMac models table
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Sven Henkel <shenkel@gmail.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sun, 02 Oct 2005 08:30:33 +1000
Message-Id: <1128205833.8267.8.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Henkel <shenkel@gmail.com>

this patch adds the new iBook G4 (manufactured after July 2005) to the PowerMac 
models table. The model name (PowerBook6,7) is taken from a 12" iBook, I 
don't know if it also matches the 14" version. The patch applies to a vanilla 
2.6.13.2 kernel.

Signed-off-by: Sven Henkel <shenkel@gmail.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

--- linux-2.6.13.2-orig/arch/ppc/platforms/pmac_feature.c	2005-09-30 19:26:55.000000000 +0200
+++ linux-2.6.13.2-dev/arch/ppc/platforms/pmac_feature.c	2005-09-30 20:07:52.000000000 +0200
@@ -2337,6 +2337,10 @@ static struct pmac_mb_def pmac_mb_defs[]
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
 		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
 	},
+	{	"PowerBook6,7",			"iBook G4",
+		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
+		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,
+	},
 	{	"PowerBook6,8",			"PowerBook G4 12\"",
 		PMAC_TYPE_UNKNOWN_INTREPID,	intrepid_features,
 		PMAC_MB_MAY_SLEEP | PMAC_MB_HAS_FW_POWER | PMAC_MB_MOBILE,


