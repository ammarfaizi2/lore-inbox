Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278625AbRKFIIq>; Tue, 6 Nov 2001 03:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278630AbRKFIIh>; Tue, 6 Nov 2001 03:08:37 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:55569 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S278625AbRKFIIS>;
	Tue, 6 Nov 2001 03:08:18 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4.14 warnings and errors - M
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 06 Nov 2001 19:08:02 +1100
Message-ID: <18970.1005034082@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Full kernel compile with everything as a module where possible,
otherwise built in.  Lots of warnings, some of which have been there
for weeks.  Is there any chance of the maintainers of these sources
fixing them?

loop.c omitted, CONFIG_BLK_DEV_PS2=n, CONFIG_USB_HPUSBSCSI=n due to
broken sources.

arch/i386/kernel/dmi_scan.c:194: warning: `disable_ide_dma' defined but not used

drivers/atm/ambassador.c:301:10: warning: pasting "." and "start" does not give a valid preprocessing token
drivers/atm/ambassador.c:305:10: warning: pasting "." and "regions" does not give a valid preprocessing token
drivers/atm/ambassador.c:310:10: warning: pasting "." and "data" does not give a valid preprocessing token
drivers/atm/atmtcp.c: In function `atmtcp_v_send':
drivers/atm/atmtcp.c:176: warning: `out_vcc' might be used uninitialized in this function

drivers/block/paride/bpck6.c:294: warning: `init_module' defined but not used

drivers/char/applicom.c:268:2: warning: #warning "LEAK"
drivers/char/applicom.c:532:2: warning: #warning "Je suis stupide. DW. - copy*user in cli"
drivers/char/ip2/i2cmd.c:142: warning: `ct89' defined but not used
drivers/char/ftape/lowlevel/ftape-setup.c:64: warning: `ftape_setup' defined but not used

drivers/ide/pdc202xx.c: In function `config_chipset_for_dma':
drivers/ide/pdc202xx.c:529: warning: `drive_pci' might be used uninitialized in this function
drivers/ide/pdcraid.c: In function `pdcraid_ioctl':
drivers/ide/pdcraid.c:99: warning: unused variable `larg'
drivers/ide/pdcraid.c: In function `pdcraid0_make_request':
drivers/ide/pdcraid.c:284: warning: label `outerr' defined but not used
drivers/ide/pdcraid.c: In function `pdcraid_init_one':
drivers/ide/pdcraid.c:550: warning: unused variable `q'
drivers/ide/pdcraid.c: In function `pdcraid_init':
drivers/ide/pdcraid.c:588: warning: unused variable `i'

drivers/ieee1394/pcilynx.c:775: warning: `aux_ops' defined but not used

drivers/media/video/msp3400.c: In function `msp_attach':
drivers/media/video/msp3400.c:1233: warning: `rev2' might be used uninitialized in this function
drivers/media/video/w9966.c:634: warning: `w9966_rReg_i2c' defined but not used

drivers/message/i2o/i2o_block.c: In function `i2ob_install_device':
drivers/message/i2o/i2o_block.c:1375: warning: comparison is always 0 due to width of bitfield
drivers/message/i2o/i2o_block.c:1378: warning: comparison is always 0 due to width of bitfield

drivers/mtd/devices/doc1000.c:87:2: warning: #warning This is definitely not SMP safe. Lock the paging mechanism.

drivers/net/rrunner.c: In function `rr_dump':
drivers/net/rrunner.c:1241: warning: comparison of distinct pointer types lacks a cast
drivers/net/rrunner.c:1252: warning: comparison of distinct pointer types lacks a cast
drivers/net/via-rhine.c: In function `via_rhine_remove_one':
drivers/net/via-rhine.c:1590: warning: unused variable `np'
drivers/net/hamradio/6pack.c:703: warning: `msg_invparm' defined but not used
drivers/net/irda/ali-ircc.c:467: warning: `ali_ircc_probe_43' defined but not used
drivers/net/sk98lin/skvpd.c:245: warning: `VpdWriteDWord' defined but not used
drivers/net/tokenring/olympic.c:1725:22: warning: no newline at end of file
drivers/net/tulip/tulip_core.c: In function `tulip_mwi_config':
drivers/net/tulip/tulip_core.c:1326: warning: label `early_out' defined but not used
drivers/net/wan/comx-hw-mixcom.c: In function `MIXCOM_open':
drivers/net/wan/comx-hw-mixcom.c:570: warning: label `err_restore_flags' defined but not used

drivers/parport/parport_cs.c:109: warning: `parport_cs_ops' defined but not used

drivers/pcmcia/i82092.c: In function `i82092aa_get_mem_map':
drivers/pcmcia/i82092.c:798: warning: unsigned int format, u_long arg (arg 3)
drivers/pcmcia/i82092.c:798: warning: unsigned int format, u_long arg (arg 4)
drivers/pcmcia/i82092.c: In function `i82092aa_set_mem_map':
drivers/pcmcia/i82092.c:822: warning: unsigned int format, u_long arg (arg 3)
drivers/pcmcia/i82092.c:822: warning: unsigned int format, u_long arg (arg 4)
drivers/pcmcia/i82092.c: In function `i82092aa_module_exit':
drivers/pcmcia/i82092.c:898: warning: unused variable `i'

drivers/scsi/advansys.c: In function `advansys_detect':
drivers/scsi/advansys.c:5555: warning: `req_cnt' might be used uninitialized in this function
drivers/scsi/aha1542.c:114: warning: `setup_str' defined but not used
drivers/scsi/NCR5380.c:795: warning: `NCR5380_print_options' defined but not used
drivers/scsi/dpt_i2o.c:115: warning: `DebugFlags' defined but not used
drivers/scsi/eata_dma.c: In function `register_HBA':
drivers/scsi/eata_dma.c:1070: warning: `hd' might be used uninitialized in this function
drivers/scsi/osst.c: In function `osst_reposition_and_retry':
drivers/scsi/osst.c:1385: warning: `expected' might be used uninitialized in this function
drivers/scsi/qla1280.c:1615: warning: `qla1280_do_dpc' defined but not used
drivers/scsi/scsi_debug.c: In function `scsi_debug_biosparam':
drivers/scsi/scsi_debug.c:656: warning: unused variable `size'

drivers/sound/ad1816.c:1340: warning: initialization from incompatible pointer type
drivers/sound/awe_wave.c:4794: warning: initialization from incompatible pointer type
drivers/sound/bin2hex.c: In function `main':
drivers/sound/bin2hex.c:21: warning: implicit declaration of function `exit'
drivers/sound/rme96xx.c: In function `rme96xx_release':
drivers/sound/rme96xx.c:1220: warning: unused variable `hwp'
drivers/sound/trident.c: In function `trident_probe':
drivers/sound/trident.c:3937: warning: unused variable `mask'
drivers/sound/cs4281/cs4281m.c:4478: warning: initialization from incompatible pointer type
drivers/sound/cs4281/cs4281m.c:4479: warning: initialization from incompatible pointer type

drivers/telephony/ixj.h:41: warning: `ixj_h_rcsid' defined but not used

include/linux/ixjuser.h:45: warning: `ixjuser_h_rcsid' defined but not used

drivers/video/vesafb.c: In function `vesafb_setup':
drivers/video/vesafb.c:460: warning: suggest parentheses around assignment used as truth value
drivers/video/vesafb.c: At top level:
drivers/video/vesafb.c:93: warning: `fbcon_cmap' defined but not used
drivers/video/fbcon.c: In function `fbcon_show_logo':
drivers/video/fbcon.c:2129: warning: unused variable `y1'
drivers/video/fbcon.c:2129: warning: unused variable `x1'
drivers/video/fbcon.c:2128: warning: unused variable `src'
drivers/video/fbcon.c:2128: warning: unused variable `dst'
drivers/video/fbcon.c:2125: warning: unused variable `line'
drivers/video/aty128fb.c: In function `aty128fb_setup':
drivers/video/aty128fb.c:1616: warning: suggest parentheses around assignment used as truth value
drivers/video/radeonfb.c: In function `radeonfb_setup':
drivers/video/radeonfb.c:645: warning: suggest parentheses around assignment used as truth value
drivers/video/radeonfb.c: At top level:
drivers/video/radeonfb.c:2506: warning: `fbcon_radeon8' defined but not used
drivers/video/radeonfb.c:601: warning: `radeon_read_OF' declared `static' but never defined
drivers/video/sstfb.c: In function `sstfb_setup':
drivers/video/sstfb.c:1700: warning: suggest parentheses around assignment used as truth value
drivers/video/vfb.c: In function `vfb_setup':
drivers/video/vfb.c:385: warning: suggest parentheses around assignment used as truth value
drivers/video/vga16fb.c: In function `vga16fb_setup':
drivers/video/vga16fb.c:695: warning: suggest parentheses around assignment used as truth value

drivers/video/aty/mach64_accel.c:341:1: warning: pasting "fbcon_aty8" and "=" does not give a valid preprocessing token
drivers/video/aty/mach64_accel.c:344:1: warning: pasting "fbcon_aty16" and "=" does not give a valid preprocessing token
drivers/video/aty/mach64_accel.c:347:1: warning: pasting "fbcon_aty24" and "=" does not give a valid preprocessing token
drivers/video/aty/mach64_accel.c:350:1: warning: pasting "fbcon_aty32" and "=" does not give a valid preprocessing token
drivers/video/matrox/matroxfb_g450.c:7: warning: `matroxfb_g450_get_reg' defined but not used
drivers/video/sis/sis_main.c: In function `sisfb_setup':
drivers/video/sis/sis_main.c:1728: warning: suggest parentheses around assignment used as truth value

fs/affs/super.c:273:2: warning: #warning

fs/ncpfs/ncplib_kernel.c:56: warning: `ncp_add_mem_fromfs' defined but not used

net/irda/irsyms.c:202: warning: `irda_cleanup' defined but not used

depmod: *** Unresolved symbols in /lib/modules/2.4.14/kernel/drivers/acpi/ospm/processor/ospm_processor.o
depmod:		xquad_portio
Lots more references to xquad_portio suppressed.

depmod: *** Unresolved symbols in /lib/modules/2.4.14/kernel/drivers/net/wan/comx.o
depmod:		proc_get_inode

