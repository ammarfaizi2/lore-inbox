Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265777AbSKRWeb>; Mon, 18 Nov 2002 17:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265543AbSKRWea>; Mon, 18 Nov 2002 17:34:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26639 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265777AbSKRWe2>;
	Mon, 18 Nov 2002 17:34:28 -0500
Message-ID: <3DD96C98.7020508@pobox.com>
Date: Mon, 18 Nov 2002 17:41:28 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Dresser <mdresser_l@windsormachine.com>
CC: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: RTL8139D support for 2.4?
References: <Pine.LNX.4.33.0211181731040.1796-100000@router.windsormachine.com>
In-Reply-To: <Pine.LNX.4.33.0211181731040.1796-100000@router.windsormachine.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Dresser wrote:

> On Mon, 18 Nov 2002, Jeff Garzik wrote:
>
>
> >this is a toughie...   basically that is an invalid PCI ID that should
> >not occur.  the "00ec" should really be "10ec", but it sounds like there
> >is a missing bit in the EEPROM where your card's PCI ID is stored.
>
>
> I'll try another card, and get back to you, just in case it's a
> partially fubar card.


FWIW I have seen tons of 8139s that work fine but have invalid PCI 
IDs... the price of being a US$0.50 chip I guess :)

So I doubt it's a fubar card...


> >A better patch would add
> >
> >	{ 0x00ec, 0x8139, 0xa0a0, 0x0027, ... }
>
>
> True true, until Aopen plays games with PCI ID's again :)


exactly... :/


> Never said i was a programmer :)  More of a hacker in the traditional
> sense.  Nano is my hammer, all .c code is nails.


hehe

>
>
> >>I left the D card in my workstation for now, I'll see how it handles the
> >>nightly backup tonight, and if you want me to test things for 8139cp
> >
> >cool.  no need to test 8139cp, it won't even load with your card, since
> >it is not an 8139C+ chip.
>
>
> Ok.  I take it the C+ has functions that weren't carried over to D?


8139C+ is, in CVS lingo, a branch.  8139D has -none- of the 8139C+ 
functions...

> >>What IS pci-skeleton then?
> >
> >Example driver that other developers may base drivers off of...
>
> Or feed to the Penguin.  Hey, you said red herring :D



hehe :)

	Jeff



