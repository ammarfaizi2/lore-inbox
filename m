Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267553AbTBLQBW>; Wed, 12 Feb 2003 11:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267558AbTBLQBW>; Wed, 12 Feb 2003 11:01:22 -0500
Received: from CPEdeadbeef0000-CM400026342639.cpe.net.cable.rogers.com ([24.114.185.204]:1796
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S267553AbTBLQBU>; Wed, 12 Feb 2003 11:01:20 -0500
Date: Wed, 12 Feb 2003 11:12:02 -0500 (EST)
From: Shawn Starr <spstarr@sh0n.net>
To: Brian Gerst <bgerst@didntduck.org>
cc: Adam Belay <ambx1@neo.rr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.20][2.5.60] /proc/interrupts comparsion - two irqs for
 i8042?
In-Reply-To: <3E4A6BF0.1000004@didntduck.org>
Message-ID: <Pine.LNX.4.44.0302121110570.211-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Right, but this wasn't a problem in 2.4? I had a PS/2 mouse before in 2.4
and this didnt have the problem.


On Wed, 12 Feb 2003, Brian Gerst wrote:

> Shawn Starr wrote:
> > 2.4:
> >            CPU0
> >   0:    2576292          XT-PIC  timer
> >   1:        661          XT-PIC  keyboard
> >   2:          0          XT-PIC  cascade
> >   3:         10          XT-PIC  serial
> >   5:    1104824          XT-PIC  soundblaster
> >   8:          1          XT-PIC  rtc
> >   9:          0          XT-PIC  acpi
> >  10:          7          XT-PIC  aic7xxx
> >  11:      15167          XT-PIC  usb-uhci, eth0
> >  14:       7554          XT-PIC  ide0
> >  15:          3          XT-PIC  ide1
> >
> > 2.5:
> >
> >            CPU0
> >   0:      36281          XT-PIC  timer
> >   1:         15          XT-PIC  i8042
> >   2:          0          XT-PIC  cascade
> >   3:        149          XT-PIC  serial
> >   5:          0          XT-PIC  soundblaster
> >   8:          1          XT-PIC  rtc
> >   9:          0          XT-PIC  acpi
> >  10:         20          XT-PIC  aic7xxx
> >  11:        324          XT-PIC  uhci-hcd, eth0
> >  12:         60          XT-PIC  i8042 <--???
> >  14:        723          XT-PIC  ide0
> >  15:          9          XT-PIC  ide1
> > NMI:          0
> > LOC:      35547
> > ERR:          0
> > MIS:          0
> >
> > Interesting, why are we using two interrupts for the i8042 (keyboard).
>
> IRQ12 is for the PS/2 mouse port.
>
> --
> 				Brian Gerst
>
>
>

