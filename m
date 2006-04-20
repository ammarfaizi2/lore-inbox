Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWDTLts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWDTLts (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 07:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWDTLtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 07:49:47 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:15371 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750708AbWDTLtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 07:49:47 -0400
Date: Thu, 20 Apr 2006 13:49:46 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, torvalds@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: [PATCH] [6/6] i386: Move CONFIG_DOUBLEFAULT into arch/i386 where it belongs.
Message-ID: <20060420114946.GM25047@stusta.de>
References: <4444C0EA.mailKK411J5GA@suse.de> <20060418190528.GL11582@stusta.de> <200604182212.13835.ak@suse.de> <20060418190839.3fa53a0f.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060418190839.3fa53a0f.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2006 at 07:08:39PM -0700, Randy.Dunlap wrote:
> On Tue, 18 Apr 2006 22:12:13 +0200 Andi Kleen wrote:
> 
> > On Tuesday 18 April 2006 21:05, Adrian Bunk wrote:
> > > On Tue, Apr 18, 2006 at 12:35:22PM +0200, Andi Kleen wrote:
> > > > 
> > > > Signed-off-by: Andi Kleen <ak@suse.de>
> > > >...
> > > 
> > > NAK.
> > >  submitting a patch that is the revert of a patch that went 
> > > into Linus' tree just 8 days ago [1], I'd expect at least:
> > > - a Cc to the people involved with the patch you are reverting
> > > - a note that you are reverting a recent patch in your patch
> > >   description
> > > - an explanation why you disagree with the patch you are reverting
> > 
> > The subject was very clear. i386 options belong into arch/i386.
> 
> Yes, the timing could have been better.  Whatever.
> 
> I agree with Andi that it should be moved back to the ix86 Processor
> menu, but not where he moved it to.  My patch is below.
>...

I'd still disagree with Andi regarding this point (but it's not a very 
important issue).

My main problem with his patch is still the way he did it - sending a 
patch reverting a recently included patch with neither discussion before 
the patch nor mentioning in the patch that it's a revert nor a Cc to the 
people involved with the patch.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

