Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161153AbVKDP7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161153AbVKDP7m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 10:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161154AbVKDP7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 10:59:42 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:21773 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161153AbVKDP7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 10:59:41 -0500
Date: Fri, 4 Nov 2005 16:59:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Jaya Kumar <jayalk@intworks.biz>, linux-kernel@vger.kernel.org
Subject: [2.6 patch] arch/i386/kernel/reboot_fixups.c should #include <linux/reboot_fixups.h>
Message-ID: <20051104155939.GC5368@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every file should #include the header files containing the prototypes of 
it's global functions


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 3 Oct 2005

--- linux-2.6.14-rc2-mm2-full/arch/i386/kernel/reboot_fixups.c.old	2005-10-02 02:15:19.000000000 +0200
+++ linux-2.6.14-rc2-mm2-full/arch/i386/kernel/reboot_fixups.c	2005-10-02 02:15:37.000000000 +0200
@@ -10,6 +10,7 @@
 
 #include <asm/delay.h>
 #include <linux/pci.h>
+#include <linux/reboot_fixups.h>
 
 static void cs5530a_warm_reset(struct pci_dev *dev)
 {

