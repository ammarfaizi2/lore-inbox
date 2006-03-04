Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWCDLE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWCDLE4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 06:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWCDLE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 06:04:56 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:56591 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751223AbWCDLEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 06:04:55 -0500
Date: Sat, 4 Mar 2006 12:04:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [2.6 patch] schedule eepro100.c for removal
Message-ID: <20060304110454.GI9295@stusta.de>
References: <20060214152226.GK10701@stusta.de> <4408FA6E.3040808@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4408FA6E.3040808@pobox.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 09:24:46PM -0500, Jeff Garzik wrote:
> Adrian Bunk wrote:
> >Signed-off-by: Adrian Bunk <bunk@stusta.de>
> >
> >---
> >
> >This patch was already sent on:
> >- 4 Feb 2006
> >
> > Documentation/feature-removal-schedule.txt |    6 ++++++
> > drivers/net/eepro100.c                     |    1 +
> > 2 files changed, 7 insertions(+)
> >
> >--- linux-2.6.15-mm4-full/Documentation/feature-removal-schedule.txt.old 
> >2006-01-18 08:38:57.000000000 +0100
> >+++ linux-2.6.15-mm4-full/Documentation/feature-removal-schedule.txt 
> >2006-01-18 08:39:59.000000000 +0100
> >@@ -164,0 +165,6 @@
> >+---------------------------
> >+
> >+What:   eepro100 network driver
> >+When:   August 2006
> >+Why:    replaced by the e100 driver
> >+Who:    Adrian Bunk <bunk@stusta.de>
> 
> ACK, provided you change the year to 2007
> 
> >--- linux-2.6.16-rc1-mm5-full/drivers/net/eepro100.c.old	2006-02-03 
> >23:37:55.000000000 +0100
> >+++ linux-2.6.16-rc1-mm5-full/drivers/net/eepro100.c	2006-02-03 
> >23:39:10.000000000 +0100
> >@@ -2391,6 +2391,7 @@ static int __init eepro100_init_module(v
> > #ifdef MODULE
> > 	printk(version);
> > #endif
> >+	printk(KERN_WARNING "eepro100 will be removed soon, please use the 
> >e100 driver\n");
> > 	return pci_module_init(&eepro100_driver);
> 
> NAK

Other people wanted this part of the patch...


It seems the feature-removal-schedule.txt part with a changed date is 
already part of git-netdev-all.patch in recent -mm kernels.

Do you still want me to resend it?


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

