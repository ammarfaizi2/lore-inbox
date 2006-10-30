Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030501AbWJ3Dif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030501AbWJ3Dif (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 22:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030503AbWJ3Dif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 22:38:35 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:11786 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030501AbWJ3Dif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 22:38:35 -0500
Date: Mon, 30 Oct 2006 04:38:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Oleg Verych <olecom@flower.upol.cz>
Subject: Re: why test for "__GNUC__"?
Message-ID: <20061030033834.GJ27968@stusta.de>
References: <Pine.LNX.4.64.0610290610020.6502@localhost.localdomain> <Pine.LNX.4.61.0610291244310.15986@yvahk01.tjqt.qr> <Pine.LNX.4.64.0610290742310.7457@localhost.localdomain> <20061029120534.GA4906@martell.zuzino.mipt.ru> <Pine.LNX.4.64.0610291044230.9726@localhost.localdomain> <slrnek9le5.2vm.olecom@flower.upol.cz> <20061029171855.GF27968@stusta.de> <Pine.LNX.4.64.0610291223520.31583@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610291223520.31583@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2006 at 12:37:36PM -0500, Robert P. J. Day wrote:
> On Sun, 29 Oct 2006, Adrian Bunk wrote:
> 
> > On Sun, Oct 29, 2006 at 04:17:51PM +0000, Oleg Verych wrote:
> > >...
> > > On 2006-10-29, Robert P. J. Day wrote:
> > >>...
> > > And if you can, please, help with development or bugs, not this.
> >
> > Cleanup of the kernel source is also a valuable task (and as a side
> > effect it even sometimes finds bugs).
> 
> on that note, i realize that most of my postings are addressing
> nitpicky/aesthetic issues that don't actually *hurt* anything, but for
> someone who's clawing his way through the kernel code for the first
> time, a lot of it is unnecessarily confusing.
> 
> for better or worse, i generally assume that whatever i'm looking at
> is there for a *reason* and i might spend some time puzzling over a
> bit of code until it finally dawns on me that it's just historical
> cruft that has no value.  it's not a bug, it just doesn't *do*
> anything anymore.
> 
> in my case, it's sometimes easier to spot things like this since i'm
> following along in some book, like r. love's "linux kernel
> development."  so when he writes that the linux kernel is wedded to
> gcc, and yet i see tests for "__GNUC__" throughout the code, my little
> antenna stalks perk up a bit.
>...

Looking at it, it seems I might look through them - some of them seem to 
be really pointless.

> in any event, i'm most emphatically *not* (yet) at the level where i'm
> going to be able to contribute bleeding-edge code.  but i'm certainly
> capable of poring over the *existing* code and pointing out the places
> that might lead someone to mutter, "what the hell...?"
> 
> maybe there's a better forum for me to make these observations.  i'm
> open to suggestions.  i've made a list of these observations and i'd
> be happy to send them to the right person.

There's also the kernelnewbies list.

But your emails are not as bad as you think - the email starting this 
thread as well as your earlier emails regarding menu structure etc. have 
some value (and they are better than many other questions that hit 
this list...).

> rday

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

