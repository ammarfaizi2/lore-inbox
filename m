Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316548AbSFDSy5>; Tue, 4 Jun 2002 14:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316477AbSFDSy5>; Tue, 4 Jun 2002 14:54:57 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:12812 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S315447AbSFDSyz>; Tue, 4 Jun 2002 14:54:55 -0400
Date: Tue, 4 Jun 2002 14:50:39 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Derek Vadala <derek@cynicism.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-raid@vger.kernel.org
Subject: Re: RAID-6 support in kernel?
In-Reply-To: <Pine.GSO.4.21.0206021721120.15478-100000@gecko.roadtoad.net>
Message-ID: <Pine.LNX.3.96.1020604144204.5024D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Jun 2002, Derek Vadala wrote:

> You can always fake this effect by combining two 8-disk RAID-5s into a
> RAID-0. It's not technically RAID-6, but can withstand a 2-disk failure,
> although not _any_ 2-disk failure. However, it's my understanding that
> RAID-6 cannot withstand _any_ two disk failure either (see the above
> thread). 

I think (hope) you meant 1+5, which will stand any three disk failure, and
up to 1+N/2 if just the right drives fail. They never do, of course.
 
> I also suspect that the use of dual RAID-5s combined with the CPU overhead
> of ATA will kill most systems under any kind of load. For that matter, the
> 2x parity hit from RAID-6 probably wouldn't make you CPU too happy either,
> even if there was a kernel driver that implemented it.

I doubt it. Unless you run a system with heavy CPU demand there are lots
of cycles for this stuff. I run 0+1 several places and I don't see serious
CPU load. I would be very interested in RAID-6 in the kernel, but I have
the feeling that RAID-6 means diferent things to diferent people, judging
from posts here and articles online. I haven't found the performance info
you, I assume I will.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

