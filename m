Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269040AbTBWXyj>; Sun, 23 Feb 2003 18:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269041AbTBWXyj>; Sun, 23 Feb 2003 18:54:39 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:21771 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S269040AbTBWXyi> convert rfc822-to-8bit; Sun, 23 Feb 2003 18:54:38 -0500
Date: Sun, 23 Feb 2003 19:01:01 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Xavier Bestel <xavier.bestel@free.fr>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Minutes from Feb 21 LSE Call
In-Reply-To: <1046031687.2140.32.camel@bip.localdomain.fake>
Message-ID: <Pine.LNX.3.96.1030223185816.999G-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Feb 2003, Xavier Bestel wrote:

> Le dim 23/02/2003 à 20:17, Linus Torvalds a écrit :
> 
> > And the baroque instruction encoding on the x86 is actually a _good_
> > thing: it's a rather dense encoding, which means that you win on icache. 
> > It's a bit hard to decode, but who cares? Existing chips do well at
> > decoding, and thanks to the icache win they tend to perform better - and
> > they load faster too (which is important - you can make your CPU have
> > big caches, but _nothing_ saves you from the cold-cache costs). 
> 
> Next step: hardware gzip ?

If the firmware issues were better defined in Intel ia32 chips, I could
see a gzip instruction pointing to blocks in memory. As a proof of
concept, not a big win.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

