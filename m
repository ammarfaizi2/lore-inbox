Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263001AbSJBIlh>; Wed, 2 Oct 2002 04:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263002AbSJBIlh>; Wed, 2 Oct 2002 04:41:37 -0400
Received: from stud3.tuwien.ac.at ([193.170.75.13]:28662 "EHLO
	stud3.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S263001AbSJBIlf>; Wed, 2 Oct 2002 04:41:35 -0400
Date: Wed, 2 Oct 2002 10:47:03 +0200
From: Stefan Schwandter <swan@shockfrosted.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.40: problems with cmd649 ide
Message-ID: <20021002084703.GA640@TK150122.tuwien.teleweb.at>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!


I can't use my cdrom drive at the moment with 2.5.40. I've appended the
ide-related output from /var/log/messages. Please tell me if you need
more data.


regards, Stefan

-- 
----> http://www.shockfrosted.org

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ide-errors

Oct  2 10:41:33 TK150122 kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Oct  2 10:41:33 TK150122 kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Oct  2 10:41:33 TK150122 kernel: CMD649: IDE controller at PCI slot 00:07.0
Oct  2 10:41:33 TK150122 kernel: CMD649: chipset revision 2
Oct  2 10:41:33 TK150122 kernel: CMD649: not 100%% native mode: will probe irqs later
Oct  2 10:41:33 TK150122 kernel: CMD649: ROM enabled at 0xdff00000
Oct  2 10:41:33 TK150122 kernel:     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:pio, hdb:pio
Oct  2 10:41:33 TK150122 kernel:     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio
Oct  2 10:41:33 TK150122 kernel: hda: ST360021A, ATA DISK drive
Oct  2 10:41:33 TK150122 kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Oct  2 10:41:33 TK150122 kernel: dffd1e34 c0115b54 c02f26e0 c02f7af0 0000055e 00000002 c013301f c02f7af0 
Oct  2 10:41:33 TK150122 kernel:        0000055e 00000000 ffffffff dffd1ee3 00000002 0000000a ffffffff 00000001 
Oct  2 10:41:33 TK150122 kernel:        c0165a60 0000004f 000001d0 00000048 c03e9f00 dffd1eea dffd1ee0 ffffffff 
Oct  2 10:41:33 TK150122 kernel: Call Trace:
Oct  2 10:41:33 TK150122 kernel:  [__might_sleep+84/96]__might_sleep+0x54/0x60
Oct  2 10:41:33 TK150122 kernel:  [kmalloc+79/544]kmalloc+0x4f/0x220
Oct  2 10:41:33 TK150122 kernel:  [proc_create+128/256]proc_create+0x80/0x100
Oct  2 10:41:33 TK150122 kernel:  [proc_mkdir+23/64]proc_mkdir+0x17/0x40
Oct  2 10:41:33 TK150122 kernel:  [register_irq_proc+95/112]register_irq_proc+0x5f/0x70
Oct  2 10:41:33 TK150122 kernel:  [setup_irq+198/224]setup_irq+0xc6/0xe0
Oct  2 10:41:33 TK150122 kernel:  [ide_intr+0/368]ide_intr+0x0/0x170
Oct  2 10:41:33 TK150122 kernel:  [request_irq+136/176]request_irq+0x88/0xb0
Oct  2 10:41:33 TK150122 kernel:  [init_irq+505/864]init_irq+0x1f9/0x360
Oct  2 10:41:33 TK150122 kernel:  [ide_intr+0/368]ide_intr+0x0/0x170
Oct  2 10:41:33 TK150122 kernel:  [hwif_init+262/592]hwif_init+0x106/0x250
Oct  2 10:41:33 TK150122 kernel:  [probe_hwif_init+28/112]probe_hwif_init+0x1c/0x70
Oct  2 10:41:33 TK150122 kernel:  [ide_setup_pci_device+61/112]ide_setup_pci_device+0x3d/0x70
Oct  2 10:41:33 TK150122 kernel:  [cmd64x_init_one+51/64]cmd64x_init_one+0x33/0x40
Oct  2 10:41:33 TK150122 kernel:  [init+47/384]init+0x2f/0x180
Oct  2 10:41:33 TK150122 kernel:  [init+0/384]init+0x0/0x180
Oct  2 10:41:33 TK150122 kernel:  [kernel_thread_helper+5/16]kernel_thread_helper+0x5/0x10
Oct  2 10:41:33 TK150122 kernel: 
Oct  2 10:41:33 TK150122 kernel: ide0 at 0xe800-0xe807,0xe402 on irq 18
Oct  2 10:41:33 TK150122 kernel: hdc: IRQ probe failed (0xfffbfcba)
Oct  2 10:41:33 TK150122 kernel: hdc: IRQ probe failed (0xfffbfcba)
Oct  2 10:41:33 TK150122 kernel: hdc: CD-RW CRX100E, ATAPI CD/DVD-ROM drive
Oct  2 10:41:33 TK150122 kernel: hdc: IRQ probe failed (0xfffbfcba)
Oct  2 10:41:33 TK150122 kernel: hdd: IRQ probe failed (0xfffbfcba)
Oct  2 10:41:33 TK150122 kernel: hdd: IRQ probe failed (0xfffbfcba)
Oct  2 10:41:33 TK150122 kernel: ide1: DISABLED, NO IRQ
Oct  2 10:41:33 TK150122 kernel: hdc: ERROR, PORTS ALREADY IN USE
Oct  2 10:41:33 TK150122 kernel: hda: host protected area => 1
Oct  2 10:41:33 TK150122 kernel: hda: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=116301/16/63, UDMA(100)
Oct  2 10:41:33 TK150122 kernel:  hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 >

--AhhlLboLdkugWU4S--
