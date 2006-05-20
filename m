Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbWETKZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbWETKZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 06:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbWETKZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 06:25:27 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:56582 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964803AbWETKZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 06:25:27 -0400
Date: Sat, 20 May 2006 12:25:26 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: replacing X Window System !
Message-ID: <20060520102526.GH10077@stusta.de>
References: <200605200733.08757.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605200733.08757.a1426z@gawab.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2006 at 07:33:08AM +0300, Al Boldi wrote:
> Adrian Bunk wrote:
> > On Sat, May 20, 2006 at 12:40:56AM +0200, linux cbon wrote:
> > > I think the discussion should move to X.Org ?
> >
> > The whole discussion is pointless anywhere as long as you are not
> > writing the code to implement your proposal.
> >
> > If you think you could send an idea and other people would implement it
> > you are misunderstanding how open source software works.
> >
> > You have your idea.
> >
> > It is YOUR job to write the code implementing your proposal.
> >
> > Then there's a basis for a technical discussion of the advantages and
> > disadvantages of your ideas.
> 
> Implementing an idea before discussing it's feasibility?
> 
> Kind of stupid, don't you think?

Sure, it does make sense to ask for comments before starting with an 
implementation.

But discussing possible patches also becomes kind of stupid if you
aren't willing to implement it yourself.

There have already been more than enough discussions regarding this 
issue - if he still considers his idea worth it HE must start with the 
implementation NOW.

He seems to be the kind of troll who wants to convince other people of 
his "great" ideas without writing a single line of code himself.

> > Otherwise, you are only wasting your (and our) time since there's
> > exactly a 0% probability that someone else will implement your ideas.
> 
> Maybe not 0% exactly.

In this case, 0% exactly.

> Not that I would agree with the in-Kernel X idea per se, but it does raise 
> the issue of a stable API once more, as it would allow more freedom to 
> create a module against a version line w/o fear of being rejected.

It does not raise the issue of a stable kernel API:

The solution is to work on getting the module included into the kernel. 
All problems with changing kernel APIs vanish as soon as your module is 
included. This is independent from what the module in question is doing.

Documentation/stable_api_nonsense.txt explains the advantages of not 
having a stable API.

> Thanks!
> Al

cu
Adrian

BTW: Don't drop people from the Cc.

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

