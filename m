Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131566AbRCQHKY>; Sat, 17 Mar 2001 02:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131567AbRCQHKO>; Sat, 17 Mar 2001 02:10:14 -0500
Received: from www.wen-online.de ([212.223.88.39]:12298 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S131566AbRCQHKJ>;
	Sat, 17 Mar 2001 02:10:09 -0500
Date: Sat, 17 Mar 2001 08:09:00 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Will Newton <will@misconception.org.uk>
cc: Tim Waugh <twaugh@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: VIA audio and parport in 2.4.2
In-Reply-To: <Pine.LNX.4.33.0103161450000.1403-100000@dogfox.localdomain>
Message-ID: <Pine.LNX.4.33.0103170756470.2637-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Mar 2001, Will Newton wrote:

> On Fri, 16 Mar 2001, Tim Waugh wrote:
>
> > > I don't know why it prints it twice.
> >
> > Looks like the module is getting loaded, then unloaded, then loaded
> > again.  Perhaps because of module autocleaning?
>
> Could be, but the final lp0 line is only printed once:
> lp0: using parport0 (interrupt-driven).
>
> > > I also get spurios interrupts on 7 when the parport is not loaded.
> >
> > I'm not sure what you mean here.  Can you be more specific?
>
> messages.1:Mar  8 22:49:00 dogfox kernel: spurious 8259A interrupt: IRQ7.

I see these once in a while too in 2.4.x, and only when copying largish
files between boxes.  NIC is IRQ-10, but the spurious interrupt is always
IRQ-7.  I'm not using the printer port for anything on this box.  It only
happens here when the network is going full bore for at least a few secs.

	-Mike

