Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277055AbRJHSFA>; Mon, 8 Oct 2001 14:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277054AbRJHSEk>; Mon, 8 Oct 2001 14:04:40 -0400
Received: from web21108.mail.yahoo.com ([216.136.227.110]:37307 "HELO
	web21108.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S277052AbRJHSEb>; Mon, 8 Oct 2001 14:04:31 -0400
Message-ID: <20011008180501.74394.qmail@web21108.mail.yahoo.com>
Date: Mon, 8 Oct 2001 19:05:01 +0100 (BST)
From: =?iso-8859-1?q?Steven=20Newbury?= <s_j_newbury@yahoo.co.uk>
Subject: Re: Tyan Tiger MP AMD760 chipset support
To: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Roy-Magne Mo wrote:
> > > On Sun, Oct 07, 2001 at 03:39:42PM -0400, Willem
> Riede wrote:
> > > That's not the issue, I'm not that ignorant.
sensors-detect
> > > just doesn't find anything!
> > > Upgrade to the cvs version of lm_sensors and the
> i2c drivers.
> > > I can with these modules detect the eeprom, the
AMD756 and the
> > winbond W83782D.
> > > But, however, inserting the winbond driver locks
> the computer hard.
> > I've had the same problem with two Tyan Thunder K7
> motherboards, inserting the
> winbond driver locks the computer hard. However
booting with the "noapic" option
I have had no problems with my ThunderK7 lpci -v below
> solves this. Ideas anyone ? Are the AMD erratas
publicly available ?
Yes they are avaliable from AMD's website (PDF)


00:00.0 Host bridge: Advanced Micro Devices [AMD]:
Unknown device 700c (rev 11)
	Flags: bus master, medium devsel, latency 64
	Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Memory at f4025000 (32-bit, prefetchable) [size=4K]
	I/O ports at 2070 [disabled] [size=4]
	Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: Advanced Micro Devices [AMD]:
Unknown device 700d (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 99
	Bus: primary=00, secondary=01, subordinate=01,
sec-latency=69
	Memory behind bridge: f6000000-f68fffff
	Prefetchable memory behind bridge: fc000000-fdffffff

00:07.0 ISA bridge: Advanced Micro Devices [AMD]:
Unknown device 7410 (rev 02)
	Flags: bus master, medium devsel, latency 0

00:07.1 IDE interface: Advanced Micro Devices [AMD]:
Unknown device 7411 (rev 01) (prog-if 8a [Master SecP
PriP])
	Flags: bus master, medium devsel, latency 64
	I/O ports at f000 [size=16]


--
Steven Newbury


____________________________________________________________
Do You Yahoo!?
Get your free @yahoo.co.uk address at http://mail.yahoo.co.uk
or your free @yahoo.ie address at http://mail.yahoo.ie
