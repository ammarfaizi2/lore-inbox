Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262536AbUCHQTt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 11:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbUCHQTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 11:19:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:55757 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262536AbUCHQTg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 11:19:36 -0500
Subject: Re: 2.6.4-rc2-mm1 (compile stats)
From: John Cherry <cherry@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20040307223221.0f2db02e.akpm@osdl.org>
References: <20040307223221.0f2db02e.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1078762814.10171.4.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 08 Mar 2004 08:20:14 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Included with this report is a list of the current warnings from the
2.6.4-rc2-mm1 builds.

Linux 2.6 (mm tree) Compile Statistics (gcc 3.2.2)
Warnings/Errors Summary

Kernel            bzImage   bzImage  bzImage  modules  bzImage  modules
                (defconfig) (allno) (allyes) (allyes) (allmod) (allmod)
--------------- ---------- -------- -------- -------- -------- --------
2.6.3-rc2-mm1     1w/0e     5w/0e   146w/12e  11w/0e   3w/0e    147w/2e
2.6.3-rc1-mm2     1w/0e     5w/0e   144w/ 0e  11w/0e   3w/0e    145w/0e
2.6.3-rc1-mm1     1w/0e     5w/0e   147w/ 5e  11w/0e   3w/0e    147w/0e
2.6.3-mm4         1w/0e     5w/0e   146w/ 0e   7w/0e   3w/0e    142w/0e
2.6.3-mm3         1w/2e     5w/2e   146w/15e   7w/0e   3w/2e    144w/5e
2.6.3-mm2         1w/8e     5w/0e   140w/ 0e   7w/0e   3w/0e    138w/0e
2.6.3-mm1         1w/0e     5w/0e   143w/ 5e   7w/0e   3w/0e    141w/0e
2.6.3-rc3-mm1     1w/0e     0w/0e   144w/13e   7w/0e   3w/0e    142w/3e
2.6.3-rc2-mm1     1w/0e     0w/265e 144w/ 5e   7w/0e   3w/0e    145w/0e
2.6.3-rc1-mm1     1w/0e     0w/265e 141w/ 5e   7w/0e   3w/0e    143w/0e
2.6.2-mm1         2w/0e     0w/264e 147w/ 5e   7w/0e   3w/0e    173w/0e
2.6.2-rc3-mm1     2w/0e     0w/265e 146w/ 5e   7w/0e   3w/0e    172w/0e
2.6.2-rc2-mm2     0w/0e     0w/264e 145w/ 5e   7w/0e   3w/0e    171w/0e
2.6.2-rc2-mm1     0w/0e     0w/264e 146w/ 5e   7w/0e   3w/0e    172w/0e
2.6.2-rc1-mm3     0w/0e     0w/265e 144w/ 8e   7w/0e   3w/0e    169w/0e
2.6.2-rc1-mm2     0w/0e     0w/264e 144w/ 5e  10w/0e   3w/0e    171w/0e
2.6.2-rc1-mm1     0w/0e     0w/264e 144w/ 5e  10w/0e   3w/0e    171w/0e
2.6.1-mm5         2w/5e     0w/264e 153w/11e  10w/0e   3w/0e    180w/0e
2.6.1-mm4         0w/821e   0w/264e 154w/ 5e   8w/1e   5w/0e    179w/0e
2.6.1-mm3         0w/0e     0w/0e   151w/ 5e  10w/0e   3w/0e    177w/0e
2.6.1-mm2         0w/0e     0w/0e   143w/ 5e  12w/0e   3w/0e    171w/0e
2.6.1-mm1         0w/0e     0w/0e   146w/ 9e  12w/0e   6w/0e    171w/0e
2.6.1-rc2-mm1     0w/0e     0w/0e   149w/ 0e  12w/0e   6w/0e    171w/4e
2.6.1-rc1-mm2     0w/0e     0w/0e   157w/15e  12w/0e   3w/0e    185w/4e
2.6.1-rc1-mm1     0w/0e     0w/0e   156w/10e  12w/0e   3w/0e    184w/2e
2.6.0-mm2         0w/0e     0w/0e   161w/ 0e  12w/0e   3w/0e    189w/0e
2.6.0-mm1         0w/0e     0w/0e   173w/ 0e  12w/0e   3w/0e    212w/0e

Web page with links to complete details:
   http://developer.osdl.org/cherry/compile/

Warnings in the build
---------------------
drivers/cdrom/aztcd.c:379: warning: `pa_ok' defined but not used
drivers/cdrom/isp16.c:124: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:121)
drivers/cdrom/mcdx.h:180:2: warning: #warning You have not edited mcdx.h
drivers/cdrom/mcdx.h:181:2: warning: #warning Perhaps irq and i/o
settings are wrong.
drivers/cdrom/sjcd.c:1703: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:121)
drivers/char/applicom.c:522:2: warning: #warning "Je suis stupide. DW. -
copy*user in cli"
drivers/char/applicom.c:67: warning: `applicom_pci_tbl' defined but not
used
drivers/char/ipmi/ipmi_smb.c:224: warning: implicit declaration of
function `i2c_set_spin_delay'
drivers/char/watchdog/alim1535_wdt.c:320: warning: `ali_pci_tbl' defined
but not used
drivers/char/watchdog/cpu5wdt.c:305: warning: initialization discards
qualifiers from pointer target type
drivers/char/watchdog/cpu5wdt.c:305: warning: return discards qualifiers
from pointer target type
drivers/ide/ide-tape.c:4701: warning: duplicate `const'
drivers/ide/ide.c:2291: warning: implicit declaration of function
`pnpide_init'
drivers/ide/legacy/ide-cs.c:364: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:515)
drivers/ide/legacy/ide-cs.c:410: warning: `MOD_DEC_USE_COUNT' is
deprecated (declared at include/linux/module.h:527)
drivers/ide/pci/trm290.c:378: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:121)
drivers/isdn/capi/capidrv.c:2111:10: warning: #warning FIXME: maybe a
race condition the card should be removed here from global list /kkeil
drivers/isdn/hisax/config.c:1889: warning: `hisax_pci_tbl' defined but
not used
drivers/isdn/i4l/isdn_v110.c:523: warning: `ret' might be used
uninitialized in this function
drivers/isdn/icn/icn.c:719:18: warning: #warning TODO test headroom or
use skb->nb to flag ACK
drivers/media/dvb/frontends/stv0299.c:356: warning: unused variable `i'
drivers/media/dvb/frontends/tda1004x.c:191: warning: `errno' defined but
not used
drivers/media/video/zoran_card.c:149: warning: `zr36067_pci_tbl' defined
but not used
drivers/message/fusion/mptscsih.c:7117: warning: `mptscsih_setup'
defined but not used
drivers/message/i2o/i2o_block.c:1493: warning: `MOD_DEC_USE_COUNT' is
deprecated (declared at include/linux/module.h:527)
drivers/mtd/chips/amd_flash.c:783: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:515)
drivers/mtd/chips/cfi_cmdset_0001.c:381: warning: unsigned int format,
different type arg (arg 2)
drivers/mtd/chips/cfi_cmdset_0001.c:965: warning: unsigned int format,
different type arg (arg 2)
drivers/mtd/chips/cfi_cmdset_0002.c:1157: warning: unsigned int format,
different type arg (arg 4)
drivers/mtd/chips/cfi_cmdset_0002.c:513: warning: unsigned int format,
different type arg (arg 4)
drivers/mtd/chips/cfi_cmdset_0002.c:651: warning: unsigned int format,
different type arg (arg 4)
drivers/mtd/chips/cfi_cmdset_0002.c:977: warning: unsigned int format,
different type arg (arg 4)
drivers/mtd/chips/cfi_cmdset_0020.c:1148: warning: unsigned int format,
different type arg (arg 3)
drivers/mtd/chips/cfi_cmdset_0020.c:1297: warning: unsigned int format,
different type arg (arg 3)
drivers/mtd/chips/cfi_cmdset_0020.c:493: warning: unsigned int format,
different type arg (arg 3)
drivers/mtd/chips/cfi_cmdset_0020.c:862: warning: unsigned int format,
different type arg (arg 3)
drivers/mtd/chips/sharp.c:157: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:515)
drivers/mtd/cmdlinepart.c:344: warning: `mtdpart_setup' defined but not
used
drivers/mtd/devices/doc2000.c:567: warning: assignment from incompatible
pointer type
drivers/mtd/devices/doc2000.c:568: warning: assignment from incompatible
pointer type
drivers/mtd/devices/doc2001.c:376: warning: assignment from incompatible
pointer type
drivers/mtd/devices/doc2001.c:377: warning: assignment from incompatible
pointer type
drivers/mtd/nftlcore.c:354: warning: passing arg 7 of pointer to
function makes pointer from integer without a cast
drivers/mtd/nftlcore.c:358: warning: passing arg 7 of pointer to
function makes pointer from integer without a cast
drivers/mtd/nftlcore.c:363: warning: passing arg 7 of pointer to
function makes pointer from integer without a cast
drivers/mtd/nftlcore.c:632: warning: passing arg 7 of pointer to
function makes pointer from integer without a cast
drivers/mtd/nftlcore.c:696: warning: passing arg 7 of pointer to
function makes pointer from integer without a cast
drivers/mtd/nftlmount.c:220: warning: passing arg 7 of pointer to
function makes pointer from integer without a cast
drivers/net/arcnet/com20020-isa.c:188: warning: unused variable `dev'
drivers/net/arcnet/com20020-isa.c:189: warning: unused variable `lp'
drivers/net/ibmlana.c:910: warning: `ibmlana_probe' defined but not used
drivers/net/sk98lin/skaddr.c:1427: warning: `ReturnCode' might be used
uninitialized in this function
drivers/net/sk98lin/skaddr.c:895: warning: `ReturnCode' might be used
uninitialized in this function
drivers/net/tulip/winbond-840.c:149: warning: `version' defined but not
used
drivers/net/wan/cycx_drv.c:430: warning: unsigned int format, long
unsigned int arg (arg 3)
drivers/pcmcia/i82365.c:672: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:121)
drivers/pcmcia/i82365.c:806: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:121)
drivers/pcmcia/tcic.c:347: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:121)
drivers/scsi/BusLogic.c:1000: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:121)
drivers/scsi/BusLogic.c:1005: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:121)
drivers/scsi/BusLogic.c:3556: warning: `BusLogic_AbortCommand' defined
but not used
drivers/scsi/BusLogic.c:694: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:121)
drivers/scsi/BusLogic.c:698: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:121)
drivers/scsi/BusLogic.c:702: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:121)
drivers/scsi/BusLogic.c:706: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:121)
drivers/scsi/BusLogic.c:710: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:121)
drivers/scsi/BusLogic.c:714: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:121)
drivers/scsi/BusLogic.c:970: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:121)
drivers/scsi/BusLogic.c:985: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:121)
drivers/scsi/BusLogic.c:990: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:121)
drivers/scsi/BusLogic.c:995: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:121)
drivers/scsi/NCR5380.c:396: warning: `phases' defined but not used
drivers/scsi/NCR5380.c:699: warning: `NCR5380_probe_irq' defined but not
used
drivers/scsi/NCR5380.c:756: warning: `NCR5380_print_options' defined but
not used
drivers/scsi/NCR53c406a.c:611: warning: `NCR53c406a_setup' defined but
not used
drivers/scsi/NCR53c406a.c:660: warning: initialization from incompatible
pointer type
drivers/scsi/NCR53c406a.c:669: warning: `wait_intr' defined but not used
drivers/scsi/aacraid/rkt.c:335: warning: `aac_rkt_check_health' defined
but not used
drivers/scsi/aacraid/rx.c:335: warning: `aac_rx_check_health' defined
but not used
drivers/scsi/aacraid/sa.c:310: warning: `aac_sa_check_health' defined
but not used
drivers/scsi/advansys.c:10006: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:121)
drivers/scsi/advansys.c:4622: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:121)
drivers/scsi/dtc.c:187: warning: `dtc_setup' defined but not used
drivers/scsi/eata_pio.c:596: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:121)
drivers/scsi/fd_mcs.c:300: warning: `fd_mcs_setup' defined but not used
drivers/scsi/fd_mcs.c:311: warning: initialization from incompatible
pointer type
drivers/scsi/fd_mcs.h:27: warning: `fd_mcs_command' declared `static'
but never defined
drivers/scsi/fdomain.c:763: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:121)
drivers/scsi/g_NCR5380.c:931: warning: `id_table' defined but not used
drivers/scsi/gdth.c:880: warning: `gdthtable' defined but not used
drivers/scsi/libata-core.c:2172: warning: `ata_qc_push' defined but not
used
drivers/scsi/psi240i.c:713: warning: initialization from incompatible
pointer type
drivers/scsi/psi240i.c:714: warning: initialization from incompatible
pointer type
drivers/scsi/qla1280.c:3124: warning: `qla1280_64bit_start_scsi' defined
but not used
drivers/scsi/sym53c416.c:627: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:121)
drivers/scsi/sym53c416.c:715: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:121)
drivers/scsi/wd7000.c:1611: warning: `wd7000_abort' defined but not used
drivers/serial/8250.c:689: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:121)
drivers/telephony/ixj.c:7737: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:121)
drivers/telephony/ixj.c:7799: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:121)
drivers/telephony/ixj.c:7835: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:121)
drivers/telephony/ixj.h:41: warning: `ixj_h_rcsid' defined but not used
drivers/usb/class/usb-midi.h:144: warning: `usb_midi_ids' defined but
not used
drivers/usb/media/pwc-if.c:1124: warning: control reaches end of
non-void function
drivers/usb/media/pwc-if.c:1855: warning: assignment from incompatible
pointer type
drivers/video/console/mdacon.c:374: warning: `MOD_INC_USE_COUNT' is
deprecated (declared at include/linux/module.h:515)
drivers/video/console/mdacon.c:384: warning: `MOD_DEC_USE_COUNT' is
deprecated (declared at include/linux/module.h:527)
drivers/video/console/mdacon.c:599: warning: initialization from
incompatible pointer type
drivers/video/hgafb.c:452: warning: `hgafb_fillrect' defined but not
used
drivers/video/hgafb.c:472: warning: `hgafb_copyarea' defined but not
used
drivers/video/hgafb.c:502: warning: `hgafb_imageblit' defined but not
used
drivers/video/imsttfb.c:1089: warning: `imsttfb_load_cursor_image'
defined but not used
drivers/video/imsttfb.c:1159: warning: `imstt_set_cursor' defined but
not used
drivers/video/matrox/matroxfb_base.c:1250: warning: `inverse' defined
but not used
drivers/video/matrox/matroxfb_g450.c:129: warning: duplicate `const'
drivers/video/matrox/matroxfb_g450.c:130: warning: duplicate `const'
drivers/video/matrox/matroxfb_maven.c:347: warning: duplicate `const'
drivers/video/matrox/matroxfb_maven.c:348: warning: duplicate `const'
drivers/video/tdfxfb.c:1005: warning: `tdfxfb_cursor' defined but not
used
drivers/video/tdfxfb.c:198: warning: `inverse' defined but not used
drivers/video/tdfxfb.c:199: warning: `mode_option' defined but not used
drivers/video/tridentfb.c:455: warning: `tridentfb_fillrect' defined but
not used
drivers/video/tridentfb.c:473: warning: `tridentfb_copyarea' defined but
not used
include/asm-generic/tlb.h:107: warning: implicit declaration of function
`page_cache_release'
include/asm-generic/tlb.h:74: warning: implicit declaration of function
`release_pages'
include/asm-generic/tlb.h:74: warning: previous implicit declaration of
`release_pages'
include/linux/ixjuser.h:45: warning: `ixjuser_h_rcsid' defined but not
used
include/linux/mca-legacy.h:12:2: warning: #warning "MCA legacy - please
move your driver to the new sysfs api"
include/linux/pagemap.h:50: warning: `release_pages' was previously
implicitly declared to return `int'
include/linux/pagemap.h:50: warning: type mismatch with previous
implicit declaration
include/sound/initval.h:141: warning: `get_id' defined but not used
sound/isa/dt019x.c:147: warning: long unsigned int format, int arg (arg
5)
sound/isa/dt019x.c:147: warning: long unsigned int format, int arg (arg
6)
sound/isa/dt019x.c:168: warning: long unsigned int format, int arg (arg
5)
sound/isa/wavefront/wavefront_synth.c:1923: warning: `errno' defined but
not used
sound/oss/ad1848.c:1580: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:121)
sound/oss/ad1848.c:2530: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:121)
sound/oss/ad1848.c:2967: warning: `id_table' defined but not used
sound/oss/cmpci.c:1465: warning: unused variable `s'
sound/oss/cmpci.c:2865: warning: `cmpci_pci_tbl' defined but not used
sound/oss/cs4232.c:141: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:121)
sound/oss/cs4232.c:193: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:121)
sound/oss/gus_card.c:76: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:121)
sound/oss/gus_card.c:78: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:121)
sound/oss/gus_card.c:93: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:121)
sound/oss/gus_card.c:94: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:121)
sound/oss/mad16.c:322: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:121)
sound/oss/maui.c:307: warning: `check_region' is deprecated (declared at
include/linux/ioport.h:121)
sound/oss/mpu401.c:1217: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:121)
sound/oss/msnd.c:63: warning: `MOD_INC_USE_COUNT' is deprecated
(declared at include/linux/module.h:515)
sound/oss/msnd.c:84: warning: `MOD_DEC_USE_COUNT' is deprecated
(declared at include/linux/module.h:527)
sound/oss/msnd_pinnacle.c:1123: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:121)
sound/oss/msnd_pinnacle.c:1811: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:121)
sound/oss/opl3sa.c:114: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:121)
sound/oss/opl3sa.c:122: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:121)
sound/oss/pss.c:1004: warning: `check_region' is deprecated (declared at
include/linux/ioport.h:121)
sound/oss/pss.c:191: warning: `check_region' is deprecated (declared at
include/linux/ioport.h:121)
sound/oss/pss.c:640: warning: `check_region' is deprecated (declared at
include/linux/ioport.h:121)
sound/oss/pss.c:710: warning: `check_region' is deprecated (declared at
include/linux/ioport.h:121)
sound/oss/sb_common.c:1224: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:121)
sound/oss/sb_common.c:523: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:121)
sound/oss/sgalaxy.c:89: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:121)
sound/oss/sgalaxy.c:97: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:121)
sound/oss/sscape.c:1113: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:121)
sound/oss/sscape.c:1132: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:121)
sound/oss/sscape.c:1137: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:121)
sound/oss/sscape.c:737: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:121)
sound/oss/trix.c:147: warning: `check_region' is deprecated (declared at
include/linux/ioport.h:121)
sound/oss/trix.c:292: warning: `check_region' is deprecated (declared at
include/linux/ioport.h:121)
sound/oss/trix.c:85: warning: `check_region' is deprecated (declared at
include/linux/ioport.h:121)
sound/oss/wavfront.c:2426: warning: `check_region' is deprecated
(declared at include/linux/ioport.h:121)
sound/oss/wavfront.c:2497: warning: `errno' defined but not used
sound/oss/wavfront.c:2524: warning: implicit declaration of function
`sys_open'
sound/oss/wavfront.c:2533: warning: implicit declaration of function
`sys_read'
sound/oss/wavfront.c:2582: warning: implicit declaration of function
`sys_close'
sound/oss/wf_midi.c:788: warning: `check_region' is deprecated (declared
at include/linux/ioport.h:121)

John


