Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262706AbTCYQIx>; Tue, 25 Mar 2003 11:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262708AbTCYQIx>; Tue, 25 Mar 2003 11:08:53 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:14341 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S262706AbTCYQIv>; Tue, 25 Mar 2003 11:08:51 -0500
Date: Tue, 25 Mar 2003 11:15:42 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Nicholas Wourms <nwourms@myrealbox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: reiserfs oops [2.5.65]
In-Reply-To: <3E7CBB27.8090506@myrealbox.com>
Message-ID: <Pine.LNX.3.96.1030325110717.1437D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Mar 2003, Nicholas Wourms wrote:

> Randy.Dunlap wrote:
> [SNIP]
> > 
> > I've done some 2.5.xyz work on kmsgdump (dump kernel messages to
> > floppy).  I'll try to get back to it soon.
> > 
> 
> Thank you!  That'd be a god-send for those of us w/o serial 
> ports and who have very cramped hands from hand-copying 
> panics :-D.  Frankly, I can't imagine why something a simple 
> as this isn't in the kernel.  Technically, it isn't a 
> debugger, so I don't think it violates Linus' "No Kernel 
> Debuggers in the Kernel" rule.

I have the feeling from Linus' reaction to the "dump to hd partiton"
feature, that he is all developer with little professional (paid to de
what someone else wants) admin experience. I tried to explain that
machines many timezones away in a secured environment make it hard to read
a console (none), insert a floppy, or use a serial cable. I actually
looked at serial, it would take (a) a capital budget for the cable, (b) a
labor budget for a cleared consultant to plug it in, (c) approval of the
network group because it's a data cable, and (d) a security analysis of
the risks of connecting two secure machines.

And of course the identical machines I can touch don't have that failure
mode :-(

Anyway you are not likely to see that in the official kernel unless Linus
has a change of heart, but you can patch it in so that's not critical,
just one more issue if you have to justify Linux vs. AIX or Solaris in a
bid.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

