Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314077AbSHFRSr>; Tue, 6 Aug 2002 13:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314083AbSHFRSr>; Tue, 6 Aug 2002 13:18:47 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:31752 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S314077AbSHFRSq>; Tue, 6 Aug 2002 13:18:46 -0400
Date: Tue, 6 Aug 2002 13:31:56 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: jt@hpl.hp.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.4.20-pre1
In-Reply-To: <20020806171736.GC11313@bougret.hpl.hp.com>
Message-ID: <Pine.LNX.4.44.0208061331260.7534-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Aug 2002, Jean Tourrilhes wrote:

> On Tue, Aug 06, 2002 at 09:33:45AM -0300, Marcelo Tosatti wrote:
> >
> >
> > On Mon, 5 Aug 2002, Jean Tourrilhes wrote:
> >
> > > 	Hi,
> > >
> > > 	Sorry to disturb, but it seems that kernel.org didn't pick up
> > > 2.4.20-pre1 (or I'm looking at the wrong places).
> > >
> > > 	I'm asking because I've just finished testing my IrDA update
> > > for 2.4.20, and you've just included some useless IrDA change that
> > > probably render my patch worthless
> >
> > What you mean I included some useless IrDA patch?
>
> 	Yep, tons of these :
> -----------------------------------------------
> -        IRDA_DEBUG(4, __FUNCTION__ "(), speed=%d (was %d)\n", speed,
> -		   self->speed);
> +        IRDA_DEBUG(4, "%s(), speed=%d (was %d)\n", __FUNCTION__,
> +        	speed, self->speed);
> -----------------------------------------------
> 	Between this and fixing a Oops or Deadlock, I'll take the
> second any day.
> 	I don't care on those patch in general, I'm not a control
> freak, except that being so pervasive they are guaranteed to screw up
> my own patches. That's why yesterday I *explicitely* asked you and
> Alan if anything was pending, so that I could avoid wasting my time
> and instead wait for the next release doing something else.
> 	I guess it's too late, I already wasted my afternoon.
>
> 	The second thing that bugs me is that because those patches
> pass behind my back, they won't get applied to *both* 2.4.X and
> 2.5.X. Because of that, keeping 2.4.X and 2.5.X in synch is an
> exercise in futility.
> 	But maybe you are finding that there is already too many IrDA
> maintainers.
>
> 	I'll send you the Wireless patches, and I'll try to respin the
> IrDA patches this afternoon (i.e. please screw me again !).

I can back out those patches if you want. Will that help you?

