Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161158AbVKDQAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161158AbVKDQAH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 11:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161156AbVKDQAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 11:00:07 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:22541 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161154AbVKDP7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 10:59:43 -0500
Date: Fri, 4 Nov 2005 16:59:41 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: christer@weinigel.se, linux-kernel@vger.kernel.org
Subject: [2.6 patch] arch/i386/kernel/scx200.c should #include <linux/scx200_gpio.h>
Message-ID: <20051104155941.GD5368@stusta.de>
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

--- linux-2.6.14-rc2-mm2-full/arch/i386/kernel/scx200.c.old	2005-10-02 02:16:57.000000000 +0200
+++ linux-2.6.14-rc2-mm2-full/arch/i386/kernel/scx200.c	2005-10-02 02:17:10.000000000 +0200
@@ -12,6 +12,7 @@
 #include <linux/pci.h>
 
 #include <linux/scx200.h>
+#include <linux/scx200_gpio.h>
 
 /* Verify that the configuration block really is there */
 #define scx200_cb_probe(base) (inw((base) + SCx200_CBA) == (base))

