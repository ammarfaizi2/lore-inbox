Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263303AbTLXEBt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 23:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263343AbTLXEBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 23:01:49 -0500
Received: from herald.cc.purdue.edu ([128.210.11.29]:18661 "EHLO
	herald.cc.purdue.edu") by vger.kernel.org with ESMTP
	id S263303AbTLXEBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 23:01:47 -0500
Date: Tue, 23 Dec 2003 23:01:45 -0500 (EST)
From: "alex.g.goddard.1" <agoddard@purdue.edu>
X-X-Sender: agoddard@herald.cc.purdue.edu
To: linux-kernel@vger.kernel.org
Subject: Re: DevFS vs. udev
In-Reply-To: <E1AYvs0-0000Xp-3G@O.Q.NET>
Message-ID: <Pine.SOL.4.51.0312232236170.1447@herald.cc.purdue.edu>
References: <E1AYvs0-0000Xp-3G@O.Q.NET>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Dec 2003, Bradley W. Allen wrote:

> The main problem is documentation, as you pointed out.  I went to
> "make menuconfig" in the new stable kernel, and ran into this problem
> head-on:  help for that option says that it is either depracated
> or obsolete, and after using it without big problems for a long
> time, I wanted to know why.  Everything I saw after that smelled
> bad, and I'm saying so, but that may not mean that it is.  It was
> so bad I didn't even read the "paper" about why on one of the
> referenced web sites.  Also, my old 3 year archive via USENET
> of linux-kernel no longer exists within my grasp (not any fault of
> mine), so I'm forced to use web archive access, and it's hard to
> navigate in those.

http://marc.theaimsgroup.com/?l=linux-kernel&m=105851630726585&w=2

>From the first page of results for 'devfs deadlock'.  That you didn't read
the udev paper (what?  Can't Google for 'udev OLS 2003'?  Or snag the URL
from the udev FAQ?) is just laziness.  It "smelled bad"?  I don't see much
evidence of you attempting to see if your instinct regarding udev's odor
was correct or not.

Not that saying this will help much, but can we please avoid any more
baseless, unresearched "udev is teh suck!" threads for a while?  I'm sure
Greg would welcome well thought out, researched criticism, but there's
been quite a rash of the unresearched, thoughtless kind of late.

> Moving kernel functions into user space has always been a pet peeve of
> mine:  why do it, when it just means shuffling back and forth between
> system calls and user processes ... if that's what is actually happening
> ... unless that's not what's happening ...  I'll have to research this
> myself at some other time.

You can respond to this off-list (in fact, I'd rather you do so), but out
of curiosity where do you draw the line between things that should be in
the kernel and things that shouldn't be?  Should we shove the GUI down
into the kernel?

[snip]

> Sure, I could continue to use DevFS, but if as you said, it's not
> going to be around long, then I could be in trouble for depending
> on it.

As someone else pointed out, deprecation doesn't mean it's going away in
the next few months, or even any time this year or during 2004.  In fact,
you can still use devfs.  Read up on the problems with it, and be prepared
for what that might mean for your system.

Please, please, please in the future see if your instincts are
well-founded before launching another thread like this (whether it's about
udev or anything else).  Not that my saying this here and now is going to
help much when the next person who can't be bothered to find out whether
his criticism is well-founded comes along...

-- 
Alex Goddard
agoddard at purdue dot edu
Another one of the sane Gentoo users
