Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265219AbTFEWFC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 18:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265217AbTFEWFC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 18:05:02 -0400
Received: from air-2.osdl.org ([65.172.181.6]:18110 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265214AbTFEWEz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 18:04:55 -0400
Subject: [PATCH 2.5.70] fix warning: unused variable longrun.c
From: Joe DiMartino <joe@osdl.org>
To: Trivial <trivial@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1054851505.3642.59.camel@joe2.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Jun 2003 15:18:25 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

simple fix to remove compiler warning

===== arch/i386/kernel/cpu/cpufreq/longrun.c 1.13 vs edited =====
--- 1.13/arch/i386/kernel/cpu/cpufreq/longrun.c	Mon Mar 17 05:54:38 2003
+++ edited/arch/i386/kernel/cpu/cpufreq/longrun.c	Thu Jun  5 14:57:41 2003
@@ -224,7 +224,6 @@
 static int longrun_cpu_init(struct cpufreq_policy *policy)
 {
 	int                     result = 0;
-	struct cpuinfo_x86 *c = cpu_data;
 
 	/* capability check */
 	if (policy->cpu != 0)


