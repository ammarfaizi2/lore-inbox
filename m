Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266844AbTAKAx4>; Fri, 10 Jan 2003 19:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266852AbTAKAx4>; Fri, 10 Jan 2003 19:53:56 -0500
Received: from air-2.osdl.org ([65.172.181.6]:64477 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266844AbTAKAxw>;
	Fri, 10 Jan 2003 19:53:52 -0500
Subject: [STABILITY] Compile / STP metrics for 2.5.56
From: John Cherry <cherry@osdl.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1042246990.32624.30.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 10 Jan 2003 17:03:11 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compile statistics have been for kernel releases from 2.5.46 to 2.5.56
at: www.osdl.org/archive/cherry/stability

Not much change in the warnings and errors between 2.5.55 and 2.5.56. 
However, from 2.5.54 onward, there was a significant increase in both
warnings and errors (see web site).

The latest results show...

                           2.5.55                       2.5.56
                       ------------------------ ------------------------
bzImage (defconfig)      71 warnings/0 errors     67 warnings/0 errors
bzImage (allmodconfig)   48 warnings/11 errors    48 warnings/11 errors
modules (allmodconfig) 3161 warnings/199 errors 3151 warnings/201 errors

The script that generated this data is also at
www.osdl.org/archive/cherry/stability.  Detailed information on warnings
and errors can be found by following the links in the table, but a
summary of the 2.5.56 run is shown here....

Kernel version: 2.5.56
Kernel build: 
   Making bzImage (defconfig): 67 warnings, 0 errors
   Making modules (defconfig): 0 warnings, 0 errors
   Making bzImage (allmodconfig): 48 warnings, 11 errors
   Making modules (allmodconfig): 3151 warnings, 201 errors

Building directories:
   Building fs/adfs: clean
   Building fs/affs: clean
   Building fs/afs: clean
   Building fs/autofs: clean
   Building fs/autofs4: clean
   Building fs/befs: clean
   Building fs/bfs: clean
   Building fs/cifs: 4 warnings, 0 errors
   Building fs/coda: clean
   Building fs/cramfs: clean
   Building fs/devfs: clean
   Building fs/devpts: clean
   Building fs/efs: clean
   Building fs/exportfs: clean
   Building fs/ext2: clean
   Building fs/ext3: clean
   Building fs/fat: clean
   Building fs/freevxfs: clean
   Building fs/hfs: clean
   Building fs/hpfs: clean
   Building fs/hugetlbfs: clean
   Building fs/intermezzo: 2 warnings, 0 errors
   Building fs/isofs: clean
   Building fs/jbd: clean
   Building fs/jffs: clean
   Building fs/jffs2: clean
   Building fs/jfs: clean
   Building fs/lockd: 4 warnings, 0 errors
   Building fs/minix: clean
   Building fs/msdos: clean
   Building fs/ncpfs: clean
   Building fs/nfs: clean
   Building fs/nfsd: 2 warnings, 0 errors
   Building fs/nls: clean
   Building fs/ntfs: 3 warnings, 0 errors
   Building fs/openpromfs: clean
   Building fs/partitions: clean
   Building fs/proc: clean
   Building fs/qnx4: clean
   Building fs/ramfs: clean
   Building fs/reiserfs: 1 warnings, 0 errors
   Building fs/romfs: clean
   Building fs/smbfs: 2 warnings, 0 errors
   Building fs/sysfs: clean
   Building fs/sysv: clean
   Building fs/udf: clean
   Building fs/ufs: clean
   Building fs/vfat: clean
   Building fs/xfs: 2 warnings, 0 errors
   Building drivers/acpi: clean
   Building drivers/net: 611 warnings, 20 errors
   Building drivers/media: 166 warnings, 24 errors
   Building drivers/base: clean
   Building drivers/hotplug: 10 warnings, 0 errors
   Building drivers/isdn: 466 warnings, 18 errors
   Building drivers/serial: 1 warnings, 0 errors
   Building drivers/fc4: clean
   Building drivers/char: 373 warnings, 10 errors
   Building drivers/i2c: 3 warnings, 0 errors
   Building drivers/parport: 10 warnings, 0 errors
   Building drivers/mtd: 30 warnings, 4 errors
   Building drivers/usb: 24 warnings, 0 errors
   Building drivers/acorn: clean
   Building drivers/block: 10 warnings, 2 errors
   Building drivers/pcmcia: 13 warnings, 0 errors
   Building drivers/pci: clean
   Building drivers/input: 5 warnings, 0 errors
   Building drivers/pnp: clean
   Building drivers/ide: 45 warnings, 2 errors
   Building drivers/atm: 50 warnings, 0 errors
   Building drivers/oprofile: clean
   Building drivers/ieee1394: 17 warnings, 2 errors
   Building drivers/cdrom: 34 warnings, 0 errors
   Building drivers/zorro: clean
   Building drivers/sgi: clean
   Building drivers/message: 18 warnings, 2 errors
   Building drivers/sbus: clean
   Building drivers/macintosh: 1 warnings, 2 errors
   Building drivers/bluetooth: 15 warnings, 0 errors
   Building drivers/telephony: 11 warnings, 2 errors
   Building drivers/md: 18 warnings, 0 errors
   Building drivers/tc: clean
   Building drivers/mca: clean
   Building drivers/nubus: clean
   Building drivers/misc: clean
   Building drivers/dio: clean
   Building drivers/video/aty: 0 warnings, 2 errors
   Building drivers/video/console: 2 warnings, 0 errors
   Building drivers/video/i810: clean
   Building drivers/video/matrox: 106 warnings, 20 errors
   Building drivers/video/riva: clean
   Building drivers/video/sis: 37 warnings, 3 errors
   Building sound/core: 2 warnings, 0 errors
   Building sound/drivers: 1 warnings, 0 errors
   Building sound/i2c: clean
   Building sound/isa: 105 warnings, 34 errors
   Building sound/oss: 159 warnings, 13 errors
   Building sound/pci: 8 warnings, 0 errors
   Building sound/synth: clean
   Building sound/usb: clean
   Building arch/i386: clean
   Building crypto: clean
   Building lib: clean
   Building net: 312 warnings, 0 errors
   Building security: 2 warnings, 0 errors
   Building sound: 123 warnings, 47 errors
   Building drivers/video: 297 warnings, 35 errors
   Building usr: clean


Error Summary:

   drivers/block: 10 warnings, 2 errors
   drivers/char: 373 warnings, 10 errors
   drivers/ide: 45 warnings, 2 errors
   drivers/ieee1394: 17 warnings, 2 errors
   drivers/isdn: 466 warnings, 18 errors
   drivers/macintosh: 1 warnings, 2 errors
   drivers/media: 166 warnings, 24 errors
   drivers/message: 18 warnings, 2 errors
   drivers/mtd: 30 warnings, 4 errors
   drivers/net: 611 warnings, 20 errors
   drivers/telephony: 11 warnings, 2 errors
   drivers/video: 297 warnings, 35 errors
   drivers/video/aty: 0 warnings, 2 errors
   drivers/video/matrox: 106 warnings, 20 errors
   drivers/video/sis: 37 warnings, 3 errors
   sound: 123 warnings, 47 errors
   sound/isa: 105 warnings, 34 errors
   sound/oss: 159 warnings, 13 errors


Warning Summary:

   drivers/atm: 50 warnings, 0 errors
   drivers/bluetooth: 15 warnings, 0 errors
   drivers/cdrom: 34 warnings, 0 errors
   drivers/hotplug: 10 warnings, 0 errors
   drivers/i2c: 3 warnings, 0 errors
   drivers/input: 5 warnings, 0 errors
   drivers/md: 18 warnings, 0 errors
   drivers/parport: 10 warnings, 0 errors
   drivers/pcmcia: 13 warnings, 0 errors
   drivers/serial: 1 warnings, 0 errors
   drivers/usb: 24 warnings, 0 errors
   drivers/video/console: 2 warnings, 0 errors
   fs/cifs: 4 warnings, 0 errors
   fs/intermezzo: 2 warnings, 0 errors
   fs/lockd: 4 warnings, 0 errors
   fs/nfsd: 2 warnings, 0 errors
   fs/ntfs: 3 warnings, 0 errors
   fs/reiserfs: 1 warnings, 0 errors
   fs/smbfs: 2 warnings, 0 errors
   fs/xfs: 2 warnings, 0 errors
   net: 312 warnings, 0 errors
   security: 2 warnings, 0 errors
   sound/core: 2 warnings, 0 errors
   sound/drivers: 1 warnings, 0 errors
   sound/pci: 8 warnings, 0 errors



-- 
John Cherry <cherry@osdl.org>

