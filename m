Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131401AbQLVQYZ>; Fri, 22 Dec 2000 11:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131430AbQLVQYP>; Fri, 22 Dec 2000 11:24:15 -0500
Received: from chaos.analogic.com ([204.178.40.224]:4224 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131401AbQLVQYM>; Fri, 22 Dec 2000 11:24:12 -0500
Date: Fri, 22 Dec 2000 10:53:31 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.19pre3
In-Reply-To: <20001222173228.A1424@elektroni.ee.tut.fi>
Message-ID: <Pine.LNX.3.95.1001222104908.791A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Dec 2000, Petri Kaukasoina wrote:

> On Fri, Dec 22, 2000 at 12:52:32AM +0000, Alan Cox wrote:
> > 
> > o	Optimise kernel compiler detect, kgcc before	(Peter Samuelson)
> > 	gcc272 also
> 
> kwhich doesn't seem to work ok with several arguments if sh is bash-1.14.7:
> 
> $ sh scripts/kwhich kgcc gcc272 cc gcc
> kgcc:gcc272:cc:gcc: not found
> 
> If sh is bash-2.04 or ash-0.3.7 it works ok:
> 
> $ sh scripts/kwhich kgcc gcc272 cc gcc
> /usr/bin/kgcc
> -

Yep.

alias kwhich='type -path' in ~./bashrc should fix. I don't know
why 'standard' Unix/sell/executable commands keep getting changed
to GNUisms in distributions.

If you make a neat new GNU program, it had ought to function at
least like what it's replacing...

Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
