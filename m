Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262606AbSJHS6q>; Tue, 8 Oct 2002 14:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261753AbSJHS5d>; Tue, 8 Oct 2002 14:57:33 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:17164 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261755AbSJHS5Z>; Tue, 8 Oct 2002 14:57:25 -0400
Date: Tue, 8 Oct 2002 14:55:01 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Larry McVoy <lm@bitmover.com>
cc: "David S. Miller" <davem@redhat.com>, mau@oscar.prima.de,
       linux-kernel@vger.kernel.org
Subject: Re: LMbench results for 2.5.40
In-Reply-To: <20021001163757.J13270@work.bitmover.com>
Message-ID: <Pine.LNX.3.96.1021008144209.5056D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2002, Larry McVoy wrote:

> By the way, the place you will probably see variance in LMbench is in the
> context switch benchmarks, it's almost certainly due to randomness in 
> cache layout and there isn't a thing we can do about it.  You can run a
> zillion runs to get an average but please realize that is an *average*.
> The context switch number are accurate, the low ones represent no cache
> collisions and the high ones represent lots of cache collisions.
> 
> FYI.  I don't like it either.

Thank you, that explains some things I've seen in my context switching
benchmark as well, which uses a bunch of different services to transfer
tiny data from on process to another.

Time for some statistical jiggery-pokery, dust off deviant mean or some
such.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

