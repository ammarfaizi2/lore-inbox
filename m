Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbTE2QvH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 12:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbTE2QvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 12:51:06 -0400
Received: from air-2.osdl.org ([65.172.181.6]:4260 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262363AbTE2QvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 12:51:01 -0400
Subject: [2.5.70][PATCH][TRIVIAL] cpufreq/longrun.c : eliminate unused
	variable
From: Andy Pfiffer <andyp@osdl.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1054227828.12412.12.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 29 May 2003 10:03:48 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or
higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1426  -> 1.1427 
#	arch/i386/kernel/cpu/cpufreq/longrun.c	1.13    -> 1.14   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/29	andyp@andyp.pdx.osdl.net	1.1427
# Remove a compile-time warning.
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/cpu/cpufreq/longrun.c
b/arch/i386/kernel/cpu/cpufreq/longrun.c
--- a/arch/i386/kernel/cpu/cpufreq/longrun.c	Thu May 29 09:56:52 2003
+++ b/arch/i386/kernel/cpu/cpufreq/longrun.c	Thu May 29 09:56:53 2003
@@ -224,7 +224,6 @@
 static int longrun_cpu_init(struct cpufreq_policy *policy)
 {
 	int                     result = 0;
-	struct cpuinfo_x86 *c = cpu_data;
 
 	/* capability check */
 	if (policy->cpu != 0)



