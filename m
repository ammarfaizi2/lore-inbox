Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289865AbSBEXZX>; Tue, 5 Feb 2002 18:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289867AbSBEXZO>; Tue, 5 Feb 2002 18:25:14 -0500
Received: from air-2.osdl.org ([65.201.151.6]:55470 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S289865AbSBEXZI>;
	Tue, 5 Feb 2002 18:25:08 -0500
Date: Tue, 5 Feb 2002 15:25:36 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Joel Jaeggli <joelja@darkwing.uoregon.edu>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Russell King <rmk@arm.linux.org.uk>, Pavel Machek <pavel@suse.cz>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: driverfs support for motherboard devices
In-Reply-To: <E16YF2I-0003En-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0202051520270.25114-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 5 Feb 2002, Alan Cox wrote:

> > > > What about, say, a Promise PCI IDE card?  You really need to reference
> > > > the parent PCI device when the is one.
> > > LOL, how about ones that are quad-channel with a DEC-Bridge to slip the
> > > local BUSS?
> > 
> > or an i960rp and 3 promise 20276's, I've got two of those...
> 
> Yep. And then you hit the CRIS where the ide appears to be on the CPU 8)
> 
> I don't think anyone should be trying to define where the IDE goes in the
> heirarchy like this - its dependant on the situation and the platform.

Exactly. My point was that based on the situation, you know the hierarchy 
and you can use it. 

	-pat

