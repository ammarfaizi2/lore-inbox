Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130463AbQKUOVd>; Tue, 21 Nov 2000 09:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130657AbQKUOVX>; Tue, 21 Nov 2000 09:21:23 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62786 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130463AbQKUOVQ>; Tue, 21 Nov 2000 09:21:16 -0500
Subject: Linux 2.4.0test11-ac1
To: linux-kernel@vger.kernel.org
Date: Tue, 21 Nov 2000 13:51:53 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13yDpy-0004ir-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Differences between 2.4.0test11ac1 and 2.4.0test11, pretty much all merged
from stuff off the maintainers and kernel list. 

For newcomers to these patches:

-	You can find them on ftp.*.kernel.org/pub/linux/kernel/people/alan
-	They are diffed against the base revision not cumulative diffs
-	Please report -ac bugs to me. I'm sure Linus doesn't want to know
	unless you can duplicate the problem on unadulterated 2.4test

Change Log

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
