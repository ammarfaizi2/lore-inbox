Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263578AbUECDV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263578AbUECDV3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 23:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263580AbUECDV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 23:21:29 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:3549 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S263578AbUECDV1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 23:21:27 -0400
Subject: Re: [PATCH] Numdimmies MUST DIE!
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040502195109.3897ee2e@laptop.delusion.de>
References: <1083551201.25582.149.camel@bach>
	 <20040502195109.3897ee2e@laptop.delusion.de>
Content-Type: text/plain
Message-Id: <1083554446.6876.153.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 03 May 2004 13:20:50 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-03 at 12:51, Udo A. Steinberg wrote:
> While you're at it, there's more (revised patch below):

Thank you for your valuable contribution.  I hesitate to suggest that a
CREDITS entry is appropriate at this point, but it's good to know that
someone else shares my finely-tuned sense of what's important in the
kernel.

Name: Psuedo Numdimmies MUST DIE!
Status: Vitally Important

I'm sure this is violating the trademark of a pre-schooler's TV show
somewhere in the world.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18765-linux-2.6.6-rc3-bk4/drivers/net/dummy.c .18765-linux-2.6.6-rc3-bk4.updated/drivers/net/dummy.c
--- .18765-linux-2.6.6-rc3-bk4/drivers/net/dummy.c	2004-04-29 17:29:43.000000000 +1000
+++ .18765-linux-2.6.6-rc3-bk4.updated/drivers/net/dummy.c	2004-05-03 12:25:11.000000000 +1000
@@ -104,7 +104,7 @@ static struct net_device **dummies;
 
 /* Number of dummy devices to be set up by this module. */
 module_param(numdummies, int, 0);
-MODULE_PARM_DESC(numdimmies, "Number of dummy psuedo devices");
+MODULE_PARM_DESC(numdummies, "Number of dummy pseudo devices");
 
 static int __init dummy_init_one(int index)
 {

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

