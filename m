Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131747AbRCQRpX>; Sat, 17 Mar 2001 12:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131756AbRCQRpO>; Sat, 17 Mar 2001 12:45:14 -0500
Received: from cmailg3.svr.pol.co.uk ([195.92.195.173]:8520 "EHLO
	cmailg3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S131747AbRCQRoy>; Sat, 17 Mar 2001 12:44:54 -0500
Date: Sat, 17 Mar 2001 17:46:39 +0000 (GMT)
From: Will Newton <will@misconception.org.uk>
X-X-Sender: <will@dogfox.localdomain>
To: Mike Galbraith <mikeg@wen-online.de>
cc: Tim Waugh <twaugh@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: VIA audio and parport in 2.4.2
In-Reply-To: <Pine.LNX.4.33.0103170756470.2637-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.33.0103171744430.4733-100000@dogfox.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Mar 2001, Mike Galbraith wrote:

> > messages.1:Mar  8 22:49:00 dogfox kernel: spurious 8259A interrupt: IRQ7.
>
> I see these once in a while too in 2.4.x, and only when copying largish
> files between boxes.  NIC is IRQ-10, but the spurious interrupt is always
> IRQ-7.  I'm not using the printer port for anything on this box.  It only
> happens here when the network is going full bore for at least a few secs.

With the VIA chipset?

There definitely seems to be something wrong in the IRQ handling on this
board. e.g. when I insmod the sound driver it just sits there on IRQ 10,
getting no interrupts. Unfortunately I don't know enough about Linux
internals to really investigate this further.


