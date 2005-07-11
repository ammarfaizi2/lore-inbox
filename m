Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262742AbVGKVYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbVGKVYL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 17:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262693AbVGKVV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 17:21:59 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:52667 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S262761AbVGKVVG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 17:21:06 -0400
Date: Mon, 11 Jul 2005 17:21:05 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Michel Bouissou <michel@bouissou.net>
cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [SOLVED ??] Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
In-Reply-To: <200507112246.48069@totor.bouissou.net>
Message-ID: <Pine.LNX.4.44L0.0507111713320.14116-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2005, Michel Bouissou wrote:

> Well, I'm afraid I spoke too fast :-(
> 
> I rebooted my system with "usb-handoff" again, but still the USB mouse enabled 
> in BIOS, and this time got the punishent again :-(

> irq 21: nobody cared!
> 
> ...etc :-(
> 
> Well, this time, I deactivated the mouse in BIOS, rebooted again, also with 
> "usb-handoff", and "again it works"...

> ...at least, it worked until I unplugged my USB scanner...
>
> Jul 11 22:52:54 totor kernel: usb 3-2: USB disconnect, address 2
>
> ...then replugged my USB scanner...
>
> Jul 11 22:53:08 totor kernel: usb 3-2: new full speed USB device using
> uhci_hcd and address 3
> Jul 11 22:53:08 totor kernel: irq 21: nobody cared!
>
> Oh no :-(

Don't jump to hasty conclusions.  Problems like this are often caused by
unrelated things that you wouldn't suspect at first.  Getting something to
work once doesn't mean the problem has been fixed.  And you can be fooled
by coincidences.  (I would be surprised if that event above was really 
caused by plugging in the scanner, unless your UHCI hardware is broken.)

One thing you might try, time-consuming though it will be, is to remove or
disable as much hardware as possible from your system.  If you can
reliably determine that the problem occurs only when one particular piece
of hardware is enabled, then you'll know how to proceed.

Alan Stern

