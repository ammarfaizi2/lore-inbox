Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756726AbWKSPtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756726AbWKSPtM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 10:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756729AbWKSPtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 10:49:12 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:17931 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1756726AbWKSPtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 10:49:11 -0500
Date: Sun, 19 Nov 2006 16:49:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Alan Cox <alan@redhat.com>,
       Andrew Morton <akpm@osdl.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [2.6 patch] mark pci_find_device() as __deprecated
Message-ID: <20061119154909.GJ31879@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org> <20061117142145.GX31879@stusta.de> <20061117143236.GA23210@devserv.devel.redhat.com> <20061118000629.GW31879@stusta.de> <1163929632.31358.481.camel@laptopd505.fenrus.org> <20061119095258.GK3735@rhun.zurich.ibm.com> <20061119140600.GG31879@stusta.de> <20061119152421.GB19613@rhun.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061119152421.GB19613@rhun.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2006 at 05:24:21PM +0200, Muli Ben-Yehuda wrote:
> On Sun, Nov 19, 2006 at 03:06:00PM +0100, Adrian Bunk wrote:
> 
> > unmaintained != not used
> > 
> > As an example, some people might be unhappy if the floppy driver that is 
> > unmaintained for ages and not in a good state was removed.
> 
> I understand. However, if it was slated to be removed, said people
> might be inclined to start maintaining it.

Most Linux users weren't able to maintain any peace of kernel code even 
if they wanted to.

> We have a bar for inclusion
> of new code into the tree - why shouldn't a quality bar also be
> applied to old code in the tree?

Removing an older unmaintained but working driver is from a user's point 
of view a regression that locks this user into using an older kernel.

> Cheers,
> Muli

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

