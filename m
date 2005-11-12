Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964885AbVKLXsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbVKLXsr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 18:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbVKLXsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 18:48:47 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:19986 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964885AbVKLXsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 18:48:46 -0500
Date: Sun, 13 Nov 2005 00:48:44 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, hugh@veritas.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH 01/15] mm: poison struct page for ptlock
Message-ID: <20051112234844.GD21448@stusta.de>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com> <Pine.LNX.4.61.0511100142160.5814@goblin.wat.veritas.com> <20051109181022.71c347d4.akpm@osdl.org> <Pine.LNX.4.61.0511100215150.6138@goblin.wat.veritas.com> <20051109185645.39329151.akpm@osdl.org> <20051110120624.GB32672@elte.hu> <20051110042613.7a585dec.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051110042613.7a585dec.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2005 at 04:26:13AM -0800, Andrew Morton wrote:
> Ingo Molnar <mingo@elte.hu> wrote:
>...
> > We really dont want to 
> >  rewrite spinlocks (or remove features) just to keep gcc 2.95 supported 
> >  for some more time. In fact, is there any 2.6 based distro that uses gcc 
> >  2.95?
> 
> I think some of the debian derivates might.  But who knows?

Debian 3.1 still ships a gcc 2.95, but the default compiler is gcc 3.3 .

Even Debian 3.0 (released in July 2002 and not supporting kernel 2.6) 
ships a gcc 3.0.4 (although it isn't the default compiler on !hppa).

Considering that kernel 2.6.0 was released two and a half years _after_ 
gcc 3.0, I do heavily doubt that there is any distribution that does 
both support kernel 2.6 and not ship any gcc >= 3.0 .

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

