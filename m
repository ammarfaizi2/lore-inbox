Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282978AbRL0O4U>; Thu, 27 Dec 2001 09:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282187AbRL0O4K>; Thu, 27 Dec 2001 09:56:10 -0500
Received: from unicef.org.yu ([194.247.200.148]:22546 "EHLO unicef.org.yu")
	by vger.kernel.org with ESMTP id <S282099AbRL0Oz6>;
	Thu, 27 Dec 2001 09:55:58 -0500
Date: Thu, 27 Dec 2001 15:55:42 +0100 (CET)
From: Davidovac Zoran <zdavid@unicef.org.yu>
To: Kai Henningsen <kaih@khms.westfalen.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Configure.help editorial policy
In-Reply-To: <8FeKjZHHw-B@khms.westfalen.de>
Message-ID: <Pine.LNX.4.33.0112271538140.4874-100000@unicef.org.yu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Dec 2001, Kai Henningsen wrote:

> tas@mindspring.com (Timothy A. Seufert)  wrote on 22.12.01 in <p05101000b84a980dd9e1@[10.0.0.42]>:
>
> > Vojtech Pavlich wrote:
> >
> > >4Mbit bandwidth is usually 4 * 10^3 * 2^10 bits per second.
> > >20GB harddrive is usually 20 * 10^6 * 2^10 bytes.
> >
> > A 20 GB hard drive is always 20 * 10^9 bytes.  I'm not sure why so
> > many people on the linux-kernel list think otherwise, but the hard
> > drive industry is quite consistent in its use of power-of-10 units to
> > describe capacity.  See:
>
> >From dmesg:
>
> "195371568 sectors (100030 MB)" (calls itself 100)
> "8250001 512-byte hdwr sectors (4224 MB)" (calls itself 4330)
>
> I take back whatever I said. It's not 1024^n. It's not 1024*1000^n. It's
> not 1000^n. I don't know what it is, except it's all a lie.
>
perhaps it is true.

in old days they were specified
for floppy disks and very old hd drives
so you had like floppy diskette 2MB diskette capacity unformated and
 1.44 formated. (so we had 2m1 tools for dos and we can use /dev/fd0u1680)

the same was with hdd's there were disk with capacity 21MB unformated
but if they were with MFM controler they would have 19 with RLL 17MB
that was very old drives.

IN old days you had declared how much can hold unformated media
and how much in PC/CPM/MAC mode.

As I remember 5.25" history floppies in CP/M were unformatted about 450KB
on kaypro formated were 400KB / PC CP/M 86 360KB / and other 320KB
some cp/m like commodore c128D could read all those formats.

I think it is the same with HDD drives they full capcity may be
40GB where 40GB=40*1000M*1000K but real usefull is much less than declared

drive has it's own filesystem whathewer we use on top ot it,
you will realise that if you notice that there is no more low level format
option in bios, further more SMART in drives automatically change or
relocate bad sectors.

BUT I must admit I think it is stupid,
if 1KB is not 1024 bytes or 1Kb is not 1024 bites or 128 bytes.

regards,

 Zoran



