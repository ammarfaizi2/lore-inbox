Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262410AbSKCUx4>; Sun, 3 Nov 2002 15:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262411AbSKCUx4>; Sun, 3 Nov 2002 15:53:56 -0500
Received: from steve.prima.de ([62.72.84.2]:5008 "HELO steve.prima.de")
	by vger.kernel.org with SMTP id <S262410AbSKCUxy>;
	Sun, 3 Nov 2002 15:53:54 -0500
Date: Sun, 3 Nov 2002 21:55:53 +0100
From: Patrick Mau <mau@oscar.prima.de>
To: William Lee Irwin III <wli@holomorphy.com>,
       Patrick Mau <mau@oscar.prima.de>,
       Margit Schubert-While <margit@margit.com>, linux-kernel@vger.kernel.org
Subject: Re: U160 on Adaptec 39160
Message-ID: <20021103205553.GA10923@oscar.homelinux.net>
Reply-To: Patrick Mau <mau@oscar.prima.de>
References: <4.3.2.7.2.20021103124403.00b4c860@mail.dns-host.com> <20021103133014.GJ23425@holomorphy.com> <20021103195325.GA9689@oscar.homelinux.net> <20021103200340.GL23425@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021103200340.GL23425@holomorphy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, Nov 03, 2002 at 08:53:25PM +0100, Patrick Mau wrote:
> > the Adaptec 39160 is indeed capable of doing 160MB/s/channel. Did I
> > misread the whole thread ? Here's the dmesg output of my system.
> > I get >40MB/s per disk and >80MB/s per channel.
> > Maybe it's because of your DVD and DAT device. I only have disks
> > connected to the adapter.
> 
> 64-bit vs. 32-bit PCI. Please follow up with the PCI info from dmesg
> to let them know of where to get the (uncommon/expensive) right hardware.
> 
> 
> Bill

Hi Bill,

I don't exactly know what PCI Info you want from dmesg.
My (uncommon ?) hardware includes the following:

ASUS P4T533-C (Intel 850 chipset)
Pentium IV 2.4 GHz
512MB PC1600 RDRAM
Intel E100 LAN Onboard
Sound Onboard

Radeon 8500QL AGP
Adaptec 39160D Kit

Kind regards,
Patrick

PS: I ordered every piece online from http://www.wave-comnputer.de/
    It's really no fancy Server Mainboard or something special.

PPS: If you want further information on the specs, let me know.

[root@tony] lspci
00:00.0 Host bridge: Intel Corp. 82850 850 (Tehama) Chipset Host Bridge (MCH) (rev 04)
00:01.0 PCI bridge: Intel Corp. 82850 850 (Tehama) Chipset AGP Bridge (rev 04)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA PCI Bridge (rev 04)
00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 04)
00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 04)
00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audio (rev 04)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon QL
02:04.0 USB Controller: NEC Corporation USB (rev 41)
02:04.1 USB Controller: NEC Corporation USB (rev 41)
02:04.2 USB Controller: NEC Corporation USB 2.0 (rev 02)
02:08.0 Ethernet controller: Intel Corp. 82801BA/BAM/CA/CAM Ethernet Controller (rev 03)
02:0a.0 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m (rev 01)
02:0a.1 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m (rev 01)

