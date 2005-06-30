Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262895AbVF3PeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262895AbVF3PeT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 11:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbVF3PeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 11:34:19 -0400
Received: from atpro.com ([12.161.0.3]:43793 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S262895AbVF3PeA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 11:34:00 -0400
From: "Jim Crilly" <jim@why.dont.jablowme.net>
Date: Thu, 30 Jun 2005 11:33:26 -0400
To: shevek@bur.st
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiser4 vs politics: linux misses out again
Message-ID: <20050630153326.GB24468@voodoo>
Mail-Followup-To: shevek@bur.st, linux-kernel@vger.kernel.org
References: <1120134372.42c3e4e49e610@webmail.bur.st>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120134372.42c3e4e49e610@webmail.bur.st>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/30/05 10:26:12PM +1000, shevek@bur.st wrote:
> As far as I'm concerned, commercial trolls have successfully taken away
> linux's only ever chance to sweep the field.

And you are?

> 
> It is now gone. OSX rocks harder than linux, the spotlight function is superb.
> 
> That plus this squabbling is buying m$ enough time to make their version.
>

MS has been working on and delaying WinFS for years, arguing with Hans for
a few months will have no affect on MS' release schedule.

> 
> I label according to the observed effect. I haven't read the code.
> 

Of course not, it's not like the code actually matters, right?

> Linux coulda had the OSX-type spotlight thing working, plus twice as fast
> filesystem 6 months or a year before Apple ... and a couple of years before m$.
> 

So? Most of the complaints about Linux on the desktop are userland
problems. Adding cool features to the kernel won't make a big difference,
if for no other reason than it will take a long time for support to make it
into things like Gnome and KDE. And that's if they choose to support them,
they have to support other OSes as well and adding support for features
that are Linux-specific isn't to be taken lightly, especially since these
would be less than Linux-specific, they would be tied to a single
filesystem on Linux.

> Someone shoulda simply forked it then. When Hans first said 'replace VFS with
> reiser4'. I doubt he could have done it by himself ... they (trolls) would
> simply isolate his work and write his efforts off as the typical actions of a
> lone looney ... as they already characterise him.
> 

He can still do that, nothing is stopping him from forking Reisux and
trying to woo developers.

> The achievement reiser4 represents cannot be overstated. Genuine linux
> developers would have bent over backwards to get this as the primary filesystem
> for linux. Noone has ever doubled filesystem performance before, as far as I
> know, except the BeOS development team who have been divided as spoils of war
> between the two major competitors Apple and M$.
> 
> And he did so in a way that (a) provides for simple expansion in arbitrary
> directions without hackish horror such as AVFS presents; and (b) enables
> provision of compatibility with any arbitrary filesystem featureset.
> 
> What is all the complaining about?
> 
> And who are these guys?
> 
> Reiser has chased around trying to respond to all your criticisms for how long
> now? A year? Many of the critics I recall hadn't even read the material on his
> web site. Are these the same people now further delaying linux's adoption of
> 21st century filesystem semantics?
> 

Probably because most of the material on his website reads like a
commercial. It's hard to read through documentation when it feels like
someone's constantly trying to sell you something.

> So many of the arguments I read are circular.
> 
> eg
> 
> * reiser4 can't be included until it has had widespread testing.
> 
> * reiser4 shouldn't contain two levels of plugins, since plugins properly belong
> in the awful hackish AVFS layer, above the VFS layer.
> 
> In fact the main impediment to reiser4 having been widely tested, in my
> ill-educated opinion, is simply that the directories look like files. This
> means a lot of application code needs minor tweaks, or at least thorough
> testing. Yet, it should be trivial to fix reiser4 so that directories don't
> look like files, no? using plugins?
> 
> Some arguments against reiser4 show that the arguer in question is even less
> well educated than even myself. ie, the person has not even tried reiser4.
> 
> Anyone who has, finds themselves so blown away by the apparent doubling of speed
> of any disk-bound task, that they start to question how much effort must have
> gone into making previous filesystems so slow. Who ever thought putting a
> transaction log at the end of the disk furthest away from where the data needs
> to be written would be a good thing? Why should it not go just near to where
> the head happens to be already? Thankyou Hans for showing us how.
> 
> To argue that benchmarks do not truly reflect real world use, you must never
> have even taken the time to real world use this thing. While Herr Reiser has
> put years of his life, and now apparently also much of his money, into creating
> it for you.
> 
> Try and get a wider scope on life, people. What is better for the future? Slow,
> dawdling development on slow dawdling filesystems and their supporting
> architecture, when we have been shown a fully functioning, effective and I am
> led to believe, simple replacement?
> 

And what is better for Linux? It's all about perspective and the people on
this mailing list have to maintain the kernel from a developer's standpoint
and if they start accepting every new feature regardless of complexity,
maintainability, etc the kernel will become a nightmare. 

And what happens in 2 years when Hans posts about reiser5 fixing all of the
bad things about reiser4 and that reiser5 should be merged ASAP so that
everyone can upgrade again?

> Well, like I said at the start, it's too late, if you do not like that path. We
> are now trapped there. The masses of users who would have been attracted by
> linux beating Apple and M$ to the punch, are now fading into some potential
> parallel universe. It's not this one. Hang your heads in shame, and cry. We
> lost. We are back to the same commercial monopoly-dominated market that we ever
> had. The loser is all of us, the common good, which has been sacrificed for the
> good of the few, by the invisible hand of the market, and the collective
> unconsciousness.
> 

And you're asking the kernel devs to get a wider scope on life? It sounds
like you're not even living in the same reality that I am.

> Simeon
> 

Jim.
