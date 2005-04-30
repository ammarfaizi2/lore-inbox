Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVD3Nup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVD3Nup (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 09:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVD3Nup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 09:50:45 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:63754 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261220AbVD3Nuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 09:50:39 -0400
Date: Sat, 30 Apr 2005 15:50:38 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       shaohua.li@intel.com, Carlos Martin <carlosmn@gmail.com>
Subject: Re: 2.6.12-rc3-mm1
Message-ID: <20050430135038.GA3571@stusta.de>
References: <20050429231653.32d2f091.akpm@osdl.org> <1114867539.872.35.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114867539.872.35.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2005 at 03:25:39PM +0200, Alexander Nyberg wrote:
> > - We're still miles away from 2.6.12.  Lots of patches here, plus my
> >   collection of bugs-post-2.6.11 is vast.  I'll start working through them
> >   again after 2.6.12-rc4 is available to testers.
> > 
> 
> sep-initializing-rework.patch doesn't even call sysenter_setup() on UP
> boxes so it'll break the vsyscall instantly. This cannot even have been
> boot-tested on UP...
> 
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc3/2.6.12-rc3-mm1/broken-out/sep-initializing-rework.patch

Thanks for this email, reverting this patch fixed the boot problem I 
reported.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

