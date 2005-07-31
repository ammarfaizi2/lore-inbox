Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbVGaQ07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbVGaQ07 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 12:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbVGaQ07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 12:26:59 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:8712 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261806AbVGaQ06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 12:26:58 -0400
Date: Sun, 31 Jul 2005 18:26:56 +0200
From: Adrian Bunk <bunk@stusta.de>
To: lethal@linux-sh.org, rc@rc0.org.uk
Cc: linuxsh-shmedia-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] arch/sh64/Kconfig: doesn't need it's own LOG_BUF_SHIFT
Message-ID: <20050731162656.GA3608@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The LOG_BUF_SHIFT from lib/Kconfig.debug is sufficient.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc4-mm1/arch/sh64/Kconfig.old	2005-07-31 18:24:19.000000000 +0200
+++ linux-2.6.13-rc4-mm1/arch/sh64/Kconfig	2005-07-31 18:24:26.000000000 +0200
@@ -29,10 +29,6 @@
 	bool
 	default y
 
-config LOG_BUF_SHIFT
-	int
-	default 14
-
 config RWSEM_XCHGADD_ALGORITHM
 	bool
 

