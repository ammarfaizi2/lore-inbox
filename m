Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286795AbRLVPD3>; Sat, 22 Dec 2001 10:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286792AbRLVPDS>; Sat, 22 Dec 2001 10:03:18 -0500
Received: from eos.telenet-ops.be ([195.130.132.40]:60139 "EHLO
	eos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S286796AbRLVPDP>; Sat, 22 Dec 2001 10:03:15 -0500
Date: Sat, 22 Dec 2001 16:03:15 +0100 (CET)
From: Dirk Moerenhout <dirk@staf.planetinternet.be>
X-X-Sender: <dmoerenh@dirk>
To: Jeff Mcadams <jeffm@iglou.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure.hel
 p.
In-Reply-To: <20011222075343.A29939@iglou.com>
Message-ID: <Pine.LNX.4.33.0112221538560.214-100000@dirk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Dec 2001, Jeff Mcadams wrote:

> Also sprach Mikael Abrahamsson
> >On Thu, 20 Dec 2001 ncw@axis.demon.co.uk wrote:
> >> Actually a 1 Mb/s connection is 1024000 bits/second (ie not 1000000
> >> or 1048576 bits/second).
>
> >But gigabit ethernet is clocked at 1.25GHz with 8b10-encoding, meaning
> >you'll get literally 1.000.000.000 bits/second over that line. As far
> >as I know this is true for all kinds of ethernet.
>
> >Basically, it's only when it comes to memory terms that we use 1024 as
> >a base.
>
> Again..."Uhm...no."
>
> Ethernet isn't the only networking technology out there.

While there are, historically 1Mb/s has allways been 1.000.000. The
misconception about it not being 1.000.000 is cause people associate it
with bytes. Though it's not because bits make up bytes that bits are
naturally forced to "live" on byte boundaries. As clock pulse generators
generally don't really live on byte boundaries either there was never a
real reason to make 1Mb/s related to bytes (or to make 1Kb/s related to
bytes). When referring to byte-bound data transfer speed you can stick to
xB/s instead of xb/s.

As an example, your Serial port doesn't exactly think of bits in
groups of 1024 either.

So in general your best bet is to see 1Kb/s as 1.000 bits per second and
1Mb/s as 1000Kb/s or 1.000.000b/s. As most technologies will stick to
that. Though off course through the ages a lot of things have been altered
it and therefor have added to the confusion.

Dirk Moerenhout ///// System Administrator ///// Planet Internet NV

