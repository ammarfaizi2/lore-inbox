Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965309AbWHOJCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965309AbWHOJCq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 05:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965310AbWHOJCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 05:02:46 -0400
Received: from mail.charite.de ([160.45.207.131]:27089 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S965309AbWHOJCp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 05:02:45 -0400
Date: Tue, 15 Aug 2006 11:02:07 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Subject: PATCH: Fix typo in net/sched/cls_u32.c
Message-ID: <20060815090207.GO27850@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	kernel-janitors@lists.osdl.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>

Fixes a typo in net/sched/cls_u32.c.orig

Signed-off-by: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>

---

--- /usr/src/linux-2.6.17.8/net/sched/cls_u32.c.orig	2006-08-13 12:51:55.000000000 +0200
+++ /usr/src/linux-2.6.17.8/net/sched/cls_u32.c	2006-08-13 12:52:06.000000000 +0200
@@ -802,7 +802,7 @@
 {
 	printk("u32 classifier\n");
 #ifdef CONFIG_CLS_U32_PERF
-	printk("    Perfomance counters on\n");
+	printk("    Performance counters on\n");
 #endif
 #ifdef CONFIG_NET_CLS_POLICE
 	printk("    OLD policer on \n");


-- 
_________________________________________________

  Charité - Universitätsmedizin Berlin
_________________________________________________

  Ralf Hildebrandt
   i.A. Geschäftsbereich Informationsmanagement
   Campus Benjamin Franklin
   Hindenburgdamm 30 | Berlin
   Tel. +49 30 450 570155 | Fax +49 30 450 570962
   Ralf.Hildebrandt@charite.de
   http://www.charite.de
