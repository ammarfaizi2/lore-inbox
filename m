Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758455AbWK3HJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758455AbWK3HJN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 02:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758457AbWK3HJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 02:09:13 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:39941 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1758429AbWK3HJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 02:09:12 -0500
Date: Thu, 30 Nov 2006 08:09:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Simon Evans <spse@secret.org.uk>, linux-pcmcia@lists.infradead.org,
       linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] remove the broken MTD_PCMCIA driver
Message-ID: <20061130070917.GH11084@stusta.de>
References: <20061118214056.GB31879@stusta.de> <1164752187.14595.20.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164752187.14595.20.camel@pmac.infradead.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2006 at 10:16:27PM +0000, David Woodhouse wrote:
> On Sat, 2006-11-18 at 22:40 +0100, Adrian Bunk wrote:
> > The MTD_PCMCIA driver has:
> > - already been marked as BROKEN in 2.6.0 three years ago and
> > - is still marked as BROKEN.
> > 
> > Drivers that had been marked as BROKEN for such a long time seem to be
> > unlikely to be revived in the forseeable future.
> 
> Actually, there's hardware currently on its way to me, and I plan to fix
> this driver fairly soon.

OK.

> > But if anyone wants to ever revive this driver, the code is still
> > present in the older kernel releases.
> 
> I'm unconvinced by that argument in the general case. People don't go
> looking back through git history, do they? Drivers such as this don't
> really do any harm as they are, and they're _much_ easier to find when
> someone does want to fix them up.

If there is an already merged driver that is marked as broken for a long 
time, there are usually two possible cases:
- it is really unused
- patches to fix it are pending or floating around

A patch to remove a driver is usually the best way for getting the 
information which case a driver belongs into (a good example might be 
the zr36120 driver that seems to have found a new maintainer due to my 
removal patch).

And if there's no reaction, the usefullness of very outdated and 
usually non-compiling code is quite questionable.

> dwmw2

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

