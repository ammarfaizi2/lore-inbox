Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316838AbSFATyY>; Sat, 1 Jun 2002 15:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316849AbSFATyX>; Sat, 1 Jun 2002 15:54:23 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:55302
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S316838AbSFATyV>; Sat, 1 Jun 2002 15:54:21 -0400
Date: Sat, 1 Jun 2002 12:53:41 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Anthony Spinillo <tspinillo@linuxmail.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: INTEL 845G Chipset IDE Quandry
In-Reply-To: <20020601110355.26944.qmail@linuxmail.org>
Message-ID: <Pine.LNX.4.10.10206011253240.5846-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I need to add "24cb" to the list of hosts.

On Sat, 1 Jun 2002, Anthony Spinillo wrote:

> I am having trouble enabling DMA on a recently
> installed motherboard. (Intel D845GBVL - 845g chipset). I am running a fresh RedHat7.3 install 
> and have tried the stock RH kernel, and I'm up to 2.4.19-pre9. I have a CD burner and DVD drive 
> attached which operated with DMA on an older 
> 845 mobo. If I run hdparm -d1 /dev/hd(a or c),
> I now get:
> 
> HDIO_SET_DMA failed: Operation not permitted
> 
> Here is a snippet from dmesg:
> 
> ide: Assuming 33MHz system bus speed for PIO modes;
> override with idebus=xx
> PCI_IDE: unknown IDE controller on PCI bus 00 device
> f9, VID=8086, DID=24cb
> PCI: Device 00:1f.1 not available because of resource
> collisions
> PCI_IDE: (ide_setup_pci_device:) Could not enable
> device.
> 
> Here is some lspci
> 
> 00:00.0 Host bridge: Intel Corp.: Unknown device 2560 (rev 01)
> 00:01.0 PCI bridge: Intel Corp.: Unknown device 2561 (rev 01)
> 00:1d.0 USB Controller: Intel Corp.: Unknown device 24c2 (rev 01)
> 00:1d.1 USB Controller: Intel Corp.: Unknown device 24c4 (rev 01)
> 00:1d.2 USB Controller: Intel Corp.: Unknown device 24c7 (rev 01)
> 00:1e.0 PCI bridge: Intel Corp. 82801BA/CA PCI Bridge (rev 81)
> 00:1f.0 ISA bridge: Intel Corp.: Unknown device 24c0 (rev 01)
> 00:1f.1 IDE interface: Intel Corp.: Unknown device 24cb (rev 01)
> 
> I followed some recent threads, and tried fixes to similiar problems but I'm still locked out.
> 
> Aside from this glitch everything else seems to run fine. Could someone give my a hand? Am I missing something simple, is my bios borked, or do I need a patch to support the newer chipset?
> 
> Thanks,
> 
> Tony
> 
> -- 
> Get your free email from www.linuxmail.org 
> 
> 
> Powered by Outblaze
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

