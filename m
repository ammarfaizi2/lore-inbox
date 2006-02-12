Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWBLR4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWBLR4a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 12:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWBLR4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 12:56:30 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:62213 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750761AbWBLR43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 12:56:29 -0500
Date: Sun, 12 Feb 2006 18:56:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] let NET_CLS_ACT no longer depend on EXPERIMENTAL
Message-ID: <20060212175628.GL30922@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This option should IMHO no longer depend on EXPERIMENTAL.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc2-mm1-full/net/sched/Kconfig.old	2006-02-12 02:21:30.000000000 +0100
+++ linux-2.6.16-rc2-mm1-full/net/sched/Kconfig	2006-02-12 02:21:58.000000000 +0100
@@ -434,7 +434,6 @@
 
 config NET_CLS_ACT
 	bool "Actions"
-	depends on EXPERIMENTAL
 	select NET_ESTIMATOR
 	---help---
 	  Say Y here if you want to use traffic control actions. Actions


