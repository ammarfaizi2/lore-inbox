Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131197AbRANKlX>; Sun, 14 Jan 2001 05:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131953AbRANKlO>; Sun, 14 Jan 2001 05:41:14 -0500
Received: from fungus.teststation.com ([212.32.186.211]:27556 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S131197AbRANKlH>; Sun, 14 Jan 2001 05:41:07 -0500
Date: Sun, 14 Jan 2001 11:40:57 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: "Mike A. Harris" <mharris@opensourceadvocate.org>
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: eth1: Transmit timed out, status 0000, PHY status 0000
In-Reply-To: <Pine.LNX.4.31.0101130334190.716-100000@asdf.capslock.lan>
Message-ID: <Pine.LNX.4.30.0101141132100.22034-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jan 2001, Mike A. Harris wrote:

> Becker's latest via-rhine driver ontop 2.2.18..
>
> ...
> eth1: Transmit timed out, status 0000, PHY status 0000,
> resetting...
[snip]
> Keeps going nonstop until I ifdown eth1.
>
> Card worked fine 2 days ago...

So what did you change?
Has the machine been up since then?


Someone else with the same symptoms (in 2.4)
    http://www.uwsg.iu.edu/hypermail/linux/net/0011.0/0027.html

Becker's reply
    http://www.uwsg.iu.edu/hypermail/linux/net/0011.0/0032.html

"Try unplugging the system and doing a really cold boot. A soft-off does
 not reset the chip.

 If this solves the problem, we will have to add code to re-load the
 EEPROM info into the chip."


There is no further reply in that thread.

/Urban

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
