Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262510AbVBXVw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262510AbVBXVw2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 16:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262513AbVBXVw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 16:52:27 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:52742 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262510AbVBXVvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 16:51:38 -0500
Date: Thu, 24 Feb 2005 22:51:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@cpushare.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] seccomp: don't say it was more or less mandatory
Message-ID: <20050224215136.GK8651@stusta.de>
References: <20050223014233.6710fd73.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050223014233.6710fd73.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

seccomp might be a nice feature under some circumstances.
But the suggestion in the help text is IMHO too strong and therefore 
removed by this patch.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc4-mm1-full/arch/i386/Kconfig.old	2005-02-24 22:47:32.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/arch/i386/Kconfig	2005-02-24 22:48:11.000000000 +0100
@@ -903,8 +903,6 @@
 	  and the task is only allowed to execute a few safe syscalls
 	  defined by each seccomp mode.
 
-	  If unsure, say Y. Only embedded should say N here.
-
 source "drivers/perfctr/Kconfig"
 
 config PHYSICAL_START
