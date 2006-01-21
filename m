Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbWAUDxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbWAUDxd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 22:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWAUDxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 22:53:33 -0500
Received: from relay00.pair.com ([209.68.5.9]:13586 "HELO relay00.pair.com")
	by vger.kernel.org with SMTP id S932397AbWAUDxb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 22:53:31 -0500
X-pair-Authenticated: 67.163.102.102
From: Chase Venters <chase.venters@clientec.com>
Organization: Clientec, Inc.
To: Anton Titov <a.titov@host.bg>
Subject: Re: OOM Killer killing whole system
Date: Fri, 20 Jan 2006 21:53:05 -0600
User-Agent: KMail/1.9
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
References: <1137337516.11767.50.camel@localhost> <1137806248.4122.11.camel@mulgrave> <1137815109.11771.77.camel@localhost>
In-Reply-To: <1137815109.11771.77.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601202153.27386.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 January 2006 21:44, Anton Titov wrote:
> 00:00.0 Host bridge: Intel Corporation 915G/P/GV/GL/PL/910GL Processor
> to I/O Controller (rev 0e)
> 00:02.0 VGA compatible controller: Intel Corporation 82915G/GV/910GL
> Express Chipset Family Graphics Controller (rev 0e)
> 00:02.1 Display controller: Intel Corporation 82915G Express Chipset
> Family Graphics Controller (rev 0e)
> 00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
> Family) PCI Express Port 1 (rev 03)
> 00:1c.1 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
> Family) PCI Express Port 2 (rev 03)
> 00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d3)
> 00:1f.0 ISA bridge: Intel Corporation 82801FB/FR (ICH6/ICH6R) LPC
> Interface Bridge (rev 03)
> 00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
> Family) IDE Controller (rev 03)
> 00:1f.2 SATA controller: Intel Corporation 82801FR/FRW (ICH6R/ICH6RW)
> SATA Controller (rev 03)
> 00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
> SMBus Controller (rev 03)
> 01:04.0 Mass storage controller: <pci_lookup_name: buffer too small>
> (rev 13)
> 02:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8053 PCI-E
> Gigabit Ethernet Controller (rev 15)

Random guess... Asus P5GDC-V with Firewire and USB turned off?

00:00.0 Host bridge: Intel Corporation 915G/P/GV/GL/PL/910GL Processor to I/O 
Controller (rev 04)
00:01.0 PCI bridge: Intel Corporation 915G/P/GV/GL/PL/910GL PCI Express Root 
Port (rev 04)
00:1b.0 Class 0403: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) High 
Definition Audio Controller (rev 03)
00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI 
Express Port 1 (rev 03)
00:1c.1 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI 
Express Port 2 (rev 03)
00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #1 (rev 03)
00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #2 (rev 03)
00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #3 (rev 03)
00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #4 (rev 03)
00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB2 EHCI Controller (rev 03)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d3)
00:1f.0 ISA bridge: Intel Corporation 82801FB/FR (ICH6/ICH6R) LPC Interface 
Bridge (rev 03)
00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
IDE Controller (rev 03)
00:1f.2 Class 0106: Intel Corporation 82801FR/FRW (ICH6R/ICH6RW) SATA 
Controller (rev 03)
00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus 
Controller (rev 03)
01:03.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 
Controller (PHY/Link)
01:04.0 Mass storage controller: <pci_lookup_name: buffer too small> (rev 13)
01:09.0 Multimedia audio controller: Creative Labs SB Audigy (rev 04)
01:09.1 Input device controller: Creative Labs SB Audigy MIDI/Game port (rev 
04)
01:09.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port (rev 04)
01:0a.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
02:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8053 Gigabit 
Ethernet Controller (rev 15)
04:00.0 VGA compatible controller: nVidia Corporation Unknown device 0092 (rev 
a1)

Also using Marvell's sk98lin driver (iirc, sky2 should supercede it soon 
enough). This is the only machine I'm using sk98lin on, but I haven't had any 
trouble with it on prior kernels.

Thanks,
Chase
