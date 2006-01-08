Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932730AbWAHM6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932730AbWAHM6J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 07:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932731AbWAHM6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 07:58:09 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:18576 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S932730AbWAHM6I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 07:58:08 -0500
Date: Sun, 8 Jan 2006 13:57:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org
Subject: Re: [2.6 patch] no longer mark MTD_OBSOLETE_CHIPS as BROKEN and remove broken MTD_OBSOLETE_CHIPS drivers
Message-ID: <20060108125700.GI3774@stusta.de>
References: <20060107220702.GZ3774@stusta.de> <1136678409.30348.26.camel@pmac.infradead.org> <20060108002457.GE3774@stusta.de> <1136680734.30348.34.camel@pmac.infradead.org> <20060107174523.460f1849.akpm@osdl.org> <1136724072.30348.66.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136724072.30348.66.camel@pmac.infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2006 at 12:41:12PM +0000, David Woodhouse wrote:
> On Sat, 2006-01-07 at 17:45 -0800, Andrew Morton wrote:
> > Hey, Adrian isn't an MTD developer
> 
> Indeed he is not. And while his minor nitpicks can sometimes be worth
> the effort, it's less useful for him to start making value judgements
> about removing drivers which have _theoretically_ been replaced by new
> code, but which are actually still being used in some cases.

I interpreted your "or just removed" in [1] as your approval for a patch 
to remove the non-compiling drivers.

I'm not a native English speaker, and therefore I might have 
misunderstood your email.

What I want for 2.6.16 is to remove the wrong dependency of MTD_SHARP on 
BROKEN and the non-compiling drivers either still hidden under BROKEN or 
removed.

If there is any way I can submit a patch achieving this that would be 
acceptable for you simply tell how exactly you want this patch.

> > What he's doing here is to poke other maintainers into getting the tree
> > cleaned up.  It's a useful thing to do.
> 
> I know what needs doing to clean the tree up -- and removing the older
> chip drivers is very far from the top of my todo list. If you really
> want to accelerate their demise, add a #warning and a printk saying "You
> should no longer be using this driver -- try using jedec_probe or
> cfi_probe instead and contact the linux-mtd list if that fails". 
>...

We are talking about drivers marked as BROKEN for one and a half years 
that do no longer compile.

> dwmw2

cu
Adrian

[1] http://lkml.org/lkml/2005/12/12/43

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

