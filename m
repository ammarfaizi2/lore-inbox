Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316712AbSHGDLs>; Tue, 6 Aug 2002 23:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316715AbSHGDLs>; Tue, 6 Aug 2002 23:11:48 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:22544 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316712AbSHGDLr>; Tue, 6 Aug 2002 23:11:47 -0400
Date: Tue, 6 Aug 2002 23:09:14 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Nick Orlov <nick.orlov@mail.ru>
cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pdc20265 problem.
In-Reply-To: <20020806043304.GA8272@nikolas.hn.org>
Message-ID: <Pine.LNX.3.96.1020806230434.9964C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Aug 2002, Nick Orlov wrote:

> 1. ide0/1 reserved for onboard controllers.

Not sure about that, I've run 2.4.x (ie. x<10} on machines so old that
they had no onboard anything, and were using "VESA bus" ide controllers. I
think they were ide0/1.

> 2. on most hardware, pdc20xxx is really additional controller.

That's the problem, most not all. No matter what we assume it will be
wrong part of the time.

> 3. if we put pdc20265 in "onboard" list on some hardware (mine for example)
> pdc20265 is assigned to ide0/1 (even if it's really ide2/3)

Does this matter as long as we can force it to be where we want? 

> 4. ide0=<what> ??? (do we have this option?)

I made that up, I believe we do/did if my memory isn't totally kidding me.
 
> Correct me, if I'm wrong.

This is lkml, count on it. Sometimes they correct you if you're right ;-)

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

