Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267869AbUJCMak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267869AbUJCMak (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 08:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267863AbUJCMak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 08:30:40 -0400
Received: from gate.crashing.org ([63.228.1.57]:29887 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267869AbUJCMaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 08:30:06 -0400
Subject: [Fwd: Properly recognize PowerMac7,3]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1096806324.23142.21.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 03 Oct 2004 22:25:24 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply...

-----Forwarded Message-----
From: Andreas Schwab <schwab@suse.de>
To: linuxppc64-dev@ozlabs.org
Subject: Properly recognize PowerMac7,3
Date: Sun, 03 Oct 2004 14:20:43 +0200

Make the PowerMac7,3 no longer unknown.

Andreas.

Signed-off-by: Andreas Schwab <schwab@suse.de>

--- linux-2.6/arch/ppc64/kernel/pmac_feature.c.~1~	2004-09-28 00:28:34.000000000 +0200
+++ linux-2.6/arch/ppc64/kernel/pmac_feature.c	2004-10-03 14:17:03.458461540 +0200
@@ -343,6 +343,10 @@ static struct pmac_mb_def pmac_mb_defs[]
 		PMAC_TYPE_POWERMAC_G5,		g5_features,
 		0,
 	},
+	{	"PowerMac7,3",			"PowerMac G5",
+		PMAC_TYPE_POWERMAC_G5,		g5_features,
+		0,
+	},
 	{       "RackMac3,1",                   "XServe G5",
 		PMAC_TYPE_POWERMAC_G5,          g5_features,
 		0,
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

