Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265169AbSKRWug>; Mon, 18 Nov 2002 17:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267010AbSKRWug>; Mon, 18 Nov 2002 17:50:36 -0500
Received: from windsormachine.com ([206.48.122.28]:45837 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S265169AbSKRWue>; Mon, 18 Nov 2002 17:50:34 -0500
Date: Mon, 18 Nov 2002 17:57:34 -0500 (EST)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: RTL8139D support for 2.4?
In-Reply-To: <3DD9688F.8030202@pobox.com>
Message-ID: <Pine.LNX.4.33.0211181755560.24054-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, Jeff Garzik wrote:

> this is a toughie...   basically that is an invalid PCI ID that should
> not occur.  the "00ec" should really be "10ec", but it sounds like there
> is a missing bit in the EEPROM where your card's PCI ID is stored.

Took the card out, tried another, 10ec:8139 as expected.

Put the old card back in, didn't come up in BIOS or lspci.  Pulled the
card out, put it back in, comes up as 10ec:8139.

I suspect there's something flaky about this card :D

So yeah, ignore all the pci_id stuff, this card is just fubar :)

Man, I'd hate to be someone in charge of hardware under linux, there's so
much flaky stuff.

Mike

