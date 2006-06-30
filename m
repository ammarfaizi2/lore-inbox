Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbWF3LcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWF3LcN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 07:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbWF3LcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 07:32:00 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:12040 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751067AbWF3Lbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 07:31:48 -0400
Date: Fri, 30 Jun 2006 13:31:47 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/sys.c: EXPORT_UNUSED_SYMBOL{,_GPL}
Message-ID: <20060630113147.GL19712@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch marks unused exports as EXPORT_UNUSED_SYMBOL{,_GPL}.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 kernel/sys.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.17-mm4-full/kernel/sys.c.old	2006-06-30 02:38:57.000000000 +0200
+++ linux-2.6.17-mm4-full/kernel/sys.c	2006-06-30 02:43:32.000000000 +0200
@@ -663,7 +663,7 @@
 	printk(".\n");
 	machine_restart(cmd);
 }
-EXPORT_SYMBOL_GPL(kernel_restart);
+EXPORT_UNUSED_SYMBOL_GPL(kernel_restart);  /*  June 2006  */
 
 /**
  *	kernel_kexec - reboot the system
@@ -705,7 +705,7 @@
 	machine_halt();
 }
 
-EXPORT_SYMBOL_GPL(kernel_halt);
+EXPORT_UNUSED_SYMBOL_GPL(kernel_halt);  /*  June 2006  */
 
 /**
  *	kernel_power_off - power_off the system
@@ -1713,7 +1713,7 @@
 	return retval;
 }
 
-EXPORT_SYMBOL(in_egroup_p);
+EXPORT_UNUSED_SYMBOL(in_egroup_p);  /*  June 2006  */
 
 DECLARE_RWSEM(uts_sem);
 
