Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268084AbUIUWNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268084AbUIUWNh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 18:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268100AbUIUWNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 18:13:37 -0400
Received: from baikonur.stro.at ([213.239.196.228]:18409 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S268084AbUIUWNN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 18:13:13 -0400
Date: Wed, 22 Sep 2004 00:13:07 +0200
From: maximilian attems <janitor@sternwelten.at>
To: kj <kernel-janitors@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [announce] 2.6.9-rc2-kjt1
Message-ID: <20040921221307.GG4260@stro.at>
Mail-Followup-To: kj <kernel-janitors@osdl.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lots of new stuff from nacc, lots got merged thanks to akpm.
special kudos to adrian bunk for fixing some mischief of ours.
this kjt has huge pile of 228 patches. some stuff already in -mm.
please poke on it. reviews welcome. :)

here the patch:
http://debian.stro.at/kjt/2.6.9-rc2-kjt1/2.6.9-rc2-bk7-kjt1.patch.bz2

splitted out patches 
(if your patch is inside please double check):
http://debian.stro.at/kjt/2.6.9-rc2-kjt1/split/

thanks for any reports.
a++ maks


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
added since 2.6.9-rc1-kjt1

fix-units-drivers_isdn_icn.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] Re: isdn/icn: change units of ICN_BOOT_TIMEOUT1

function-string-arch_mips_au1000_db1x00_mirage_ts.patch
  From: Clemens Buchacher <drizzd@aon.at>
  Subject: [Kernel-janitors] [PATCH] __FUNCTION__ string concatenation 	deprecated

msleep-drivers_atm_ambassador.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 1/5] atm/ambassador: replace 	schedule_timeout() with msleep()

msleep-drivers_atm_firestream.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2/5] atm/firestream: replace 	schedule_timeout() with msleep()

msleep-drivers_atm_he.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 3/5] atm/he: replace schedule_timeout() 	with msleep()

msleep-drivers_atm_idt77252.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 4/5] atm/idt77252: replace 	schedule_timeout() with msleep_interruptible()

msleep-drivers_atm_lanai.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 5/5] atm/lanai: replace schedule_timeout() 	with msleep()

msleep-drivers_block_xd.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 8/8] block/xd: replace schedule_timeout() 	with msleep()/msleep_interruptible()

msleep-drivers_char_rio_linux.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 20/33] char/rio_linux: replace 	schedule_timeout() with msleep()/msleep_interruptible()

msleep-drivers_char_sis-agp.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 24/33] char/sis-agp: replace 	schedule_timeout() with msleep()

msleep-drivers_ide_ide-cd.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 1/3] ide/ide-cd: replace 	cdrom_sleep() with msleep()

msleep-drivers_ide_ide-cs.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 2/3] ide/ide-cs: replace 	schedule_timeout() with msleep()

msleep-drivers_isdn_hisax_config.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 3/15] isdn/config: replace 	schedule_timeout() with msleep()

msleep-drivers_isdn_hisax_elsa.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 4/15] isdn/elsa: replace 	schedule_timeout() with msleep()

msleep-drivers_isdn_hisax_hfc_pci.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 7/15] isdn/hfc_pci: replace 	schedule_timeout() with msleep()

msleep-drivers_isdn_hisax_hfc_sx.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 8/15] isdn/hfc_sx: replace 	schedule_timeout() with msleep()

msleep-drivers_isdn_hisax_hfcscard.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 9/15] isdn/hfcscard: replace 	schedule_timeout() with msleep()

msleep-drivers_media_video_ovcamchip_ovcamchip_core.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 8/17] media/ovcamchip_core: 	replace schedule_timeout() with msleep()

msleep-drivers_media_video_zr36120.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 17/17] media/zr36120: replace 	schedule_timeout() with msleep()

msleep-drivers_mtd_chips_amd_flash.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 1/4] mtd/amd_flash: replace 	schedule_timeout() with msleep()

msleep-drivers_mtd_chips_cfi_cmdset_0001.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 2/4] mtd/cfi_cmdset_0001: 	replace schedule_timeout() with msleep()

msleep-drivers_mtd_chips_cfi_cmdset_0002.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 3/4] mtd/cfi_cmdset_0002: 	replace schedule_timeout() with msleep()

msleep-drivers_mtd_chips_cfi_cmdset_0020.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 4/4] mtd/cfi_cmdset_0020: 	replace schedule_timeout() with msleep()

msleep_interruptible-drivers_base_dmapool.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH] base/dmapool: replace schedule_timeout() 	with msleep_interruptible()

msleep_interruptible-drivers_block_cciss.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 1/8] block/cciss: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_block_pcd.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2/8] block/pcd: replace pcd_sleep() with 	msleep_interruptible()

msleep_interruptible-drivers_block_pf.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 3/8] block/pf: replace pf_sleep() with 	msleep_interruptible()

msleep_interruptible-drivers_block_pg.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 4/8] block/pg: replace pg_sleep() with 	msleep_interruptible()

msleep_interruptible-drivers_block_pt.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 5/8] block/pt: replace pt_sleep() with 	msleep_interruptible()

msleep_interruptible-drivers_cdrom_sonycd535.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH] cdrom/sonycd535: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_char_amiserial.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 1/33] char/amiserial: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_char_cyclades.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 2/33] char/cyclades: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_char_dtlk.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 4/33] char/dtlk: replace 	schedule_timeout()/dtlk_delay() with msleep_interruptible()

msleep_interruptible-drivers_char_epca.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 5/33] char/epca: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_char_esp.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 6/33] char/esp: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_char_ftape-io.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 8/33] char/ftape-io: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_char_generic_serial.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 9/33] char/generic_serial: 	replace schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_char_hvc_console.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 10/33] char/hvc_console: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_char_ip2main.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 12/33] char/ip2main: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_char_isicom.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 14/33] char/isicom: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_char_istallion.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 15/33] char/istallion: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_char_lcd.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 16/33] char/lcd: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_char_moxa.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 17/33] char/moxa: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_char_mxser.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 18/33] char/mxser: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_char_pcxx.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 19/33] char/pcxx: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_char_riscom8.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 21/33] char/riscom8: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_char_rocket.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 22/33] char/rocket: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_char_serial167.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 23/33] char/serial167: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_char_specialix.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 25/33] char/specialix: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_char_stallion.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 26/33] char/stallion: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_char_synclink.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 28/33] char/synclink: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_char_synclink_cs.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 29/33] char/synclink_cs: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_char_synclinkmp.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 30/33] char/synclinkmp: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_char_tpqic02.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 31/33] char/tpqic02: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_char_zftape-buffers.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 32/33] char/zftape-buffers: 	replace schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_i2c_busses_i2c-mpc.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 2/2] i2c/i2c-mpc: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_ieee1394_nodemgr.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 1/2] ieee1394/nodemgr: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_ieee1394_sbp2.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 2/2] ieee1394/sbp2: replace 	schedule_timeout() with msleep_interruptible()
reworked as 2 hunk is already merged, kept first

msleep_interruptible-drivers_isdn_act2000_isa_delay.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 1/15] isdn/act2000_isa: replace 	act2000_isa_delay() with msleep_interruptible()

msleep_interruptible-drivers_isdn_capi_kcapi.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 16/16] isdn/kcapi: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_isdn_hysdn_boardergo.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 2/15] isdn/boardergo: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_isdn_hysdn_sched.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 10/15] isdn/hysdn_sched: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_isdn_icn.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 12/15] isdn/icn: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_isdn_init.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] Re: isdn/init: replace schedule_timeout() with 	msleep_interruptible()

msleep_interruptible-drivers_isdn_tty.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 14/16] isdn/isdn_tty: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_macintosh_macserial.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 1/3] macintosh/macserial: 	replace schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_macintosh_mediabay.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 2/3] macintosh/mediabay: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_macintosh_therm_windtunnel.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 3/3] macintosh/therm_windtunnel: 	replace schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_md_md.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 1/3] md/md: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_md_raid1.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 3/3] md/raid1: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_md_raid10.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 2/3] md/raid10: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_media_video_bttv-i2c.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 1/17] media/bttv-i2c: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_media_video_bw-qcam.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 2/17] media/bw-qcam: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_media_video_c-qcam.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 3/17] media/c-qcam: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_media_video_cpia.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 4/17] media/cpia: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_media_video_cx88_cx88-tvaudio.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 4/17] media/cx88-tvaudio: 	replace schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_media_video_cx88_cx88-video.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 6/17] media/cx88-video: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_media_video_msp3400.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 7/17] media/msp3400: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_media_video_planb.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 9/17] media/planb: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_media_video_saa5249.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 10/17] media/saa5249: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_media_video_saa6752hs.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 11/17] media/saa6752hs: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_media_video_saa7134_saa7134-core.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 12/17] media/saa7134-core: 	replace schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_media_video_saa7134_saa7134-ts.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 13/17] media/saa7134-ts: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_media_video_saa7134_saa7134-tvaudio.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 14/17] media/saa7134-tvaudio: 	replace schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_media_video_tda9887.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 15/17] media/tda9887: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_message_fusion_mptbase.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 3/3] message/mptbase: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_message_i2o_exec-osm.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 2/4] message/exec-osm: replace 	schedule_timeout() with msleep_interruptible()

msleep_interruptible-drivers_mmc_mmc.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2] mmc: replace schedule_timeout() 	with msleep_interruptible()

remove-milliseconds-drivers_isdn_sc_hardware.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 5/15] isdn/hardware: remove 	milliseconds()

remove-unused-sleep-drivers_i2c_algos_i2c-algo-ite.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 1/2] i2c/i2c-algo-ite: remove 	unused iic_sleep()

set_current_state-drivers_block_swim3.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 6/8] block/swim3: replace direct 	assignment with set_current_state()

set_current_state-drivers_block_swim_iop.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 7/8] block/swim_iop: replace direct 	assignment with set_current_state()

set_current_state-drivers_char_fdc-io.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 7/33] char/fdc-io: replace 	direct assignment with set_current_state()

set_current_state-drivers_char_ipmi_si_intf.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 13/33] char/ipmi_si_intf: add 	set_current_state()

set_current_state-drivers_char_sx.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 27/33] char/sx: replace direct 	assignment with set_current_state()

set_current_state-drivers_isdn_isdnloop.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 15/16] isdn/isdnloop: add 	set_current_state() before schedule_timeout()

ssleep-drivers_media_video_zoran_driver.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 16/17] media/zoran_driver: 	replace schedule_timeout() with ssleep()

ssleep-drivers_message_i20_device.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH 2.6.9-rc2 1/4] message/device: replace 	schedule_timeout() with ssleep()


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
merged 45 patches in linus current:

add-msleep_interruptible.patch
list-for-each-arch_sparc64_kernel_pci_common.patch
list-for-each-arch_sparc64_kernel_pci_sabre.patch
min-max-arch_ia64_hp_sim_simserial.patch
min-max-arch_ia64_kernel_unwind.patch
min-max-arch_s390_kernel_debug.patch
min-max-char_amiserial.patch
min-max-char_epca.patch
min-max-char_esp.patch
min-max-char_isicom.patch
min-max-char_mxser.patch
min-max-char_pcmcia_synclink_cs.patch
min-max-char_pcxx.patch
min-max-char_riscom8.patch
min-max-char_rocket_int.h.patch
min-max-char_rocket.patch
min-max-char_selection.patch
min-max-char_serial167.patch
min-max-char_specialix.patch
min-max-char_synclinkmp.patch
min-max-char_synclink.patch
min-max-linux_isicom.h.patch
min-max-tc_zs.patch
msleep-drivers_cdrom_cdu31a.patch
msleep-drivers_cdrom_mcd.patch
msleep-drivers_char_ds1620.patch
msleep-drivers_char_dsp56k.patch
msleep-drivers_char_ec3104_keyb.patch
msleep-drivers_char_isicom.patch
msleep-drivers_char_nwflash.patch
msleep-drivers_char_watchdog_pcwd.patch
msleep-drivers_media_common_saa7146_i2c.patch
msleep-drivers_media_radio-aimslab.patch
msleep-drivers_media_radio-cadet.patch
msleep-drivers_media_radio-maestro.patch
msleep-drivers_media_radio-maxiradio.patch
msleep-drivers_media_radio-miropcm20-rds.patch
msleep-drivers_media_radio-sf16fmi.patch
msleep-drivers_media_radio-sf16fmr2.patch
msleep-drivers_media_video_zoran_device.patch
msleep-drivers_message_fusion_mptscsih.patch
msleep-drivers_mtd_chips_cfi_cmdset_0001.patch
use-msecs-to-jiffies-pcmcia_synclink_cs.patch
use-msecs-to-jiffies-pcmcia_synclinkmp.patch
use-msecs-to-jiffies-drivers_char_synclink.patch


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
dropped 36 patches:

msleep-drivers_message_i2o_i2o_core.patch
kernel_thread-i2o_core.patch
no more i2o/i2o_core.c

msleep-drivers_media_radio-zoltrix.patch
driver should sleep for 10 mS rather than pointless schedule

min-max-arch_um_drivers_mconsole_user.patch
touching a strange user space program

msleep-drivers_atm_firestream.patch
msleep-drivers_atm_he.patch
msleep-drivers_block_cciss.patch
msleep-drivers_block_paride_pcd.patch
msleep-drivers_block_paride_pf.patch
msleep-drivers_block_paride_pg.patch
msleep-drivers_block_paride_pt.patch
msleep-drivers_block_xd.patch
msleep-drivers_char_agp_sis-agp.patch
msleep-drivers_char_hvc_console.patch
msleep-drivers_ide_ide-cd.patch
msleep-drivers_ide_legacy_ide-cs.patch
msleep-drivers_isdn_hisax_config.patch
msleep-drivers_isdn_hisax_elsa.patch
msleep-drivers_isdn_hisax_hfc_pci.patch
msleep-drivers_isdn_hisax_hfc_sx.patch
msleep-drivers_isdn_hisax_hfcscard.patch
msleep-drivers_isdn_hysdn_boardergo.patch
msleep-drivers_isdn_hysdn_sched.patch
msleep-drivers_isdn_i4l_isdn_tty.patch
msleep-drivers_isdn_icn.patch
msleep-drivers_isdn_sc_init.patch
msleep-drivers_media_video_bw-qcam.patch
msleep-drivers_media_video_c-qcam.patch
msleep-drivers_media_video_cx88-video.patch
msleep-drivers_media_video_msp3400.patch
msleep-drivers_media_video_planb.patch
msleep-drivers_media_video_sa7134-core.patch
msleep-drivers_media_video_sa7134-ts.patch
msleep-drivers_media_video_sa7134_saa6752hs.patch
msleep-drivers_media_video_zoran_driver.patch
msleep-drivers_media_video_zr26120.patch
use-msecs-to-jiffies-drivers_macintosh_mediabay.patch
reworked by nacc


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
todo:
- split kernel_thread() patches from Walter Harms
- get __FUNCTION__ string patches splitted from Clemens Buchacher

 
