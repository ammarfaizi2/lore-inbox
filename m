Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbVCUUZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbVCUUZT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 15:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVCUUZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 15:25:19 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:56838 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261857AbVCUUZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 15:25:13 -0500
Date: Mon, 21 Mar 2005 21:25:06 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, arjanv@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc1-mm1
Message-ID: <20050321202506.GA3982@stusta.de>
References: <20050321025159.1cabd62e.akpm@osdl.org> <200503210915.53193.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503210915.53193.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 09:15:53AM -0800, Jesse Barnes wrote:
> On Monday, March 21, 2005 2:51 am, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/2.
> >6.12-rc1-mm1/
> 
> Andrew, please drop
> 
> revert-allow-oem-written-modules-to-make-calls-to-ia64-oem-sal-functions.patch
> 
> The tiocx.c driver is now in the tree, and it uses those functions.

IOW:
The EXPORT_SYMBOL's should still be removed, but the functions 
themselves should stay.

> Thanks,
> Jesse

cu
Adrian

BTW: 

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

