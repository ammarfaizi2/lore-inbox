Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932480AbVJCReR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbVJCReR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 13:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbVJCReQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 13:34:16 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25107 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932480AbVJCReP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 13:34:15 -0400
Date: Mon, 3 Oct 2005 19:34:14 +0200
From: Adrian Bunk <bunk@stusta.de>
To: christer@weinigel.se
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] arch/i386/kernel/scx200.c should #include <linux/scx200_gpio.h>
Message-ID: <20051003173414.GC3652@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every file should #include the header files containing the prototypes of 
it's global functions


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.14-rc2-mm2-full/arch/i386/kernel/scx200.c.old	2005-10-02 02:16:57.000000000 +0200
+++ linux-2.6.14-rc2-mm2-full/arch/i386/kernel/scx200.c	2005-10-02 02:17:10.000000000 +0200
@@ -12,6 +12,7 @@
 #include <linux/pci.h>
 
 #include <linux/scx200.h>
+#include <linux/scx200_gpio.h>
 
 /* Verify that the configuration block really is there */
 #define scx200_cb_probe(base) (inw((base) + SCx200_CBA) == (base))

