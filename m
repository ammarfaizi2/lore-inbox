Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbTELSMl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 14:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262526AbTELSMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 14:12:41 -0400
Received: from palrel12.hp.com ([156.153.255.237]:10728 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262335AbTELSMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 14:12:39 -0400
Date: Mon, 12 May 2003 11:25:23 -0700
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.69-bk7] wireless header fix
Message-ID: <20030512182523.GB24830@bougret.hpl.hp.com>
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

	Hi Jeff,

	To compile Wireless Extensions, you will need the patch
below to add a missing header.
	Thanks...

	Jean


diff -u -p linux/net/core/wireless.16.c linux/net/core/wireless.c
--- linux/net/core/wireless.16.c        Mon May 12 11:01:30 2003
+++ linux/net/core/wireless.c   Mon May 12 11:02:06 2003
@@ -60,6 +60,7 @@
 #include <linux/seq_file.h>
 #include <linux/init.h>                        /* for __init */
 #include <linux/if_arp.h>              /* ARPHRD_ETHER */
+#include <linux/module.h>              /* THIS_MODULE */
 
 #include <linux/wireless.h>            /* Pretty obvious */
 #include <net/iw_handler.h>            /* New driver API */
