Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271082AbRH1VpL>; Tue, 28 Aug 2001 17:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271142AbRH1VpC>; Tue, 28 Aug 2001 17:45:02 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:59233 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S271082AbRH1Vo5>;
	Tue, 28 Aug 2001 17:44:57 -0400
Message-ID: <20010828234521.A20830@win.tue.nl>
Date: Tue, 28 Aug 2001 23:45:21 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: nick@guardiandigital.com, linux-kernel@vger.kernel.org
Subject: units - was: Re: Determining maximum partition size...
In-Reply-To: <3B82BCCB.377BCC4@guardiandigital.com> <3B82BCCB.377BCC4@guardiandigital.com> <20010828142315.A20775@win.tue.nl> <5.1.0.14.2.20010828134152.04eeaa10@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <5.1.0.14.2.20010828134152.04eeaa10@pop.cus.cam.ac.uk>; from Anton Altaparmakov on Tue, Aug 28, 2001 at 01:53:29PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2001 at 01:53:29PM +0100, Anton Altaparmakov wrote:

> > > I thought maybe Linux set 1MB=1000k but that doesn't seem to case.

> >Well, 1 M = 1000 k by definition of the SI system of units.
> >This has nothing to do with Linux.
> 
> While it is true that M = 10^6 and k = 10^3, surely that doesn't apply to 
> byte quantities?!? At least I have always interpreted 1 Megabyte = 1024 
> kilobytes = 1024*1024 bytes


Ah, an old discussion - I imagine it must have occurred here a few times.
Anyway: k is the prefix for 1000, M is the prefix for 1000000. Always.

But there is a natural sloppiness, where people round numbers when either
the precise size is unimportant, or is clear from the context.
If xyzzies come in boxes of 27 and I say that I bought a hundred xyzzies
then that probably means that in fact I bought 108.

Thus, our old PDP8 with 4k of memory had 4096 12-bit words, that is,
6 KiB in modern terminology.

You see two very different situations here: "precise size is unimportant"
and "precise size is clear from the context". When someone says that she
bought a 10 GB disk I will assume that the precise size is somewhere
between 9.5 and 10.5 GB. This is the "rounded" case.
When someone says that she bought a 32 MB SIMM I will assume that this was
32 MiB, that is, 2^25 bytes, since, unlike disks, memory modules tend to
come in power-of-two units. This is the "clear from the context" case.

Andries
