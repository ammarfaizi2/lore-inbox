Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279542AbRJ2VVq>; Mon, 29 Oct 2001 16:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279544AbRJ2VVg>; Mon, 29 Oct 2001 16:21:36 -0500
Received: from fungus.teststation.com ([212.32.186.211]:17164 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S279542AbRJ2VV1>; Mon, 29 Oct 2001 16:21:27 -0500
Date: Mon, 29 Oct 2001 22:22:02 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: Martin Eriksson <nitrax@giron.wox.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: via-rhine and MMIO
In-Reply-To: <009e01c160b5$e48038c0$0201a8c0@HOMER>
Message-ID: <Pine.LNX.4.30.0110292135540.21339-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2001, Martin Eriksson wrote:

> I'll check that out, and if all works fine I'll release a patch. By the way,
> how *do* you measure network performance the best way? What I have done now

You set up 2 or more machines, send data and time it. :)
[Perhaps someone more qualified would like to give some advise here]

There are some networking benchmarks (netperf, ttcp), "ping -f" gives
round-trip times. They should be able to tell if a change makes things 
noticably better or worse.

I've probably missed some important benchmark, go search ...


I doubt that this change is measurable at that level. You could instead
insert some time measuring inside the driver and see if things like
interrupt processing of 10000 interrupts goes from 100x to 99x, for some
unit x.

Did I hear timepegs? http://www.uow.edu.au/~andrewm/linux/,
but that patch hasn't been updated since 2.4.1-pre10-1 :(
It has some other potentially useful stuff, like cyclesoak.

/Urban

