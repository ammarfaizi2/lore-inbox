Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266662AbUGVBdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266662AbUGVBdg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 21:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266663AbUGVBdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 21:33:36 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:62935 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S266662AbUGVBdb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 21:33:31 -0400
Message-ID: <170fa0d2040721183350cc5cb8@mail.gmail.com>
Date: Wed, 21 Jul 2004 19:33:31 -0600
From: Mike Snitzer <snitzer@gmail.com>
To: Brian Gerst <bgerst@didntduck.org>
Subject: Re: [PATCH] delete devfs
Cc: Greg KH <greg@kroah.com>, Adrian Bunk <bunk@fs.tum.de>,
       Jesse Stockall <stockall@magma.ca>, Oliver Neukum <oliver@neukum.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <40FEEEBC.7080104@quark.didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040721141524.GA12564@kroah.com> <200407211626.55670.oliver@neukum.org> <20040721145208.GA13522@kroah.com> <1090444782.8033.4.camel@homer.blizzard.org> <20040721212745.GC18110@kroah.com> <20040721220237.GX14733@fs.tum.de> <20040721220736.GC18721@kroah.com> <40FEEEBC.7080104@quark.didntduck.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a portion of the story; hopefully posting a snippet will not
offend John Corbet.  You guys really should just subscribe to LWN..
the following is just a taste of the insight LWN has to offer:

<snip>
Linus talked about how happy just about everybody is with 2.6. It has
been almost two years since the alleged 2.5 feature freeze, but there
still is no great pressure to start a new development series. Linus
asks: could things just go on the way they are for a while yet, until
enough pressure forms to force the 2.7 fork?

Bdale Garbee pointed out that, in the absence of a 2.7, many people
will conclude that 2.6 has not yet stabilized sufficiently. There may
be a need to do the fork just to convince people that 2.6 is ready.
Alan Cox had a different idea: given that there is not a great deal of
stuff to merge into 2.7, perhaps the developers could actually do a
six-month release cycle for a change?

Andrew pointed out that, during the 2.6 process, he and Linus have
been merging patches at a rate of about 10MB/month. There is, he says,
no reason to believe that things will not continue that way. The
traditional stabilization mechanism, where almost no patches are
accepted for long periods of time, does not strike him as a good idea.
Instead, Andrew would like to see a 2.6 tree which continues to change
and evolve, and let the distributors do the final stabilization work.
In his vision of the future, the kernel.org kernel will be the most
featureful and fastest kernel out there, but it will not necessarily
be the most stable.

The idea here is that restricting changes creates an incredible "patch
pressure," which eventually leads to massive amounts of changes going
into the kernel suddenly. At that point, things really do become
unstable. It is better to keep the flow rate on patches higher; that
keeps the developers happy and gets new code out to users quicker.
Andrew really believes this: there are, seemingly, very few patches
that he is not willing to accept into 2.6 - as long as they make sense
and survive testing in -mm.

These patches include API changes, incidentally. Stable internal
kernel APIs have never been guaranteed, but the developers have
usually tried to not make big changes during a stable kernel series.
That looks to change now. Among other things, it was said that API
changes should be merged before an eventual 2.7 fork, since that would
make synchronization between the two trees easier.  Your editor, who
really would like to see Linux Device Drivers not go obsolete before
it hits the shelves, finds this idea somewhat dismaying.

What may happen is that Linus creates a 2.7 tree in the near future,
but that tree will be restricted to truly experimental, destabilizing
changes. This tree may have no future: if it doesn't work out, or
can't be kept in sync with 2.6, it might simply be dropped. Or it
could yet develop into 2.8, if that makes sense.

On Wed, 21 Jul 2004 18:31:24 -0400, Brian Gerst <bgerst@didntduck.org> wrote:
> Greg KH wrote:
> > On Thu, Jul 22, 2004 at 12:02:38AM +0200, Adrian Bunk wrote:
> >
> >>>As for "right now"?  Why not?  I'm just embracing the new development
> >>>model of the kernel :)
> >>
> >>Could anyone please explain this mysterious "new development model of
> >>the kernel"?
> >>
> >>Is this some personal fight from you against Linus or someone else you
> >>are trying to bring to linux-kernel, or WTF has happened???
> >
> >
> > No fighting is going on here.  I know lwn.net has already reported about
> > this, see there for details.  I don't have the time to write it up right
> > now due to being at OLS.
> >
> > thanks,
> 
> Ok, is there anywhere else that isn't subscriber-only that has the scoop?
> 
> --
>                                 Brian Gerst
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
