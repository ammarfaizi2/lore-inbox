Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290218AbSAWXue>; Wed, 23 Jan 2002 18:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290216AbSAWXuY>; Wed, 23 Jan 2002 18:50:24 -0500
Received: from fungus.teststation.com ([212.32.186.211]:33543 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S290218AbSAWXuL>; Wed, 23 Jan 2002 18:50:11 -0500
Date: Thu, 24 Jan 2002 00:49:57 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: Justin A <justin@bouncybouncy.net>
cc: Andrew Morton <akpm@zip.com.au>, Martin Eriksson <nitrax@giron.wox.org>,
        Andy Carlson <naclos@swbell.net>, <linux-kernel@vger.kernel.org>,
        Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: via-rhine timeouts
In-Reply-To: <20020123234138.GA12264@bouncybouncy.net>
Message-ID: <Pine.LNX.4.33.0201240042460.3190-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2002, Justin A wrote:

> I don't think thats the full problem, I just noticed I had been getting
> errors too with the via driver, but it's been working fine otherwise:
> 
[snip]
> Jan 23 09:45:52 bouncybouncy kernel: eth0: Transmit error, Tx status 8100.
> Jan 23 09:49:33 bouncybouncy kernel: eth0: Transmit error, Tx status 8100.
> Jan 23 09:51:50 bouncybouncy kernel: eth0: Transmit error, Tx status 8100.
> Jan 23 17:55:15 bouncybouncy kernel: eth0: Transmit error, Tx status 8100.

0100 is that it sees too many collisions. The netdev watchdog I can
trigger seems to be caused by a lot of collisions.


> Is it possible that the problem is with the hub and via-rhine resetting
> the card repetedly just makes it worse?

The hub can be the problem and I suppose resetting could make something
worse (if it is done wrong, for example).

/Urban

