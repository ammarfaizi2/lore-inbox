Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267345AbUJDN0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267345AbUJDN0O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 09:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266619AbUJDNX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 09:23:29 -0400
Received: from gprs214-62.eurotel.cz ([160.218.214.62]:22656 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267345AbUJDNUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 09:20:47 -0400
Date: Mon, 4 Oct 2004 13:54:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       Andrew Morton <akpm@zip.com.au>
Subject: Small cleanups in donauboe
Message-ID: <20041004115448.GA25287@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes ugly comment and unneccessary __'s in donauboe. Please
apply,

								Pavel

Index: linux/drivers/net/irda/donauboe.c
===================================================================
--- linux.orig/drivers/net/irda/donauboe.c	2004-10-01 12:24:24.000000000 +0200
+++ linux/drivers/net/irda/donauboe.c	2004-08-15 19:15:53.000000000 +0200
@@ -247,7 +248,7 @@
 static void
 toshoboe_dumpregs (struct toshoboe_cb *self)
 {
-  __u32 ringbase;
+  u32 ringbase;
 
   IRDA_DEBUG (4, "%s()\n", __FUNCTION__);
 
@@ -601,7 +602,7 @@
   /* Start up the clocks */
   OUTB (OBOE_ENABLEH_PHYANDCLOCK, OBOE_ENABLEH);
 
-  /*set to sensible speed */
+  /* Set to sensible speed */
   self->speed = 9600;
   toshoboe_setbaud (self);
   toshoboe_initptrs (self);


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
