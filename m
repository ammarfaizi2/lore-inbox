Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbWHGBUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWHGBUc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 21:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbWHGBUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 21:20:32 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:37385 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750867AbWHGBUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 21:20:32 -0400
Date: Mon, 7 Aug 2006 03:20:30 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, Rolf Eike Beer <eike-kernel@sf-tec.de>,
       trivial@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use BUG_ON(foo) instead of "if (foo) BUG()" in include/asm-i386/dma-mapping.h
Message-ID: <20060807012030.GA3691@stusta.de>
References: <200607280928.54306.eike-kernel@sf-tec.de> <20060728004758.5e7c5120.akpm@osdl.org> <20060805113703.GD4506@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060805113703.GD4506@ucw.cz>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2006 at 11:37:04AM +0000, Pavel Machek wrote:
> Hi!
> 
> > > We have BUG_ON() right for this, don't we?
> > 
> > Well yes, but there are over a thousand BUG->BUG_ON conversion
> > possibilities in the tree.  If people start sending them three-at-a-time
> > we'll all go mad.
> > 
> > So.  If we're going to do this, bigger patches, please.
> 
> If we are going that way... I guess we should specify if BUG_ON() has
> to evaluate its arguments even if it is compiled out...
>...

This is already implemented for ages.

> 							Pavel

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

