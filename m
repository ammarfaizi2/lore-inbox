Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129584AbQJ0N0b>; Fri, 27 Oct 2000 09:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129387AbQJ0N0V>; Fri, 27 Oct 2000 09:26:21 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:16904 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129120AbQJ0N0G>; Fri, 27 Oct 2000 09:26:06 -0400
Date: Fri, 27 Oct 2000 11:29:08 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Neale Banks <neale@lowendale.com.au>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-net@vger.kernel.org
Subject: Re: VM-global-2.2.18pre17-7
In-Reply-To: <Pine.LNX.4.05.10010271651240.14633-100000@marina.lowendale.com.au>
Message-ID: <Pine.LNX.4.21.0010271124550.5338-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Oct 2000, Neale Banks wrote:

> On Thu, 26 Oct 2000, octave klaba wrote:
> 
> > > > Oct 26 16:38:01 ns29 kernel: eth0: card reports no resources.
> > > let me guess: intel eepro100 or similar??
> > yeap
> 
> er, "me too":
> 
>   Bus  0, device   2, function  0:
>     Ethernet controller: Intel 82557 (rev 8).
>       Medium devsel.  Fast back-to-back capable.  IRQ 10.  Master Capable.  Latency=64.  Min Gnt=8.Max Lat=56.
>       Non-prefetchable 32 bit memory at 0xb5fff000 [0xb5fff000].
>       I/O at 0x2400 [0x2401].
>       Non-prefetchable 32 bit memory at 0xb5e00000 [0xb5e00000].
> 
> On Debian's 2.2.17-compact on a Compaq DL380 - with 60 days uptime I have
> 6 "eth0: card reports no resources." messages reported in dmesg.

We are having the same problem with eepro100 on a Compaq DL360. 

v1.11 of eepro100.c fixed the problem:

ftp://ftp.scyld.com/pub/network/eepro100.c

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
