Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318789AbSIDN7i>; Wed, 4 Sep 2002 09:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318810AbSIDN7i>; Wed, 4 Sep 2002 09:59:38 -0400
Received: from b.mail.peak.org ([198.88.144.71]:28679 "EHLO b.mail.peak.org")
	by vger.kernel.org with ESMTP id <S318789AbSIDN7h>;
	Wed, 4 Sep 2002 09:59:37 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kenneth Corbin <kencx@peak.org>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Linux consistently crashes running grip. (continued)
Date: Wed, 4 Sep 2002 06:51:53 -0700
User-Agent: KMail/1.4.1
References: <Pine.LNX.4.44.0209040257470.28297-100000@balthasar.nuitari.net>
In-Reply-To: <Pine.LNX.4.44.0209040257470.28297-100000@balthasar.nuitari.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209040651.53490.kencx@peak.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 September 2002 12:02 am, Nuitari wrote:
> On Tue, 3 Sep 2002, Kenneth Corbin wrote:
> > Long description of same problem.   Still continuing after dumping the
> > nvidia drivers and upgrading to the latest Redhat kernel.   Anything else
> > I can do?
> >
> > I am not subscribed to this list, please cc me with any response.
> > Thanks in advance for wading through this.
> >
> > 1. Linux consistently crashes running grip.
> >
> > 2. Grip 3.0.1-1 is a graphical X frontend for a variety of CD ripper and
> > MP3 encoder programs.   When it is only ripping CD's everything is OK. 
> > But when it is ripping and encoding tracks, the system will die shortly
> > after the ripping operation finishes while the encoding operation is
> > going on.   The time till death is variable, it has ranged from 5 seconds
> > to 5 minutes on one occasion, but it always crashes.  It happens with two
> > different encoders (notlame and oggenc) and two different rippers
> > (cdparanoia and cdda2wav)  The quickest way to induce a failure is to
> > make one pass ripping tracks and a second pass asking it to rip and
> > encode.  It is smart enough to realize the tracks have already been
> > ripped and doesn't do much beyond checking that they are all accounted
> > for.   But my system still crashes.
> >
> > Gnu C                  2.96
>
> Did you try testing your ram for any defects (even if it means trying
> various combinations of ram) ?
> The only times I had similar problems was when I had faulty ram on my
> motherboard or (in 1 case) a really defective onboard ide controller.
>
> Also be careful with Gcc 2.96, there is a lot of problems related to it.

OK, went looking for hardware diagnostic tools.   memtest86 ran all night 
without reporting any problems.   But cpuburn-1.4 burnK7 locked up almost 
immediately.   Interestingly it seems to do OK in single user mode, but if 
anything else is running things go south very quickly.   Usually it is a 
silent lockup.  In one case I got an Ooops:0002.   Indications are pointing 
toward some kind of hardware problem.  Looks like I need to take this to 
someone who has some real diagnostics, or the resources to swap out parts 
until things start working.   I'll let you know how this turns out.

