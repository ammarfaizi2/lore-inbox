Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319616AbSH3RBj>; Fri, 30 Aug 2002 13:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319619AbSH3RBi>; Fri, 30 Aug 2002 13:01:38 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21523 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319616AbSH3RBi>; Fri, 30 Aug 2002 13:01:38 -0400
Date: Fri, 30 Aug 2002 10:12:32 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Manfred Spraul <manfred@colorfullife.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.5.31] transparent PCI-to-PCI bridges
In-Reply-To: <20020830035318.A3224@jurassic.park.msu.ru>
Message-ID: <Pine.LNX.4.44.0208301009210.2163-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 30 Aug 2002, Ivan Kokshaysky wrote:
> 
> I disagree. There was a very good reason for doing that - you can build
> PCI bus tree (up to 256 buses) _only_ with PCI-to-PCI bridges

Your logic is so flawed that it's scary.

Your logic is "I _can_ do it this way, thus everybody else must do it this
way". Where the _hell_ is the logic there?

I pointed out a _fact_: there are PCI bridges that bridge more than 3 
resources. Argue with that until you turn blue in the face, I don't care. 
I'm not talking about theory, I'm talking about bridges that I _have_ in 
my machines, and that may have been set up by the firmware. 

The fact that you could have built hardware and firmware that didn't have 
more than three resources is _immaterial_, since it has nothing to do with 
the realities of today.

		Linus

