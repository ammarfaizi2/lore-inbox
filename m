Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275662AbTHOCv4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 22:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275663AbTHOCv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 22:51:56 -0400
Received: from inova102.correio.tnext.com.br ([200.222.67.102]:63400 "HELO
	leia-auth.correio.tnext.com.br") by vger.kernel.org with SMTP
	id S275662AbTHOCvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 22:51:55 -0400
X-Analyze: Velop Mail Shield v0.0.3
Date: Thu, 14 Aug 2003 23:51:48 -0300 (E. South America Standard Time)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <0@pervalidus.tk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: How do IDE chipset drivers work as modules ?
Message-ID: <Pine.WNT.4.56.0308142338470.3912@pervalidus>
X-X-Sender: fredlwm@postaccesslite.com@[212.15.85.11]
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.6.0-test3. First time I try this. Does initrd make it
work ?

I thought modprobe via82cxxx, but:

Aug 14 17:00:36 pervalidus kernel: VP_IDE: IDE controller at PCI slot 0000:00:11.1
Aug 14 17:00:36 pervalidus kernel: VP_IDE: chipset revision 6
Aug 14 17:00:36 pervalidus kernel: VP_IDE: not 100%% native mode: will probe irqs later
Aug 14 17:00:36 pervalidus kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Aug 14 17:00:36 pervalidus kernel: VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
Aug 14 17:00:36 pervalidus kernel:     ide0: BM-DMA at 0xe800-0xe807, BIOS settings: hda:DMA, hdb:pio
Aug 14 17:00:36 pervalidus kernel:     ide1: BM-DMA at 0xe808-0xe80f, BIOS settings: hdc:DMA, hdd:DMA
Aug 14 17:00:36 pervalidus kernel: ide0: I/O resource 0x3F6-0x3F6 not free.
Aug 14 17:00:36 pervalidus kernel: hda: ERROR, PORTS ALREADY IN USE
Aug 14 17:00:36 pervalidus kernel: register_blkdev: cannot get major 3 for ide0
Aug 14 17:00:36 pervalidus kernel: ide1: I/O resource 0x376-0x376 not free.
Aug 14 17:00:36 pervalidus kernel: hdc: ERROR, PORTS ALREADY IN USE
Aug 14 17:00:36 pervalidus kernel: hdd: ERROR, PORTS ALREADY IN USE
Aug 14 17:00:36 pervalidus kernel: register_blkdev: cannot get major 22 for ide 1
Aug 14 17:00:36 pervalidus kernel: Module via82cxxx cannot be unloaded due to unsafe usage in include/linux/module.h:483
