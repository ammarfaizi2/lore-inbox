Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbVAXTOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbVAXTOl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 14:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbVAXTLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 14:11:07 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:40204 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261578AbVAXTJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 14:09:12 -0500
Date: Mon, 24 Jan 2005 20:09:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1
Message-ID: <20050124190909.GQ3515@stusta.de>
References: <20050124021516.5d1ee686.akpm@osdl.org> <20050124185823.GE1847@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124185823.GE1847@ens-lyon.fr>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 07:58:23PM +0100, Benoit Boissinot wrote:
> On Mon, Jan 24, 2005 at 02:15:16AM -0800, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc1/2.6.11-rc1-mm1/
> > 
> > 
> > - Lots of updates and fixes all over the place.
> > 
> > - On my test box there is no flashing cursor on the vga console.  Known bug,
> >   please don't report it.
> > 
> >   Binary searching shows that the bug was introduced by
> >   cleanup-vc-array-access.patch but that patch is, unfortunately, huge.
> > 
> > 
> > 
> > Changes since 2.6.11-rc1-mm2:
> >
> > [snip]
> > 
> > +matroxfb_basec-make-some-code-static.patch
> > 
> >  Little fixes.
> > 
> It breaks compilation with gcc-4.0
> 
> The patch below correct it.

This patch is correct, too.

I do grep for the symbols I'm making static, but it seems I have to 
sharpen my eyes...

> regards,
> 
> Benoit
>...

Sorry
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

