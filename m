Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264755AbSLFQkA>; Fri, 6 Dec 2002 11:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264760AbSLFQkA>; Fri, 6 Dec 2002 11:40:00 -0500
Received: from rakis.net ([216.235.252.212]:44685 "EHLO egg.rakis.net")
	by vger.kernel.org with ESMTP id <S264755AbSLFQj6>;
	Fri, 6 Dec 2002 11:39:58 -0500
Date: Fri, 6 Dec 2002 11:47:35 -0500 (EST)
From: Greg Boyce <gboyce@rakis.net>
X-X-Sender: gboyce@egg
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Dazed and Confused
In-Reply-To: <1039190719.22971.15.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.42.0212061133330.7770-100000@egg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Dec 2002, Alan Cox wrote:

> On Fri, 2002-12-06 at 14:55, Greg Boyce wrote:
> > I work in a company with a large number of Linux machine deployed all
> > around the country, and in some of the machines we've been seeing the
> > following error:
> >
> > Uhhuh. NMI received. Dazed and confused, but trying to continue
> > You probably have a hardware problem with your RAM chips
>
> There are several causes of an NMI depending on the system - hardware
> failures is one, some systems do it for things like PCI errors, a few
> boxes you see them on power management events (notably old 486's)
>
> > Due to the number of machines and their locations, running memtest86 on
> > them isn't exactly feasible.
>
> Then buy better ram ;)

We have a large number of a very small number of machine types.  The
OS images installed are identical, and the bioses should be identical
between each individual machine types.

Since the number of machines reporting this error are pretty small, I
think it's unlikely to be power management, or anything like that.

> > Is there anything besides failing hardware that could be the cause of this
> > error?  Also, how serious is this error?  Some of the machines reporting
> > this error have had problems with programs crashing, while others seem to
> > run fine.
>
> Take a sample set of machines which have been crashing and run memtest86
> on a couple. That should tell you if it is RAM. From a sample you can
> then figure out how to handle the rest (things that come to mind if
> memtest86 fails on the test machines include replacing the ram in a few
> more then taking the old ram back to test)

I'll mention it to the people who handle the replacement of hardware, but
from the sounds of this and Dick's e-mail, it's most likely hardware of
some sort or possibly overheating.  They can decide if they want to try to
figure out which component is causing the problem, or if they'd prefer to
just replace the faulty machines completely and worry about tracking the
component later.  We have plenty of spares in the warehouse.

Thanks for the help,

Greg

