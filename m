Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131737AbRCQTPw>; Sat, 17 Mar 2001 14:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131740AbRCQTPm>; Sat, 17 Mar 2001 14:15:42 -0500
Received: from www.wen-online.de ([212.223.88.39]:53777 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S131737AbRCQTP2>;
	Sat, 17 Mar 2001 14:15:28 -0500
Date: Sat, 17 Mar 2001 20:13:44 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Will Newton <will@misconception.org.uk>
cc: Tim Waugh <twaugh@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: VIA audio and parport in 2.4.2
In-Reply-To: <Pine.LNX.4.33.0103171744430.4733-100000@dogfox.localdomain>
Message-ID: <Pine.LNX.4.33.0103171951340.440-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Mar 2001, Will Newton wrote:

> On Sat, 17 Mar 2001, Mike Galbraith wrote:
>
> > > messages.1:Mar  8 22:49:00 dogfox kernel: spurious 8259A interrupt: IRQ7.
> >
> > I see these once in a while too in 2.4.x, and only when copying largish
> > files between boxes.  NIC is IRQ-10, but the spurious interrupt is always
> > IRQ-7.  I'm not using the printer port for anything on this box.  It only
> > happens here when the network is going full bore for at least a few secs.
>
> With the VIA chipset?

Yes.

> There definitely seems to be something wrong in the IRQ handling on this
> board. e.g. when I insmod the sound driver it just sits there on IRQ 10,
> getting no interrupts. Unfortunately I don't know enough about Linux
> internals to really investigate this further.

No device I'm using has irq troubles.. at least nothing obvious.  I've
no idea if the spurious irq is VIA chipset related or not.. only that
it's a fairly recent arrival.  All devices work fine here.

	-Mike

