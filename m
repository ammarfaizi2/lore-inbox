Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319465AbSH3GzG>; Fri, 30 Aug 2002 02:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319469AbSH3GzG>; Fri, 30 Aug 2002 02:55:06 -0400
Received: from 210006171136.ctinets.com ([210.6.171.136]:13035 "EHLO
	sml.dyndns.org") by vger.kernel.org with ESMTP id <S319465AbSH3GzF>;
	Fri, 30 Aug 2002 02:55:05 -0400
Message-ID: <3533.192.168.0.99.1030690765.squirrel@sml.dyndns.org>
Date: Fri, 30 Aug 2002 14:59:25 +0800 (HKT)
Subject: System hang when bootup
From: "Thomas Graham" <lkthomas@sml.dyndns.org>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
X-Mailer: SquirrelMail (version 1.2.7)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller on PCI bus 00 dev 15
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SiS745    ATA 100 controller
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:DMA
hda: IBM-DTTA-351680, ATA DISK drive
hdb: CREATIVECD4831E, ATAPI CD/DVD-ROM drive
hdc: IC35L040AVER07-0, ATA DISK drive
hdd: IBM-DTLA-307030, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 33022080 sectors (16907 MB) w/462KiB Cache, CHS=2055/255/63, UDMA(33)
hdc: host protected area => 1
hdc: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63, UDMA(100)
hdd: host protected area => 1
hdd: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=59560/16/63, UDMA(100)
hdb: ATAPI 32X CD-ROM drive, 240kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1
 /dev/ide/host0/bus1/target0/lun0: p1
 /dev/ide/host0/bus1/target1/lun0:

---------------------------------------------------------------------------
This is the sample to show how kernel hang when I plug in my another HD
my HD model is IBM deskstar DPTA-372050 20.5GB 7200RPM
first time I think the problem is come from my HD, so that I try to
install windows and load up from that HD, but windows work fine
I am wonder why linux kernel would hang there, Please let me know if
anyone have idea, Thanks.
-- 
Sourcemage GNU/Linux Unoffical Site: http://sml.dyndns.org


