Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318980AbSHWPWY>; Fri, 23 Aug 2002 11:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318991AbSHWPWX>; Fri, 23 Aug 2002 11:22:23 -0400
Received: from windsormachine.com ([206.48.122.28]:29449 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id <S318980AbSHWPWV>; Fri, 23 Aug 2002 11:22:21 -0400
Date: Fri, 23 Aug 2002 11:26:26 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: Bill Unruh <unruh@physics.ubc.ca>
cc: <linux-ppp@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: your mail
In-Reply-To: <Pine.LNX.4.33L2.0208230806050.16223-100000@string.physics.ubc.ca>
Message-ID: <Pine.LNX.4.33.0208231113550.8320-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Aug 2002, Bill Unruh wrote:

> Well, it would be good if you actually told us what problem you were
> describing. Is this a new connection attempt after the first hang up?
> What?
>
> What repeats over and over-- I see no repeat.

I >
> You also do not tell us info like what kind of modem is this-- external,
> internal, serial, usb, pci, winmodem,....
>
> I assume what you are refering to is the "inappropriate ioctl" line.
> This indicates a hardware problem.
>
> Actually, it looks to me like another pppd is up on the line. Those
> EchoReq are another pppd receiving stuff on an open pppd on another
> line. More information on what it is you are trying to do, on what your
> system is, and what the problem is might get you help.
>

Sorry.

It's a new connection from the persist option.  The exact same message
repeats for every dial out it attempts.

It's a PCI 3com 56k Sportster.  It's a hardware modem.

There is sometimes another pppd up on ttys1

Here's the setup:

There is an external modem on ttyS01, irq 3, that dials in occasionally as
needed.

there is an internal PCI modem on ttyS04, irq 5, that dials in permamently
to the ISP.

Every 6 hours, the ISP enforces the 6 hour hangup rule they have.

The modem is set to persist, max-fails 0.  It is not able to redial, and
keeps giving the error message that i pasted.

Under 2.2.x, this functioned properly.

System is a VIA VT82C693A/694x [Apollo PRO133x] based motherboard, from
Giga-byte, if I remember correctly.  Celeron 533.

Sorry about the too brief error message, I fell into my "it makes sense to
me the way it is" trap.

Mike

