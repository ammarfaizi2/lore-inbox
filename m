Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271743AbTHHSc2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 14:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271744AbTHHSc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 14:32:28 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:3598 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S271743AbTHHScZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 14:32:25 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Dumb question - why is dmesg interleaved with rc.sysinit logs in messages?
Date: Sat, 9 Aug 2003 02:32:02 +0800
User-Agent: KMail/1.5.2
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200308090229.26494.mflt1@micrologica.com.hk>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why is this and how to fix?

Aug  9 00:05:00 mhfl2 kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11, disabled)
Aug  9 00:04:40 mhfl2 rc.sysinit: Remounting root filesystem in read-write mode:  succeeded 
Aug  9 00:05:00 mhfl2 keytable: 
Aug  9 00:05:00 mhfl2 kernel: ACPI: Power Resource [PFN0] (off)
Aug  9 00:04:40 mhfl2 rc.sysinit: Activating swap partitions:  succeeded 
Aug  9 00:05:00 mhfl2 keytable: Loading system font: 
Aug  9 00:05:00 mhfl2 kernel: ACPI: Power Resource [PFN1] (off)
Aug  9 00:04:40 mhfl2 rc.sysinit: Checking filesystems succeeded 
Aug  9 00:05:00 mhfl2 keytable: 
Aug  9 00:05:00 mhfl2 kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Aug  9 00:04:41 mhfl2 mount: mount: fs type mfs not supported by kernel 
Aug  9 00:05:00 mhfl2 keytable: mapscrn: cannot open map file _iso01_
Aug  9 00:04:41 mhfl2 rc.sysinit: Mounting local filesystems:  failed 
Aug  9 00:05:00 mhfl2 kernel: PnPBIOS: Scanning system for PnP BIOS support...
Aug  9 00:05:00 mhfl2 rc: Starting keytable:  succeeded
Aug  9 00:04:41 mhfl2 rc.sysinit: Enabling local filesystem quotas:  succeeded 
Aug  9 00:05:00 mhfl2 kernel: PnPBIOS: PnP BIOS support was not detected.
Aug  9 00:04:43 mhfl2 rc.sysinit: Enabling swap space:  succeeded 
Aug  9 00:05:00 mhfl2 kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
Aug  9 00:04:44 mhfl2 hdparm: /dev/hda: 
Aug  9 00:05:00 mhfl2 kernel: ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 5
Aug  9 00:04:44 mhfl2 hdparm:  setting standby to 12 (1 minutes) 
Aug  9 00:05:00 mhfl2 kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
Aug  9 00:04:44 mhfl2 rc.sysinit: Setting hard drive parameters for hda:  succeeded 
Aug  9 00:05:00 mhfl2 kernel:  pci_irq-0294 [21] acpi_pci_irq_derive   : Unable to derive IRQ for device 0000:00:10.0
Aug  9 00:04:48 mhfl2 init: Entering runlevel: 4 
Aug  9 00:05:01 mhfl2 kernel: ACPI: No IRQ known for interrupt pin A of device 0000:00:10.0 - using IRQ 255
Aug  9 00:04:49 mhfl2 iptables: Flushing all current rules and user defined chains: 
Aug  9 00:05:01 mhfl2 random: Initializing random number generator:  succeeded
Aug  9 00:05:01 mhfl2 kernel: ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
Aug  9 00:04:49 mhfl2 iptables:  succeeded 
Aug  9 00:05:01 mhfl2 kernel: ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 7
Aug  9 00:04:49 mhfl2 iptables: ^[[60G 
Aug  9 00:05:01 mhfl2 kernel: PCI: Using ACPI for IRQ routing
Aug  9 00:04:49 mhfl2 iptables: [   
Aug  9 00:05:01 mhfl2 kernel: PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Aug  9 00:04:49 mhfl2 iptables: ^[[0;32mOK 
Aug  9 00:04:49 mhfl2 iptables:  
Aug  9 00:05:01 mhfl2 kernel: vga16fb: mapped to 0xc00a0000
Aug  9 00:04:49 mhfl2 iptables: Clearing all current rules and user defined chains: 
Aug  9 00:05:01 mhfl2 kernel: fb0: VGA16 VGA frame buffer device
Aug  9 00:04:49 mhfl2 iptables:  succeeded 
Aug  9 00:05:01 mhfl2 kernel: pty: 256 Unix98 ptys configured
-- 
Powered by linux-2.6-test2-mm5. Compiled with gcc-2.95-3 - mature and rock solid

2.4/2.6 kernel testing: ACPI PCI interrupt routing, PCI IRQ sharing, swsusp
2.6 kernel testing:     PCMCIA yenta_socket, Suspend to RAM with ACPI S1-S3

More info on swsusp: http://sourceforge.net/projects/swsusp/

