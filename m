Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318136AbSHDJru>; Sun, 4 Aug 2002 05:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318139AbSHDJru>; Sun, 4 Aug 2002 05:47:50 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:23561 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S318136AbSHDJrs>;
	Sun, 4 Aug 2002 05:47:48 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19 make allyesconfig - errors and warnings
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 04 Aug 2002 19:51:07 +1000
Message-ID: <28360.1028454667@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.19 make allyesconfig got two errors and lots of warnings.

CONFIG_JFFS2_FS - duplicate symbols between jffs2 and ppp_deflate - an
oldy but goody.

CONFIG_IEEE1394 - does not build
drivers/ieee1394/nodemgr.c: In function `nodemgr_host_reset':
drivers/ieee1394/nodemgr.c:1307: parse error before `else'

The rest are "just" warnings.

drivers/char/mxser.c: In function `mxser_init':
drivers/char/mxser.c:656: warning: suggest parentheses around assignment used as truth value

drivers/char/ip2/i2ellis.c:107: warning: `iiEllisCleanup' defined but not used

drivers/char/applicom.c:268:2: warning: #warning "LEAK"
drivers/char/applicom.c:532:2: warning: #warning "Je suis stupide. DW. - copy*user in cli"

drivers/char/tpqic02.c: In function `qic02_tape_read':
drivers/char/tpqic02.c:1818: warning: unused variable `err'
drivers/char/tpqic02.c: In function `qic02_tape_write':
drivers/char/tpqic02.c:2012: warning: unused variable `err'

drivers/char/wdt_pci.c:79: warning: `expect_close' defined but not used

drivers/block/umem.c: In function `mm_start_io':
drivers/block/umem.c:346: warning: right shift count >= width of type

drivers/net/rcpci45.c: In function `rcpci45_init_one':
drivers/net/rcpci45.c:191: warning: unsigned int format, long unsigned int arg (arg 2)
drivers/net/rcpci45.c:191: warning: unsigned int format, long unsigned int arg (arg 3)
drivers/net/rcpci45.c: At top level:
drivers/net/rcpci45.c:105: warning: `RCinit' declared `static' but never defined

drivers/net/winbond-840.c:149: warning: `version' defined but not used

drivers/net/ppp_generic.c: In function `ppp_read':
drivers/net/ppp_generic.c:381: warning: `ret' might be used uninitialized in this function

drivers/net/arlan.c:26: warning: `probe' defined but not used
drivers/net/arlan.c:1128: warning: `arlan_find_devices' defined but not used

drivers/media/video/msp3400.c: In function `msp_attach':
drivers/media/video/msp3400.c:1237: warning: `rev2' might be used uninitialized in this function
drivers/media/video/zr36067.c: In function `do_zoran_ioctl':
drivers/media/video/zr36067.c:4166: warning: unused variable `timeout'

drivers/char/agp/agpgart_be.c: In function `agp_generic_agp_enable':
drivers/char/agp/agpgart_be.c:400: warning: unused variable `cap_id'
drivers/char/agp/agpgart_be.c: In function `agp_find_supported_device':
drivers/char/agp/agpgart_be.c:4298: warning: unused variable `scratch'
drivers/char/agp/agpgart_be.c:4298: warning: unused variable `cap_id'

drivers/char/drm-4.0/r128_cce.c: In function `r128_cce_packet':
drivers/char/drm-4.0/r128_cce.c:1023: warning: unused variable `size'
drivers/char/drm-4.0/r128_cce.c:1021: warning: unused variable `buffer'
drivers/char/drm-4.0/r128_cce.c:1019: warning: unused variable `dev_priv'
drivers/char/drm-4.0/i810_dma.c: In function `i810_free_page':
drivers/char/drm-4.0/i810_dma.c:296: warning: implicit declaration of function `unlock_page'

drivers/net/fc/iph5526.c:227: warning: `driver_template' defined but not used

drivers/net/tokenring/tmsisa.c:44: warning: `portlist' defined but not used

drivers/net/wan/comx-hw-munich.c: In function `MUNICH_close':
drivers/net/wan/comx-hw-munich.c:2011: warning: assignment from incompatible pointer type
drivers/net/wan/comx-hw-munich.c: In function `BOARD_exit':
drivers/net/wan/comx-hw-munich.c:2780: warning: unused variable `hw'

drivers/net/wan/8253x/crc32.c:49:8: warning: extra tokens at end of #endif directive
drivers/net/wan/8253x/crc32.c:55:8: warning: extra tokens at end of #endif directive
drivers/net/wan/8253x/crc32.c:91: warning: static declaration for `fn_calc_memory_chunk_crc32' follows non-static
drivers/net/wan/8253x/8253xtty.c: In function `GetMinorStart':
drivers/net/wan/8253x/8253xtty.c:2405: warning: implicit declaration of function `get_tty_driver'
drivers/net/wan/8253x/8253xtty.c:2405: warning: assignment makes pointer from integer without a cast

drivers/net/wan/sdla_chdlc.c: In function `process_route':
drivers/net/wan/sdla_chdlc.c:2857: warning: format argument is not a pointer (arg 3)
drivers/net/wan/sdla_chdlc.c:2857: warning: too many arguments for format

drivers/atm/ambassador.c:301:10: warning: pasting "." and "start" does not give a valid preprocessing token
drivers/atm/ambassador.c:305:10: warning: pasting "." and "regions" does not give a valid preprocessing token
drivers/atm/ambassador.c:310:10: warning: pasting "." and "data" does not give a valid preprocessing token

drivers/atm/atmtcp.c: In function `atmtcp_v_send':
drivers/atm/atmtcp.c:176: warning: `out_vcc' might be used uninitialized in this function

drivers/ide/hpt366.c:913: warning: `hpt3xx_tristate' defined but not used

drivers/scsi/advansys.c: In function `advansys_detect':
drivers/scsi/advansys.c:5555: warning: `req_cnt' might be used uninitialized in this function

drivers/scsi/dpt_i2o.c:115: warning: `DebugFlags' defined but not used

drivers/scsi/fdomain.c: In function `fdomain_16x0_release':
drivers/scsi/fdomain.c:2045: warning: control reaches end of non-void function

drivers/scsi/NCR5380.c:458: warning: `NCR5380_print_phase' defined but not used
drivers/scsi/NCR5380.c:402: warning: `NCR5380_print' defined but not used

drivers/scsi/qla1280.c:1615: warning: `qla1280_do_dpc' defined but not used

drivers/scsi/pas16.c: In function `pas16_setup':
drivers/scsi/pas16.c:318: warning: declaration of `ints' shadows a parameter
drivers/scsi/pas16.c: At top level:
drivers/scsi/pas16.c:336: warning: initialization from incompatible pointer type

drivers/scsi/NCR5380.c:458: warning: `NCR5380_print_phase' defined but not used
drivers/scsi/NCR5380.c:402: warning: `NCR5380_print' defined but not used
drivers/scsi/NCR5380.c:458: warning: `NCR5380_print_phase' defined but not used
drivers/scsi/NCR5380.c:402: warning: `NCR5380_print' defined but not used
drivers/scsi/NCR5380.c:738: warning: `NCR5380_print_options' defined but not used
drivers/scsi/NCR5380.c:458: warning: `NCR5380_print_phase' defined but not used
drivers/scsi/NCR5380.c:402: warning: `NCR5380_print' defined but not used
drivers/scsi/NCR5380.c:684: warning: `NCR5380_probe_irq' defined but not used
drivers/scsi/NCR5380.c:458: warning: `NCR5380_print_phase' defined but not used
drivers/scsi/NCR5380.c:402: warning: `NCR5380_print' defined but not used

drivers/scsi/eata_dma.c: In function `register_HBA':
drivers/scsi/eata_dma.c:1070: warning: `hd' might be used uninitialized in this function

drivers/message/fusion/mptscsih.c:7183: warning: `mptscsih_setup' defined but not used

In file included from drivers/cdrom/mcdx.c:81:
drivers/cdrom/mcdx.h:180:2: warning: #warning You have not edited mcdx.h
drivers/cdrom/mcdx.h:181:2: warning: #warning Perhaps irq and i/o settings are wrong.

drivers/sound/bin2hex.c: In function `main':
drivers/sound/bin2hex.c:21: warning: implicit declaration of function `exit'

drivers/sound/awe_wave.c:4794: warning: initialization from incompatible pointer type

drivers/sound/msndperm.c:723: warning: `msndpermLen' defined but not used

drivers/sound/msndinit.c:158: warning: `msndinitLen' defined but not used

drivers/sound/pndsperm.c:723: warning: `pndspermLen' defined but not used

drivers/sound/pndspini.c:158: warning: `pndspiniLen' defined but not used

drivers/sound/cmpci.c: In function `cm_release_mixdev':
drivers/sound/cmpci.c:1457: warning: unused variable `s'

drivers/mtd/devices/doc1000.c:87:2: warning: #warning This is definitely not SMP safe. Lock the paging mechanism.

drivers/net/pcmcia/nmclan_cs.c:1061: warning: `smc91c92_ioctl' defined but not used

drivers/net/pcmcia/xirc2ps_cs.c:2099:18: warning: extra tokens at end of #undef directive

In file included from drivers/video/pm3fb.c:88:
drivers/video/pm3fb.h:1286:8: warning: extra tokens at end of #endif directive

drivers/video/aty128fb.c: In function `aty128fb_ioctl':
drivers/video/aty128fb.c:2480: warning: unused variable `rc'
drivers/video/aty128fb.c:2479: warning: unused variable `value'
drivers/video/aty128fb.c:2478: warning: unused variable `fb'
drivers/video/aty128fb.c: At top level:
drivers/video/aty128fb.c:230: warning: `font' defined but not used
drivers/video/aty128fb.c:231: warning: `mode' defined but not used
drivers/video/aty128fb.c:232: warning: `nomtrr' defined but not used
drivers/video/aty128fb.c:1066: warning: `aty128_set_crt_enable' defined but not used
drivers/video/aty128fb.c:1076: warning: `aty128_set_lcd_enable' defined but not used

drivers/video/radeonfb.c:3026: warning: `fbcon_radeon8' defined but not used

drivers/video/sis/init301.c: In function `SiS_GetCRT2Data301':
drivers/video/sis/init301.c:1988: warning: `tempax' might be used uninitialized in this function
drivers/video/sis/init301.c:1988: warning: `tempbx' might be used uninitialized in this function

drivers/video/sstfb.c: In function `sstfb_get_fix':
drivers/video/sstfb.c:777: warning: `var' might be used uninitialized in this function

drivers/usb/vicamurbs.h:21: warning: `s128x98bw' defined but not used

drivers/message/i2o/i2o_pci.c:387:1: warning: no newline at end of file
drivers/message/i2o/i2o_pci.c: In function `i2o_pci_core_attach':
drivers/message/i2o/i2o_pci.c:362: warning: implicit declaration of function `i2o_sys_init'
drivers/message/i2o/i2o_block.c:510: warning: `i2ob_flush' defined but not used

drivers/net/irda/w83977af_ir.c:275: warning: `w83977af_close' defined but not used
drivers/net/irda/ali-ircc.c: In function `ali_ircc_open':
drivers/net/irda/ali-ircc.c:261: warning: unused variable `ret'
drivers/net/irda/ali-ircc.c: At top level:
drivers/net/irda/ali-ircc.c:465: warning: `ali_ircc_probe_43' defined but not used

drivers/telephony/ixj.h:41: warning: `ixj_h_rcsid' defined but not used
include/linux/ixjuser.h:45: warning: `ixjuser_h_rcsid' defined but not used

drivers/isdn/avmb1/capi.c:1551: warning: `capinc_tty_break_ctl' defined but not used
drivers/isdn/avmb1/capi.c:1572: warning: `capinc_tty_send_xchar' defined but not used
drivers/isdn/avmb1/capi.c:1580: warning: `capinc_tty_read_proc' defined but not used

In file included from drivers/scsi/pcmcia/fdomain_inc.c:1:
drivers/scsi/fdomain.c: In function `fdomain_16x0_release':
drivers/scsi/fdomain.c:2045: warning: control reaches end of non-void function

