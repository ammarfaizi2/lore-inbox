Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262924AbSJTPiO>; Sun, 20 Oct 2002 11:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262933AbSJTPiO>; Sun, 20 Oct 2002 11:38:14 -0400
Received: from ulima.unil.ch ([130.223.144.143]:17280 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S262924AbSJTPiN>;
	Sun, 20 Oct 2002 11:38:13 -0400
Date: Sun, 20 Oct 2002 17:44:17 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.5.44 and IDE, what does that mean?
Message-ID: <20021020154417.GA14338@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I got those at boot:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 00:1f.1
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:pio, hdd:pio
hda: IC35L120AVVA07-0, ATA DISK drive
IDE init is ugly:Call Trace: [<c0264791>]  [<c0261203>]  [<c02612ae>]  [<c0261317>]  [<c02704ae>]  [<c027058e>]  [<c02706f0>]  [<c025c81f>]  [<c025c9da>]  [<c0264500>]  [<c025cfd8>]  [<c025c6a4>]  [<c026e030>]  [<c010506a>]  [<c0105040>]  [<c0105615>] 
hda: bad special flag: 0x03
IDE init is ugly:Call Trace: [<c0264791>]  [<c0261203>]  [<c02612ae>]  [<c0261317>]  [<c0270513>]  [<c027058e>]  [<c02706f0>]  [<c025c81f>]  [<c025c9da>]  [<c0264500>]  [<c025cfd8>]  [<c025c6a4>]  [<c026e030>]  [<c010506a>]  [<c0105040>]  [<c0105615>] 
hda: tagged command queueing enabled, command queue depth 32
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 241254720 sectors (123522 MB) w/1863KiB Cache, CHS=15017/255/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 >
ide-floppy driver 0.99.newide
hdc: 244766kB, 489532 blocks, 512 sector size
hdc: 244736kB, 239/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
hdc: The disk reports a capacity of 250640384 bytes, but the drive only handles 250609664
hdc: The disk reports a capacity of 250640384 bytes, but the drive only handles 250609664
 /dev/ide/host0/bus1/target0/lun0: unknown partition table
 /dev/ide/host0/bus1/target0/lun0: unknown partition table
SCSI subsystem driver Revision: 1.00

Thank you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
