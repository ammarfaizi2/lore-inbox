Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbVKSUfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbVKSUfM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 15:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbVKSUfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 15:35:08 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:45829 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750809AbVKSUe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 15:34:59 -0500
Date: Sat, 19 Nov 2005 21:34:57 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, saw@saw.sw.com.sg,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC: 2.6 patch] remove drivers/net/eepro100.c
Message-ID: <20051119203457.GL16060@stusta.de>
References: <20051118033302.GO11494@stusta.de> <20051118090158.GA11621@flint.arm.linux.org.uk> <437DFD6C.1020106@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437DFD6C.1020106@pobox.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 11:12:28AM -0500, Jeff Garzik wrote:
> Russell King wrote:
> >On Fri, Nov 18, 2005 at 04:33:02AM +0100, Adrian Bunk wrote:
> >
> >>This patch removes the obsolete drivers/net/eepro100.c driver.
> >>
> >>Is there any reason why it should be kept?
> >
> >
> >Tt's the only driver which works correctly on ARM CPUs.  e100 is
> >basically buggy.  This has been discussed here on lkml and more
> >recently on linux-netdev.  If anyone has any further questions
> >please read the archives of those two lists.
> 
> After reading the archives, one discovers the current status is:
> 
> 	waiting on ARM folks to test e100
> 
> Latest reference is public message-id <4371A373.6000308@pobox.com>, 
> which was CC'd to you.
> 
> There is a patch in netdev-2.6.git#e100-sbit and in Andrew's -mm tree 
> that should solve the ARM problems, and finally allow us to kill 
> eepro100.  But it's waiting for feedback...

I'mn not subscribed to netdev, and 4371A373.6000308@pobox.com was not 
Cc'ed to me, but I do now understand the status of e100/eepro100.

After all my email was just an RFC.

> 	Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

