Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbUA3SP6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 13:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263166AbUA3SP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 13:15:58 -0500
Received: from smtp14.eresmas.com ([62.81.235.114]:12425 "EHLO
	smtp14.eresmas.com") by vger.kernel.org with ESMTP id S263125AbUA3SPR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 13:15:17 -0500
Message-ID: <401A9F2B.1060400@wanadoo.es>
Date: Fri, 30 Jan 2004 19:15:07 +0100
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; es-ES; rv:1.4.1) Gecko/20031114
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Compile Regression] 2.4.25-pre8: 126 warnings 0 errors
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

 kernel: 2.4.25-pre8

 distribution : RHL 9
 gcc:    3.2.2

[...]

Kernel build of original configuration:
   Making bzImage (oldconfig): 15 warnings, 0 errors
   Making modules (oldconfig): 126 warnings, 0 errors

Warning Summary (individual module builds):

   drivers/atm: 1 warnings, 0 errors
   drivers/char: 10 warnings, 0 errors
   drivers/ide: 2 warnings, 0 errors
   drivers/ieee1394: 1 warnings, 0 errors
   drivers/isdn: 25 warnings, 0 errors
   drivers/media: 1 warnings, 0 errors
   drivers/mtd: 10 warnings, 0 errors
   drivers/net: 10 warnings, 0 errors
   drivers/net: 2 warnings, 0 errors
   drivers/pcmcia: 2 warnings, 0 errors
   drivers/scsi: 14 warnings, 0 errors
   drivers/scsi/aacraid: 2 warnings, 0 errors
   drivers/scsi/pcmcia: 2 warnings, 0 errors
   drivers/sound: 5 warnings, 0 errors
   drivers/telephony: 2 warnings, 0 errors
   drivers/usb: 6 warnings, 0 errors
   drivers/video: 9 warnings, 0 errors
   drivers/video/matrox: 5 warnings, 0 errors
   drivers/video/riva: 1 warnings, 0 errors
   fs/befs: 4 warnings, 0 errors
   fs/hfs: 2 warnings, 0 errors
   fs/intermezzo: 1 warnings, 0 errors
   fs/nfs: 2 warnings, 0 errors
   fs/xfs: 1 warnings, 0 errors
   net: 7 warnings, 0 errors

Warning List:

aachba.c:1682: warning: cast to pointer from integer of different size
aachba.c:1744: warning: cast to pointer from integer of different size
ac97_plugin_ad1980.c:92: warning: initialization from incompatible pointer type
ad1889.c:361: warning: unsigned int format, different type arg (arg 4)
agpgart_be.c:5647:17: warning: extra tokens at end of #undef directive
../aha152x.c:853: warning: `do_setup' defined but not used
aha1542.c:114: warning: `setup_str' defined but not used
ali5455.c:2939: warning: `addr2' might be used uninitialized in this function
ali5455.c:2939: warning: `data' might be used uninitialized in this function
amd74xx.c:389: warning: `ata66_amd74xx' defined but not used
amd76x_pm.c:483: warning: `activate_amd76x_SLP' defined but not used
amd76xrom.c:181: warning: label `err_out_none' defined but not used
amd7930_fn.h:35: warning: `initAMD' defined but not used
applicom.c:268:2: warning: #warning "LEAK"
applicom.c:532:2: warning: #warning "Je suis stupide. DW. - copy*user in cli"
aty128fb.c:1066: warning: `aty128_set_crt_enable' defined but not used
aty128fb.c:1076: warning: `aty128_set_lcd_enable' defined but not used
aty128fb.c:2485: warning: unused variable `fb'
aty128fb.c:2486: warning: unused variable `value'
aty128fb.c:2487: warning: unused variable `rc'
cardbus.c:239: warning: assignment makes pointer from integer without a cast
cardbus.c:239: warning: implicit declaration of function `pci_scan_device_Rsmp_aceae718'
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
csr.c:120: warning: long unsigned int format, int arg (arg 3)
/datos/kernel/linux/include/asm/smpboot.h:126: warning: deprecated use of label at end of compound statement
/datos/kernel/linux/include/linux/autoconf.h:2070:1: warning: "CONFIG_SERIAL_SHARE_IRQ" redefined
/datos/kernel/linux/include/linux/ixjuser.h:45: warning: `ixjuser_h_rcsid' defined but not used
/datos/kernel/linux/include/linux/kdev_t.h:81:1: warning: this is the location of the previous definition
/datos/kernel/linux/include/linux/modules/sunrpc_syms.ver:38:1: warning: this is the location of the previous definition
doc1000.c:85:2: warning: #warning This is definitely not SMP safe. Lock the paging mechanism.
dtc.c:182: warning: `dtc_setup' defined but not used
fbcon.c:2138: warning: unused variable `line'
fbcon.c:2141: warning: unused variable `dst'
fbcon.c:2141: warning: unused variable `src'
fbcon.c:2142: warning: unused variable `x1'
fbcon.c:2142: warning: unused variable `y1'
fbdev.c:2224: warning: label `err_out_kfree' defined but not used
../fdomain.c:565: warning: `fdomain_setup' defined but not used
file.c:64: warning: `rc' might be used uninitialized in this function
gamma_dma.c:608:18: warning: #warning list_entry() is needed here
g_NCR5380.c:212: warning: `do_NCR5380_setup' defined but not used
g_NCR5380.c:230: warning: `do_NCR53C400_setup' defined but not used
g_NCR5380.c:248: warning: `do_NCR53C400A_setup' defined but not used
g_NCR5380.c:266: warning: `do_DTC3181E_setup' defined but not used
hc_sl811_rh.c:171: warning: duplicate `const'
hc_sl811_rh.c:416: warning: duplicate `const'
hc_sl811_rh.c:421: warning: duplicate `const'
hid-core.c:879: warning: implicit declaration of function `hiddev_report_event'
i2o_block.c:510: warning: `i2ob_flush' defined but not used
i2o_pci.c:393:1: warning: no newline at end of file
idt77252.c:669: warning: unsigned int format, different type arg (arg 5)
interrupt.c:201: warning: unsigned int format, different type arg (arg 4)
ip_conntrack_core.c:1161: warning: passing arg 1 of `unhelp' discards qualifiers from pointer target type
ircomm_param.c:202: warning: concatenation of string literals with __FUNCTION__ is deprecated
irlmp.c:1244: warning: concatenation of string literals with __FUNCTION__ is deprecated
irlmp.c:1258: warning: concatenation of string literals with __FUNCTION__ is deprecated
irlmp.c:1277: warning: concatenation of string literals with __FUNCTION__ is deprecated
irlmp.c:1284: warning: concatenation of string literals with __FUNCTION__ is deprecated
it8181fb.c:162: warning: `fontname' defined but not used
ixj.h:41: warning: `ixj_h_rcsid' defined but not used
kaweth.c:738: warning: assignment from incompatible pointer type
linuxvfs.c:682: warning: `befs_listxattr' defined but not used
linuxvfs.c:690: warning: `befs_getxattr' defined but not used
linuxvfs.c:697: warning: `befs_setxattr' defined but not used
linuxvfs.c:703: warning: `befs_removexattr' defined but not used
ma600.c:51:22: warning: extra tokens at end of #undef directive
main.c:236:2: warning: #warning "Initialisation order race. Must register after usable"
make[1]: warning: jobserver unavailable: using -j1.  Add `+' to parent make rule.
matroxfb_g450.c:134: warning: duplicate `const'
matroxfb_g450.c:135: warning: duplicate `const'
matroxfb_g450.c:561: warning: unused variable `minfo'
matroxfb_maven.c:359: warning: duplicate `const'
matroxfb_maven.c:360: warning: duplicate `const'
meye.c:212: warning: passing arg 3 of `dma_alloc_coherent' from incompatible pointer type
mpc.c:330: warning: `mpoa_device_type_string' defined but not used
mptbase.c:2906: warning: `pCached' might be used uninitialized in this function
NCR5380.c:402: warning: `NCR5380_print' defined but not used
NCR5380.c:458: warning: `NCR5380_print_phase' defined but not used
NCR5380.c:684: warning: `NCR5380_probe_irq' defined but not used
NCR5380.c:738: warning: `NCR5380_print_options' defined but not used
nfs3proc.c:48:1: warning: "rpc_call_sync" redefined
ns83820.c:1708: warning: `ns83820_probe_phy' defined but not used
pc300_tty.c:706: warning: passing arg 2 of pointer to function discards qualifiers from pointer target type
pci-pc.c:180:1: warning: "PCI_CONF1_ADDRESS" redefined
pci-pc.c:58:1: warning: this is the location of the previous definition
pm3fb.c:3835: warning: passing arg 2 of `__release_region_Rsmp_d49501d4' makes integer from pointer without a cast
pm3fb.c:3838: warning: passing arg 2 of `__release_region_Rsmp_d49501d4' makes integer from pointer without a cast
r128_cce.c:357: warning: unsigned int format, different type arg (arg 3)
radeon_cp.c:908: warning: unsigned int format, different type arg (arg 3)
radeon_mem.c:135: warning: `print_heap' defined but not used
scsi_merge.c:104: warning: long unsigned int format, different type arg (arg 4)
sddr09.c:448: warning: `sddr09_request_sense' defined but not used
siimage.c:65: warning: control reaches end of non-void function
sstfb.c:971: warning: unused variable `i'
st5481_b.c:122: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_b.c:176: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_b.c:367: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_d.c:362: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_d.c:386: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_d.c:419: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_d.c:453: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_d.c:602: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_usb.c:134: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_usb.c:188: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_usb.c:244: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_usb.c:253: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_usb.c:263: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_usb.c:360: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_usb.c:474: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_usb.c:504: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_usb.c:510: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_usb.c:512: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_usb.c:514: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_usb.c:51: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_usb.c:522: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_usb.c:609: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_usb.c:612: warning: concatenation of string literals with __FUNCTION__ is deprecated
st5481_usb.c:67: warning: concatenation of string literals with __FUNCTION__ is deprecated
sundance.c:1678: warning: unsigned int format, different type arg (arg 3)
sundance.c:994: warning: unsigned int format, different type arg (arg 3)
super.c:164: warning: `fork' might be used uninitialized in this function
super.c:164: warning: `names' might be used uninitialized in this function
tipar.c:76:1: warning: "minor" redefined
tms380tr.c:1449: warning: long unsigned int format, different type arg (arg 3)
vac-serial.c:13:1: warning: this is the location of the previous definition
vesafb.c:93: warning: `fbcon_cmap' defined but not used
wd7000.c:832: warning: `p' might be used uninitialized in this function
xfs_log_recover.c:1534: warning: `flags' might be used uninitialized in this function
yellowfin.c:1282: warning: unsigned int format, different type arg (arg 2)
yellowfin.c:1294: warning: unsigned int format, different type arg (arg 2)

# EOT

