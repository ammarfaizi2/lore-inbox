Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129030AbQJ0Fk5>; Fri, 27 Oct 2000 01:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129079AbQJ0Fkr>; Fri, 27 Oct 2000 01:40:47 -0400
Received: from [203.26.242.120] ([203.26.242.120]:17682 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S129030AbQJ0Fkg>; Fri, 27 Oct 2000 01:40:36 -0400
Date: Fri, 27 Oct 2000 16:59:58 +1100 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-net@vger.kernel.org
Subject: Re: VM-global-2.2.18pre17-7
In-Reply-To: <39F85A09.DA88452F@ovh.net>
Message-ID: <Pine.LNX.4.05.10010271651240.14633-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2000, octave klaba wrote:

> > > Oct 26 16:38:01 ns29 kernel: eth0: card reports no resources.
> > let me guess: intel eepro100 or similar??
> yeap

er, "me too":

  Bus  0, device   2, function  0:
    Ethernet controller: Intel 82557 (rev 8).
      Medium devsel.  Fast back-to-back capable.  IRQ 10.  Master Capable.  Latency=64.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xb5fff000 [0xb5fff000].
      I/O at 0x2400 [0x2401].
      Non-prefetchable 32 bit memory at 0xb5e00000 [0xb5e00000].

On Debian's 2.2.17-compact on a Compaq DL380 - with 60 days uptime I have
6 "eth0: card reports no resources." messages reported in dmesg.

[...]
> > Well known problem with that one. dont know if its fully fixed ... With
> > 2.4.0-test9-pre3 it doesnt happen on my machine ...
> we have 1-2 servers running 2.4.0-test9 and we got this error ...
> 
> is there any patch to 2.2.18pre ? since the server has to run on sunday
> we can still make the crazy tests 3 days. it would be cool to fix it to 
> 2.2.X if the bug is known ;)

Unless this is "mostly harmless" a backport of any fix to 2.2.xx would be
received most gratefully.

Thanks,
Neale.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
