Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263638AbTGKPgN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 11:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263597AbTGKPgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 11:36:13 -0400
Received: from air-2.osdl.org ([65.172.181.6]:48570 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263738AbTGKPed (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 11:34:33 -0400
Subject: Re: Linux 2.5.75 (compile statistics)
From: John Cherry <cherry@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0307101405490.4560-100000@home.osdl.org>
References: <Pine.LNX.4.44.0307101405490.4560-100000@home.osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1057938733.27296.19.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Jul 2003 08:52:14 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compile statistics: 2.5.75
Compiler: gcc 3.2.2
Script: http://www.osdl.org/archive/cherry/stability/compregress.sh

          bzImage       bzImage        modules
        (defconfig)  (allmodconfig) (allmodconfig)

2.5.75  0 warnings     8 warnings   1296 warnings
        0 errors       9 errors       39 errors

2.5.74  0 warnings     8 warnings   1338 warnings
        0 errors       9 errors       40 errors

2.5.73  2 warnings    11 warnings   1347 warnings
        0 errors       9 errors       43 errors

2.5.72  2 warnings     8 warnings   1335 warnings
        0 errors       0 errors       48 errors

2.5.71  6 warnings    11 warnings   1347 warnings
        0 errors       0 errors       48 errors

2.5.70  7 warnings    10 warnings   1366 warnings
        0 errors       0 errors       57 errors


Compile statistics have been for kernel releases from 2.5.46 to 2.5.75
at: www.osdl.org/archive/cherry/stability

Failure summary:

   drivers/block: 2 warnings, 1 errors
   drivers/char: 228 warnings, 4 errors
   drivers/isdn: 216 warnings, 6 errors
   drivers/media: 102 warnings, 5 errors
   drivers/mtd: 42 warnings, 1 errors
   drivers/net: 29 warnings, 6 errors
   drivers/net: 302 warnings, 6 errors
   drivers/scsi/aic7xxx: 0 warnings, 1 errors
   drivers/scsi: 110 warnings, 10 errors
   drivers/video: 75 warnings, 3 errors
   sound/oss: 49 warnings, 3 errors
   sound: 5 warnings, 3 errors

Warning summary:

   drivers/atm: 36 warnings, 0 errors
   drivers/cdrom: 25 warnings, 0 errors
   drivers/i2c: 3 warnings, 0 errors
   drivers/ide: 28 warnings, 0 errors
   drivers/md: 2 warnings, 0 errors
   drivers/message: 1 warnings, 0 errors
   drivers/pci: 1 warnings, 0 errors
   drivers/pcmcia: 3 warnings, 0 errors
   drivers/scsi/aacraid: 1 warnings, 0 errors
   drivers/scsi/pcmcia: 5 warnings, 0 errors
   drivers/scsi/sym53c8xx_2: 1 warnings, 0 errors
   drivers/serial: 1 warnings, 0 errors
   drivers/telephony: 9 warnings, 0 errors
   drivers/video/aty: 3 warnings, 0 errors
   drivers/video/matrox: 5 warnings, 0 errors
   drivers/video/sis: 2 warnings, 0 errors
   fs/afs: 1 warnings, 0 errors
   fs/intermezzo: 1 warnings, 0 errors
   fs/jffs: 1 warnings, 0 errors
   fs/lockd: 4 warnings, 0 errors
   fs/nfsd: 2 warnings, 0 errors
   fs/smbfs: 2 warnings, 0 errors
   net: 35 warnings, 0 errors
   sound/isa: 3 warnings, 0 errors


===== Porting items identified as warnings (2003-07-10) ========

=====================================
Misc porting reminders: 4 reminders
=====================================
drivers/char/applicom.c:260:2: warning: #warning "LEAK"
drivers/char/applicom.c:524:2: warning: #warning "Je suis stupide. DW. -
copy*user in cli"
drivers/char/mwave/mwavedd.c:332:2: warning: #warning "Sleeping on
spinlock"
kernel/suspend.c:294:2: warning: #warning This might be broken. We need
to somehow wait for data to reach the disk

========================================================================
DMA mapping conversions using Documnentation/DMA-mapping.txt: 5 files
========================================================================
drivers/net/defxx.c:202:2: #error Please convert me to
Documentation/DMA-mapping.txt
drivers/scsi/AM53C974.c:1:2: #error Please convert me to
Documentation/DMA-mapping.txt
drivers/scsi/dpt_i2o.c:32:2: #error Please convert me to
Documentation/DMA-mapping.txt
drivers/scsi/ini9100u.c:111:2: #error Please convert me to
Documentation/DMA-mapping.txt
drivers/scsi/scsiiom.c:9:2: #error Please convert me to
Documentation/DMA-mapping.txt

=====================================
Other #error conversions: 1 files
=====================================
drivers/scsi/pci2220i.c:37:2: #error Convert me to understand
page+offset based scatterlists

===========================================
MOD_INC_USE_COUNT deprecations: 123 files
===========================================
drivers/atm/eni.c
drivers/atm/idt77252.c
drivers/atm/lanai.c
drivers/atm/uPD98402.c
drivers/atm/zatm.c
drivers/char/ftape/compressor/zftape-compress.c
drivers/char/genrtc.c
drivers/char/ip2.c
drivers/char/n_r3964.c
drivers/char/watchdog/acquirewdt.c
drivers/char/watchdog/ib700wdt.c
drivers/char/watchdog/machzwd.c
drivers/char/watchdog/pcwd.c
drivers/char/watchdog/sbc60xxwdt.c
drivers/char/watchdog/sc520_wdt.c
drivers/char/watchdog/softdog.c
drivers/char/watchdog/wdt_pci.c
drivers/ide/ide-probe.c
drivers/ide/legacy/ide-cs.c
drivers/ide/pci/aec62xx.c
drivers/ide/pci/alim15x3.c
drivers/ide/pci/amd74xx.c
drivers/ide/pci/cmd64x.c
drivers/ide/pci/cs5520.c
drivers/ide/pci/cy82c693.c
drivers/ide/pci/hpt34x.c
drivers/ide/pci/hpt366.c
drivers/ide/pci/ns87415.c
drivers/ide/pci/opti621.c
drivers/ide/pci/pdc202xx_new.c
drivers/ide/pci/pdc202xx_old.c
drivers/ide/pci/piix.c
drivers/ide/pci/rz1000.c
drivers/ide/pci/sc1200.c
drivers/ide/pci/serverworks.c
drivers/ide/pci/siimage.c
drivers/ide/pci/sis5513.c
drivers/ide/pci/slc90e66.c
drivers/ide/pci/triflex.c
drivers/ide/pci/trm290.c
drivers/ide/pci/via82cxxx.c
drivers/isdn/capi/capidrv.c
drivers/isdn/capi/kcapi.c
drivers/isdn/hardware/eicon/capifunc.c
drivers/isdn/hardware/eicon/capimain.c
drivers/isdn/hardware/eicon/diva_didd.c
drivers/isdn/hardware/eicon/divamnt.c
drivers/isdn/hardware/eicon/divasi.c
drivers/isdn/hardware/eicon/divasmain.c
drivers/isdn/hysdn/hysdn_net.c
drivers/isdn/i4l/isdn_common.c
drivers/isdn/i4l/isdn_tty.c
drivers/md/md.c
drivers/media/video/bt819.c
drivers/media/video/bt856.c
drivers/media/video/saa5249.c
drivers/media/video/saa7110.c
drivers/media/video/saa7111.c
drivers/media/video/saa7185.c
drivers/media/video/tuner-3036.c
drivers/media/video/zr36067.c
drivers/mtd/chips/amd_flash.c
drivers/mtd/chips/sharp.c
drivers/mtd/devices/blkmtd.c
drivers/net/arcnet/arc-rimi.c
drivers/net/arcnet/com20020-isa.c
drivers/net/arcnet/com20020-pci.c
drivers/net/arcnet/com20020.c
drivers/net/arcnet/com90io.c
drivers/net/arcnet/com90xx.c
drivers/net/fc/iph5526.c
drivers/net/hamradio/baycom_epp.c
drivers/net/hamradio/baycom_par.c
drivers/net/hamradio/baycom_ser_fdx.c
drivers/net/hamradio/baycom_ser_hdx.c
drivers/net/hamradio/bpqether.c
drivers/net/hamradio/hdlcdrv.c
drivers/net/hamradio/mkiss.c
drivers/net/irda/act200l.c
drivers/net/irda/actisys.c
drivers/net/irda/esi.c
drivers/net/irda/girbil.c
drivers/net/irda/irtty.c
drivers/net/irda/litelink.c
drivers/net/irda/ma600.c
drivers/net/irda/mcp2120.c
drivers/net/irda/old_belkin.c
drivers/net/irda/tekram.c
drivers/net/irda/toshoboe.c
drivers/net/pcmcia/com20020_cs.c
drivers/net/rrunner.c
drivers/net/wan/comx-hw-comx.c
drivers/net/wan/comx-hw-locomx.c
drivers/net/wan/comx-hw-mixcom.c
drivers/net/wan/comx-hw-munich.c
drivers/net/wan/comx-proto-fr.c
drivers/net/wan/comx-proto-lapb.c
drivers/net/wan/comx-proto-ppp.c
drivers/net/wan/comx.c
drivers/net/wan/cosa.c
drivers/net/wan/dlci.c
drivers/net/wan/dscc4.c
drivers/net/wan/farsync.c
drivers/net/wan/hostess_sv11.c
drivers/net/wan/lmc/lmc_main.c
drivers/net/wan/pc300_drv.c
drivers/net/wan/sdla.c
drivers/net/wan/sdlamain.c
drivers/net/wan/sealevel.c
drivers/telephony/ixj.c
drivers/telephony/phonedev.c
fs/lockd/clntlock.c
fs/lockd/svc.c
fs/nfsd/nfssvc.c
fs/smbfs/smbiod.c
net/atm/br2684.c
net/atm/pppoatm.c
net/irda/ircomm/ircomm_tty.c
net/lapb/lapb_iface.c
net/wanrouter/wanmain.c
sound/oss/cs4281/cs4281m.c
sound/oss/cs46xx.c
sound/oss/msnd.c

===========================================
MOD_DEC_USE_COUNT deprecations: 91 files
===========================================
drivers/atm/eni.c
drivers/atm/idt77252.c
drivers/atm/lanai.c
drivers/char/epca.c
drivers/char/genrtc.c
drivers/char/ip2.c
drivers/char/n_r3964.c
drivers/ide/ide-probe.c
drivers/ide/legacy/ide-cs.c
drivers/isdn/capi/capidrv.c
drivers/isdn/capi/kcapi.c
drivers/isdn/hardware/eicon/capifunc.c
drivers/isdn/hardware/eicon/capimain.c
drivers/isdn/hardware/eicon/diva_didd.c
drivers/isdn/hardware/eicon/divamnt.c
drivers/isdn/hardware/eicon/divasi.c
drivers/isdn/hardware/eicon/divasmain.c
drivers/isdn/hysdn/hysdn_net.c
drivers/isdn/i4l/isdn_common.c
drivers/isdn/i4l/isdn_tty.c
drivers/md/md.c
drivers/media/video/bt819.c
drivers/media/video/bt856.c
drivers/media/video/saa5249.c
drivers/media/video/saa7110.c
drivers/media/video/saa7111.c
drivers/media/video/saa7185.c
drivers/media/video/tuner-3036.c
drivers/media/video/zr36067.c
drivers/message/i2o/i2o_block.c
drivers/mtd/devices/blkmtd.c
drivers/net/arcnet/arc-rimi.c
drivers/net/arcnet/com20020-isa.c
drivers/net/arcnet/com20020-pci.c
drivers/net/arcnet/com20020.c
drivers/net/arcnet/com90io.c
drivers/net/arcnet/com90xx.c
drivers/net/fc/iph5526.c
drivers/net/hamradio/baycom_epp.c
drivers/net/hamradio/baycom_par.c
drivers/net/hamradio/baycom_ser_fdx.c
drivers/net/hamradio/baycom_ser_hdx.c
drivers/net/hamradio/bpqether.c
drivers/net/hamradio/hdlcdrv.c
drivers/net/hamradio/mkiss.c
drivers/net/irda/act200l.c
drivers/net/irda/actisys.c
drivers/net/irda/esi.c
drivers/net/irda/girbil.c
drivers/net/irda/irtty.c
drivers/net/irda/litelink.c
drivers/net/irda/ma600.c
drivers/net/irda/mcp2120.c
drivers/net/irda/old_belkin.c
drivers/net/irda/tekram.c
drivers/net/irda/toshoboe.c
drivers/net/pcmcia/com20020_cs.c
drivers/net/rrunner.c
drivers/net/wan/comx-hw-comx.c
drivers/net/wan/comx-hw-locomx.c
drivers/net/wan/comx-hw-mixcom.c
drivers/net/wan/comx-hw-munich.c
drivers/net/wan/comx-proto-fr.c
drivers/net/wan/comx-proto-lapb.c
drivers/net/wan/comx-proto-ppp.c
drivers/net/wan/comx.c
drivers/net/wan/cosa.c
drivers/net/wan/dlci.c
drivers/net/wan/dscc4.c
drivers/net/wan/farsync.c
drivers/net/wan/hostess_sv11.c
drivers/net/wan/lmc/lmc_main.c
drivers/net/wan/pc300_drv.c
drivers/net/wan/sdla.c
drivers/net/wan/sdlamain.c
drivers/net/wan/sealevel.c
drivers/telephony/ixj.c
drivers/telephony/phonedev.c
fs/intermezzo/inode.c
fs/lockd/clntlock.c
fs/lockd/svc.c
fs/nfsd/nfssvc.c
fs/smbfs/smbiod.c
net/atm/br2684.c
net/atm/pppoatm.c
net/irda/ircomm/ircomm_tty.c
net/lapb/lapb_iface.c
net/wanrouter/wanmain.c
sound/oss/cs4281/cs4281m.c
sound/oss/cs46xx.c
sound/oss/msnd.c

===========================================
cli, save_flags conversions: 62 files
===========================================
drivers/atm/ambassador.c
drivers/atm/uPD98402.c
drivers/atm/zatm.c
drivers/cdrom/cdu31a.c
drivers/cdrom/cm206.c
drivers/cdrom/sbpcd.c
drivers/cdrom/sonycd535.c
drivers/char/cyclades.c
drivers/char/epca.c
drivers/char/esp.c
drivers/char/ftape/lowlevel/fdc-io.c
drivers/char/ftape/lowlevel/ftape-calibr.c
drivers/char/ftape/lowlevel/ftape-format.c
drivers/char/generic_serial.c
drivers/char/ip2main.c
drivers/char/isicom.c
drivers/char/istallion.c
drivers/char/moxa.c
drivers/char/mxser.c
drivers/char/stallion.c
drivers/i2c/i2c-elektor.c
drivers/isdn/act2000/capi.h
drivers/isdn/divert/divert_init.c
drivers/isdn/divert/divert_procfs.c
drivers/isdn/divert/isdn_divert.c
drivers/isdn/hardware/avm/b1.c
drivers/isdn/hardware/avm/c4.c
drivers/isdn/hardware/avm/t1isa.c
drivers/isdn/hysdn/boardergo.c
drivers/isdn/hysdn/hysdn_proclog.c
drivers/isdn/hysdn/hysdn_sched.c
drivers/isdn/i4l/isdn_audio.c
drivers/isdn/i4l/isdn_tty.c
drivers/isdn/i4l/isdn_ttyfax.c
drivers/isdn/icn/icn.c
drivers/isdn/isdnloop/isdnloop.c
drivers/isdn/pcbit/edss1.c
drivers/isdn/pcbit/layer2.c
drivers/isdn/sc/command.c
drivers/isdn/sc/message.c
drivers/isdn/sc/shmem.c
drivers/isdn/sc/timer.c
drivers/net/3c527.c
drivers/net/82596.c
drivers/net/hamradio/6pack.c
drivers/net/hamradio/dmascc.c
drivers/net/hamradio/mkiss.c
drivers/net/irda/toshoboe.c
drivers/net/ni5010.c
drivers/net/ni65.c
drivers/net/pcmcia/nmclan_cs.c
drivers/net/sk_mca.c
drivers/net/tulip/xircom_tulip_cb.c
drivers/net/wan/comx-hw-comx.c
drivers/net/wan/comx-hw-locomx.c
drivers/net/wan/comx-hw-mixcom.c
drivers/net/wan/comx.c
drivers/net/wan/sdla.c
drivers/net/wan/sdla_x25.c
drivers/net/wan/x25_asy.c
drivers/scsi/AM53C974.c
drivers/scsi/mca_53c9x.c

===========================================
sti conversions: 14 files
===========================================
drivers/cdrom/cdu31a.c
drivers/cdrom/cm206.c
drivers/cdrom/sbpcd.c
drivers/cdrom/sonycd535.c
drivers/char/esp.c
drivers/char/ftape/lowlevel/fdc-isr.c
drivers/char/ftape/lowlevel/ftape-io.c
drivers/char/generic_serial.c
drivers/char/isicom.c
drivers/i2c/i2c-elektor.c
drivers/isdn/act2000/act2000_isa.c
drivers/isdn/hysdn/boardergo.c
drivers/isdn/hysdn/hysdn_sched.c
drivers/net/wan/cosa.c

John

