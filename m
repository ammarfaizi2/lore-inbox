Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277208AbRJDTCx>; Thu, 4 Oct 2001 15:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277210AbRJDTCo>; Thu, 4 Oct 2001 15:02:44 -0400
Received: from shell.cyberus.ca ([209.195.95.7]:46778 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S277208AbRJDTCa>;
	Thu, 4 Oct 2001 15:02:30 -0400
Date: Thu, 4 Oct 2001 15:00:05 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Ion Badulescu <ionut@cs.columbia.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <200110041855.f94ItSH11421@buggy.badula.org>
Message-ID: <Pine.GSO.4.30.0110041456000.10825-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Oct 2001, Ion Badulescu wrote:

> On Thu, 4 Oct 2001 07:54:19 -0400 (EDT), jamal <hadi@cyberus.ca> wrote:
>
> > Has nothing to do with specific hardware although i see your point.
> > send me an eepro and i'll at least add hardware flow control for you.
> > The API is simple, its up to the driver maintainers to use. This
> > discussion is good to make people aware of those drivers.
>
> A bit of documentation for the hardware flow control API would help as
> well. The API might be fine and dandy, but if all you have is a couple of
> modified drivers -- some of which are not even in the standard kernel --
> then you can bet not many driver writers are going to even be aware of it,
> let alone care to implement it.

I could write a small HOWTO at least for HWFLOWCONTROL since that doesnt
need anything fancy.

>
> For instance: in 2.2.19, the help text for CONFIG_NET_HW_FLOWCONTROL says
> only tulip supports it in the standard kernel -- yet I can't find that
> support anywhere in drivers/net/*.c, tulip.c included.
>

Thats dated. It means a doc is needed.

> In 2.4.10 tulip finally supports it (and I'm definitely going to take a
> closer look), but that's about it. And tulip is definitely the wrong
> example to pick if you want a nice and clean model for your driver.
>

I like the tulip code.

cheers,
jamal

