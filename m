Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263676AbTH0QZT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 12:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263474AbTH0QVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 12:21:54 -0400
Received: from p089.as-l007.contactel.cz ([212.65.200.89]:20865 "EHLO
	penguin.localdomain") by vger.kernel.org with ESMTP id S263531AbTH0QUh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 12:20:37 -0400
Date: Wed, 27 Aug 2003 18:20:13 +0200
From: Marcel Sebek <sebek64@post.cz>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][TRIVIAL] number of CPUs
Message-ID: <20030827162012.GA2726@penguin.penguin>
Mail-Followup-To: trivial@rustcorp.com.au,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This patch adjusts maximum number of CPUs in help text to correct value.


diff -urN a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	Sat Aug 23 13:57:33 2003
+++ b/arch/i386/Kconfig	Sun Aug 24 13:49:29 2003
@@ -443,7 +443,7 @@
 	default "8"
 	help
 	  This allows you to specify the maximum number of CPUs which this
-	  kernel will support.  The maximum supported value is 32 and the
+	  kernel will support.  The maximum supported value is 255 and the
 	  minimum value which makes sense is 2.
 
 	  This is purely to save memory - each supported CPU adds


-- 
Marcel Sebek
jabber: sebek@jabber.cz                     ICQ: 279852819
linux user number: 307850                 GPG ID: 5F88735E
GPG FP: 0F01 BAB8 3148 94DB B95D  1FCA 8B63 CA06 5F88 735E

