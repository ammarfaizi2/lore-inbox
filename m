Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbVGCM7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbVGCM7v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 08:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVGCM7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 08:59:51 -0400
Received: from zork.zork.net ([64.81.246.102]:32213 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S261414AbVGCM7t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 08:59:49 -0400
From: Sean Neakums <sneakums@zork.net>
To: mingo@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] realtime preempt V0.7.50-43: arch/ppc/Kconfig sources non-existent file
Mail-Followup-To: mingo@redhat.com, linux-kernel@vger.kernel.org
Date: Sun, 03 Jul 2005 13:59:44 +0100
Message-ID: <6u4qbct58f.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No __raw_local_irq_restore so I guess ppc is not expected to work
right now anyway.


--- S12-rtpe/arch/ppc/Kconfig~	2005-07-03 13:29:11.000000000 +0100
+++ S12-rtpe/arch/ppc/Kconfig	2005-07-03 13:32:33.000000000 +0100
@@ -904,7 +904,7 @@
 	depends on SMP
 	default "4"
 
-source "lib/Kconfig.RT"
+source "kernel/Kconfig.preempt"
 
 config HIGHMEM
 	bool "High memory support"


-- 
Dag vijandelijk luchtschip de huismeester is dood
