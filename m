Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289756AbSAWJov>; Wed, 23 Jan 2002 04:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289752AbSAWJod>; Wed, 23 Jan 2002 04:44:33 -0500
Received: from fungus.teststation.com ([212.32.186.211]:18190 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S289754AbSAWJoU>; Wed, 23 Jan 2002 04:44:20 -0500
Date: Wed, 23 Jan 2002 10:44:17 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: Justin A <justin@bouncybouncy.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: via-rhine timeouts
In-Reply-To: <20020123010248.GB835@bouncybouncy.net>
Message-ID: <Pine.LNX.4.33.0201231015300.6354-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2002, Justin A wrote:

> It only does that after resetting the card over and over again, perhaps
> it tries to reset it again before its ready?

Andrew Morton sent me some stuff on this. It seems via changed the
meaning of some register bits, but the driver doesn't understand that. So
it reads certain status events all wrong and does the wrong thing.

I'll have a look and see if I can do something over the weekend.


> > + Move the card to another slot (remove/re-arrange other cards in the box)
> It's built into the motherboard:)

So bring out your soldering iron ... :)


> I just found this in my old logs:
> Nov 18 19:01:14 bouncybouncy kernel: NETDEV WATCHDOG: eth0: transmit timed out
> Nov 18 19:01:14 bouncybouncy kernel: eth0: transmit timed out, Tx_status 00 status 2000 Tx FIFO room 520.
> 
> That was with my old motherboard, and an isa 3c509.

Probably completely unrelated as it is a different card and a different
mb (and a different network?).

/Urban

