Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbTDZQ2r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 12:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbTDZQ2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 12:28:47 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:50582 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261863AbTDZQ2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 12:28:46 -0400
Date: Sat, 26 Apr 2003 12:25:04 -0400
From: Ben Collins <bcollins@debian.org>
To: Stelian Pop <stelian.pop@fr.alcove.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The IEEE-1394 saga continued... [ was: IEEE-1394 problem on init ]
Message-ID: <20030426162503.GF2774@phunnypharm.org>
References: <20030423145122.GL820@hottah.alcove-fr> <20030423144857.GN354@phunnypharm.org> <20030423152914.GM820@hottah.alcove-fr> <Pine.LNX.4.53L.0304231609230.5536@freak.distro.conectiva> <20030423202002.GA10567@vitel.alcove-fr> <20030423202453.GA354@phunnypharm.org> <20030423204258.GB10567@vitel.alcove-fr> <20030426082956.GB18917@vitel.alcove-fr> <20030426144017.GD2774@phunnypharm.org> <20030426162323.GD18917@vitel.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030426162323.GD18917@vitel.alcove-fr>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 26, 2003 at 06:23:23PM +0200, Stelian Pop wrote:
> On Sat, Apr 26, 2003 at 10:40:18AM -0400, Ben Collins wrote:
> 
> > > Since I reported issues about this 3 days ago, I would have appreciated
> > > being CC:'ed on the patch mail, so I could have reported issues 
> > > like this _before_ such a patch being applied. 
> > 
> > BTW, there are atleast 2 dozen people looking for this patch. I tested
> > it and several others on the linux1394 mailing list tested it. If you
> > want to be more closely involved with linux1394 specifically, then don't
> > expect me to search you out...
> 
> So if I report a bug I must be subscribed to your list to get the answer,
> that's it ? 
> 
> You don't have to 'come search me out'. *I* sent you a bug report, the least
> you could do is to CC: me on the answers. (Or gently tell me that this is
> a known bug being discussed on your list and inviting me to go there to
> find the answers).

I already told you I could reproduce the bug and that it was known. The
fact that i fixed it for myself is enough for me to know I fixed it for
you too.

Now if I couldn't reproduce the bug, I'd go back to you in a attempt to
test patches and pinpoint the problem. That just isn't the case here.
Once I reproduce the problem, your job is done.

> > come to us where our development happens.
> > We have a commit list to the repo and a developers list.
> 
> As I said in the previous mail, I did check the archives and saw nothing
> trivially relevant. But of course, I could have missed something.

Then you must not be looking in the proper place.

> > I've never sent my patches to the list prior to inclusion in the kernel,
> > and a lot of folks don't, depending on neccessity. I don't see the need
> > to start now, not when interested parties have a place to go to see the
> > patches before hand anyway.
> 
> Keeping the development discussions on your own list is of course ok,
> but I believe posting an announce on lkml each time you send something
> for inclusion in the main kernel would be a good idea. Especially when
> you're not sending patches every day and when your patches tend to be
> considerably big.
> 
> This is what (a lot of) other subsystem maintainers do.

But not all...I personally choose to keep specific discussions about
linux1394 on the linux1394 mailing lists. That's not to say I wont
respond on this list, but it is to say that if I announce something
important, it will be there and only there.

Sounds to me like you want to be in the middle of me and Marcelo. That
neither I nor him have the ability to agree on what patches should and
should not be moved from Linux1394 to the 2.4.x tree. Do you want either
or both of our jobs?

The fact is that the current 2.4.21-rc+bk tree is more stable for
ieee1394 than it was in 2.4.20. The only drawback at this point in time
is the fact that you have to run a single script for sbp2 to scan scsi
devices. I could fill a page with the things that are fixed. I have
_zero_ bug reports about the current tree other than a nagging problem
with a rare TI chip that doesn't seem to fit into OHCI specs too well.

No crashes, no lockups...now that's progress over 2.4.20's ieee1394
tree. I can tell you 20 ways to crash that with something as simple as
replugging a device.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
