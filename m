Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261377AbSKDPad>; Mon, 4 Nov 2002 10:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264705AbSKDPad>; Mon, 4 Nov 2002 10:30:33 -0500
Received: from excalibur.cc.purdue.edu ([128.210.189.22]:50443 "EHLO
	ibm-ps850.purdueriots.com") by vger.kernel.org with ESMTP
	id <S261377AbSKDPad>; Mon, 4 Nov 2002 10:30:33 -0500
Date: Mon, 4 Nov 2002 10:38:41 -0500 (EST)
From: Patrick Finnegan <pat@purdueriots.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [lkcd-general] Re: What's left over.
In-Reply-To: <aq63kp$9j6$1@forge.intermeta.de>
Message-ID: <Pine.LNX.4.44.0211041034330.16432-100000@ibm-ps850.purdueriots.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Nov 2002, Henning P. Schmiedehausen wrote:

> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
>
> >On Mon, 2002-11-04 at 14:45, Henning P. Schmiedehausen wrote:
> >> Good! This means, people debugging the code have actually to think and
> >> don't produce "turn on debugger, step here, there, patch a band aid,
>
> >Some of us debug hardware. Regardless of the nice theories about
> >reviewing your code they don't actually work on hardware because no
> >amount of code review will let you discover things like undocumented
> >2uS deskew delays, or errors in DMA engines
>
> A debugger won't help you here either. A pci bus probe, a 'scope and a
> logic analyzer do.
>
> (And experience, elbow grease, experience and a nice amount of ESP :-)
> I do hate hardware. Had to debug too much of it (and just on
> m68k/MCS-51 where the clock rates are low and the parts easy to
> solder...).

I find that hard to believe.  You're saying it's impossible to use a
software debugger to debug the interface between the software and the
hardware?  Eg. errors in the hardware that cause periodic anomalies in the
output read by the software would be one thing they could catch, along
with diagnosing that a problem is caused by flaky hardware rather than the
latest not-well-tested VM code.  In that last case, since bad hardware can
usually cause a panic, I see crash dumps as an invaluable resource ;-).
(No Linus, I'm not pushing them, just stating my opinion.)

Pat
--
Purdue Universtiy ITAP/RCS
Information Technology at Purdue
Research Computing and Storage
http://www-rcd.cc.purdue.edu

http://dilbert.com/comics/dilbert/archive/images/dilbert2040637020924.gif



