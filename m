Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756682AbWKSOGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756682AbWKSOGF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 09:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756684AbWKSOGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 09:06:04 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:33545 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1756682AbWKSOGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 09:06:02 -0500
Date: Sun, 19 Nov 2006 15:06:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Alan Cox <alan@redhat.com>,
       Andrew Morton <akpm@osdl.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [2.6 patch] mark pci_find_device() as __deprecated
Message-ID: <20061119140600.GG31879@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org> <20061117142145.GX31879@stusta.de> <20061117143236.GA23210@devserv.devel.redhat.com> <20061118000629.GW31879@stusta.de> <1163929632.31358.481.camel@laptopd505.fenrus.org> <20061119095258.GK3735@rhun.zurich.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061119095258.GK3735@rhun.zurich.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2006 at 11:52:58AM +0200, Muli Ben-Yehuda wrote:
> On Sun, Nov 19, 2006 at 10:47:12AM +0100, Arjan van de Ven wrote:
> > 
> > > 
> > > Oh, and if anything starts complaining "But this adds some warnings to 
> > > my kernel build!", he should either first fix the 200 kB (sic) of 
> > > warnings I'm getting in 2.6.19-rc5-mm2 starting at MODPOST or go to hell.
> > 
> > we can solve this btw; we could have a
> > 
> > #define THIS_MODULE_IS_LEGACY_CRAP_AND_WONT_GET_FIXED
> > 
> > that would turn __deprecated into a nop for those few legacy modules
> > inside the kernel that nobody really is looking after.
> 
> If no one is looking after them, shouldn't they just be removed?

unmaintained != not used

As an example, some people might be unhappy if the floppy driver that is 
unmaintained for ages and not in a good state was removed.

> Cheers,
> Muli

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

