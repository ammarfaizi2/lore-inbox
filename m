Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317619AbSHaQRs>; Sat, 31 Aug 2002 12:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317622AbSHaQRr>; Sat, 31 Aug 2002 12:17:47 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35852 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317619AbSHaQRp>; Sat, 31 Aug 2002 12:17:45 -0400
Date: Sat, 31 Aug 2002 09:29:17 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Manfred Spraul <manfred@colorfullife.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.5.31] transparent PCI-to-PCI bridges
In-Reply-To: <20020831022341.C926@jurassic.park.msu.ru>
Message-ID: <Pine.LNX.4.44.0208310925390.2129-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 31 Aug 2002, Ivan Kokshaysky wrote:
> 
> Well, I'm just too lazy and don't want to rewrite that setup-bus stuff
> once again. :-)

I'm not so much worried about setup_bus(), I worry more about special 
cases. It's easier to handle some "extended bridge" (like CardBus) if you 
already have a notion of a "generic set of resources" and don't get too 
hung up about how a standard PCI bridge looks.

		Linus

