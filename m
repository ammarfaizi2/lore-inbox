Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267146AbTAKG0t>; Sat, 11 Jan 2003 01:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267149AbTAKG0t>; Sat, 11 Jan 2003 01:26:49 -0500
Received: from dt081n53.san.rr.com ([204.210.23.83]:57994 "EHLO
	vortex.ottix.com") by vger.kernel.org with ESMTP id <S267146AbTAKG0s>;
	Sat, 11 Jan 2003 01:26:48 -0500
Message-ID: <3E1FBB35.10305@san.rr.com>
Date: Fri, 10 Jan 2003 22:35:33 -0800
From: Matthew Costello <mattc@san.rr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.19 & 2.4.20 hang without oops...
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My motherboard is a Supermicro P6DBE with the 440BX chipset,
2 x P3 (Katmai) at 450MHz, 512MB RAM.
The output of lspci:

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge 
(rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge 
(rev 03)
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:0f.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] 
(rev 08)
00:10.0 SCSI storage controller: Adaptec AHA-2940U2/U2W
00:12.0 PCI bridge: Hint Corp HB1-SE33 PCI-PCI Bridge (rev 13)
00:14.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] 
(rev 08)
01:08.0 USB Controller: NEC Corporation USB (rev 41)
01:08.1 USB Controller: NEC Corporation USB (rev 41)
01:08.2 USB Controller: NEC Corporation USB 2.0 (rev 02)
01:0b.0 FireWire (IEEE 1394): Texas Instruments TSB12LV26 IEEE-1394 
Controller (Link)
02:00.0 VGA compatible controller: nVidia Corporation RIVA TNT2 Model 64 
(rev 15)

Also two ISA cards:
Adaptec AHA1542C
Digiboard PC/8i

I'd be happy to help track the hang down.  If not I'll have to backport
the firewire changes in 2.4.19/20 to 2.4.18 since the WD firewire drive
is not recognized correctly in 2.4.20.
--- Matthew Costello <mattc@san.rr.com>

