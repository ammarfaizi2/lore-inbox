Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263531AbTKWXoF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 18:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263532AbTKWXoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 18:44:04 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:49413 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S263531AbTKWXoD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 18:44:03 -0500
Date: Sun, 23 Nov 2003 23:44:01 +0000
From: Simon Richard Grint <rgrint@mrtall.compsoc.man.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Typo in arch/i386/kernel/acpi/boot.c
Message-ID: <20031123234401.GA45970@mrtall.compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1AO3ta-0002Gq-2i*kDz7of7eWpA*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is against the latest bk snapshot of the vanilla 2.6.0test9.  It corrects a typo which 
may get displayed during acpi initialisation on i386 

sr

--- 2.6.0-test9-orig/arch/i386/kernel/acpi/boot.c       2003-11-23 23:27:29.000000000 +0000
+++ 2.6.0-test9/arch/i386/kernel/acpi/boot.c    2003-11-21 17:57:06.000000000 +0000
@@ -268,7 +268,7 @@

        if (!(val & mask)) {
                printk(KERN_WARNING PREFIX "IRQ %d was Edge Triggered, "
-                       "setting to Level Triggerd\n", irq);
+                       "setting to Level Triggered\n", irq);
                outb(val | mask, port);
        }
 }

