Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318855AbSHREqT>; Sun, 18 Aug 2002 00:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318856AbSHREqT>; Sun, 18 Aug 2002 00:46:19 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29968 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318855AbSHREqS>; Sun, 18 Aug 2002 00:46:18 -0400
Date: Sat, 17 Aug 2002 21:53:46 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Oliver Xymoron <oxymoron@waste.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
In-Reply-To: <20020818044242.GI21643@waste.org>
Message-ID: <Pine.LNX.4.44.0208172151440.1829-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 17 Aug 2002, Oliver Xymoron wrote:
> 
> But it will get data of _equal quality_ to the current approach from
> /dev/urandom.

So what?

If you make /dev/random useless ("but you can use /dev/urandom instead") 
then we should not have it.

> > Are you seriously trying to say that a TSC running at a gigahertz cannot 
> > be considered to contain any random information just because you think you 
> > can time the network activity so well from the outside?
> 
> Yes. The clock of interest is the PCI bus clock, which is not terribly
> fast next to a gigabit network analyzer.

Be realistic. This is what I ask of you. We want _real_world_ security, 
not a completely made-up-example-for-the-NSA-that-is-useless-to-anybody- 
else.

All your arguments seem to boil down to "people shouldn't use /dev/random 
at all, they should use /dev/urandom".

Which is just ridiculous.

		Linus

