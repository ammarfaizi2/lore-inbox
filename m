Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268514AbUHLLfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268514AbUHLLfV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 07:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268513AbUHLLfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 07:35:21 -0400
Received: from gprs214-235.eurotel.cz ([160.218.214.235]:8837 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S268514AbUHLLfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 07:35:12 -0400
Date: Thu, 12 Aug 2004 13:34:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, davej@redhat.com
Subject: Typo fixes for cpufreq
Message-ID: <20040812113455.GA20373@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Small typo fixes, please apply
									Pavel

--- tmp/linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2004-06-22 12:35:47.000000000 +0200
+++ linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2004-06-22 14:56:22.000000000 +0200
@@ -184,7 +184,7 @@
 		       "The speedstep_centrino module offers voltage scaling"
 		       " in addition of frequency scaling. You should use "
 		       "that instead of p4-clockmod, if possible.\n");
-		/* on P-4s, the TSC runs with constant frequency independent wether
+		/* on P-4s, the TSC runs with constant frequency independent whether
 		 * throttling is active or not. */
 		p4clockmod_driver.flags |= CPUFREQ_CONST_LOOPS;
 		return speedstep_get_processor_frequency(SPEEDSTEP_PROCESSOR_PM);
@@ -195,7 +195,7 @@
 		return 0;
 	}
 
-	/* on P-4s, the TSC runs with constant frequency independent wether
+	/* on P-4s, the TSC runs with constant frequency independent whether
 	 * throttling is active or not. */
 	p4clockmod_driver.flags |= CPUFREQ_CONST_LOOPS;
 


--- tmp/linux/arch/i386/kernel/smpboot.c	2004-06-22 12:35:47.000000000 +0200
+++ linux/arch/i386/kernel/smpboot.c	2004-07-06 13:10:21.000000000 +0200
@@ -17,7 +17,7 @@
  *	Fixes
  *		Felix Koop	:	NR_CPUS used properly
  *		Jose Renau	:	Handle single CPU case.
- *		Alan Cox	:	By repeated request 8) - Total BogoMIP report.
+ *		Alan Cox	:	By repeated request 8) - Total BogoMIPS report.
  *		Greg Wright	:	Fix for kernel stacks panic.
  *		Erich Boleyn	:	MP v1.4 and additional changes.
  *	Matthias Sattler	:	Changes for 2.1 kernel map.

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
