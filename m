Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314077AbSHGWte>; Wed, 7 Aug 2002 18:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314096AbSHGWte>; Wed, 7 Aug 2002 18:49:34 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:44816 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S314077AbSHGWtd>; Wed, 7 Aug 2002 18:49:33 -0400
Date: Wed, 7 Aug 2002 18:46:55 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Nick Orlov <nick.orlov@mail.ru>
cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pdc20265 problem.
In-Reply-To: <20020807035623.GA3411@nikolas.hn.org>
Message-ID: <Pine.LNX.3.96.1020807183410.14463B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Aug 2002, Nick Orlov wrote:

> On Tue, Aug 06, 2002 at 11:09:14PM -0400, Bill Davidsen wrote:

> > > 3. if we put pdc20265 in "onboard" list on some hardware (mine for example)
> > > pdc20265 is assigned to ide0/1 (even if it's really ide2/3)
> > 
> > Does this matter as long as we can force it to be where we want? 
> 
> But wouldn't it be a cleaner solution if we will have _compile_ time
> option that by default is turned on in order to handle rare cases,
> and _can_ be turned off in order to handle _most_ cases without any
> boot-time options?

Nick, I think that's a matter of taste. I am perfectly happy to default to
using the ideN based on the io address, or any other determanent method,
as long as it's reasonable to have the user specify the order if s/he has
a reason to do so. Of course some BIOS will mess up io addresses at some
time, crappy {hard,firm}ware is a problem in any case.

I would just as soon use a boot option as to try and make it a compile
option, and I think that many people just use a compiled kernel and never
change, which argues for a reasonable default (most pdc20265) ARE
currently offboard, and an easy way to change it.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

