Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbVAXRZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVAXRZu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 12:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVAXRZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 12:25:49 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:35333 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261535AbVAXRZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 12:25:18 -0500
Date: Mon, 24 Jan 2005 18:25:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1 [compile fix]
Message-ID: <20050124172512.GI3515@stusta.de>
References: <20050124021516.5d1ee686.akpm@osdl.org> <20050124151113.GA12312@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124151113.GA12312@ens-lyon.fr>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 04:11:13PM +0100, Benoit Boissinot wrote:
> On Mon, Jan 24, 2005 at 02:15:16AM -0800, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc1/2.6.11-rc1-mm1/
> > 
> > 
> > - Lots of updates and fixes all over the place.
> > 
> > 
> > Changes since 2.6.11-rc1-mm2:
> > 
> > [snip]
> > 
> > +kernel-forkc-make-mm_cachep-static.patch
> > 
> >  Little fixes.
> > 
> >
> It breaks compilation with gcc-4.0
> 
> kernel/fork.c:1249: error: static declaration of ???mm_cachep??? follows non-static declaration
> include/linux/slab.h:117: error: previous declaration of ???mm_cachep??? was here
> make[1]: *** [kernel/fork.o] Error 1
> make: *** [kernel] Error 2
>...

Ups, yes, thanks. This was my fault.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

