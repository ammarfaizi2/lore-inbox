Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267641AbTAHBDi>; Tue, 7 Jan 2003 20:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267642AbTAHBDi>; Tue, 7 Jan 2003 20:03:38 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:9741 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S267641AbTAHBDg>; Tue, 7 Jan 2003 20:03:36 -0500
Date: Tue, 7 Jan 2003 17:10:41 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: venom@sns.it
cc: Larry McVoy <lm@bitmover.com>, Matthias Andree <matthias.andree@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Honest does not pay here ...
In-Reply-To: <Pine.LNX.4.43.0301080152130.25245-100000@cibs9.sns.it>
Message-ID: <Pine.LNX.4.10.10301071659480.421-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Luigi,

You forgot one thing.  None of us can control what the end user does.
If a vendor tells the enduser to alter the 2.5/2.6 kernel and recompile.
What are you going to do?

Add a clause where the enduser can not change the source code or apply a
patch to do it for them?

Funny, you lost your rights to do that w/ GPL, as did I.

*sigh*

Andre Hedrick
LAD Storage Consulting Group

On Wed, 8 Jan 2003 venom@sns.it wrote:

> 
> well, I was forgetting to specify,
> queues are kernel threads, and that is quite
> optimum expecially on SMP systems.
> One big advantage is that conflicts possibilities are
> (should be) less than minimal.
> 
> Luigi
> 
> On Tue, 7 Jan 2003, Larry McVoy wrote:
> 
> > Date: Tue, 7 Jan 2003 16:30:50 -0800
> > From: Larry McVoy <lm@bitmover.com>
> > To: venom@sns.it
> > Cc: Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org,
> >      andre@linux-ide.org
> > Subject: Re: Honest does not pay here ...
> >
> >
> > > In very semplicistic words:
> > > In 2.5/2.6 kernels, non GPL modules have a big
> > > penalty, because they cannot create their own queue, but have to use a default
> > > one.
> >
> > I may be showing my ignorance here (won't be the first time) but this makes
> > me wonder if Linux could provide a way to do "user level drivers".  I.e.,
> > drivers which ran in kernel mode but in the context of a process and had
> > to talk to the real kernel via pipes or whatever.  It's a fair amount of
> > plumbing but could have the advantage of being a more stable interface
> > for the drivers.
> >
> > If you think about it, drivers are more or less open/close/read/write/ioctl.
> > They need kernel privileges to do their thing but don't need (and shouldn't
> > have) access to all the guts of the kernel.
> >
> > Can any well traveled driver people see this working or is it nuts?
> > --
> > ---
> > Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm
> >
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

