Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWDTNrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWDTNrw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 09:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWDTNrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 09:47:52 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:54796 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750722AbWDTNrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 09:47:52 -0400
Date: Thu, 20 Apr 2006 15:47:51 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, "Randy.Dunlap" <rdunlap@xenotime.net>,
       torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: [PATCH] [6/6] i386: Move CONFIG_DOUBLEFAULT into arch/i386 where it belongs.
Message-ID: <20060420134751.GS25047@stusta.de>
References: <4444C0EA.mailKK411J5GA@suse.de> <20060418190839.3fa53a0f.rdunlap@xenotime.net> <20060420114946.GM25047@stusta.de> <200604201526.22318.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604201526.22318.ak@suse.de>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 03:26:21PM +0200, Andi Kleen wrote:
> On Thursday 20 April 2006 13:49, Adrian Bunk wrote:
> 
> > My main problem with his patch is still the way he did it - sending a 
> > patch reverting a recently included patch with neither discussion before 
> > the patch nor mentioning in the patch that it's a revert nor a Cc to the 
> > people involved with the patch.
> 
> I just noticed a problem (bogus symbols in my x86-64 config) and fixed it. I normally 
> don't look at which patch it introduced for such trivial changes.

First of all, the "problem" of an unset config variable in the .config 
is at most a cosmetical issue.

And even if it had been a real problem, discussing such an issue and 
convincing people why you consider it to be bad is always better, since 
whoever gets conviced in the situation will have learned for similar 
future cases.

There are ways how things should work and we should follow them.

As an example, there is one trivial x86_64 specific patch removing the 
small bloat caused by an unused export I made in -mm Andrew has 
forwarded at least twice to you.

Until now, I'd have considered it an unfriendly act to forward such a 
patch to Linus through my trivial tree bypassing you as the maintainer, 
but looking at your statement it seems to be OK for you if I send such 
trivial patches directly to Linus without bothering to go through you as 
the maintainer.

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

