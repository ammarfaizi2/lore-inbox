Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267532AbTBLSW2>; Wed, 12 Feb 2003 13:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267536AbTBLSW2>; Wed, 12 Feb 2003 13:22:28 -0500
Received: from CPEdeadbeef0000-CM400026342639.cpe.net.cable.rogers.com ([24.114.185.204]:9476
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S267532AbTBLSW0>; Wed, 12 Feb 2003 13:22:26 -0500
Date: Wed, 12 Feb 2003 13:33:10 -0500 (EST)
From: Shawn Starr <spstarr@sh0n.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: bgerst@didntduck.org, <ambx1@neo.rr.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.20][2.5.60] /proc/interrupts comparsion - two irqs for
 i8042?
In-Reply-To: <20030212102022.0f620cf4.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.44.0302121332180.356-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


well, In 2.4, i wasn't out of IRQs, I had 3 Com ports and the sound
blaster working fine. If I didn't have PS/2 compiled In i don't know if
that would bring me back into the situation that I'm currently in.

Something weird is going on.

On Wed, 12 Feb 2003, Randy.Dunlap wrote:

> How are you out of IRQs now?
> Were you out of IRQs in 2.4.20 and just didn't notice it?
>
> ~Randy
>
>
> On Wed, 12 Feb 2003 13:07:00 -0500 (EST)
> Shawn Starr <spstarr@sh0n.net> wrote:
>
> |
> | hmm, It appears the PS/2 was not on when I built that kernel.
> |
> | But the fact remains, I'm out of IRQs some how. ;/
> |
> | Shawn.
> |
> | On Wed, 12 Feb 2003, Randy.Dunlap wrote:
> |
> | > (see an answer at bottom)
> | >
> | > On Wed, 12 Feb 2003 11:12:02 -0500 (EST)
> | > Shawn Starr <spstarr@sh0n.net> wrote:
> | >
> | > |
> | > | Right, but this wasn't a problem in 2.4? I had a PS/2 mouse before in 2.4
> | > | and this didnt have the problem.
> | > |
> | > |
> | > | On Wed, 12 Feb 2003, Brian Gerst wrote:
> | > |
> | > | > Shawn Starr wrote:
> | > | > > 2.4:
> | > | > >            CPU0
> | > | > >   0:    2576292          XT-PIC  timer
> | > | > >   1:        661          XT-PIC  keyboard
> | > | > >   2:          0          XT-PIC  cascade
> | > | > >   3:         10          XT-PIC  serial
> | > | > >   5:    1104824          XT-PIC  soundblaster
> | > | > >   8:          1          XT-PIC  rtc
> | > | > >   9:          0          XT-PIC  acpi
> | > | > >  10:          7          XT-PIC  aic7xxx
> | > | > >  11:      15167          XT-PIC  usb-uhci, eth0
> | > | > >  14:       7554          XT-PIC  ide0
> | > | > >  15:          3          XT-PIC  ide1
> | > | > >
> | > | > > 2.5:
> | > | > >
> | > | > >            CPU0
> | > | > >   0:      36281          XT-PIC  timer
> | > | > >   1:         15          XT-PIC  i8042
> | > | > >   2:          0          XT-PIC  cascade
> | > | > >   3:        149          XT-PIC  serial
> | > | > >   5:          0          XT-PIC  soundblaster
> | > | > >   8:          1          XT-PIC  rtc
> | > | > >   9:          0          XT-PIC  acpi
> | > | > >  10:         20          XT-PIC  aic7xxx
> | > | > >  11:        324          XT-PIC  uhci-hcd, eth0
> | > | > >  12:         60          XT-PIC  i8042 <--???
> | > | > >  14:        723          XT-PIC  ide0
> | > | > >  15:          9          XT-PIC  ide1
> | > | > > NMI:          0
> | > | > > LOC:      35547
> | > | > > ERR:          0
> | > | > > MIS:          0
>
>

