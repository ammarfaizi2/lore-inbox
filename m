Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263550AbTEIWwA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 18:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263558AbTEIWwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 18:52:00 -0400
Received: from air-2.osdl.org ([65.172.181.6]:34438 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263550AbTEIWv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 18:51:59 -0400
Date: Fri, 9 May 2003 16:04:37 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.69] unused variables in cpufreq drivers
Message-Id: <20030509160437.6b534a0c.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of unused variables that can go.  Probably just some leftover
copy/paste of code.

diff -Nru a/arch/i386/kernel/cpu/cpufreq/longrun.c b/arch/i386/kernel/cpu/cpufreq/longrun.c
--- a/arch/i386/kernel/cpu/cpufreq/longrun.c	Fri May  9 15:54:51 2003
+++ b/arch/i386/kernel/cpu/cpufreq/longrun.c	Fri May  9 15:54:51 2003
@@ -224,7 +224,6 @@
 static int longrun_cpu_init(struct cpufreq_policy *policy)
 {
 	int                     result = 0;
-	struct cpuinfo_x86 *c = cpu_data;
 
 	/* capability check */
 	if (policy->cpu != 0)
diff -Nru a/arch/i386/kernel/cpu/cpufreq/powernow-k6.c b/arch/i386/kernel/cpu/cpufreq/powernow-k6.c
--- a/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	Fri May  9 15:54:51 2003
+++ b/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	Fri May  9 15:54:51 2003
@@ -142,7 +142,6 @@
 
 static int powernow_k6_cpu_init(struct cpufreq_policy *policy)
 {
-	struct cpuinfo_x86 *c = cpu_data;
 	unsigned int i;
 
 	if (policy->cpu != 0)
