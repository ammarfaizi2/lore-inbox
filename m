Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbUKUPTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbUKUPTI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 10:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbUKUPTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 10:19:08 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:20740 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261312AbUKUPTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 10:19:04 -0500
Date: Sun, 21 Nov 2004 16:18:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: ambx1@neo.rr.com, perex@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] misc ISAPNP cleanups
Message-ID: <20041121151856.GM2829@stusta.de>
References: <20041113030234.GX2249@stusta.de> <20041116050316.GC29574@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041116050316.GC29574@neo.rr.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 12:03:16AM -0500, Adam Belay wrote:
> On Sat, Nov 13, 2004 at 04:02:34AM +0100, Adrian Bunk wrote:
> > The patch below removes some completely unused code and makes some 
> > needlessly global code static in drivers/pnp/isapnp/core.c .
> > 
> > Please review whether this patch is correct or whether it conflicts with 
> > pending ISAPNP updates/usages.
> > 
> > 
> > diffstat output:
> >  drivers/pnp/isapnp/core.c |   47 ++++++++------------------------------
> >  include/linux/isapnp.h    |   20 ----------------
> >  2 files changed, 11 insertions(+), 56 deletions(-)
> > 
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 
> 
> I have to check that this doesn't break any obscure isapnp drivers.  Otherwise

Why are these "obscure isapnp drivers" not included in the kernel?

> it looks good.  Some of them, like "isapnp_alloc", look obvious.
> 
> Thanks,
> Adam

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

