Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756681AbWKSOEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756681AbWKSOEX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 09:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756679AbWKSOEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 09:04:23 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:31241 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1756677AbWKSOEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 09:04:22 -0500
Date: Sun, 19 Nov 2006 15:04:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Alan Cox <alan@redhat.com>, Andrew Morton <akpm@osdl.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [2.6 patch] mark pci_find_device() as __deprecated
Message-ID: <20061119140420.GF31879@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org> <20061117142145.GX31879@stusta.de> <20061117143236.GA23210@devserv.devel.redhat.com> <20061118000629.GW31879@stusta.de> <1163929632.31358.481.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163929632.31358.481.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2006 at 10:47:12AM +0100, Arjan van de Ven wrote:
> 
> > 
> > Oh, and if anything starts complaining "But this adds some warnings to 
> > my kernel build!", he should either first fix the 200 kB (sic) of 
> > warnings I'm getting in 2.6.19-rc5-mm2 starting at MODPOST or go to hell.
> 
> we can solve this btw; we could have a
> 
> #define THIS_MODULE_IS_LEGACY_CRAP_AND_WONT_GET_FIXED
>...

The few warnings by __deprecated are not that much of a problem.

But the > 200 kB starting at MODPOST in -mm are really annoying.
And it seems noone cares about them.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

