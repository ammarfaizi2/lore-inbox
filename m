Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263093AbUHNO0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263093AbUHNO0K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 10:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbUHNO0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 10:26:10 -0400
Received: from verein.lst.de ([213.95.11.210]:18347 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S263001AbUHNOZv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 10:25:51 -0400
Date: Sat, 14 Aug 2004 16:25:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: benh@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] #if 0 dump_HT_speeds
Message-ID: <20040814142542.GA25939@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, benh@kernel.crashing.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

likes it caller


--- 1.3/arch/ppc64/kernel/pmac_feature.c	2004-06-10 23:33:43 +02:00
+++ edited/arch/ppc64/kernel/pmac_feature.c	2004-08-14 16:02:30 +02:00
@@ -611,7 +611,7 @@
 
 device_initcall(pmac_feature_late_init);
 
-
+#if 0
 static void dump_HT_speeds(char *name, u32 cfg, u32 frq)
 {
 	int	freqs[16] = { 200,300,400,500,600,800,1000,0,0,0,0,0,0,0,0,0 };
@@ -625,6 +625,7 @@
 		       name, freqs[freq],
 		       bits[(cfg >> 28) & 0x7], bits[(cfg >> 24) & 0x7]);
 }
+#endif
 
 void __init pmac_check_ht_link(void)
 {
