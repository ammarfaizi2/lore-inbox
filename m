Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263009AbTC1O4C>; Fri, 28 Mar 2003 09:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263016AbTC1O4C>; Fri, 28 Mar 2003 09:56:02 -0500
Received: from smtp4.wanadoo.es ([62.37.236.138]:52620 "EHLO smtp.wanadoo.es")
	by vger.kernel.org with ESMTP id <S263009AbTC1Ozz>;
	Fri, 28 Mar 2003 09:55:55 -0500
Message-ID: <3E8464C3.2020607@wanadoo.es>
Date: Fri, 28 Mar 2003 16:05:39 +0100
From: =?ISO-8859-1?Q?Xos=C9_Vazquez?= <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Compile Regression on i386]-2.4.21-pre6
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

environment: Red Hat LiNUX 7.3

--cut--
Welcome to the [ Compile Regression on i386 ] Filter

This filter generates a list of warnings and errors in the kernel source.
A PASS will be reported if there are no errors found, regardless of the
presence of warning conditions.  It will be uncommon for this to PASS
on kernels that support allmodconfig.  It is nice to dream though.

The primary purpose of this report is to show WHERE the error and warning
messages are being generated.

This kernel does NOT support 'defconfig' (skipping)
This kernel does NOT support 'allmodconfig' (skipping)
This kernel does support 'oldconfig' (including)

Kernel version: 2.4.21-pre6
Kernel build:
   Making bzImage (oldconfig): 6 warnings, 0 errors
   Making modules (oldconfig): 70 warnings, 0 errors

Building directories:
   Building fs/adfs: clean
   Building fs/affs: clean
   Building fs/autofs: clean
   Building fs/autofs4: clean
   Building fs/befs: 4 warnings, 0 errors
   Building fs/bfs: clean
   Building fs/coda: clean
   Building fs/cramfs: clean
   Building fs/devfs: clean
   Building fs/devpts: 0 warnings, 2 errors
   Building fs/efs: clean
   Building fs/ext2: clean
   Building fs/ext3: clean
   Building fs/fat: clean
   Building fs/freevxfs: clean
   Building fs/hfs: clean
   Building fs/hpfs: clean
   Building fs/intermezzo: 1 warnings, 0 errors
   Building fs/isofs: clean
   Building fs/jbd: clean
   Building fs/jffs: clean
   Building fs/jffs2: clean
   Building fs/jfs: clean
   Building fs/lockd: clean
   Building fs/minix: clean
   Building fs/msdos: clean
   Building fs/ncpfs: clean
   Building fs/nfs: clean
   Building fs/nls: clean
   Building fs/ntfs: clean
   Building fs/openpromfs: 19 warnings, 2 errors
   Building fs/partitions: clean
   Building fs/proc: clean
   Building fs/qnx4: clean
   Building fs/ramfs: clean
   Building fs/reiserfs: clean
   Building fs/romfs: clean
   Building fs/smbfs: clean
   Building fs/sysv: clean
   Building fs/udf: clean
   Building fs/ufs: clean
   Building fs/umsdos: clean
   Building fs/vfat: clean
   Building drivers/net: 8 warnings, 0 errors
   Building drivers/block: clean
   Building drivers/char: 11 warnings, 0 errors
   Building drivers/sound: 4 warnings, 0 errors
   Building drivers/pci: clean
   Building drivers/cdrom: clean
   Building drivers/isdn: 1 warnings, 0 errors
   Building drivers/sbus: clean
   Building drivers/ide: clean
   Building drivers/pnp: clean
   Building drivers/misc: clean
   Building drivers/macintosh: 2 warnings, 1 errors
   Building drivers/sgi: clean
   Building drivers/fc4: clean
   Building drivers/nubus: clean
   Building drivers/acorn: clean
   Building drivers/zorro: clean
   Building drivers/dio: clean
   Building drivers/usb: 1 warnings, 0 errors
   Building drivers/tc: clean
   Building drivers/atm: 3 warnings, 0 errors
   Building drivers/parport: clean
   Building drivers/pcmcia: 4 warnings, 0 errors
   Building drivers/i2c: clean
   Building drivers/telephony: 2 warnings, 0 errors
   Building drivers/ieee1394: 1 warnings, 0 errors
   Building drivers/media: clean
   Building drivers/acpi: clean
   Building drivers/mtd: clean
   Building drivers/input: clean
   Building drivers/md: clean
   Building drivers/bluetooth: clean
   Building drivers/message: 0 warnings, 1 errors
   Building drivers/hotplug: clean
   Building drivers/gsc: clean
   Building drivers/hil: clean
   Building drivers/video/aty: clean
   Building drivers/video/intel: clean
   Building drivers/video/matrox: clean
   Building drivers/video/riva: 1 warnings, 0 errors
   Building drivers/video/sis: clean
   Building drivers/video/sti: clean
   Building arch/i386: 0 warnings, 1 errors
   Building lib: clean
   Building net: 1 warnings, 0 errors
   Building drivers/video: 8 warnings, 0 errors


Error Summary:

   arch/i386: 0 warnings, 1 errors
   drivers/macintosh: 2 warnings, 1 errors
   drivers/message: 0 warnings, 1 errors
   fs/devpts: 0 warnings, 2 errors
   fs/openpromfs: 19 warnings, 2 errors


Warning Summary:

   drivers/atm: 3 warnings, 0 errors
   drivers/char: 11 warnings, 0 errors
   drivers/ieee1394: 1 warnings, 0 errors
   drivers/isdn: 1 warnings, 0 errors
   drivers/net: 8 warnings, 0 errors
   drivers/pcmcia: 4 warnings, 0 errors
   drivers/sound: 4 warnings, 0 errors
   drivers/telephony: 2 warnings, 0 errors
   drivers/usb: 1 warnings, 0 errors
   drivers/video: 8 warnings, 0 errors
   drivers/video/riva: 1 warnings, 0 errors
   fs/befs: 4 warnings, 0 errors
   fs/intermezzo: 1 warnings, 0 errors
   net: 1 warnings, 0 errors


Error List:
make[1]: [devpts.o] Error 1 (ignored)
make[1]: [inode.o] Error 1 (ignored)
make[1]: [nvram.o] Error 1 (ignored)
make[1]: [openpromfs.o] Error 1 (ignored)
make: [_mod_arch/i386] Error 2 (ignored)
make: [_mod_drivers/message] Error 2 (ignored)


Warning List:

advansys.c:5554: warning: `req_cnt' might be used uninitialized in this
function
agpgart_be.c:2453: warning: assignment from incompatible pointer type
agpgart_be.c:2454: warning: assignment from incompatible pointer type
agpgart_be.c:2480: warning: assignment from incompatible pointer type
agpgart_be.c:2481: warning: assignment from incompatible pointer type
agpgart_be.c:3562: warning: assignment from incompatible pointer type
agpgart_be.c:3563: warning: assignment from incompatible pointer type
agpgart_be.c:3591: warning: assignment from incompatible pointer type
agpgart_be.c:3592: warning: assignment from incompatible pointer type
agpgart_be.c:580: warning: assignment from incompatible pointer type
aha1542.c:114: warning: `setup_str' defined but not used
airo.c:1969: warning: `buffer' might be used uninitialized in this function
ali5455.c:2951: warning: `addr2' might be used uninitialized in this
function
ali5455.c:2951: warning: `data' might be used uninitialized in this function
ali5455.c:2987: warning: unused variable `flags'
ambassador.c:301:10: warning: pasting "." and "start" does not give a
valid preprocessing token
ambassador.c:305:10: warning: pasting "." and "regions" does not give a
valid preprocessing token
ambassador.c:310:10: warning: pasting "." and "data" does not give a
valid preprocessing token
amd74xx.c:384: warning: `ata66_amd74xx' defined but not used
amd76x_pm.c:482: warning: `activate_amd76x_SLP' defined but not used
amd7930_fn.h:35: warning: `initAMD' defined but not used
aty128fb.c:1066: warning: `aty128_set_crt_enable' defined but not used
aty128fb.c:1076: warning: `aty128_set_lcd_enable' defined but not used
aty128fb.c:2478: warning: unused variable `fb'
aty128fb.c:2479: warning: unused variable `value'
aty128fb.c:2480: warning: unused variable `rc'
cardbus.c:226: warning: unused variable `bus'
cardbus.c:240: warning: assignment makes pointer from integer without a cast
cardbus.c:240: warning: implicit declaration of function
`pci_scan_device_Raceae718'
cardbus.c:405: warning: control reaches end of non-void function
cpqfcTSi2c.c:62: warning: `i2c_delay' declared `static' but never defined
crc32.c:91: warning: static declaration for `fn_calc_memory_chunk_crc32'
follows non-static
/datos/kernel/linux/include/linux/ixjuser.h:45: warning:
`ixjuser_h_rcsid' defined but not used
delay.c:59: warning: type defaults to `int' in declaration of
`__cyclone_delay'
dma.c:160: warning: control reaches end of non-void function
dmi_scan.c:832: warning: unused variable `data'
dtc.c:182: warning: `dtc_setup' defined but not used
eata_dma.c:1070: warning: `hd' might be used uninitialized in this function
fbdev.c:2225: warning: label `err_out_kfree' defined but not used
file.c:64: warning: `rc' might be used uninitialized in this function
generic.h:138: warning: `unknown_chipset' defined but not used
g_NCR5380.c:212: warning: `do_NCR5380_setup' defined but not used
g_NCR5380.c:230: warning: `do_NCR53C400_setup' defined but not used
g_NCR5380.c:248: warning: `do_NCR53C400A_setup' defined but not used
g_NCR5380.c:266: warning: `do_DTC3181E_setup' defined but not used
i2o_block.c:510: warning: `i2ob_flush' defined but not used
i2o_pci.c:393:1: warning: no newline at end of file
i810_audio.c:3272: warning: label `out_chan' defined but not used
inode.c:108: warning: assignment makes pointer from integer without a cast
inode.c:108: warning: implicit declaration of function `prom_firstprop'
inode.c:110: warning: assignment makes pointer from integer without a cast
inode.c:110: warning: implicit declaration of function `prom_nextprop'
inode.c:114: warning: implicit declaration of function `prom_getproplen'
inode.c:134: warning: implicit declaration of function `prom_getproperty'
inode.c:525: warning: implicit declaration of function `prom_feval'
inode.c:531: warning: implicit declaration of function `prom_setprop'
inode.c:595: warning: implicit declaration of function `prom_getname'
inode.c:666: warning: assignment makes pointer from integer without a cast
inode.c:668: warning: assignment makes pointer from integer without a cast
inode.c:806: warning: assignment makes pointer from integer without a cast
inode.c:808: warning: assignment makes pointer from integer without a cast
inode.c:934: warning: assignment makes pointer from integer without a cast
inode.c:936: warning: assignment makes pointer from integer without a cast
inode.c:940: warning: assignment makes pointer from integer without a cast
inode.c:942: warning: assignment makes pointer from integer without a cast
inode.c:958: warning: implicit declaration of function `prom_getchild'
inode.c:964: warning: implicit declaration of function `prom_getsibling'
ip2main.c:991: warning: unused variable `rc'
ip_nat_helper.c:87: warning: unused variable `data'
ixj.h:41: warning: `ixj_h_rcsid' defined but not used
kaweth.c:736: warning: assignment from incompatible pointer type
linuxvfs.c:682: warning: `befs_listxattr' defined but not used
linuxvfs.c:690: warning: `befs_getxattr' defined but not used
linuxvfs.c:697: warning: `befs_setxattr' defined but not used
linuxvfs.c:703: warning: `befs_removexattr' defined but not used
ma600.c:189:9: warning: pasting ";" and "return" does not give a valid
preprocessing token
ma600.c:303:9: warning: pasting ";" and "return" does not give a valid
preprocessing token
ma600.c:51:22: warning: extra tokens at end of #undef directive
NCR5380.c:402: warning: `NCR5380_print' defined but not used
NCR5380.c:458: warning: `NCR5380_print_phase' defined but not used
NCR5380.c:684: warning: `NCR5380_probe_irq' defined but not used
NCR5380.c:738: warning: `NCR5380_print_options' defined but not used
ns83820.c:1708: warning: `ns83820_probe_phy' defined but not used
nsp32.h:428:8: warning: extra tokens at end of #endif directive
nsp32_io.h:268:8: warning: extra tokens at end of #endif directive
nvram.c:81: warning: unreachable code at beginning of switch statement
nvram.c:85: warning: implicit declaration of function `pmac_get_partition'
pm3fb.c:3833: warning: passing arg 2 of `__release_region_Rd49501d4'
makes integer from pointer without a cast
pm3fb.c:3836: warning: passing arg 2 of `__release_region_Rd49501d4'
makes integer from pointer without a cast
qla1280.c:1615: warning: `qla1280_do_dpc' defined but not used
radeonfb.c:3033: warning: `fbcon_radeon8' defined but not used
skge.c:2872: warning: `SetQueueSizes' defined but not used
sym53c8xx.c:6995: warning: `istat' might be used uninitialized in this
function
sym_hipd.c:224: warning: `istat' might be used uninitialized in this
function
time.c:433: warning: `do_gettimeoffset_cyclone' defined but not used
wavelan_cs.h:492:33: warning: extra tokens at end of #undef directive
--end--
-- 
Galiza nin perdoa nin esquence. Governo demision!


