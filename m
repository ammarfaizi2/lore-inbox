Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278162AbRJOUdi>; Mon, 15 Oct 2001 16:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278275AbRJOUd2>; Mon, 15 Oct 2001 16:33:28 -0400
Received: from promotionalresponse.com ([209.209.190.216]:2543 "EHLO
	apexmail.kih.net") by vger.kernel.org with ESMTP id <S278162AbRJOUdU>;
	Mon, 15 Oct 2001 16:33:20 -0400
Date: Mon, 15 Oct 2001 15:31:44 -0500 (CDT)
From: grouch <grouch@apex.net>
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: VIA chipset
In-Reply-To: <Pine.LNX.4.10.10110151554040.23528-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.30.0110151515280.13346-100000@paq.edgers.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2001, Mark Hahn wrote:

>> RAM is cheap :). BIOS is the latest available from Tyan for this board.
>
>I meant to imply that such hardware was not originally designed for
>lots of memory (or rather, when it was designed and tested, "lots"
>meant something quite different!)

Maximum RAM for the motherboard is 768MB; it has 3 168 pin DIMM sockets.

>> That's an interesting point. This thing does not like 80 conductor
>> cables at all.
>
>that can only mean that the driver is correctly sensing whether
>you have 40 or 80, and limiting speed with 40 to udma33, and that
>the lower speed doesn't provoke as much trouble.

The motherboard supports only up to UDMA 33 which, IIUC, does not
require 80 conductor cables. The board shipped with a 40 conductor cable
when new. I only tried an 80 to try to cover all bases.

>I don't remember whether I asked this or not, but are you sure
>of your clocks?  ie, not overclocking, and have agp at 66,
>pci at 33?

CPU bus speed is at 100 MHz, memory is at 100 MHz, PCI is at 33 MHz, AGP
is unused.

>personally, I don't see any real point to using obsolete 2.2 kernels;
>I'd rather figure out how to make it work with a modern kernel.
>I acknowlege that other people may have different priorities ;)

This is the first PC I've been unable to get to be stable using Linux.
Up until about 2 months ago this system was used by a Windows user
(maybe some of his lockups were not due to windows?). I have two
machines running 2.2 kernels and three running 2.4 kernels constantly,
with another machine that dual boots with a 2.4 kernel.

>I have a K6-2/300 with a via board that works perfectly
>with 2.4.something (probably around 9).  I think it's doing some
>reasonable udma mode, as well, though not with a DTLA.

The stable machine that runs the same brand and model motherboard as the
one that is causing troubles is running 2.4.5. It has a WDC
WD400BB-00AUA1 hard drive as hda and an ASUS CD-S400/A 40x cd as hdb. I
started testing by duplicating as much as possible from the setup of the
stable machine.


