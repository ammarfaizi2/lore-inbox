Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289432AbSAJM54>; Thu, 10 Jan 2002 07:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289433AbSAJM5p>; Thu, 10 Jan 2002 07:57:45 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:12168 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S289432AbSAJM5h>;
	Thu, 10 Jan 2002 07:57:37 -0500
Date: Thu, 10 Jan 2002 13:56:58 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Henrique de Moraes Holschuh <hmh@debian.org>
cc: linux-kernel@vger.kernel.org, Jani Forssell <jani.forssell@viasys.com>
Subject: Re: Via KT133 pci corruption: stock 2.4.18pre2 oopses as well
In-Reply-To: <20020110100101.A25366@khazad-dum>
Message-ID: <Pine.LNX.4.21.0201101352270.17054-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2002, Henrique de Moraes Holschuh wrote:

> On Thu, 10 Jan 2002, Martin Josefsson wrote:
> > We've replaved that memory module now and now it's better but I have to
> > say that the KT133 or atleast the Asus A7V motherboard seems to be quite
> > broken. we have a lot of spurious irq's and the ide controllers freak when
> > but under some load and start getting irq timeouts and resets the ide
> > channels over and over again with some delay in between when it kind of
> > works, slow as hell but works.
> 
> Well, my A7V is also acting up, with spurious IRQs (but not too many), and
> PCI lockups if the load on the PCI bus increases too much -- this is
> probably the last time I ever buy a VIA board (because they take soooo much
> time to acknowledge their screw ups and help people fix it) unless they
> start issuing non-binary-only fixes (heck, all it takes is a doc telling us
> what to do on the PCI registers!).
> 
> The IDE corruption and lockups you can fix, just apply the latest IDE
> patches, the 2.4.18pre IDE subsystem is not to be used on a KT133, it will
> not work at all if you give it a slightly bigger load on the promise
> controller, for example.
> 
> > We are going to replace the motherboard with one with VIA KT266A chipset,
> > hope that works better.
> 
> Without the IDE patches, it will (most probably) not help.

I am using the IDE patch. I've heard that the A7V133 which is based on the
KT133A chipset works much better in linux. I know people using it in a
router for a 1000 client network on a 100Mbit connection and it's working
fine, no problems at all. If we push the networking too hard we get a lot
of spurious interrupts and it appears as we loose some interrupts aswell
as NIC drivers and IDE drivers start complaining sometimes and when it has
started loosing interrupts only a reboot can bring it back to
"normal" operation.

/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.

