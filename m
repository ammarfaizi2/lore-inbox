Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129091AbQKWQKv>; Thu, 23 Nov 2000 11:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129153AbQKWQKl>; Thu, 23 Nov 2000 11:10:41 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61972 "EHLO
        the-village.bc.nu") by vger.kernel.org with ESMTP
        id <S129091AbQKWQKc>; Thu, 23 Nov 2000 11:10:32 -0500
Subject: Linux 2.4.0test11-ac3
To: linux-kernel@vger.kernel.org
Date: Thu, 23 Nov 2000 15:40:57 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13yyUc-0007U6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in 2.4.0test11ac3

o	Features is back to flags for compatibility	(me)
o	Cleanup ramdisk namespace			(Jeff Garzik)
o	ACPI updates					(Andrew Grover)
o	Make SET_MODULE_OWNER macro safer		(Jeff Garzik)
o	Hisax needed __init				(Jeff Garzik)
o	Tidy riscom8 and sx namespace			(Jeff Garzik)
o	Tidy network drivers module locking		(Jeff Garzik)
o	APM updates, fix the Dell 5000e check for APM=m	(Stephen Rothwell)
o	Fix module initialization oops 			(Keith Owens)
o	Clean up Abyss driver				(Jeff Garzik)
o	Fix raid linking order				(Neil Brown)
o	Clean up rcpci driver (new style pci etc)	(Jeff Garzik)
o	Fix SCSI / PCI dependancies			(Jeff Garzik)
o	Better trap for MP board with no MP cpu		(Maciej W. Rozycki)
o	Tidy up mad16 driver				(Pavel Rabel)
o	Update EATA driver and Ultrastor driver		(Dario Ballabio)
o	Clean up printk formatting in a few drivers	(me)
o	Disable PMC511 driver - its obviously broken	(me)

Changes in 2.4.0test11ac2

o	Fix pcnet32 printk problems			(Vojtech Pavlik)
o	Fix kd_mksound declaration			(Geert Uytterhoeven)
o	m68k config fixes				(Geert Uytterhoeven)
o	Make uid16 macros safer				(Andreas Schwab)
o	Fix dquot overflow/recovery			(Jan Kara)
o	Rename block_til_ready in generic_serial      (Patrick van de Lageweg)
o	Fix missing Config doc and sound doc error	(Thierry Vignaud)
o	Fix Ruffian Alpha boot				(Ivan Kokshaysky)
o	Bridge handling patches needed for Alpha	(Ivan Kokshaysky /
							Richard Henderson)
o	APM update 					(Stephen Rothwell)
o	Fix SMP build on x86				(Steven Cole)
o	Remove unneeded inits to 0 in ide code	  (Bartlomiej Zolnierkiewicz)
o	IDE documentation fixes			  (Bartlomiej Zolnierkiewicz)
o	Maestro ioctl locking fix			(Zach Brown)
o	NFS atomic fixes				(Trond Myklebust)
o	Drop out escaped hp-plus noise			(me)
o	Make console_* static inline not extern		(Jeff Garzik)
o	Update to new ramfs patches			(David Gibson)
o	Work arounds for broken Dell laptop APM		(me)
	| If you have an Inspiron 5000e please send 
	| me the dmesg of this kernel booting. Thanks
o	Fix aha1542 memory scribbles			(Phil Stracchino)
o	Fix O_SYNC for ext2fs				(Stephen Tweedie)
o	Fix ide scsi printk				(Geert Uytterhoeven)
o	Change the SMP but no apic check to handle
	older Intel boards with 82489DX devices		(me)

Differences between 2.4.0test11ac1 and 2.4.0test11, pretty much all merged
from stuff off the maintainers and kernel list.

o	Documentation for CONFIG_TOSHIBA
o	Updated version of Rusty's kernel-hacking doc
o	Updated SubmittingDrivers
o	Added SubmittingPatches
o	Updated procfs docs
o	Updated initrd docs

o	Support kgcc autodetect
o	Link correctly with ACPI on ACPI_INTERPRETER off
o	Rusty's fixes/review of unsafe set_bit usage
o	Cleanup console_verbose() dunplication
o	MTRR updates (36bit etc)
o	Dont crash on boot with a dual cpu board holding a non intel cpu
o	Ramdisk missing blkdev_put
o	Radio driver cleanups
o	BTTV radio config option
o	Fix qcam VIDIOCGWIN bugs
o	3c503 error return cleanup
o	8390 seperate tx timeout path
o	Acenic update
o	Network driver check/request region fixes
o	Epic100 update
o	Tulip crash fix on weird eeproms
o	ISAPnP hang on boot port fix
o	CS46xx update
o	Maestro pci_enable fix
o	Support mixed pnp and legacy sb cards
o	Fix function prototype in wacom drivr
o	Hopefully fix the bugs in the FAT and HPFS file systems that
	caused fs corruption
o	Fix cramfs vanishing data bug
o	Fix NLS config.in bug for SMB
o	Fix generic bitops bugs
o	Power management locking fixes
o	filemap posix compliance fix
o	Fix pte handling race

Also the ramfs changes are in my tree. I don't plan to submit the ramfs bits
to Linus in their current state, thats just an Alan Convenience


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
