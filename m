Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbVC0Ol6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbVC0Ol6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 09:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbVC0Ohg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 09:37:36 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:11789 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261733AbVC0Oez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 09:34:55 -0500
Date: Sun, 27 Mar 2005 16:34:54 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/rcupdate.c: make the exports EXPORT_SYMBOL_GPL
Message-ID: <20050327143454.GJ4285@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the patent situation at least in the USA, the exports of 
kernel/rcupdate.c should be EXPORT_SYMBOL_GPL.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 3 Mar 2005

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

