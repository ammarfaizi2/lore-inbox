Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266560AbSLWDcy>; Sun, 22 Dec 2002 22:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266555AbSLWDcy>; Sun, 22 Dec 2002 22:32:54 -0500
Received: from bay2-f160.bay2.hotmail.com ([65.54.247.160]:33544 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id <S266560AbSLWDcx>;
	Sun, 22 Dec 2002 22:32:53 -0500
X-Originating-IP: [24.186.225.115]
From: "Mark F." <daracerz@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: ATI Radeon IGP 320M and Kern. 2.4.21-pre2 Warnings/Problems...
Date: Sun, 22 Dec 2002 22:40:56 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY2-F160dWMJ69ik6k0000047c@hotmail.com>
X-OriginalArrivalTime: 23 Dec 2002 03:40:57.0151 (UTC) FILETIME=[1A5434F0:01C2AA35]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

In trying to help out the issue with the Radeon IGP Chipsets, I have posted 
out the problems that occured on my system.  This is a Readon IGP 320M chip, 
running on a Compaq 900Z.  BTW, these logs don't include loading sound 
driver.  Sound driver cause the my hda, hdc links to timeout, and the hard 
drives are completely inaccesable till i remake kernel without them.



Kernel Log Output:  (IRQ Porting Issue,  Computer wants IRQ11 to be used)

EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
Adding Swap: 1076344k swap-space (priority -1)
ohci1394: $Rev: 693 $ Ben Collins <bcollins@debian.org>
PCI: Assigned IRQ 10 for device 00:13.0
IRQ routing conflict for 00:0b.0, have irq 11, want irq 10
PCI: Sharing IRQ 10 with 00:0c.0
PCI: Sharing IRQ 10 with 01:05.0
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[10]  MMIO=[f4017000-f40177ff]  Max 
Packet=[2048]
ieee1394: SelfID completion called outside of bus reset!
ieee1394: Host added: Node[00:1023]  GUID[000802719b9e938a]  [Linux 
OHCI-1394]


LSPCI Output:
00:00.0 Host bridge: ATI Technologies Inc: Unknown device cab0 (rev 13)
00:01.0 PCI bridge: ATI Technologies Inc: Unknown device 700f (rev 01)
00:02.0 USB Controller: Acer Laboratories Inc. [ALi] USB 1.1 Controller (rev 
03)
00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge 
[Aladdin IV]
00:08.0 Multimedia audio controller: Acer Laboratories Inc. [ALi] M5451 PCI 
AC-Link Controller Audio Device (rev 02)
00:0a.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller 
(rev 02)
00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 20)
00:0c.0 Communication controller: Conexant HSF 56k HSFi Modem (rev 01)
00:0f.0 USB Controller: Acer Laboratories Inc. [ALi] USB 1.1 Controller (rev 
03)
00:10.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c4)
00:11.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
00:13.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 
Controller (PHY/Link)
01:05.0 VGA compatible controller: ATI Technologies Inc: Unknown device 4336


>From what I know, usb doesn't work either.
will give kernel2.5.52 notes as well at a later time.

Mark

_________________________________________________________________
MSN 8: advanced junk mail protection and 3 months FREE*. 
http://join.msn.com/?page=features/junkmail&xAPID=42&PS=47575&PI=7324&DI=7474&SU= 
http://www.hotmail.msn.com/cgi-bin/getmsg&HL=1216hotmailtaglines_advancedjmf_3mf

