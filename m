Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbWBBWPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWBBWPU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 17:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbWBBWPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 17:15:20 -0500
Received: from mail.acc.umu.se ([130.239.18.156]:40368 "EHLO mail.acc.umu.se")
	by vger.kernel.org with ESMTP id S932342AbWBBWPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 17:15:17 -0500
Date: Thu, 2 Feb 2006 23:15:12 +0100
From: David Weinehall <tao@acc.umu.se>
To: Michael Loftis <mloftis@wgops.com>
Cc: Doug McNaught <doug@mcnaught.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Valdis.Kletnieks@vt.edu,
       dtor_core@ameritech.net, James Courtier-Dutton <James@superbug.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <20060202221512.GJ20484@vasa.acc.umu.se>
Mail-Followup-To: Michael Loftis <mloftis@wgops.com>,
	Doug McNaught <doug@mcnaught.org>,
	Russell King <rmk+lkml@arm.linux.org.uk>, Valdis.Kletnieks@vt.edu,
	dtor_core@ameritech.net,
	James Courtier-Dutton <James@superbug.co.uk>,
	linux-kernel@vger.kernel.org
References: <d120d5000601200850w611e8af8v41a0786b7dc973d9@mail.gmail.com> <30D11C032F1FC0FE9CA1CDFD@d216-220-25-20.dynip.modwest.com> <200601201903.k0KJ3qI7006425@turing-police.cc.vt.edu> <E27F809F04C1C673D283E84F@d216-220-25-20.dynip.modwest.com> <20060120200051.GA12610@flint.arm.linux.org.uk> <5793EB6F192350088E0AC4CE@d216-220-25-20.dynip.modwest.com> <87slrio9wd.fsf@asmodeus.mcnaught.org> <25D702FB62516982999D7084@d216-220-25-20.dynip.modwest.com> <20060202121653.GI20484@vasa.acc.umu.se> <67A0AFFBC77C32B9DEE25EFA@dhcp-2-206.wgops.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67A0AFFBC77C32B9DEE25EFA@dhcp-2-206.wgops.com>
User-Agent: Mutt/1.4.2.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pub_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2006 at 11:25:24AM -0700, Michael Loftis wrote:
> --On February 2, 2006 1:16:53 PM +0100 David Weinehall <tao@acc.umu.se> 
> wrote:
[snip]
> 
> The problem is that there's no more stable kernel first, and secondly that 
> there's not much if any pointers abotu the change.  People complained I 
> didn't have specific problems to solve, I don't CARE abotu any specific 
> problems.  I could hardly give a rats ass about devfs.  It's the whole new 
> development model that's the problem, and will only get worse for the 
> types of companies who I work with who normally right now support Linux 
> development.  I only brought up devfs because certain members of the 
> community can't see past bootstrings to the bigger issue.

If you don't give a rats ass about devfs (good!), don't bring it into
the discussion in the first place; it's not like that horse hasn't been
flogged to death already...

[snip]
> There's noone out there that does that, I'd LOVE to be able to pay for it 
> and not have to do it myself.

And there is a reason that there's noone out there that does it.
There's no community to do it, because it's too time consuming, with
little or no gain, and there's no commercial effort, because noone
has publicly announced, that "Hey, I'm willing to fork up EUR50000
per year to have (say) 2.6.14 maintained indefinitely as a stable
kernel branch with only security fixes, important bugfixes,
and minor device driver backports".  If you do, I bet someone will
come running.

[not biting the distro kernel bullet]

> Further, I'm not the only one.  I'm the only one who has enough asbestos 
> to jump onto LKML and say it because they all know that it's completely 
> hostile in here when someone brings up something that looks like a major 
> issue.

Ahhh.  The silent majority.  Yup, always a good backup to lean on.

> >o You think that 2.4.x isn't supporting enough new hardware,
> >  and yet you claim that adding new PCI ID:s is enough to add
> >  support for new hardware in most cases -- check
> 
> No I don't i said in MANY or atleast SOME.  further 2.4 is supposedly
> DEAD anyway.

For running any newer kind of hardware, yes, since the kernel needs
completely new framework for a lot of the new hardware.  And that's
not going to change even if you fork a stable kernel now.  A year from
now, that fork is going to be DEAD too; all development will continue
to go into the development kernel, since that's what all the distros
use (their users want it, to be able to use their new, cool hardware).

[snip]

> And it's only been the best because there's been a way for people to sue 

(I assume you mean use, not sue here?)

> it, get security patches even teh occasional new hardware support when 
> it's not disruptive.  Now that entire development model has changed into 
> something that noone uses because it doesn't' work for a project needing a 
> stable tree, such as a kernel.  It seems most people here just can't 
> understand how it can become a problem unfortunately because they can't 
> really see the big picture.  Everyone wants to take one little piece and 
> go hey hey see that's not a problem and then self satisfied at their 
> attacking and dismissal think they've solved the problem.  This is not a 
> single problem issue.

I think most people here understand that it can be a problem.  The thing
is, however, that since this is a project driven by voluntary developers,
not by commercial interest, there has to be a choice made somewhere:
do we focus on stability, risking to drive the developers away, or do
we focus on a development process which tries to avoid breaking things
in a too bad manner while keeping up the development pace as much as
possible?

The third option you seem to look for -- full stability AND active
development, which *sort of* worked during the old days of kernel
development, simply doesn't scale.  In fact, I'd say that the
development series we have now is a lot more is a lot more stable than
2.2.0 - 2.2.20, and 2.4.0 - 2.4.12 at least.  So what you might look
forward to if we go back to the old development model is one of these
options:

o People leaving the project because the development kernel is too
  broken (most of 2.1 series, part of 2.3-series, big chunks of
  2.5-series), and the stable series is too stale

o The new stable kernel, when branched, is too unstable, since noone
  tested it (because it was unstable)

o The development kernel, while quite unasable, newer ever becomes the
  stable kernel (which is pretty much the situation we have now)

[snip]

> I'm damned sick of the number of people who just *ATTACK* people who 
> contribute.  Constructive criticism is a form of contribution, feedback if 
> those words are too big for some to understand.  Because of the 

yes, *constructive* criticism is a form of contribution.  But your
posts in this thread so far hasn't been very constructive.

> development model changes there are projects not going to use Linux at 
> several companies that I work for contracting.  Because there is no way 
> that any single entity can look at 4+MB of compressed code changes and be 
> able to be even remotely sure that the kernel is going to work, and that's 
> been the case.

How about trying?  And, as mentioned earlier in the thread,
if a company is not prepared to spend money to either hire their own
kernel maintainers or pay someone else to do it, they have to play
by the rules of the community.  If you want to complain, do it by either
submitting bug reports / patches, or by writing checks.

The fact that this is free (and FREE) software means it doesn't cost
you anything to get the sources.  Noone has said that it does not cost
you anything to use it.  It does cost you, either in terms of compromise
(accepting the limitations that are in the kernel, accepting the fact
 that the development happens in different areas than you want it to),
or in terms of support deals.

The fact that free software comes to life to "scratch an itch" does
not mean that the developers necessarily want to scratch *your* itch...

> That combined with the rapid API changes, and noone is 
> developing a long lived stable kernel anymore means that commercial 
> support of this OS is being lost.  I'm in an odd situation where because 
> of NDAs and etc. I can not disclose any real details about the commercial 
> backers, but I'm sure they're not the only ones, and probably much more 
> important ones are getting frustrated.

Ahhh, again the silent majority.

Sure, I *bet* there are commercial companies that lose their interest
in the kernel for various reasons.  If you want a slower development
cycle, why not look at one of the *BSD's?

But if you have the impression that the tide goes away from the Linux
kernel, I'm sorry to disappoint you.  I work for Nokia's OSSO team.
We pushed out a products a few months ago based on the 2.6.1x (cannot
remember, sorry) kernel -- the Nokia 770 Internet Tablet, more and more
several NAS servers are surfacing that are Linux-based, multimedia
devices, cellphones (nothing from Nokia that I'm aware of, but other
companies have several models), etc.

> Informational input can and often is as valuable as code.  Getting someone 
> to think of something they hadn't thought of can save that person or the 
> whole group lots of effors.

If you *really* think that your "insight" was unique, start reading
a bit of backlog on LKML.  This discussion surfaces every few months,
and it always dies, since nobody *ever* comes up with the financial
backing for the effort, nor does anyone step up to do the long time
maintenance.  The 2.6.x.y kernel series did indeed come out of one
of these discussions, but that's it -- if the 6 months of stability
it will bring you isn't enough, pay someone to keep it alive longer.

> So, if you don't have anything USEFUL to retort back, shut up.  I'm 
> getting sick of hearing the people who can't contribute *ANYTHING NEW* to 
> the conversation and I'm in a very short mood.

Don't forget that you started the whole thing, without bring anything
new...  Read LKML, learn from past threads.

> The ... attitude and atmosphere here on LKML when someone brings up 
> something even slightly controversial is detrimental.  I know all of you 
> mean well.  But really.  If you're not contributing then you can stay 
> quiet just as well as the person you're complaining at.

Oh yes, the attitude and atmosphere here is raw and sometimes hostile.
One reason is that most of us get tired when the same useless
discussions resurface again and again and again.  It's one thing
if we get multiple bug reports, but discussions like this does not
really bring anything useful.  It's even less meaningful than the
usual flamewars we have here, and a lot less entertaining than
some of the ravings.

Another reason is that the posts like yours always start out
with something like "This is how things should be instead", or
"We must do this", or "The current foo sucks".

If your post instead had started with "From 2.6.15 and on I'm going to
maintain a stable kernel series which will only contain security fixes,
important bugfixes, and certain driver backports; at first I will do
this alone, but I hope to be able to hire 1-2 full time kernel hackers
to do this job.  Any takers?", I bet you'd have gotten a lot of good
response.

> This thread has been closed for what?   A week now?  I'm working on trying 
> to get the systems that are currently my big problems going, and after 
> that then I can focus more attention on the points I've brought up 
> earlier.  I'm only one person and just because I can't act immediately to 
> do something does not mean I won't.  Any of us who has an extremely busy 
> day job sure can understand that statement.

Yeah, because noone on this list than you has an extremely busy day job,
right?  I do spot your innuendo, but sorry, you're way off target.

I suspect that applies for most/all of the core kernel developers as
well (the ones that you're primarily aiming this at, since it's their
efforts you want to be reorganized).


Regards: David
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
