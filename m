Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVF3SN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVF3SN0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 14:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbVF3SN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 14:13:26 -0400
Received: from hummeroutlaws.com ([12.161.0.3]:43271 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S262885AbVF3SLF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 14:11:05 -0400
From: "Jim Crilly" <jim@why.dont.jablowme.net>
Date: Thu, 30 Jun 2005 14:10:00 -0400
To: Markus =?iso-8859-1?Q?T=F6rnqvist?= <mjt@nysv.org>
Cc: shevek@bur.st, linux-kernel@vger.kernel.org
Subject: Re: reiser4 vs politics: linux misses out again
Message-ID: <20050630180959.GC24468@voodoo>
Mail-Followup-To: Markus =?iso-8859-1?Q?T=F6rnqvist?= <mjt@nysv.org>,
	shevek@bur.st, linux-kernel@vger.kernel.org
References: <1120134372.42c3e4e49e610@webmail.bur.st> <20050630153326.GB24468@voodoo> <20050630160244.GV11013@nysv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050630160244.GV11013@nysv.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/30/05 07:02:44PM +0300, Markus   Törnqvist wrote:
> On Thu, Jun 30, 2005 at 11:33:26AM -0400, Jim Crilly wrote:
> 
> >> I label according to the observed effect. I haven't read the code.
> >Of course not, it's not like the code actually matters, right?
> 
> As for Reiser4, they're fixing the code now to look more Linuxy
> and all's well.
> 
> The discussion is "Should the VFS be extended to support files-as-dirs
> or data objects by using what we already have in Reiser4 in -mm, although
> disabled."
> 
> >So? Most of the complaints about Linux on the desktop are userland
> >problems. Adding cool features to the kernel won't make a big difference,
> >if for no other reason than it will take a long time for support to make it
> >into things like Gnome and KDE. And that's if they choose to support them,
> 
> And people who'd like to use something lighter than Gnome or KDE
> and still use these nice features?
>

Then work with whatever WM you want to help them support what makes sense
for them. For instance, I use Enlightenment but most of the crap proposed
in Reiser4 doesn't make sense for E because there's no filemanager or
anything. The image thumbnails in metadata might be nice, but I wouldn't
throw a fit if the current runtime generated thumbnails were still used.

> 
> >they have to support other OSes as well and adding support for features
> >that are Linux-specific isn't to be taken lightly, especially since these
> >would be less than Linux-specific, they would be tied to a single
> >filesystem on Linux.
> 
> They would not be tied to a single filesystem, naturally, I think
> we can all agree that case is closed, as it'll just spawn another
> waste-of-time flamewar.
> 

Nothing has happened so far, once the VFS extensions are laid out,
documented and implemented we can begin to start saying that some of the
features are fs agnostic.

> >> Someone shoulda simply forked it then. When Hans first said 'replace VFS with
> >> reiser4'. I doubt he could have done it by himself ... they (trolls) would
> [...]
> >He can still do that, nothing is stopping him from forking Reisux and
> >trying to woo developers.
> 
> It'd be much better to talk this thing through..
> There have been pretty good arguments for the extended VFS, that it
> would be doable. It may just be less of a unix after that, or less
> of Linux as we know it now.
> 

I'm not advocating a fork, I just think it's stupid that so many people
have been saying "Stop arguing, just accept reiser4 as-is because it's
fast and cool!!!!"

> The circular reasoning "We don't want Reiser4's files-as-dirs in
> before they're tested. We also have them disabled by default.
> They should not be implemented on this layer here, but we won't
> let you touch our VFS." is bad.
> 
> Surely if the things started to go into the VFS in a separate,
> official tree, it'd no longer be just Namesys doing the work.
> 
> >And what is better for Linux? It's all about perspective and the people on
> >this mailing list have to maintain the kernel from a developer's standpoint
> >and if they start accepting every new feature regardless of complexity,
> >maintainability, etc the kernel will become a nightmare. 
> 
> The filesystem is tested well enough to go in. For real.
> It may not be production stable with immediacy but it is tested.
> 

People have been saying the same thing about reiser3 for years and yet
every time I break down and try it again for whatever reason I find a nice
new corner case that causes me headaches and usually ends up in me going
back to ext3 or XFS.

> The extended semantics are a separate matter.
> 
> >And what happens in 2 years when Hans posts about reiser5 fixing all of the
> >bad things about reiser4 and that reiser5 should be merged ASAP so that
> >everyone can upgrade again?
> 
> Then someone steps up and goes "No, shut the fuck up and fix the code,
> we gave you your shot" or something.
> 
> Community pressure.
> 

Right, because Hans is so damned receptive.

>
> And it'll be a lot easier with the new VFS.
>

I'm not buying it, but only time will tell.


> >And you're asking the kernel devs to get a wider scope on life? It sounds
> >like you're not even living in the same reality that I am.
> 
> Sometimes it also seems people would much rather shout at each
> other than see that reasons are starting to pop up why Linux
> could lose popularity.
> 

I don't disagree, there are many aspects of each section of a Linux distro
where decisions can affect how Linux is perceived by current and new users.
But IMO not letting reiser4 in, in it's current state, isn't going to send
a bunch of Linux users running to get Macs.

> I accidentally deleted the paragraph with you saying the page
> reads like a commercial.
> 
> I half agree, Hans has written that well, but maybe for
> people who would pay him money to do his work.
> Therefore some of the stuff is a bit obscure. Like what is now 
> Reiser4.1 (ie. ..metas/ whatever, I believe) is apparently referred 
> to as Reiser6 there.
> 

I understand why he wants to have his marketing pages and I don't care if
they exist, but you would think he would also want to have some SDK-type
pages where it explains the new features, the "plug-in" API and such.


> It'd be damned nice to see that page revisited a bit, maybe not much,
> but getting the names straight and having one of the tech guys write
> tech documentation that's clearly accessible.
> 
> That page does still not change the situation that the code exists
> to some extent, which could be merged to the VFS layer by
> extending it a bit and this would be easiest done in a tree that
> people will want to hack on.
> 

But if big VFS changes are going to happen, I doubt anyone would want to
make them in -linus or -mm because there's probably going to be a lot of
initial breakage. Maybe this would be a good reason to fork 2.7?

> And frankly this amount of tautology is starting to get even 
> on my nerves :)
> 

I agree, it was interesting for the first few days but now most of the
threads have gone so far OT that it's just stupid.

> -- 
> mjt
> 

Jim.
