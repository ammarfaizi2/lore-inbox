Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964995AbVHYN6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbVHYN6t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 09:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbVHYN6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 09:58:49 -0400
Received: from sun3.sammy.net ([68.162.198.6]:268 "HELO sun3.sammy.net")
	by vger.kernel.org with SMTP id S964995AbVHYN6r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 09:58:47 -0400
Date: Thu, 25 Aug 2005 09:59:05 -0400 (EDT)
From: Sam Creasey <sammy@sammy.net>
X-X-Sender: sammy@sun3
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Paul Jackson <pj@sgi.com>, Paul Mackerras <paulus@samba.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.13-rc7
In-Reply-To: <Pine.LNX.4.62.0508251125030.28348@numbat.sonytel.be>
Message-ID: <Pine.LNX.4.40.0508250954240.17653-100000@sun3>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 25 Aug 2005, Geert Uytterhoeven wrote:

> Can't you use the plain m68k toolchain? I always used a m68k-linux-gcc 3.3.3
> for my uClinux experiments.
>
> > sun3 is seriously broken and I doubt that we'll see any takers for testing
> > 2.6 on those anyway ;-)

Hey, I'm writing this on a sun3! :)

> However, a few months ago it was still known to work in m68k CVS (ask Sammy).
> And I didn't see any real compile regressions since then.

Looks like the last rev which really worked on the sun3 was 2.6.5, which
did work alright from m68k CVS (I did have another patch which needed to
be applied to actually get it to run, but that appears to have been only
fixes for the video/serial drivers, nothing "core").

I have been a little out of it for a while on the sun3 stuffs, I'll admit
(cursed day job), but I really, really intend to get recent 2.6 running
again.  Knowing that the rest of m68k is at least compiling is a good
start point.  Still, I'm going with Geert, and I'm not sure where the
compile regressions would have come from (outside of the video/serial
drivers, which don't compile in m68k CVS either).

What compile failures are you seeing?

-- Sam




