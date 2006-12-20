Return-Path: <linux-kernel-owner+w=401wt.eu-S965038AbWLTNfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038AbWLTNfM (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 08:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965049AbWLTNfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 08:35:12 -0500
Received: from iona.labri.fr ([147.210.8.143]:50428 "EHLO iona.labri.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965038AbWLTNfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 08:35:11 -0500
X-Greylist: delayed 1425 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Dec 2006 08:35:11 EST
Message-ID: <45893679.8030604@ens-lyon.org>
Date: Wed, 20 Dec 2006 14:11:21 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Dave Jones <davej@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] speedstep-centrino: missing space and bracket
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A space and a bracket are missing (and indentation is wrong).

Signed-off-by: Brice Goglin <Brice.Goglin@ens-lyon.org>
---
 arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-rc/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
===================================================================
--- linux-rc.orig/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2006-12-20 13:35:56.000000000 +0100
+++ linux-rc/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2006-12-20 13:41:44.000000000 +0100
@@ -533,9 +533,9 @@
 
 	/* notify BIOS that we exist */
 	acpi_processor_notify_smm(THIS_MODULE);
-	printk("speedstep-centrino with X86_SPEEDSTEP_CENTRINO_ACPI"
-			"config is deprecated.\n "
-			"Use X86_ACPI_CPUFREQ (acpi-cpufreq instead.\n" );
+	printk("speedstep-centrino with X86_SPEEDSTEP_CENTRINO_ACPI "
+	       "config is deprecated.\n "
+	       "Use X86_ACPI_CPUFREQ (acpi-cpufreq) instead.\n" );
 
 	return 0;
 


