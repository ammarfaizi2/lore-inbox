Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261576AbSJYUDe>; Fri, 25 Oct 2002 16:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261579AbSJYUDe>; Fri, 25 Oct 2002 16:03:34 -0400
Received: from [202.89.69.154] ([202.89.69.154]:1678 "EHLO manage.24online")
	by vger.kernel.org with ESMTP id <S261576AbSJYUDd>;
	Fri, 25 Oct 2002 16:03:33 -0400
Subject: Re: [vortex-bug] 3Com Cardbus 3CXFE575CT IRQ Problems
From: Dionysius Wilson Almeida <dwilson@yenveedu.com>
To: Donald Becker <becker@scyld.com>
Cc: vortex-bug@scyld.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0210241633550.1190-100000@beohost.scyld.com>
References: <Pine.LNX.4.44.0210241633550.1190-100000@beohost.scyld.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 26 Oct 2002 01:39:24 +0530
Message-Id: <1035576564.1378.2.camel@debianlap>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-25 at 02:11, Donald Becker wrote:
> On 24 Oct 2002, Dionysius Wilson Almeida wrote:
> 
> > I'm running Debian Woody with kernel 2.4.19 with cardbus and hotplug
> > support.  I've a 3Com 3CXFE575CT pcmcia card and I'm trying to get it to
> > work on my system. It seems that the card is unable to find a usable
> > IRQ.
> 
> As you likely already know, this is a kernel / BIOS issue, not a 3Com
> driver issue.  This problem will exist with any CardBus card that uses
> interrupts (almost every device).
> 
> > I've disabled Plug-n-Play in the BIOS of my Sony VAIO PCG-FX140
> > Laptop but still the card is not able to get any usable IRQs. I also
> > booted with pci=biosirq but still no progress.
> 
> You can also try "noapic", although that's almost never a issue on a
> laptop.  (It's more likely to be an issue on a desktop with a
> PCI-CardBus adapter.) 
I tried the "noapic" option ..but it still does not work.  

Can anyone suggest the appropriate mailing list to which I can send this
issue to ?

thanks and regards,

-Wilson


