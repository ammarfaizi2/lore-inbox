Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbVJCRdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbVJCRdX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 13:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbVJCRdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 13:33:23 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:23827 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932478AbVJCRdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 13:33:22 -0400
Date: Mon, 3 Oct 2005 19:33:21 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jaya Kumar <jayalk@intworks.biz>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] arch/i386/kernel/reboot_fixups.c should #include <linux/reboot_fixups.h>
Message-ID: <20051003173321.GB3652@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every file should #include the header files containing the prototypes of 
it's global functions


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.14-rc2-mm2-full/arch/i386/kernel/reboot_fixups.c.old	2005-10-02 02:15:19.000000000 +0200
+++ linux-2.6.14-rc2-mm2-full/arch/i386/kernel/reboot_fixups.c	2005-10-02 02:15:37.000000000 +0200
@@ -10,6 +10,7 @@
 
 #include <asm/delay.h>
 #include <linux/pci.h>
+#include <linux/reboot_fixups.h>
 
 static void cs5530a_warm_reset(struct pci_dev *dev)
 {

