Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965027AbVLNWqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbVLNWqg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 17:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965048AbVLNWqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 17:46:36 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:31503 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965027AbVLNWqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 17:46:35 -0500
Date: Wed, 14 Dec 2005 23:46:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [2.6 patch] offer CC_OPTIMIZE_FOR_SIZE only if EXPERIMENTAL
Message-ID: <20051214224636.GJ23349@stusta.de>
References: <20051214191006.GC23349@stusta.de> <20051214140531.7614152d.akpm@osdl.org> <20051214221304.GE23349@stusta.de> <Pine.LNX.4.64.0512141429030.3292@g5.osdl.org> <20051214224406.GI23349@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051214224406.GI23349@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 11:44:06PM +0100, Adrian Bunk wrote:
> On Wed, Dec 14, 2005 at 02:36:59PM -0800, Linus Torvalds wrote:
> > 
> > 
> > On Wed, 14 Dec 2005, Adrian Bunk wrote:
> > > 
> > > What about marking it as EXPERIMENTAL?
> > 
> > It's not experimental on other architectures, where it is always used.
> > 
> > The best option _may_ be to do something like this, where we use that 
> > "depends on" to set the expectations, and people shouldn't see it unless 
> > they ask for EXPERIMENTAL.
> >...
> 
> My patch has the advantage that it doesn't allow the broken 
> CC_OPTIMIZE_FOR_SIZE=y setting on ARM if !EXPERIMENTAL.

s/CC_OPTIMIZE_FOR_SIZE=y/CC_OPTIMIZE_FOR_SIZE=n/

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

