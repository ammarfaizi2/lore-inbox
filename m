Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261643AbVCCN1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbVCCN1e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 08:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbVCCN1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 08:27:10 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:35602 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261643AbVCCNYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 08:24:02 -0500
Date: Thu, 3 Mar 2005 14:23:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/rcupdate.c: make the exports EXPORT_SYMBOL_GPL
Message-ID: <20050303132355.GR4608@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the patet situation at least in the USA, the exports of 
kernel/rcupdate.c should be EXPORT_SYMBOL_GPL.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc5-mm1-full/kernel/rcupdate.c.old	2005-03-02 16:11:15.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/kernel/rcupdate.c	2005-03-02 16:11:30.000000000 +0100
@@ -506,6 +506,6 @@
 }
 
 module_param(maxbatch, int, 0);
-EXPORT_SYMBOL(call_rcu);
-EXPORT_SYMBOL(call_rcu_bh);
-EXPORT_SYMBOL(synchronize_kernel);
+EXPORT_SYMBOL_GPL(call_rcu);
+EXPORT_SYMBOL_GPL(call_rcu_bh);
+EXPORT_SYMBOL_GPL(synchronize_kernel);

