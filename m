Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316484AbSFALEB>; Sat, 1 Jun 2002 07:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316571AbSFALEA>; Sat, 1 Jun 2002 07:04:00 -0400
Received: from kc.hitachisoftware.com ([205.158.62.105]:63648 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S316484AbSFALD7>; Sat, 1 Jun 2002 07:03:59 -0400
Message-ID: <20020601110355.26944.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Anthony Spinillo" <tspinillo@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Sat, 01 Jun 2002 19:03:55 +0800
Subject: INTEL 845G Chipset IDE Quandry
X-Originating-Ip: 24.49.78.239
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having trouble enabling DMA on a recently
installed motherboard. (Intel D845GBVL - 845g chipset). I am running a fresh RedHat7.3 install 
and have tried the stock RH kernel, and I'm up to 2.4.19-pre9. I have a CD burner and DVD drive 
attached which operated with DMA on an older 
845 mobo. If I run hdparm -d1 /dev/hd(a or c),
I now get:

HDIO_SET_DMA failed: Operation not permitted

Here is a snippet from dmesg:

ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
PCI_IDE: unknown IDE controller on PCI bus 00 device
f9, VID=8086, DID=24cb
PCI: Device 00:1f.1 not available because of resource
collisions
PCI_IDE: (ide_setup_pci_device:) Could not enable
device.

Here is some lspci

00:00.0 Host bridge: Intel Corp.: Unknown device 2560 (rev 01)
00:01.0 PCI bridge: Intel Corp.: Unknown device 2561 (rev 01)
00:1d.0 USB Controller: Intel Corp.: Unknown device 24c2 (rev 01)
00:1d.1 USB Controller: Intel Corp.: Unknown device 24c4 (rev 01)
00:1d.2 USB Controller: Intel Corp.: Unknown device 24c7 (rev 01)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA PCI Bridge (rev 81)
00:1f.0 ISA bridge: Intel Corp.: Unknown device 24c0 (rev 01)
00:1f.1 IDE interface: Intel Corp.: Unknown device 24cb (rev 01)

I followed some recent threads, and tried fixes to similiar problems but I'm still locked out.

Aside from this glitch everything else seems to run fine. Could someone give my a hand? Am I missing something simple, is my bios borked, or do I need a patch to support the newer chipset?

Thanks,

Tony

-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
