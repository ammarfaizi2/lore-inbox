Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751774AbWJMSKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbWJMSKy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 14:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbWJMSKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 14:10:53 -0400
Received: from mail.trixing.net ([87.230.125.58]:63204 "EHLO mail.trixing.net")
	by vger.kernel.org with ESMTP id S1751774AbWJMSKv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 14:10:51 -0400
Date: Fri, 13 Oct 2006 20:10:49 +0200
From: Jan Dittmer <jdi@l4x.org>
To: linux-kernel@vger.kernel.org
Subject: Add missing space in module.c for taintskernel
Message-ID: <20061013181049.GB17614@ppp0.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Modeline: vim:set ts=8 sw=4 smarttab tw=72 si noic notitle:
X-Operating-System: Linux/2.6.19-rc1-git10-ds666-amd64 (x86_64)
X-Uptime: 20:05:36 up  2:31,  1 user,  load average: 0.12, 0.14, 0.15
Accept-Languages: de, en, fr
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: jdittmer@l4x.org
X-SA-Exim-Scanned: No (on mail.trixing.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Obvious fix, against rc1-git10

Signed-off-by: Jan Dittmer <jdi@l4x.org>

--- linux-2.6-amd64/kernel/module.c~	2006-10-13 17:41:32.000000000 +0200
+++ linux-2.6-amd64/kernel/module.c	2006-10-13 17:41:40.000000000 +0200
@@ -1342,7 +1342,7 @@ static void set_license(struct module *m
 
 	if (!license_is_gpl_compatible(license)) {
 		if (!(tainted & TAINT_PROPRIETARY_MODULE))
-			printk(KERN_WARNING "%s: module license '%s' taints"
+			printk(KERN_WARNING "%s: module license '%s' taints "
 				"kernel.\n", mod->name, license);
 		add_taint_module(mod, TAINT_PROPRIETARY_MODULE);
 	}


----- End forwarded message -----
