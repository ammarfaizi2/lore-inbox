Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290338AbSBKUeA>; Mon, 11 Feb 2002 15:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290344AbSBKUdt>; Mon, 11 Feb 2002 15:33:49 -0500
Received: from numenor.qualcomm.com ([129.46.51.58]:21438 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S290338AbSBKUdl>; Mon, 11 Feb 2002 15:33:41 -0500
Message-Id: <5.1.0.14.2.20020211121409.08b9c5f0@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 11 Feb 2002 12:33:25 -0800
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, jussi.laako@kolumbus.fi (Jussi Laako)
From: Maksim Krasnyanskiy <maxk@qualcomm.com>
Subject: Re: A7M266-D works?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16aMbQ-0007jI-00@the-village.bc.nu>
In-Reply-To: <3C681575.BED51812@kolumbus.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I'm considering to buy ASUS A7M266-D mobo and wondering if there is fix for
> > the APIC problems or is there workaround to get that mobo work? If it not
> > currently, is there some estimate if it will work in near future?
>
>The current status on the board I'm using
>
>-       The BIOS appears to misconfigure the PCI setup badly, so badly I've
>         been sticking in PCI quirk fixups to make some drivers work
Which board rev are you using ?
I have 1.03. No problem with PCI so far. All cards that I tried worked just 
fine.

>-       MP 1.4 locks solid MP 1.1 is ok - that may be a Linux bug. I have a
>         patch to test there
Same for me.

>-       The onboard USB was removed and swapped for a plug in card wasting
>         a slot (but you do get USB2 now). The manual wasn't updated
I replaced that ASUS USB 2.0 card with Adaptec Duo Connect (USB 2.0 / 1394).
Works just fine.

>-       The disk led appears to be marked wrongly. If you wire it the
>         board won't POST
Yeah. You should use another one under JEN jumper.

>-       If you put a 33Mhz card in the 64bit slots the board won't POST
>         unless you configure the board the way the manual suggests you don't
True. It should be Jumperless + DIP SW off/off/off/off.

>-       Expect to want > 400W PSU if you have lots of disks. I ended up
>         using a 550W PSU
I use EnerMax 430W. IBM 40GB + WD 10GB + HITACHI DVD + IOMEGA CDRW.
Works perfectly (with the patch from Linux-IDE folks, otherwise DMA doesn't 
work).

>-       Use a _BIG_ case. With anything but a large tower and actual
>         case fans you are not going to get enough ventilation or cable
>         room
I have minitower in-win case (with the case fan). And I'm very happy with it.
CPU and chipset temperatures are  just fine (41C - 51C).

>Having said all that - when you figure through the mess that ASUS calls
>QA and documentation (and they should be firing people for shipping it in
>its current state quite frankly) it goes like a bat out of hell.
I was pretty happy with packaging.
And yes it's super fast and reliable.

Max

