Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314446AbSHFRZw>; Tue, 6 Aug 2002 13:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314459AbSHFRZv>; Tue, 6 Aug 2002 13:25:51 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:19698 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314446AbSHFRZo>; Tue, 6 Aug 2002 13:25:44 -0400
Subject: Re: Linux 2.4.20-pre1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jt@hpl.hp.com
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020806171736.GC11313@bougret.hpl.hp.com>
References: <20020806002126.GA10585@bougret.hpl.hp.com>
	<Pine.LNX.4.44.0208060933070.7302-100000@freak.distro.conectiva> 
	<20020806171736.GC11313@bougret.hpl.hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 06 Aug 2002 19:48:22 +0100
Message-Id: <1028659702.18156.185.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-06 at 18:17, Jean Tourrilhes wrote:
> 	Yep, tons of these :
> -----------------------------------------------
> -        IRDA_DEBUG(4, __FUNCTION__ "(), speed=%d (was %d)\n", speed, 
> -		   self->speed);
> +        IRDA_DEBUG(4, "%s(), speed=%d (was %d)\n", __FUNCTION__,
> +        	speed, self->speed);
> -----------------------------------------------
> 	Between this and fixing a Oops or Deadlock, I'll take the
> second any day.

I'd prefer to be able to read the errors too but yes.

> Alan if anything was pending, so that I could avoid wasting my time
> and instead wait for the next release doing something else.
> 	I guess it's too late, I already wasted my afternoon.

By the time you asked I'd sent them

> 	The second thing that bugs me is that because those patches
> pass behind my back, they won't get applied to *both* 2.4.X and
> 2.5.X. Because of that, keeping 2.4.X and 2.5.X in synch is an
> exercise in futility.

I sent them to the maintainer. 


IRDA SUBSYSTEM
P:      Dag Brattli
M:      Dag Brattli <dag@brattli.net>
L:      linux-irda@pasta.cs.uit.no
W:      http://irda.sourceforge.net/
S:      Maintained


If thats wrong, then thats why you never found out.

