Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272280AbRJYLBv>; Thu, 25 Oct 2001 07:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279753AbRJYLBo>; Thu, 25 Oct 2001 07:01:44 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46351 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272280AbRJYLBg>; Thu, 25 Oct 2001 07:01:36 -0400
Date: Thu, 25 Oct 2001 03:59:04 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        Patrick Mochel <mochel@osdl.org>,
        Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [RFC] New Driver Model for 2.5
In-Reply-To: <m1elnsdo5t.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.33.0110250356390.1302-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 25 Oct 2001, Eric W. Biederman wrote:
>
> > That's the problem of the architecture-specific code. There is no
> > point in having a device tree for that, because it's going to be very much
> > architecture-specific anyway (ie on x86 we may have to just blindly trust
> > some silly APCI table data etc).
>
> I'm doing my best to provide a real world alternative to ACPI on some
> boards.

That will be much appreciated. ACPI is not all that wonderful to say the
least. With enough knowledge of the hardware you can mostly do a better
job (the problem is "enough knowledge", especially on most laptops where
most of the GPIO signals etc are pretty much ad-hoc and not defined by the
chipsets but by the board layout person.. And we can't query the board
revision even if they gave us the information ;)

> My perspective is coming from linuxBIOS, or in general GPL'd
> firmware, so it is a little different.

Understood.

		Linus

