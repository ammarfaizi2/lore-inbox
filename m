Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265477AbSKRW2s>; Mon, 18 Nov 2002 17:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265270AbSKRW1A>; Mon, 18 Nov 2002 17:27:00 -0500
Received: from windsormachine.com ([206.48.122.28]:8205 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S265308AbSKRW0s>; Mon, 18 Nov 2002 17:26:48 -0500
Date: Mon, 18 Nov 2002 17:33:46 -0500 (EST)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: RTL8139D support for 2.4?
In-Reply-To: <3DD9688F.8030202@pobox.com>
Message-ID: <Pine.LNX.4.33.0211181731040.1796-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, Jeff Garzik wrote:

> this is a toughie...   basically that is an invalid PCI ID that should
> not occur.  the "00ec" should really be "10ec", but it sounds like there
> is a missing bit in the EEPROM where your card's PCI ID is stored.

I'll try another card, and get back to you, just in case it's a
partially fubar card.

> A better patch would add
>
> 	{ 0x00ec, 0x8139, 0xa0a0, 0x0027, ... }

True true, until Aopen plays games with PCI ID's again :)

Never said i was a programmer :)  More of a hacker in the traditional
sense.  Nano is my hammer, all .c code is nails.

> > I left the D card in my workstation for now, I'll see how it handles the
> > nightly backup tonight, and if you want me to test things for 8139cp
>
> cool.  no need to test 8139cp, it won't even load with your card, since
> it is not an 8139C+ chip.

Ok.  I take it the C+ has functions that weren't carried over to D?

> > What IS pci-skeleton then?
> Example driver that other developers may base drivers off of...
Or feed to the Penguin.  Hey, you said red herring :D

Mike

