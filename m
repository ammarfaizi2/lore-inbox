Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbVJAH57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbVJAH57 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 03:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbVJAH57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 03:57:59 -0400
Received: from dd3624.kasserver.com ([81.209.188.85]:49894 "EHLO
	dd3624.kasserver.com") by vger.kernel.org with ESMTP
	id S1750775AbVJAH56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 03:57:58 -0400
From: Sven Henkel <shenkel@gmail.com>
To: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc32: Add new iBook 12" to PowerMac models table
Date: Sat, 1 Oct 2005 09:57:46 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510010957.46658.shenkel@gmail.com>
X-Spam-Flag: NO
X-Spam-score: -1.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch adds the new iBook G4 (manufactured after July 2005) to the PowerMac 
models table. The model name (PowerBook6,7) is taken from a 12" iBook, I 
don't know if it also matches the 14" version. The patch applies to a vanilla 
2.6.13.2 kernel.

Ciao,
Sven

Signed-off-by: Sven Henkel <shenkel@gmail.com>

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
