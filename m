Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269636AbUJWBPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269636AbUJWBPV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 21:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269600AbUJWBMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 21:12:40 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:11027 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S269760AbUJWBMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 21:12:02 -0400
Date: Sat, 23 Oct 2004 03:11:27 +0200
From: Adrian Bunk <bunk@stusta.de>
To: pavel@ucw.cz
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] small SOFTWARE_SUSPEND help text fixes
Message-ID: <20041023011127.GF22558@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some small fixes for the SOFTWARE_SUSPEND help text.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.9-mm1-full/kernel/power/Kconfig.old	2004-10-23 03:08:24.000000000 +0200
+++ linux-2.6.9-mm1-full/kernel/power/Kconfig	2004-10-23 03:11:08.000000000 +0200
@@ -29,9 +29,10 @@
 config SOFTWARE_SUSPEND
 	bool "Software Suspend (EXPERIMENTAL)"
 	depends on EXPERIMENTAL && PM && SWAP
 	---help---
-	  Enable the possibilty of suspendig machine. It doesn't need APM.
+	  Enable the possibility of suspending the machine.
+	  It doesn't need APM.
 	  You may suspend your machine by 'swsusp' or 'shutdown -z <time>' 
 	  (patch for sysvinit needed). 
 
 	  It creates an image which is saved in your active swaps. By the next
