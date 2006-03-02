Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751986AbWCBUjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbWCBUjY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 15:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751978AbWCBUjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 15:39:24 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:42769 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751986AbWCBUjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 15:39:23 -0500
Date: Thu, 2 Mar 2006 21:39:22 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Herbert Xu <herbert@gondor.apana.org.au>, dtor_core@ameritech.net,
       jgeorgas@rogers.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] make UNIX a bool
Message-ID: <20060302203922.GE9295@stusta.de>
References: <20060301175852.GA4708@stusta.de> <E1FEcfG-000486-00@gondolin.me.apana.org.au> <20060302173840.GB9295@stusta.de> <20060302195106.GC19232@lug-owl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060302195106.GC19232@lug-owl.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 08:51:06PM +0100, Jan-Benedict Glaw wrote:
> On Thu, 2006-03-02 18:38:40 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> > On Thu, Mar 02, 2006 at 12:31:34PM +1100, Herbert Xu wrote:
> > > Adrian Bunk <bunk@stusta.de> wrote:
> > > > It does also matter in the kernel image size case, since you have to put 
> > > > enough modules to the other medium for having a effect bigger than the
> > > > kernel image size increase from setting CONFIG_MODULES=y.
> > > That's not very difficult considering the large number of modules that's
> > > out there that a system may wish to use.
> > This might be true for full-blown desktop systems - but these do not 
> > tend to be the systems where kernel image size matters that much.
> > Smaller kernel image size might be an issue e.g. for distribution 
> > kernels, but in a much less pressing way.
> 
> Kernel image size matters if you try to make it boot off a floppy.

Sure, but the usual router-on-a-floppy cases are similar cases where 
CONFIG_MODULES=n brings at least as much gain as making things modular.

> MfG, JBG

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

