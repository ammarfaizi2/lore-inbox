Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266081AbTAHK6P>; Wed, 8 Jan 2003 05:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266095AbTAHK6P>; Wed, 8 Jan 2003 05:58:15 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:39949
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S266081AbTAHK6L>; Wed, 8 Jan 2003 05:58:11 -0500
Date: Wed, 8 Jan 2003 03:05:04 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: venom@sns.it
cc: Larry McVoy <lm@bitmover.com>, Matthias Andree <matthias.andree@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Honest does not pay here ...
In-Reply-To: <Pine.LNX.4.43.0301081058320.28725-100000@cibs9.sns.it>
Message-ID: <Pine.LNX.4.10.10301080249330.421-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Luigi,

I have finally determined that nobody really gives a flying flip what you
do or what ship.  Nobody cares.

I have made more noise than a jackass in tin barn.

Trying to grab the attention of peer developers.
There are binary modules out there left and right.
Many are dirty, many are okay, many do not give a rip.
I have seen and know of lots of them.
The really bad ones I laugh in the face of the vendor.
Then there are the really slick ones, which I suspect can spoof anything.

I have asked for people to object, and only one person really has.

I have pissed off everyone.
While searching for the exact line of where things are black and white.
Nobody cares enough to help clear the air.
Nobody cares to pursue any of the existing binary modules.

I just do not get it anymore.
I guess I will shutup and do whatever.
Maybe I will get sued maybe I will not.

Regards,

Andre Hedrick
LAD Storage Consulting Group

Sorry for buggy everyone.
Sorry for asking first, instead of just doing it with thumb on nose.
Sorry most that I never found an answer.
Guess I need to listen to a lawyer.

On Wed, 8 Jan 2003 venom@sns.it wrote:

> 
> if I understand your point, a vendor could ask to the end user to apply a patch
> to the new kernels, so that modules infrastructure will be changed, and also non
> GPLed modules can create their own run queue.
> 
> 
> Yes, it is possible, because we are talking about open source (I mean a more
> generic definition instead of free-software, i.e. all the software that comes
> with source code). I would add, it's in the rules of the game.
> But developers for this patch have to be paid, and
> patch could create conflicts, and has to be maintained togheter with the
> binary only module (depends on costs).
> 
> To say the truth, I do not even expect end users to care if the modules is
> running with its own kernel threads in his own run queue, or it is using the
> defaul queue.
> 
> Anyway I found the runqueue concept, as it has been implemented, an
> equilibrate and factual solution to incentivate companies to GPL their code,
> and I was surprised that none (except a short allusion from you),
> in two threads took the opportunity to talk about a fact and a good point.
> 
> Luigi Genoni
> 
> 
> On Tue, 7 Jan 2003, Andre Hedrick wrote:
> 
> > Date: Tue, 7 Jan 2003 17:10:41 -0800 (PST)
> > From: Andre Hedrick <andre@linux-ide.org>
> > To: venom@sns.it
> > Cc: Larry McVoy <lm@bitmover.com>, Matthias Andree <matthias.andree@gmx.de>,
> >      linux-kernel@vger.kernel.org
> > Subject: Re: Honest does not pay here ...
> >
> >
> > Luigi,
> >
> > You forgot one thing.  None of us can control what the end user does.
> > If a vendor tells the enduser to alter the 2.5/2.6 kernel and recompile.
> > What are you going to do?
> >
> > Add a clause where the enduser can not change the source code or apply a
> > patch to do it for them?
> >
> > Funny, you lost your rights to do that w/ GPL, as did I.
> >
> > *sigh*
> >
> > Andre Hedrick
> > LAD Storage Consulting Group
> >
> > On Wed, 8 Jan 2003 venom@sns.it wrote:
> >
> > >
> > > well, I was forgetting to specify,
> > > queues are kernel threads, and that is quite
> > > optimum expecially on SMP systems.
> > > One big advantage is that conflicts possibilities are
> > > (should be) less than minimal.
> > >
> > > Luigi
> > >
> > > On Tue, 7 Jan 2003, Larry McVoy wrote:
> > >
> > > > Date: Tue, 7 Jan 2003 16:30:50 -0800
> > > > From: Larry McVoy <lm@bitmover.com>
> > > > To: venom@sns.it
> > > > Cc: Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org,
> > > >      andre@linux-ide.org
> > > > Subject: Re: Honest does not pay here ...
> > > >
> > > >
> > > > > In very semplicistic words:
> > > > > In 2.5/2.6 kernels, non GPL modules have a big
> > > > > penalty, because they cannot create their own queue, but have to use a default
> > > > > one.
> > > >
> > > > I may be showing my ignorance here (won't be the first time) but this makes
> > > > me wonder if Linux could provide a way to do "user level drivers".  I.e.,
> > > > drivers which ran in kernel mode but in the context of a process and had
> > > > to talk to the real kernel via pipes or whatever.  It's a fair amount of
> > > > plumbing but could have the advantage of being a more stable interface
> > > > for the drivers.
> > > >
> > > > If you think about it, drivers are more or less open/close/read/write/ioctl.
> > > > They need kernel privileges to do their thing but don't need (and shouldn't
> > > > have) access to all the guts of the kernel.
> > > >
> > > > Can any well traveled driver people see this working or is it nuts?
> > > > --
> > > > ---
> > > > Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm
> > > >
> > >
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > >
> >
> 

