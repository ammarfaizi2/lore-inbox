Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264695AbUEJOFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264695AbUEJOFv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 10:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264700AbUEJOFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 10:05:51 -0400
Received: from chaos.analogic.com ([204.178.40.224]:29576 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264695AbUEJOFt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 10:05:49 -0400
Date: Mon, 10 May 2004 10:07:43 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: John Bradford <john@grabjohn.com>
cc: Shobhit Mathur <shobhitmmathur@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: PCI excessive retry error
In-Reply-To: <200405101231.i4ACVTa7000421@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.53.0405100955220.28392@chaos>
References: <20040510113303.20724.qmail@web51003.mail.yahoo.com>
 <Pine.LNX.4.53.0405100757470.28174@chaos> <200405101231.i4ACVTa7000421@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2004, John Bradford wrote:

> > I mentioned a "broken bus" in the beginning. Some new
> > PCI boards are not 5-volt tolerant. If you plug them into
> > the PCI bus of some motherboards (Intel 865PE chipset),
> > The Intel D865PERL, for one, the PCI/Bus will get blown.
> > Same with the MS-6585 (648 MAX board). I blew up several
> > boards by plugging 3.5 volt PCI cards into the 5 volt
> > bus. According to the rules, it's supposed to work unless
> > the PCI slots have "Cadium Yellow" or "Brilliant Blue"
> > keying plugs (I kid you not, it's in the PCI specs).
>
> So, did you actually plug the cards in to the wrong coloured slots, or
> do you have a 3.5 volt-incompatible motherboard with a colour of slots
> which suggests compatibility?
>
> John.
>

I have two broken motherboards that have off-white color slots
that imply that they should certainly not blow up if anything
that fits is plugged into them!

So I plugged in two high-speed data-link boards and nothing worked.
Upon removal of the boards, my SCSI controller was no longer seen
on the PCI/Bus. I called the data-link board vendor (actually a
division of this company) and they said; "Idiot! They are 3.5 volt
boards!". I said; "Yeh? The PCI Spec says they should be compatible!"
They said; "There is no PCI spec for such compatibility......", etc.
etc. When I quoted the page on the book, they said; "That's only a
BOOK, not a specification...." It's just like the l-k list.

So, some new PCI/Bus boards are not 5-volt tolerant. Some new
board slots run at 3.5 volts so older PCI/Bus boards won't
work (some do, some don't). It's a mess.

I also asked our wizards in the other division what kind of
platform the boards were supposed to be working in. They said
it was secret, but not a PC.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5557.45 BogoMips).
            Note 96.31% of all statistics are fiction.


