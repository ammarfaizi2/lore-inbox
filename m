Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262660AbUBZDhj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 22:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262669AbUBZDWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 22:22:11 -0500
Received: from palrel13.hp.com ([156.153.255.238]:27022 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262660AbUBZDUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 22:20:42 -0500
Date: Wed, 25 Feb 2004 19:20:41 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] bogus_include
Message-ID: <20040226032041.GO32263@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

irXXX_bogus_include.diff :
~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] include not needed


diff -Nru a/net/irda/irda_device.c b/net/irda/irda_device.c
--- a/net/irda/irda_device.c	Mon Feb 23 10:40:30 2004
+++ b/net/irda/irda_device.c	Mon Feb 23 10:40:30 2004
@@ -40,7 +40,6 @@
 #include <linux/init.h>
 #include <linux/tty.h>
 #include <linux/kmod.h>
-#include <linux/wireless.h>
 #include <linux/spinlock.h>
 
 #include <asm/ioctls.h>
