Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261845AbTCLTT1>; Wed, 12 Mar 2003 14:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261853AbTCLTT0>; Wed, 12 Mar 2003 14:19:26 -0500
Received: from pasky.ji.cz ([62.44.12.54]:41713 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S261845AbTCLTTY>;
	Wed, 12 Mar 2003 14:19:24 -0500
Date: Wed, 12 Mar 2003 20:29:52 +0100
From: Petr Baudis <pasky@ucw.cz>
To: Larry McVoy <lm@work.bitmover.com>, Zack Brown <zbrown@tumblerings.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Thoughts about ideal kernel SCM
Message-ID: <20030312192952.GP7397@pasky.ji.cz>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Zack Brown <zbrown@tumblerings.org>, linux-kernel@vger.kernel.org
References: <200303020011.QAA13450@adam.yggdrasil.com> <20030307123237.GG18420@atrey.karlin.mff.cuni.cz> <20030307165413.GA78966@dspnet.fr.eu.org> <20030307190848.GB21023@atrey.karlin.mff.cuni.cz> <b4b98v$14m$1@penguin.transmeta.com> <20030308225252.GA23972@renegade> <20030309000514.GB1807@work.bitmover.com> <20030309024522.GA25121@renegade> <20030310000233.GS3917@pasky.ji.cz> <20030310003233.GC29789@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030310003233.GC29789@work.bitmover.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Mon, Mar 10, 2003 at 01:32:33AM CET, I got a letter,
where Larry McVoy <lm@bitmover.com> told me, that...
> > What am I missing?
> 
> Nothing that a half of decade of work wouldn't fill in :)

Good then ;-).

> More seriously, lots.  I keep saying this and people keep not hearing it,
> but it's the corner cases that get you.  You seem to have a healthy grasp
> of the problem space on the surface but in reading over your stuff, you 
> aren't even where I was before BK was started.  That's not supposed to be
> offensive, just an observation.  As you try out the ideas you described
> you'll find that they don't work in all sorts of corner cases and the 
> problem is that there are a zillion of them.  And the solutions have
> this nasty habit of fighting with each other, you solve one problem
> and that creates another.

Sure, it's expected not to work perfectly. But we must start anywhere, it's
IMHO better than just sitting at one place saying "we won't manage to do it
perfectly anyway". We indeed won't that way, if we will start actually doing
something and discussing the basic design ideas, we may.

I can already see notes of flaws^Wshadow areas ;-) in my ideas, but I believe
most of these can be pruned out. The rest will just have to be fixed later.

..snip..
> I strongly urge you to wander off and talk to people who are actually
> writing code for real users.  Arch, SVN, CVS, whatever.  Get deeply
> involved and understand their choices.

Certainly, I'm going to start digging into Arch very soon.

> Personally, I'd suggest the SVN guys because I think they are the most
> serious, they have a team which has been together for a long time and thought
> hard about it.  On the other hand, Arch is probably closer to mimicing how
> development really happens in the real world, in theory, at least, it can do
> better than BK, it lets you take out of order changesets and BK does not.
> But it is light years behind SVN in terms of actually working and being a
> real product.  SVN is almost there, they are self hosting, they eat their own
> dog food, Arch is more a collection of ideas and some shell scripts.
> From SVN, you're going to learn more of the hard problems that actually
> occur, but Arch might be a better long term investment, hard to say.

I would probably base my potential work on Arch (or maybe Arx, I have to
actually compare these, I didn't find any good summary of differences), but I
dislike some concepts so it would be Yet Another Fork anyway ;-).

Kind regards,

-- 
 
				Petr "Pasky" Baudis
.
When in doubt, use brute force.
		-- Ken Thompson
.
Crap: http://pasky.ji.cz/
