Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290519AbSBGR0O>; Thu, 7 Feb 2002 12:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290490AbSBGR0E>; Thu, 7 Feb 2002 12:26:04 -0500
Received: from air-2.osdl.org ([65.201.151.6]:21939 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S289829AbSBGRZ6>;
	Thu, 7 Feb 2002 12:25:58 -0500
Date: Thu, 7 Feb 2002 09:26:01 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Dave Jones <davej@suse.de>
cc: Pavel Machek <pavel@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Russell King <rmk@arm.linux.org.uk>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: driverfs support for motherboard devices
In-Reply-To: <20020207142333.A22451@suse.de>
Message-ID: <Pine.LNX.4.33.0202070922460.25114-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 7 Feb 2002, Dave Jones wrote:

> On Thu, Feb 07, 2002 at 01:31:25PM +0100, Pavel Machek wrote:
>  > > I suspect PnPBIOS knows for the 486. There is PnPbios code in 2.4-ac 
>  > > perfectly ready for a 2.5 merger
>  > PnPBIOS is nasty, and I suspect it is not present/working on all
>  > models, right?
> 
>  For the most part it's fine, it just needs the floppy driver / ps2
>  driver (and maybe some others) fixed up to not allocate regions
>  that pnpbios already reserved. Other than these issues, it seems
>  to be working well. It's certainly handled itself ok on all my
>  test boxes (Even the weird compaq with the fscked up pnpbios --
>  it claims to have pnpbios, yet when you call it, you get feature
>  not supported return codes. cute.)

Hey, speaking of PnPBios, is there a spec somewhere?

Speaking of specs, does anyone know of some sort of list of specs of 
things kernel related - platforms, hardware and firmware? sandpile.org is 
good for most x86 things, though they are merely document names. 

	-pat

