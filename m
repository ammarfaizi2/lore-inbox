Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263870AbRFGAUj>; Wed, 6 Jun 2001 20:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263390AbRFGAUa>; Wed, 6 Jun 2001 20:20:30 -0400
Received: from femail1.rdc1.on.home.com ([24.2.9.88]:8388 "EHLO
	femail1.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S263334AbRFGAUT>; Wed, 6 Jun 2001 20:20:19 -0400
Date: Wed, 6 Jun 2001 20:20:12 -0400 (EDT)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: "Dr S.M. Huen" <smh1008@cus.cam.ac.uk>
cc: Sean Hunter <sean@dev.sportingbet.com>,
        Xavier Bestel <xavier.bestel@free.fr>, <linux-kernel@vger.kernel.org>
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <Pine.SOL.3.96.1010606103559.20297A-100000@draco.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.33.0106062010210.26171-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
X-Spam-To: uce@ftc.gov
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2001, Dr S.M. Huen wrote:

>> For large memory boxes, this is ridiculous.  Should I have 8GB of swap?
>>
>
>Do I understand you correctly?
>ECC grade SDRAM for your 8GB server costs £335 per GB as 512MB sticks even
>at today's silly prices (Crucial). Ultra160 SCSI costs £8.93/GB as 73GB
>drives.

Linux is all about technical correctness, and doing the job
properly.  It isn't about "there is a bug in the kernel, but that
is ok because a 8Gb swapfile only costs $2"

Why are half the people here trying to hide behind this diskspace
is cheap argument?  If we rely on that, then Linux sucks shit.

The problem IMHO is widely acknowledged by those who matter as an
official BUG, and that is that.  It is also acknowledged widely
by those who can fix the problem that it will be fixed in time.

So technically speaking - the kernel has a widely known
bug/misfeature, which is acknowledged by core kernel developers
as needing fixing, and that it will get fixed at some point.

Saying it is a nonissue due to the cost of hardware resources is
just plain Microsoft attitude and holds absolutely zero technical
merit.

It *IS* an issue, because it is making Linux suck, and is causing
REAL WORLD PROBLEMS.  The use 2x RAM is nothing more than a
bandaid workaround, so don't claim that it is the proper fix due
to big wallet size.

I have 2.2 doing a software build that takes 40 minutes with
256Mb of RAM, and 1G of swap.  The same build on 2.4 takes 60
minutes.  That is 4x RAM for swap.

Lowering the swap down to 2x RAM makes no difference in the
numbers, down to 1x RAM the 2.4 build slows down horrendously,
and droping the swap to 20Mb makes it die completely in 2.4.

2.4 is fine for a firewall, or certain other applications, but
regardless of the amount of SWAP,  I'll take the 40minute build
using 2.2 over the 60minute build using 2.4 anyday.

This is the real world.  And no cost isn't an issue to me.
Putting another 80Gb drive in this box for swap isn't going to
help the work get done any faster.


----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Open Source advocate
       Opinions and viewpoints expressed are solely my own.
----------------------------------------------------------------------

