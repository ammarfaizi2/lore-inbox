Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbTDUUnV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 16:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261999AbTDUUnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 16:43:21 -0400
Received: from zero.aec.at ([193.170.194.10]:54024 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261970AbTDUUnU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 16:43:20 -0400
Date: Mon, 21 Apr 2003 22:55:20 +0200
From: Andi Kleen <ak@muc.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix CPU Names in Kconfig
Message-ID: <20030421205520.GA13940@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add Xeon Names to Kconfig.

OldXeon for the P3 based Xeons is a bit confusing, but we cannot 
fix the Intel marchitecture here.

-Andi

diff -u linux-2.5.68-gencpu/arch/i386/Kconfig-o linux-2.5.68-gencpu/arch/i386/Kconfig
--- linux-2.5.68-gencpu/arch/i386/Kconfig-o	2003-04-20 21:24:16.000000000 +0200
+++ linux-2.5.68-gencpu/arch/i386/Kconfig	2003-04-20 21:24:22.000000000 +0200
@@ -183,7 +183,7 @@
 	  optimizations.
 
 config MPENTIUMIII
-	bool "Pentium-III/Celeron(Coppermine)"
+	bool "Pentium-III/Celeron(Coppermine)/OldXeon"
 	help
 	  Select this for Intel chips based on the Pentium-III and
 	  Celeron-Coppermine core.  This option enables use of some
@@ -191,7 +191,7 @@
 	  extensions.
 
 config MPENTIUM4
-	bool "Pentium-4/Celeron(P4-based)"
+	bool "Pentium-4/Celeron(P4-based)/Xeon(P4-based)"
 	help
 	  Select this for Intel Pentium 4 chips.  This includes both
 	  the Pentium 4 and P4-based Celeron chips.  This option
