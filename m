Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265212AbTFEWE7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 18:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265217AbTFEWE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 18:04:58 -0400
Received: from air-2.osdl.org ([65.172.181.6]:17598 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265212AbTFEWEy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 18:04:54 -0400
Subject: [PATCH 2.5.70] fix warning: unused variable powernow-k6.c
From: Joe DiMartino <joe@osdl.org>
To: Trivial <trivial@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1054851504.3642.56.camel@joe2.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Jun 2003 15:18:24 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

simple fix to remove compiler warning

===== arch/i386/kernel/cpu/cpufreq/powernow-k6.c 1.14 vs edited =====
--- 1.14/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	Mon Mar 17 05:53:03 2003
+++ edited/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	Thu Jun  5 14:56:46 2003
@@ -142,7 +142,6 @@
 
 static int powernow_k6_cpu_init(struct cpufreq_policy *policy)
 {
-	struct cpuinfo_x86 *c = cpu_data;
 	unsigned int i;
 
 	if (policy->cpu != 0)



