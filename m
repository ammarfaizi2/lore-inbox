Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280815AbRKGPU1>; Wed, 7 Nov 2001 10:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280816AbRKGPUR>; Wed, 7 Nov 2001 10:20:17 -0500
Received: from ares.sot.com ([195.74.13.236]:18181 "EHLO ares.sot.com")
	by vger.kernel.org with ESMTP id <S280815AbRKGPUJ>;
	Wed, 7 Nov 2001 10:20:09 -0500
Date: Wed, 7 Nov 2001 17:20:07 +0200 (EET)
From: Yaroslav Popovitch <yp@sot.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.12: Missing tty when logging in on the console
In-Reply-To: <XFMail.20011105074614.backes@rhrk.uni-kl.de>
Message-ID: <Pine.LNX.4.10.10111071706080.31120-100000@ares.sot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I have some additinal info:
Switching between terminals by ctrl+alt+Fn I found that sometimes some
consoles use the same tty device,for. tty2. Only one tty-fully
functional.Others have the problems described below.
Sometimes all ttys work properly.

> > ###########################################################
> >  after installation of kernel 2.4.12 (migrated from 2.4.10
> >  by "make oldconfig"), having problems when logging in on
> >  a virtual console:
> >  
> >  It sems that there is no correct tty attached to the console:
> >  
> >  1. the ps command lists _all_ processes actually running under
> >     the correspondent userid and only those running under
> >     the login shell.
> >  
> >  2. Starting a ssh command for some other box is rejected
> >     by
> >  
> >                  You have no controlling tty and no DISPLAY.
> >                  Cannot read passphrase.
> >  
> >  I never had such problems when running 2.4.10 kernel.

