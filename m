Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130090AbQKBMFN>; Thu, 2 Nov 2000 07:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130473AbQKBMFD>; Thu, 2 Nov 2000 07:05:03 -0500
Received: from cmailg5.svr.pol.co.uk ([195.92.195.175]:49469 "EHLO
	cmailg5.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S130090AbQKBMEx>; Thu, 2 Nov 2000 07:04:53 -0500
Date: Thu, 2 Nov 2000 12:03:41 +0000 (UTC)
From: Mo McKinlay <mmckinlay@gnu.org>
To: linux-kernel@vger.kernel.org
Subject: ESS device "1998"
Message-ID: <Pine.LNX.4.21.0011021158250.8426-100000@kyle.altai.org>
Organization: inter/open Labs
X-URL: http://www.interopen.org/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I recently obtained an HP Omnibook XE2 laptop. It's a reasonably
nicely-specced machine, although (unsuprsingly) the hardware isn't too
well supported with Linux.

I've given up on the internal modem (I'm 90% sure it's some kind of
software modem, and I have an external anyway), but I'm trying to get
some sort of audio to work via the internal sound device.

Here's the output of 'lspci':

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(rev 03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge
(rev 03)
00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 03)
00:0a.0 CardBus bridge: Texas Instruments PCI1225 (rev 01)
00:0a.1 CardBus bridge: Texas Instruments PCI1225 (rev 01)
00:0d.0 Multimedia audio controller: ESS Technology: Unknown device 1998
00:0d.1 Communication controller: ESS Technology: Unknown device 1999
01:00.0 VGA compatible controller: Silicon Motion, Inc.: Unknown device
0710 (rev a3)
20:00.0 Ethernet controller: Xircom Cardbus Ethernet 10/100 (rev 03)
20:00.1 Serial controller: Xircom Cardbus Ethernet + 56k Modem (rev 03)

I'm currently using 2.2.14 (plus whichever patches RH added for their 6.2
release), and it doesn't seem to be supported. So.. simple question, does
anybody know if this 'card' is supported in a more recent kernel, or
whether there's something in 2.2.14 that works?

[As an aside, from watching Windows boot, it seems to have some sort of
SoundBlaster compatibility, although it seems to lack MPU401 support or
emulation - and any attempts to use the Linux soundblaster stuff seems to
fail miserably :/]

Any hints/clues/etc welcome.

Many thanks,

Mo.

-- 
Mo McKinlay
mmckinlay@gnu.org
-------------------------------------------------------------------------
GnuPG/PGP Key: pub  1024D/76A275F9 2000-07-22






-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
