Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318041AbSHDBF0>; Sat, 3 Aug 2002 21:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318043AbSHDBF0>; Sat, 3 Aug 2002 21:05:26 -0400
Received: from dnvrdslgw14poolA183.dnvr.uswest.net ([63.228.84.183]:14892 "EHLO
	q.dyndns.org") by vger.kernel.org with ESMTP id <S318041AbSHDBFZ>;
	Sat, 3 Aug 2002 21:05:25 -0400
Date: Sat, 3 Aug 2002 19:09:21 -0600 (MDT)
From: Benson Chow <blc@q.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: issues with 2.4.19 that didn't exist in 2.4.18...
Message-ID: <Pine.LNX.4.44.0208031903530.21857-100000@q.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this new in 2.4.19, and my busmaster IDE doesn't work:

---------------
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ICH3M: IDE controller on PCI bus 00 dev f9
PCI: Device 00:1f.1 not available because of resource collisions
ICH3M: (ide_setup_pci_device:) Could not enable device.
--------------

lspci
[...]
00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 41)
00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 01)
00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 01)
00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus (rev 01)
00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem (rev 01)
[...]

Yep, that's my IDE controller allright.

The machine kept on crashing on me too before I could get this to even
boot.  2.4.18 works fine and bmide works...

Likely I have a broken bios or something, but something changed?

Thanks,

-bc

