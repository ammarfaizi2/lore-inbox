Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759679AbWLCNsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759679AbWLCNsS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 08:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759678AbWLCNsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 08:48:18 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:49932 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1758661AbWLCNsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 08:48:17 -0500
Date: Sun, 3 Dec 2006 14:48:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: col-pepper@catking.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH] - revert generic_fillattr stat->blksize to PAGE_CACHE_SIZE
Message-ID: <20061203134821.GB3442@stusta.de>
References: <op.tjzjdji6q8etvz@linbox.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.tjzjdji6q8etvz@linbox.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2006 at 02:21:09PM +0100, col-pepper@catking.net wrote:

> I am using a 2.6.18.2 based kernel and see lots of broken fs due to this  
> "diet". eg cloop
> 
> I hope some general lessons can be drawn about the necessity and  
> desirablility of such changes that (predictably) invoke broadband breakage.

Lessons 1-99:
Get your modules included in the kernel.

> This kind of change and the breakage and dependancy issues they create are  
> what makes linux a nightmare to maintain.
>...

s/linux/external modules not submitted for inclusion in the kernel/

> What kernel release contains code where all this calms down and I dont  
> need to search patches and updates for modules in order to get basics to  
> work again?
>...

None, the Linux development model is based on the fact that such changes 
are considered perfectly OK as long as all in-kernel users are being 
fixed.

The solution for your problem is that the authors of the modules you 
are using should get their modules included in the Linux kernel - and 
they'll be automatically fixed when someone changes an in-kernel API.

> Thanks for your replys.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

