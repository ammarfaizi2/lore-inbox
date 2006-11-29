Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758820AbWK2KFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758820AbWK2KFy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 05:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758824AbWK2KEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 05:04:25 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3849 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1758821AbWK2KEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 05:04:21 -0500
Date: Wed, 29 Nov 2006 11:04:26 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] arch/i386/kernel/reboot.c should #include <linux/reboot.h>
Message-ID: <20061129100426.GM11084@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every file should #include the headers containing the prototypes for 
its global functions.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc6-mm2/arch/i386/kernel/reboot.c.old	2006-11-29 10:06:47.000000000 +0100
+++ linux-2.6.19-rc6-mm2/arch/i386/kernel/reboot.c	2006-11-29 10:06:59.000000000 +0100
@@ -12,6 +12,7 @@
 #include <linux/dmi.h>
 #include <linux/ctype.h>
 #include <linux/pm.h>
+#include <linux/reboot.h>
 #include <asm/uaccess.h>
 #include <asm/apic.h>
 #include <asm/desc.h>

