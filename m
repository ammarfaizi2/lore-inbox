Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbVA3OPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbVA3OPb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 09:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbVA3OPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 09:15:30 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:45074 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261705AbVA3OPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 09:15:04 -0500
Date: Sun, 30 Jan 2005 15:14:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add compiler-gcc4.h
Message-ID: <20050130141459.GN3185@stusta.de>
References: <20050130130308.GK3185@stusta.de> <m1pszn3t2w.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1pszn3t2w.fsf@muc.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2005 at 03:11:19PM +0100, Andi Kleen wrote:
> Adrian Bunk <bunk@stusta.de> writes:
> 
> > With the release of gcc 4.0 being only a few months away and people 
> > already tring compiling with it, it's time for adding a compiler-gcc4.h .
> >
> > This patch contains the following changes:
> > - compiler-gcc+.h: add the missing noinline and __compiler_offsetof
> > - compiler-gcc4.h: new file based on the corrected compiler-gcc+.h
> > - compiler.h: include compiler-gcc4.h for gcc 4
> > - compiler-gcc3.h: remove __compiler_offsetof (there will never be a
> >                                                gcc 3.5)
> >                    small indention corrections
> 
> I don't think it makes much sense right now because it's basically
> identical to compiler-gcc3.h. I would only add it where there is a 
> need for a real difference.

The currently used file for gcc 4 is compiler-gcc+.h, not 
compiler-gcc3.h .

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

