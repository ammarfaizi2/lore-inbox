Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275050AbTHAGFh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 02:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275051AbTHAGFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 02:05:37 -0400
Received: from mail.gmx.de ([213.165.64.20]:50413 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S275050AbTHAGFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 02:05:35 -0400
Subject: IDE-Controller problems (2.6.0-test2-mm1/2)
From: Benjamin Weber <shawk@gmx.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1059718072.3863.10.camel@athxp.bwlinux.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 01 Aug 2003 08:07:52 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

Since test2-mm1 the kernel will not properly detect or enable my via
IDE-Controller. This is what I get:

VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: (ide_setup_pci_device:) Could not enable device.


2.6.0-test1-mm1 works though:

VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xe800-0xe807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xe808-0xe80f, BIOS settings: hdc:DMA, hdd:DMA


My box is a UP AMD 2700+. Kernel has IO-APIC enabled, but I am passing
the noapic kernel option at boot (cause else my USB is screwed up).

Any ideas?

--
Benjamin

