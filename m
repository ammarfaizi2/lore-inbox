Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263218AbUJ2B51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263218AbUJ2B51 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 21:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263197AbUJ2BzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 21:55:15 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:18438 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263180AbUJ2ASX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 20:18:23 -0400
Date: Fri, 29 Oct 2004 02:17:45 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Chris Gauthron <chrisg@0-in.com>, greg@kroah.com, phil@netroedge.com
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] i2c it87.c: remove an unused function
Message-ID: <20041029001745.GI29142@stusta.de>
References: <20041028222039.GO3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028222039.GO3207@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ this time without the problems due to a digital signature... ]

The patch below removes an unused function from drivers/i2c/chips/it87.c


diffstat output:
 drivers/i2c/chips/it87.c |    7 -------
 1 files changed, 7 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm1-full/drivers/i2c/chips/it87.c.old	2004-10-28 23:00:26.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/i2c/chips/it87.c	2004-10-28 23:00:37.000000000 +0200
@@ -56,13 +56,6 @@
 #define PME	0x04	/* The device with the fan registers in it */
 #define	DEVID	0x20	/* Register: Device ID */
 
-static inline void
-superio_outb(int reg, int val)
-{
-	outb(reg, REG);
-	outb(val, VAL);
-}
-
 static inline int
 superio_inb(int reg)
 {
