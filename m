Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311909AbSCTSNR>; Wed, 20 Mar 2002 13:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311911AbSCTSNI>; Wed, 20 Mar 2002 13:13:08 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:53260 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S311909AbSCTSNB>; Wed, 20 Mar 2002 13:13:01 -0500
Date: Wed, 20 Mar 2002 13:11:03 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Daniela Engert <dani@ngrt.de>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <20020320065425.D27F3DD1C@mail.medav.de>
Message-ID: <Pine.LNX.3.96.1020320130543.7804A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2002, Daniela Engert wrote:

> >This behavior is permitted by the specification, as far as I know -
> 
> Actually not. Have a look at page 36 of the current ATA6 specification.

That's probably not the place to look, since drives will conform to the
specs in place when they were designed. If older specs did not require
automatic spinup, then ATA6 doesn't apply.

In the real world I have seen drives which definitely didn't like commands
in spindown, so unless there is some really large penalty for sending that
I would suggest having the logic support the existing hardware. We still
have 386 and FPE emulation, I would bet there are more older drives than
386s in use (at least by my clients ;-).

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

