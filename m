Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263423AbTECVXB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 17:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263426AbTECVXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 17:23:01 -0400
Received: from smtp4.wanadoo.es ([62.37.236.138]:51598 "EHLO smtp.wanadoo.es")
	by vger.kernel.org with ESMTP id S263423AbTECVWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 17:22:55 -0400
Message-ID: <3EB43625.9060500@wanadoo.es>
Date: Sat, 03 May 2003 23:35:33 +0200
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [ Compile Regression on i386 ]-2.4.21-rc1-ac4 general summary
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi folks,

environment: red hat 9(gcc 3.2.2)

Lots of warnings, about 2000, are missing because they were:
xxx.c:100: warning: concatenation of string literals with __FUNCTION__ is deprecated
If you would like to see them : http://perso.wanadoo.es/xose/linux/deprecated.txt

--cut--
Welcome to the [ Compile Regression on i386 ] Filter V1.1.5
( http://www.osdl.org/archive/cherry/stability/ )

This filter generates a list of warnings and errors in the kernel source.
A PASS will be reported if there are no errors found, regardless of the
presence of warning conditions.  It will be uncommon for this to PASS
on kernels that support allmodconfig.  It is nice to dream though.

The primary purpose of this report is to show WHERE the error and warning
messages are being generated.

Version information for host [ querida ]
 gcc:    3.2.2
 ccache: not installed
 patch:  2.5.4

md5sum of available source [.patch .gz .bz2]

This kernel does support 'defconfig' (including)
This kernel does support 'allmodconfig' (including)
This kernel does support 'oldconfig' (including)

This kernel supports oldconfig but since it also supports defconfig and
there is no .config present, we won't use the oldconfig method.

Kernel version: 2.4.21-rc1-ac4
Kernel build:
   Making bzImage (defconfig): 11 warnings, 0 errors
   Making modules (defconfig): 0 warnings, 0 errors
   Making bzImage (allmodconfig): 12 warnings, 0 errors
   Making modules (allmodconfig): 2036 warnings, 5 errors

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
   Building fs/nfs: 3 warnings, 0 errors
   Building fs/nfsd: clean
   Building fs/nls: clean
   Building fs/ntfs: 20 warnings, 0 errors
   Building fs/partitions: clean
   Building fs/proc: clean
   Building fs/qnx4: clean
   Building fs/ramfs: clean
   Building fs/reiserfs: 1 warnings, 0 errors
   Building fs/romfs: clean
   Building fs/smbfs: clean
   Building fs/sysv: clean
   Building fs/udf: clean
   Building fs/ufs: clean
   Building fs/umsdos: clean
   Building fs/vfat: clean
   Building fs/xfs: 1 warnings, 0 errors
   Building drivers/net: 36 warnings, 0 errors
   Building drivers/block: clean
   Building drivers/char: 970 warnings, 2 errors
   Building drivers/sound: 4 warnings, 1 errors
   Building drivers/pci: clean
   Building drivers/cdrom: clean
   Building drivers/isdn: 17 warnings, 0 errors
   Building drivers/sbus: clean
   Building drivers/ide: 1 warnings, 0 errors
   Building drivers/pnp: clean
   Building drivers/misc: clean
   Building drivers/sgi: clean
   Building drivers/fc4: clean
   Building drivers/nubus: clean
   Building drivers/acorn: clean
   Building drivers/zorro: clean
   Building drivers/dio: clean
   Building drivers/usb: 2 warnings, 0 errors
   Building drivers/tc: clean
   Building drivers/atm: 3 warnings, 0 errors
   Building drivers/parport: clean
   Building drivers/pcmcia: 4 warnings, 0 errors
   Building drivers/i2c: clean
   Building drivers/telephony: 2 warnings, 0 errors
   Building drivers/ieee1394: clean
   Building drivers/media: 15 warnings, 0 errors
   Building drivers/acpi: clean
   Building drivers/mtd: 10 warnings, 0 errors
   Building drivers/input: clean
   Building drivers/md: clean
   Building drivers/bluetooth: clean
   Building drivers/message: 0 warnings, 1 errors
   Building drivers/hotplug: 105 warnings, 2 errors
   Building drivers/gsc: clean
   Building drivers/hil: clean
   Building drivers/video/aty: 2 warnings, 0 errors
   Building drivers/video/intel: 2 warnings, 0 errors
   Building drivers/video/matrox: 5 warnings, 0 errors
   Building drivers/video/riva: 1 warnings, 0 errors
   Building drivers/video/sis: clean
   Building drivers/video/sti: clean
   Building arch/i386: 0 warnings, 1 errors
   Building lib: clean
   Building net: 791 warnings, 0 errors
   Building drivers/video: 9 warnings, 0 errors


Error Summary:

   arch/i386: 0 warnings, 1 errors
   drivers/char: 970 warnings, 2 errors
   drivers/hotplug: 105 warnings, 2 errors
   drivers/message: 0 warnings, 1 errors
   drivers/sound: 4 warnings, 1 errors
   fs/devpts: 0 warnings, 2 errors


Warning Summary:

   drivers/atm: 3 warnings, 0 errors
   drivers/ide: 1 warnings, 0 errors
   drivers/isdn: 17 warnings, 0 errors
   drivers/media: 15 warnings, 0 errors
   drivers/mtd: 10 warnings, 0 errors
   drivers/net: 36 warnings, 0 errors
   drivers/pcmcia: 4 warnings, 0 errors
   drivers/telephony: 2 warnings, 0 errors
   drivers/usb: 2 warnings, 0 errors
   drivers/video: 9 warnings, 0 errors
   drivers/video/aty: 2 warnings, 0 errors
   drivers/video/intel: 2 warnings, 0 errors
   drivers/video/matrox: 5 warnings, 0 errors
   drivers/video/riva: 1 warnings, 0 errors
   fs/befs: 4 warnings, 0 errors
   fs/intermezzo: 1 warnings, 0 errors
   fs/nfs: 3 warnings, 0 errors
   fs/ntfs: 20 warnings, 0 errors
   fs/reiserfs: 1 warnings, 0 errors
   fs/xfs: 1 warnings, 0 errors
   net: 791 warnings, 0 errors


Error List:

make[1]: [devpts.o] Error 1 (ignored)
make[1]: [ibmphp_ebda.o] Error 1 (ignored)
make[1]: [ibmphp.o] Error 1 (ignored)
make[1]: [inode.o] Error 1 (ignored)
make[1]: [_modsubdir_sound] Error 2 (ignored)
make[2]: [ibmphp_ebda.o] Error 1 (ignored)
make[2]: [ibmphp.o] Error 1 (ignored)
make[2]: [ipmi_kcs_drv.o] Error 1 (ignored)
make[2]: [ipmi_kcs_intf.o] Error 1 (ignored)
make[3]: [ipmi_kcs_drv.o] Error 1 (ignored)
make[3]: [ipmi_kcs_intf.o] Error 1 (ignored)
make: [_mod_arch/i386] Error 2 (ignored)
make: [_mod_drivers/message] Error 2 (ignored)
make: [_mod_drivers/sound] Error 2 (ignored)


Warning List:

aha1542.c:114: warning: `setup_str' defined but not used
ali5455.c:2951: warning: `addr2' might be used uninitialized in this function
ali5455.c:2951: warning: `data' might be used uninitialized in this function
ali5455.c:2987: warning: unused variable `flags'
ambassador.c:301:21: warning: pasting "." and "start" does not give a valid preprocessing token
ambassador.c:305:23: warning: pasting "." and "regions" does not give a valid preprocessing token
ambassador.c:310:20: warning: pasting "." and "data" does not give a valid preprocessing token
amd74xx.c:389: warning: `ata66_amd74xx' defined but not used
amd76x_pm.c:482: warning: `activate_amd76x_SLP' defined but not used
amd76xrom.c:181: warning: label `err_out_none' defined but not used
amd7930_fn.h:35: warning: `initAMD' defined but not used
applicom.c:268:2: warning: #warning "LEAK"
applicom.c:532:2: warning: #warning "Je suis stupide. DW. - copy*user in cli"
aty128fb.c:1066: warning: `aty128_set_crt_enable' defined but not used
aty128fb.c:1076: warning: `aty128_set_lcd_enable' defined but not used
aty128fb.c:2478: warning: unused variable `fb'
aty128fb.c:2479: warning: unused variable `value'
aty128fb.c:2480: warning: unused variable `rc'
atyfb_base.c:1777: warning: unused variable `hs'
atyfb_base.c:1777: warning: unused variable `pm'
cardbus.c:226: warning: unused variable `bus'
cardbus.c:240: warning: assignment makes pointer from integer without a cast
cardbus.c:240: warning: implicit declaration of function `pci_scan_device'
cardbus.c:405: warning: control reaches end of non-void function
cfi_cmdset_0001.c:1135: warning: unsigned int format, different type arg (arg 2)
cfi_cmdset_0001.c:1165: warning: unsigned int format, different type arg (arg 2)
cfi_cmdset_0001.c:826: warning: unsigned int format, different type arg (arg 2)
cfi_cmdset_0020.c:1137: warning: unsigned int format, different type arg (arg 3)
cfi_cmdset_0020.c:1286: warning: unsigned int format, different type arg (arg 3)
cfi_cmdset_0020.c:491: warning: unsigned int format, different type arg (arg 3)
cfi_cmdset_0020.c:851: warning: unsigned int format, different type arg (arg 3)
cmdlinepart.c:345: warning: `mtdpart_setup' defined but not used
cpqfcTSi2c.c:62: warning: `i2c_delay' declared `static' but never defined
crc32.c:91: warning: static declaration for `fn_calc_memory_chunk_crc32' follows non-static
/datos/kernel/linux/include/asm/smpboot.h:127: warning: deprecated use of label at end of compound statement
/datos/kernel/linux/include/asm/string.h:151: warning: `strchr' defined but not used
/datos/kernel/linux/include/linux/ixjuser.h:45: warning: `ixjuser_h_rcsid' defined but not used
/datos/kernel/linux/include/linux/kdev_t.h:81:1: warning: this is the location of the previous definition
dmi_scan.c:852: warning: unused variable `data'
dn_table.c:839:35: warning: multi-line string literals are deprecated
doc1000.c:85:2: warning: #warning This is definitely not SMP safe. Lock the paging mechanism.
drm_os_linux.h:16:2: warning: #warning the author of this code needs to read up on list_entry
dscc4.c:1847: warning: `dscc4_setup' defined but not used
dtc.c:182: warning: `dtc_setup' defined but not used
fbcon.c:2138: warning: unused variable `line'
fbcon.c:2141: warning: unused variable `dst'
fbcon.c:2141: warning: unused variable `src'
fbcon.c:2142: warning: unused variable `x1'
fbcon.c:2142: warning: unused variable `y1'
fbdev.c:2224: warning: label `err_out_kfree' defined but not used
file.c:64: warning: `rc' might be used uninitialized in this function
fs.c:852: warning: deprecated use of label at end of compound statement
g_NCR5380.c:212: warning: `do_NCR5380_setup' defined but not used
g_NCR5380.c:230: warning: `do_NCR53C400_setup' defined but not used
g_NCR5380.c:248: warning: `do_NCR53C400A_setup' defined but not used
g_NCR5380.c:266: warning: `do_DTC3181E_setup' defined but not used
hdlc_fr.c:712: warning: passing arg 1 of `hdlc_to_name' from incompatible pointer type
hdlc_fr.c:720: warning: passing arg 1 of `hdlc_to_name' from incompatible pointer type
i2o_block.c:510: warning: `i2ob_flush' defined but not used
i2o_pci.c:393:1: warning: no newline at end of file
i810_audio.c:3272: warning: label `out_chan' defined but not used
ibmphp_ebda.c:666: warning: unused variable `ptr_chassis_num'
ibmphp_ebda.c:666: warning: unused variable `ptr_rxe_num'
ibmphp_ebda.c:666: warning: unused variable `ptr_slot_num'
ibmphp_ebda.c:675: warning: return makes integer from pointer without a cast
ibmphp_ebda.c:711: warning: return makes integer from pointer without a cast
intelfbhw.h:184:1: warning: this is the location of the previous definition
intelfbhw.h:186:1: warning: "PALETTE_8_SIZE" redefined
ip2main.c:991: warning: unused variable `rc'
ip6t_ah.c:137: warning: assignment from incompatible pointer type
ip6t_esp.c:127: warning: assignment from incompatible pointer type
ip6t_frag.c:151: warning: assignment from incompatible pointer type
ip6t_ipv6header.c:43: warning: unused variable `opt'
ip6t_rt.c:134: warning: assignment from incompatible pointer type
ip_nat_tftp.c:156: warning: `ret' might be used uninitialized in this function
ixj.h:41: warning: `ixj_h_rcsid' defined but not used
kaweth.c:736: warning: assignment from incompatible pointer type
linuxvfs.c:682: warning: `befs_listxattr' defined but not used
linuxvfs.c:690: warning: `befs_getxattr' defined but not used
linuxvfs.c:697: warning: `befs_setxattr' defined but not used
linuxvfs.c:703: warning: `befs_removexattr' defined but not used
ma600.c:189:40: warning: pasting ";" and "return" does not give a valid preprocessing token
ma600.c:303:40: warning: pasting ";" and "return" does not give a valid preprocessing token
ma600.c:51:22: warning: extra tokens at end of #undef directive
matroxfb_g450.c:134: warning: duplicate `const'
matroxfb_g450.c:135: warning: duplicate `const'
matroxfb_g450.c:561: warning: unused variable `minfo'
matroxfb_maven.c:359: warning: duplicate `const'
matroxfb_maven.c:360: warning: duplicate `const'
mpc.c:328: warning: `mpoa_device_type_string' defined but not used
NCR5380.c:402: warning: `NCR5380_print' defined but not used
NCR5380.c:458: warning: `NCR5380_print_phase' defined but not used
NCR5380.c:684: warning: `NCR5380_probe_irq' defined but not used
NCR5380.c:738: warning: `NCR5380_print_options' defined but not used
ns83820.c:1708: warning: `ns83820_probe_phy' defined but not used
nsp32.h:428:8: warning: extra tokens at end of #endif directive
nsp32_io.h:268:8: warning: extra tokens at end of #endif directive
olympic.c:658:16: warning: multi-line string literals are deprecated
pci-pc.c:180:1: warning: "PCI_CONF1_ADDRESS" redefined
pci-pc.c:58:1: warning: this is the location of the previous definition
pm3fb.c:3835: warning: passing arg 2 of `__release_region' makes integer from pointer without a cast
pm3fb.c:3838: warning: passing arg 2 of `__release_region' makes integer from pointer without a cast
poly.h:78:17: warning: multi-line string literals are deprecated
poly.h:93:17: warning: multi-line string literals are deprecated
qla1280.c:1615: warning: `qla1280_do_dpc' defined but not used
../qlogicfas.c:650: warning: passing arg 1 of `scsi_unregister' from incompatible pointer type
qlogicfas.c:650: warning: passing arg 1 of `scsi_unregister' from incompatible pointer type
qsort.c:202: warning: duplicate `const'
r128_cce.c:1019: warning: unused variable `dev_priv'
r128_cce.c:1021: warning: unused variable `buffer'
r128_cce.c:1023: warning: unused variable `size'
radeon_drv.h:846:2: warning: #warning PCI posting bug
radeonfb.c:3041: warning: `fbcon_radeon8' defined but not used
radeon_mem.c:135: warning: `print_heap' defined but not used
sbc60xxwdt.c:338: warning: label `err_out' defined but not used
sddr09.c:448: warning: `sddr09_request_sense' defined but not used
sdla_chdlc.c:594:43: warning: multi-line string literals are deprecated
skge.c:2872: warning: `SetQueueSizes' defined but not used
sonypi.c:123: warning: implicit declaration of function `ec_read'
sonypi.c:155: warning: implicit declaration of function `ec_write'
sstfb.c:971: warning: unused variable `i'
time.c:435: warning: `do_gettimeoffset_cyclone' defined but not used
tipar.c:76:1: warning: "minor" redefined
vesafb.c:93: warning: `fbcon_cmap' defined but not used
wavelan_cs.h:492:33: warning: extra tokens at end of #undef directive
wd7000.c:832: warning: `p' might be used uninitialized in this function
--end-

regards,
-- 
Galiza nin perdoa nin esquence. Governo demision!



