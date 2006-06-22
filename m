Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWFVQlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWFVQlk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 12:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbWFVQlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 12:41:40 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:11283 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932153AbWFVQlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 12:41:40 -0400
Date: Thu, 22 Jun 2006 18:41:38 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Willy Tarreau <w@1wt.eu>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.4.33-rc1] updated patch kit for gcc-4.1.1
Message-ID: <20060622164138.GI9111@stusta.de>
References: <200606172052.k5HKq5IX002958@harpo.it.uu.se> <20060617213824.GE13255@w.ods.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060617213824.GE13255@w.ods.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2006 at 11:38:24PM +0200, Willy Tarreau wrote:
> Hi Mikael,
> 
> On Sat, Jun 17, 2006 at 10:52:05PM +0200, Mikael Pettersson wrote:
> > An updated patch kit allowing gcc-4.1.1 to compile the 2.4.33-rc1 kernel is now available:
> > <http://user.it.uu.se/~mikpe/linux/patches/2.4/patch-gcc4-fixes-v15-2.4.33-rc1>
> > 
> > Changes since the previously announced version of the patch kit
> > <http://marc.theaimsgroup.com/?l=linux-kernel&m=114149697417107&w=2>:
> > 
> > - Merged the fixes for gcc-4.1 into the baseline patch kit for gcc-4.0.
> > - I previously reported that gcc-4.1.0 built ppc32 kernels that oopsed
> >   in shrink_dcache_parent(). gcc-4.1.1 fixed this issue.
> > - The architectures known to work in kernel 2.4.33-rc1 + this patch kit
> >   with gcc-4.1.1 and gcc-4.0.3 are i386, x86-64, and ppc32.
> 
> Thanks for still maintaining this patchset. I sometimes have coworkers
> complain that they cannot build 2.4 anymore because they have let their
> distro automatically upgarde gcc to 4.x. I will be able to point your

Which distribution does both support kernel 2.4 and no longer ship a 
compiler capable of compiling kernel 2.4?

> site to them. I was also thinking about updating my page on "linux
> kernel useful patches" with this last update, but noticed you still have
> a "patch-more-gcc4-fixes" file. Is it absolutely needed or just a cleanup ?
> 
> > /Mikael
> 
> Regards,
> Willy

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

