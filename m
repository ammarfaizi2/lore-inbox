Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282670AbRLOOF2>; Sat, 15 Dec 2001 09:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282683AbRLOOFK>; Sat, 15 Dec 2001 09:05:10 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:19893 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S282670AbRLOOEz>;
	Sat, 15 Dec 2001 09:04:55 -0500
Date: Sat, 15 Dec 2001 15:03:27 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: Linus Torvalds <torvalds@transmeta.com>, Simon Kirby <sim@netnation.com>,
        Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill(-1,sig)
In-Reply-To: <200112151019.fBFAJgS235075@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.21.0112151501480.21018-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Dec 2001, Albert D. Cahalan wrote:

> Linus Torvalds writes:
> > On Fri, 14 Dec 2001, Simon Kirby wrote:
> 
> >> it kills everything _and_ itself.  I frequently use "kill -9 -1" to kill
> >> everything except my shell, and now I'll have to kill everything else
> >> manually, one by one.
> >
> > I do agree, I've used "kill -9 -1" myself.
> 
> This means: EVERYTHING DIE DIE DIE!!!!
> 
> On a Digital UNIX system, I do "/bin/kill -9 -1" often. I expect it to
> kill the shell. This is a nice way to quickly log out and wipe out any
> background processes that might try to save state or continue running.

Works the same way in Solaris. 'kill -9 -1' kills your running shell
aswell.


/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.

