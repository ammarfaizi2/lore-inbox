Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314811AbSHIRUZ>; Fri, 9 Aug 2002 13:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314938AbSHIRUZ>; Fri, 9 Aug 2002 13:20:25 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:28945 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S314811AbSHIRUY>; Fri, 9 Aug 2002 13:20:24 -0400
Date: Fri, 9 Aug 2002 13:16:56 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Andre Hedrick <andre@linux-ide.org>
cc: Nick Orlov <nick.orlov@mail.ru>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pdc20265 problem.
In-Reply-To: <Pine.LNX.4.10.10208080344290.24560-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.3.96.1020809131136.23512A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2002, Andre Hedrick wrote:

> On Wed, 7 Aug 2002, Bill Davidsen wrote:
> 
> > I would just as soon use a boot option as to try and make it a compile
> > option, and I think that many people just use a compiled kernel and never
> > change, which argues for a reasonable default (most pdc20265) ARE
> > currently offboard, and an easy way to change it.
> 
> There are ZERO pdc20265's offboard, only pdc20267's were in both options.
> This is the direct asic packaging.  Thus all pdc20265 have the right to be
> listed as onboard.  If you have a pdc20265 on an add-on card please send
> me a digital photo so I can question promise as to why.

I probably should have said non-primary, but the issue is the the pdc now
may be identified before the built-in IDE, such as VIA. If Linux doesn't
identify hda as the same drive as the BIOS, interesting boot problems
occur. And if 2.4.18 did one thing and 2.4.19 did another it gets even
more likely to confuse the user.

I think the real issue is if we should change the order of detection in a
stable kernel series, and I'll just sit and watch the sparks, there seem
to be strong feelings both ways.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

