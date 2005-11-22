Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbVKVHlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbVKVHlQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 02:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbVKVHlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 02:41:16 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:45232
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932371AbVKVHlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 02:41:15 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [RFC] Small PCI core patch
Date: Tue, 22 Nov 2005 01:41:05 -0600
User-Agent: KMail/1.8
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Airlie <airlied@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20051121225303.GA19212@kroah.com> <1132623268.20233.14.camel@localhost.localdomain> <9e4733910511211820x3539213arfe20f3939a375b51@mail.gmail.com>
In-Reply-To: <9e4733910511211820x3539213arfe20f3939a375b51@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511220141.05877.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 November 2005 20:20, Jon Smirl wrote:
> On 11/21/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > On Maw, 2005-11-22 at 11:47 +1100, Dave Airlie wrote:
> > Nvidia are at least trying to do what they can within what for them is
> > not a very easy set of market conditions for open sourcing. ATI were
> > doing very nice things until they won the Xbox 360 contract. An
> > observation that perhaps would not go amiss reaching the US legal
> > watchdogs.
>
> How is graphics going to be dealt with on Linux? Is the Linux desktop
> going to stay stuck in 1998 since that is the last year the graphics
> vendors released specs? If the choice is "open source or die" then
> that's the answer. Of course that answer is bad news desktop Linux
> distributions and they may die.

What desktop Linux distributions?

My fiance's laptop recently got yet another spyware infection and she finally 
decided to give Linux a try on the thing.  (She still has a windows desktop 
she spends most of her time at, so the laptop's optional.)  And I've been 
looking for a decent desktop distro.  None of the big boys like Red Hat or 
SuSE care about desktops anymore.  Knoppix is great but it's only usable from 
the CD (which is too slow), I've never managed to install it to the hard 
drive and add packages afterwards.

I tried Ubuntu because it's at least _interested_ in desktop users, and my 
Fiance's reaction was "hate hate hate" (this is a quote.  Mostly what she 
seemed to hate was Gnome, and I agree with her entirely on that one.  I use 
KDE myself, but kbuntu is an afterthought that doesn't have any apps.  Not 
even a gui tool to list available access points and select which one to bind 
to.  Yeah, I can do iwlist/iwconfig from the command line every time I fire 
up my laptop at a coffee shop, but I'm not asking her to.)

I got a couple page writeup of what annoyed her, and I'm going to try to find 
something that she can hate less.  But what's next, slackware?  What distros 
are still _interested_ in linux on the desktop?

On the hardware front, there are some signs of hope.  My dell laptop may 
actually have a usable open source driver for its video hardware, totally 
reverse engineered of course:
http://r300.sourceforge.net/

And someday I hope to actually build X from source, and opengl, and try 
testing this sucker.  It probably won't be this week.  Geeky as I am, 
building X, DRI, and openGL from source isn't something I do casually.  But 
how can I try this out any other way?

The problem isn't the lack of technology.  We've got forcedeth for network 
cards that never had a spec because when people did this work lots of end 
users showed up to try it out.  But if you look at the status log for the 
radeon driver I mentioned above, it only seems to get touched every 2 months 
and the last time was in july.  And this is something that, according to 
their web page, mostly works now for the hardware I've got...

The linux of 5 years ago was about as end-user ready as the Linux of today: 
the progress we've made has been buried by new hardware requirements 
(wireless, 3d, suspend).  We mostly have the technology, but we haven't gone 
after users who don't program.  And without users, any problem solved becomes 
an isolated demo gathering dust.  Who is integrating this stuff so we can see 
what the holes _are_?

Rob
