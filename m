Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287770AbSAAHBL>; Tue, 1 Jan 2002 02:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287769AbSAAHBD>; Tue, 1 Jan 2002 02:01:03 -0500
Received: from smtp002pub.verizon.net ([206.46.170.181]:48054 "EHLO
	smtp002pub.verizon.net") by vger.kernel.org with ESMTP
	id <S285169AbSAAHAs>; Tue, 1 Jan 2002 02:00:48 -0500
Date: Tue, 1 Jan 2002 02:00:01 -0500 (EST)
From: Werner Puschitz <werner.lx@verizon.net>
X-X-Sender: <werner.lx@localhost.localdomain>
To: Rob Landley <landley@trommello.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Re: Framebuffer...Why oh Why???
In-Reply-To: <20020101054301.YWGP617.femail27.sdc1.sfba.home.com@there>
Message-ID: <Pine.LNX.4.33.0201010152190.3557-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Dec 2001, Rob Landley wrote:

> On Sunday 30 December 2001 07:19 pm, Linus Torvalds wrote:
> > On Sun, 30 Dec 2001, Timothy Covell wrote:
> > > 	When X11 locks up, I can still kill it and my box lives.  When
> > > framebuffers crash, their is no recovery save rebooting.  Back in 1995
> > > I thought that linux VTs and X11 implemenation blew Solaris out of the
> > > water, and now we want throw away our progress?  I'm still astounded
> > > by the whole "oooh I can see  a penquin while I boot-up" thing?
> > > Granted, frame buffers have usage in embedded systems, but do they
> > > really have to be so deeply integrated??
> >
> > They aren't.
> >
> > No sane person should use frame buffers if they have the choice.
> >
> > Like your mama told you: "Just say no". Use text-mode and X11, and be
> > happy.
> >
> > Some people don't have the choice, of course.
> >
> > 		Linus
> 
> X11 isn't always an improvement.  I've got an X hang on my laptop (about once 
> a week) that freezes the keyboard and ignores mouse clicks.  Numlock doesn't 
> change the keyboard LEDs, CTRL-ALT-BACKSPACE won't do a thing, and although I 
> can ssh in and run top (and see the CPU-eating loop), kill won't take X down 
> and kill-9 leaves the video display up so the console that thinks it's in 
> text mode, but isn't, is still useless.  (And that's assuming I'm plugged 
> into the network and have another box around to ssh in from...)
> 
> Compiling a debug version of X to run under gdb via ssh is on my to-do list...
> 
> A userspace program that takes over your main I/O devices modally and keeps 
> them if it hangs isn't THAT much better than having the kernel ignore you 
> directly...

I'm having the exact same problems on my ThinkPad 390X. Sometimes it
freezes several times a day with the exact same symptoms. RedHat 6.2
worked fine on this laptop. The problems started with 7.1 which uses 
XFree86 4.0, and it didn't get better with 7.2 (XFree86 4.1).
What makes it even worse is that after a warm reboot, the screen and 
keyboard locks up again as soon as gdm gets started (Numlock doesn't work 
etc.). So I always have to turn off the power to get the laptop working 
again.

Werner


