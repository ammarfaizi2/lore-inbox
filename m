Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264669AbSKDNj7>; Mon, 4 Nov 2002 08:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264673AbSKDNj7>; Mon, 4 Nov 2002 08:39:59 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:38021 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S264669AbSKDNj4> convert rfc822-to-8bit; Mon, 4 Nov 2002 08:39:56 -0500
Date: Tue, 5 Nov 2002 00:46:04 +1100
From: CaT <cat@zip.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.45 / boottime oops (pnp bios I think)
Message-ID: <20021104134604.GE3088@zip.com.au>
References: <20021104025458.GA3088@zip.com.au> <1036415133.1106.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1036415133.1106.10.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2002 at 01:05:32PM +0000, Alan Cox wrote:
> On Mon, 2002-11-04 at 02:54, CaT wrote:
> > When I unselect PNP BIOS the kernel boots fine. With it I get the
> > oops below. Please note that it was typed out manually and that that was
> > all that I could get as I could not scroll up or down in any way.
> > 
> > The PC is a Gateway laptop.
> 
> Buggy PnP bios please provide dmidecode output for that box

Is this what you wanted?

SYSID present.
SMBIOS present.
DMI 0.0 present.
35 structures occupying 1144 bytes.
DMI table at 0x000D0010.
Handle 0x0000
	DMI type 0, 20 bytes.
	BIOS Information Block
		Vendor Gateway
		Version 22.07
		Release 01/31/2001
		BIOS base 0xE5D90
		ROM size 448K
		Capabilities:
			Flags: 0x000000007C3BDF90
Handle 0x0001
	DMI type 1, 25 bytes.
	System Information Block
		Vendor Gateway
		Product Solo5300
		Version Rev 1.0
		Serial Number 0001653781
Handle 0x0002
	DMI type 2, 8 bytes.
	Board Information Block
		Vendor Gateway
		Product Solo5300
		Version Rev 1.0
		Serial Number None
Handle 0x0003
	DMI type 3, 17 bytes.
	Chassis Information Block
		Vendor Gateway
		Product °¼A
		Version N/A
		Serial Number None
		Asset Tag No Asset Tag
Handle 0x0004
	DMI type 4, 35 bytes.
Handle 0x0005
	DMI type 5, 20 bytes.
Handle 0x0006
	DMI type 6, 12 bytes.
	Memory Bank
		Socket: J2
		Banks: 0 1
		Type: 
		Installed Size: 128Mbyte (Double sided)
		Enabled Size: 128Mbyte (Double sided)
Handle 0x0007
	DMI type 6, 12 bytes.
	Memory Bank
		Socket: J3
		Banks: 2 3
		Type: 
		Installed Size: 128Mbyte (Double sided)
		Enabled Size: 128Mbyte (Double sided)
Handle 0x0008
	DMI type 7, 19 bytes.
	Cache
		Socket: L1 Cache
		L1 socketed Internal Cache: write-back
		L1 Cache Size: 32K
		L1 Cache Maximum: 32K
		L1 Cache Type: Asynchronous 
Handle 0x0009
	DMI type 7, 19 bytes.
	Cache
		Socket: L2 Cache
		L2 socketed External Cache: write-back
		L2 Cache Size: 512K
		L2 Cache Maximum: 256K
		L2 Cache Type: Burst 
Handle 0x000A
	DMI type 8, 9 bytes.
Handle 0x000B
	DMI type 8, 9 bytes.
Handle 0x000C
	DMI type 8, 9 bytes.
Handle 0x000D
	DMI type 8, 9 bytes.
Handle 0x000E
	DMI type 8, 9 bytes.
Handle 0x000F
	DMI type 8, 9 bytes.
Handle 0x0010
	DMI type 8, 9 bytes.
Handle 0x0011
	DMI type 8, 9 bytes.
Handle 0x0012
	DMI type 8, 9 bytes.
Handle 0x0013
	DMI type 9, 13 bytes.
	Card Slot
		Slot: Mini PCI Slot J20
		Type: 32bit PCI 
		Status: In use.
		Slot Features: 5v 3.3v 
Handle 0x0014
	DMI type 9, 13 bytes.
	Card Slot
		Slot: CardBUS 0
		Type: 32bit PCMCIA VLB 
		Slot Features: 5v 3.3v PCCard16 CardBus Zoom-Video ModemRingResume 
Handle 0x0015
	DMI type 9, 13 bytes.
	Card Slot
		Slot: CardBUS 1
		Type: 32bit PCMCIA VLB 
		Slot Features: 5v 3.3v PCCard16 CardBus Zoom-Video ModemRingResume 
Handle 0x0016
	DMI type 10, 10 bytes.
Handle 0x0017
	DMI type 11, 5 bytes.
	OEM Data
		Gateway Solo 5300 Mobile System
Handle 0x0018
	DMI type 16, 15 bytes.
Handle 0x0019
	DMI type 17, 27 bytes.
Handle 0x001A
	DMI type 17, 27 bytes.
Handle 0x001B
	DMI type 19, 15 bytes.
Handle 0x001C
	DMI type 20, 19 bytes.
Handle 0x001D
	DMI type 20, 19 bytes.
Handle 0x001E
	DMI type 21, 7 bytes.
Handle 0x001F
	DMI type 22, 26 bytes.
Handle 0x0020
	DMI type 22, 26 bytes.
Handle 0x0021
	DMI type 32, 20 bytes.
Handle 0x0022
	DMI type 127, 4 bytes.

-- 
        All people are equal,
        But some are more equal then others.
            - George W. Bush Jr, President of the United States
              September 21, 2002 (Abridged version of security speech)
