Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266654AbUHOMRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266654AbUHOMRs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 08:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbUHOMRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 08:17:48 -0400
Received: from baikonur.stro.at ([213.239.196.228]:6376 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S266654AbUHOMRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 08:17:19 -0400
Date: Sun, 15 Aug 2004 14:17:13 +0200
From: maximilian attems <janitor@sternwelten.at>
To: kj <kernel-janitors@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [announce] 2.6.8.1-kjt1
Message-ID: <20040815121713.GE1799@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

woow the kernel janitor mailling list was quite busy lately.
this patchset has lots of msleep and list_fore_each conversions.
it also adds msleep_interruptible() to kernel/timer.c.

diffstat show that the 202 patches change 194 files mostly under drivers.
please bug me on list if i forgot something important for next kjt.
some conversion is already in linus tree and i left those were the
maintainer said to incorporate the fix.

patchset will go tomorrow directly to akpm, as maintainer were often involved.
please test thoroughly, i'm quite happily running this kernel ATM:
Linux sputnik 2.6.8.1-kjt1.040814 #1 Sat Aug 14 23:11:28 CEST 2004 i686 GNU/Linux

here the patch (applies to 2.6.8.1):
http://debian.stro.at/kjt/2.6.8-kjt1/2.6.8-kjt1.patch.bz2

split out patches:
http://debian.stro.at/kjt/2.6.8-kjt1/split/

a++ max


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
added since 2.6.8-kjt2

list-for-each-entry-drivers_usb_core_devices.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [Kernel-janitors] [patch 2.6.8-rc2] list_for_each_entry: drivers-usb-core-devices.c

list-for-each-entry-drivers_usb_class_audio.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [Kernel-janitors] [patch 2.6.8-rc2] list_for_each_entry: drivers-usb-class-audio.c

list-for-each-entry-drivers_usb_class_usb-midi.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [Kernel-janitors] [patch 2.6.8-rc2] list_for_each_entry: drivers-usb-class-usb-midi.c

list-for-each-entry-drivers_atm_he.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [Kernel-janitors] [patch 2.6.8-rc2] list_for_each_entry: 	drivers-atm-he.c

list-for-each-entry-drivers_chan_kern.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [Kernel-janitors] [patch 2.6.8-rc2] list_for_each_entry: 	arch-um-drivers-chan_kern.c

list-for-each-entry-drivers_macintosh_via-pmu.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [Kernel-janitors] [patch 2.6.8-rc2] list_for_each_entry: 	drivers-macintosh-via-pmu.c

list-for-each-entry-drivers_net_ppp_generic.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [Kernel-janitors] [patch 2.6.8-rc2] list_for_each_entry: 	drivers-net-ppp_generic.c

list-for-each-entry-drivers_usb_host_uhci-hcd.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [Kernel-janitors] [patch 2.6.8-rc2] list_for_each_entry: 	drivers-usb-host-uhci-hcd.c

list-for-each-entry-drivers_usb_media_dabusb.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [Kernel-janitors] [patch 2.6.8-rc2] list_for_each_entry: 	drivers-usb-media-dabusb.c

list-for-each-entry-fs_jffs_intrep.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [Kernel-janitors] [patch 2.6.8-rc2] list_for_each_entry: 	fs-jffs-intrep.c

list-for-each-entry-fs_namespace.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [Kernel-janitors] [patch 2.6.8-rc2] list_for_each_entry: 	fs-namespace.c

list-for-each-entry-safe-arch_i386_mm_pageattr.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [Kernel-janitors] [patch 2.6.8-rc2] list_for_each_entry: 	arch-i386-mm-pageattr.c

list-for-each-entry-safe-drivers_usb_host_hc_sl811.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [Kernel-janitors] [patch 2.6.8-rc2] list_for_each_entry: 	drivers-usb-host-hc_sl811.c

list-for-each-entry-safe-drivers_usb_serial_ipaq.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [Kernel-janitors] [patch 2.6.8-rc2] list_for_each_entry: 	drivers-usb-serial-ipaq.c

list-for-each-entry-safe-fs_coda_psdev.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [Kernel-janitors] [patch 2.6.8-rc2] list_for_each_entry: 	fs-coda-psdev.c

list-for-each-entry-safe-fs_dquot.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [Kernel-janitors] [patch 2.6.8-rc2] list_for_each_entry: fs-dquot.c

list-for-each-entry-sound_core_memory.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [Kernel-janitors] [patch 2.6.8-rc2] list_for_each_entry: 	sound-core-memory.c

list-for-each-fs_dcache.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [Kernel-janitors] [patch 2.6.8] list_for_each_entry in fs/dcache.c

macros-correct-comments-net-appletalk.patch
  From: <WHarms@bfs.de>(Walter Harms)
  Subject: [Kernel-janitors] inux-2.6.7: sysctl_net_atalk.c fxi wrong comments

msleep-drivers_atm_firestream.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] firestream: replace schedule_timeout() 	with msleep()

msleep-drivers_atm_he.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] he: replace schedule_timeout() with 	msleep()

msleep-drivers_block_cciss.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] cciss: replace schedule_timeout() with 	msleep()

msleep-drivers_block_nbd.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] nbd: replace schedule_timeout() with 	msleep()

msleep-drivers_block_paride_pcd.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] paride: replace schedule_timeout() with 	msleep()

msleep-drivers_block_paride_pf.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] paride: replace schedule_timeout() with 	msleep()

msleep-drivers_block_paride_pg.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] paride: replace schedule_timeout() with 	msleep()

msleep-drivers_block_paride_pt.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] paride: replace schedule_timeout() with 	msleep()

msleep-drivers_block_xd.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] xd: replace schedule_timeout() with 	msleep()

msleep-drivers_cdrom_cdu31a.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] cdu31a: replace schedule_timeout() with 	msleep()

msleep-drivers_cdrom_mcd.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] mcd: replace schedule_timeout() with 	msleep()

msleep-drivers_char_agp_sis-agp.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] Re: sis-agp: replace schedule_timeout() with 	msleep()

msleep-drivers_char_ds1620.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] ds1620: replace schedule_timeout() with 	msleep()

msleep-drivers_char_dsp56k.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] dsp56k: replace schedule_timeout() with 	msleep()

msleep-drivers_char_ec3104_keyb.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] ec3104: replace schedule_timeout() with 	msleep()

msleep-drivers_char_hvc_console.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] hvc_console: replace schedule_timeout() 	with msleep()

msleep-drivers_char_isicom.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] isicom: replace schedule_timeout() with 	msleep()

msleep-drivers_char_nwflash.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] nwflash: replace schedule_timeout() with 	msleep()

msleep-drivers_char_watchdog_pcwd.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] pcwd: replace schedule_timeout() with 	msleep()

msleep-drivers_ide_ide-cd.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] ide-cd: replace schedule_timeout() with 	msleep()

msleep-drivers_ide_ide-tape.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] ide-tape: replace schedule_timeout() with 	msleep()

msleep-drivers_ide_legacy_ide-cs.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] ide-cs: replace schedule_timeout() with 	msleep()

msleep-drivers_ieee1394_sbp2.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] ieee/sbp2: replace schedule_timeout() with 	msleep()

msleep-drivers_isdn_hisax_config.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] isdn/hisax: replace schedule_timeout() 	with msleep()

msleep-drivers_isdn_hisax_elsa.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] isdn/elsa: replace schedule_timeout() 	with msleep()

msleep-drivers_isdn_hisax_hfc_pci.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] isdn/hfc_pci: replace schedule_timeout() 	with msleep()

msleep-drivers_isdn_hisax_hfc_sx.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] isdn/hfc_sx: replace schedule_timeout() 	with msleep()

msleep-drivers_isdn_hisax_hfcscard.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] isdn/hfcscard: replace schedule_timeout() 	with msleep()

msleep-drivers_isdn_hysdn_boardergo.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] isdn/boardergo: replace 	schedule_timeout() with msleep()

msleep-drivers_isdn_hysdn_sched.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] isdn/hysdn_sched: replace 	schedule_timeout() with msleep()

msleep-drivers_isdn_i4l_isdn_tty.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] isdn/isdn_tty: replace schedule_timeout() 	with msleep()

msleep-drivers_isdn_icn.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] isdn/icn.c: replace schedule_timeout() 	with msleep()

msleep-drivers_isdn_sc_init.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] isdn/sc: replace schedule_timeout() with 	msleep()

msleep-drivers_media_common_saa7146_i2c.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] Re: [PATCH] saa7146_i2c: replace 	schedule_timeout() with msleep() [corrected again]

msleep-drivers_media_dvb_b2c2_skystar2.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] dvb/skystar2: replace schedule_timeout() 	with msleep()

msleep-drivers_media_dvb_dvb-core_dvb_ca_en50221.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] dvb/dvb_ca_en50221: replace 	schedule_timeout() with msleep()

msleep-drivers_media_dvb_dvb-core_dvb_frontend.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] dvb/dvb_frontend: replace 	schedule_timeout() with msleep()

msleep-drivers_media_dvb_dvb-core_dvb_functions.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] dvb/dvb_functions: replace 	schedule_timeout() with msleep()

msleep-drivers_media_dvb_frontends_alps_tdmb7.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] dvb/alps_tdmb7: replace 	schedule_timeout() with msleep()

msleep-drivers_media_dvb_frontends_at76c651.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] dvb/at76c651: replace schedule_timeout() 	with msleep()

msleep-drivers_media_dvb_frontends_cs24110.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] dvb/cx24110: replace schedule_timeout() 	with msleep()

msleep-drivers_media_dvb_frontends_dst.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] dvb/dst: replace schedule_timeout() with 	msleep()

msleep-drivers_media_dvb_frontends_grundig_29504-401.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] dvb/grundig_29504-401: replace 	schedule_timeout() with msleep()

msleep-drivers_media_dvb_frontends_grundig_29504-491.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] dvb/grundig_29504-491: replace 	schedule_timeout() with msleep()

msleep-drivers_media_dvb_frontends_stv0299.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] dvb/stv0299.c: replace schedule_timeout() 	with msleep()

msleep-drivers_media_dvb_frontends_tda1004x.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] dvb/tda1004x.c: replace 	schedule_timeout() with msleep()

msleep-drivers_media_dvb_frontends_ves1820.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] dvb/ves1820: replace schedule_timeout() 	with msleep()

msleep-drivers_media_dvb_frontends_ves1x93.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] dvb/ves1x93: replace schedule_timeout() 	with msleep()

msleep-drivers_media_dvb_ttpci_av7110.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] dvb/av7110: replace schedule_timeout() 	with msleep()

msleep-drivers_media_dvb_ttpci_av7110_hw.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] dvb/av7110_hw: replace schedule_timeout() 	with msleep()

msleep-drivers_media_dvb_ttpci_av7110_v4l.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] dvb/av7110_v4l: replace 	schedule_timeout() with msleep()

msleep-drivers_media_dvb_ttpci_budget.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] dvb/budget: replace schedule_timeout() 	with msleep()

msleep-drivers_media_dvb_ttpci_budget-av.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] dvb/budget-av: replace schedule_timeout() 	with msleep()

msleep-drivers_media_dvb_ttpci_budget-ci.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] dvb/ttpci/buget-ci.c: replace schedule_timeout() 	with msleep()

msleep-drivers_media_radio-aimslab.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] radio/radio-aimslab: replace 	while/schedule() with msleep()

msleep-drivers_media_radio-cadet.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] radio/radio-cadet: replace 	schedule_timeout() with msleep()

msleep-drivers_media_radio-maestro.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] radio/radio-maestro: replace 	schedule_timeout() with msleep()

msleep-drivers_media_radio-maxiradio.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] radio/radio-maxiradio: replace 	schedule_timeout() with msleep()

msleep-drivers_media_radio-miropcm20-rds.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] radio/miropcm20-rds: replace 	schedule_timeout() with msleep()

msleep-drivers_media_radio-sf16fmi.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] radio/radio-sf16fmi: replace 	schedule_timeout() with msleep()

msleep-drivers_media_radio-sf16fmr2.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: Re: [Kernel-janitor@sternweltens] [PATCH] radio/radio-sf16fmr2: 	replace	schedule_timeout() with msleep()

msleep-drivers_media_radio-zoltrix.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] radio/radio-zoltrix: replace 	sleep_delay() with schedule()

msleep-drivers_media_video_bttv-driver.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] video/bttv-driver: replace 	schedule_timeout() with msleep()

msleep-drivers_media_video_bw-qcam.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] video/bw-qcam: replace schedule_timeout() 	with msleep()

msleep-drivers_media_video_c-qcam.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] video/c-qcam: replace schedule_timeout() 	with msleep()

msleep-drivers_media_video_cx88-video.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] video/cx88: replace schedule_timeout() 	with msleep()

msleep-drivers_media_video_msp3400.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] video/msp3400: replace schedule_timeout() 	with msleep()

msleep-drivers_media_video_planb.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] video/planb: replace schedule_timeout() 	with msleep()

msleep-drivers_media_video_sa7134-core.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] video/saa7134-core: replace 	schedule_timeout() with msleep()

msleep-drivers_media_video_sa7134-ts.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] video/saa7134-ts: replace 	schedule_timeout() with msleep()

msleep-drivers_media_video_sa7134_saa6752hs.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] video/saa6752hs: replace 	schedule_timeout() with msleep()

msleep-drivers_media_video_zoran_device.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] video/zoran_device: replace 	schedule_timeout() with msleep()

msleep-drivers_media_video_zoran_driver.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] video/zoran_driver: replace 	schedule_timeout() with msleep()

msleep-drivers_media_video_zr26120.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] video/zr36120: replace schedule_timeout() 	with msleep()

msleep-drivers_message_fusion_mptscsih.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] message/mptscsih: replace 	schedule_timeout() with msleep()

msleep-drivers_message_i2o_i2o_block.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] message/i2o_block: replace 	schedule_timeout() with msleep()

msleep-drivers_message_i2o_i2o_core.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] message/i2o_core: replace 	schedule_timeout() with msleep()

msleep-drivers_mtd_chips_cfi_cmdset_0001.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] mtd/cfi_cmdset_0001: replace 	schedule_timeout() with msleep()

msleep-drivers_net_3c505.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] net/3c505: replace schedule_timeout() 	with msleep()

msleep-drivers_net_appletalk_ltpc.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] net/appletalk: replace schedule_timeout() 	with msleep()

msleep-drivers_net_cs89x0.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] net/cs89x0: replace schedule_timeout() 	with msleep()

msleep-drivers_net_e100.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] net/e100: replace schedule_timeout() with 	msleep()

msleep-drivers_net_e1000_osdep.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: Re: [Kernel-janitor@sternweltens] [PATCH] net/e1000_osdep: replace 	schedule_timeout() with msleep()

msleep-drivers_net_ewrk3.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] net/ewrk3: replace schedule_timeout() 	with msleep()

msleep-drivers_net_gt96100eth.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] net/gt96100eth: replace 	schedule_timeout() with msleep()

msleep-drivers_net_irda_act200l-sir.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] irda/act200l-sir: replace 	schedule_timeout() with msleep()

msleep-drivers_net_irda_irtty-sir.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] irda/irtty-sir: replace 	schedule_timeout() with msleep()

msleep-drivers_net_irda_ma600-sir.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] irda/ma600-sir: replace 	schedule_timeout() with msleep()

msleep-drivers_net_irda_sir_dev.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] irda/sir_dev: replace schedule_timeout() 	with msleep()

msleep-drivers_net_irda_tekram-sir.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] irda/tekram-sir: replace 	schedule_timeout() with msleep()

msleep-drivers_net_ixgb_osdep.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] ixgb/ixgb_osdep: replace 	schedule_timeout() with msleep()

msleep-drivers_net_max89x0.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] net/mac89x0: replace schedule_timeout() 	with msleep()

msleep-drivers_net_ni65.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] net/ni65: replace schedule_timeout() with 	msleep()

msleep-drivers_net_ns83820.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] Re: [PATCH] net/ns83820: replace 	schedule_timeout() with msleep()

msleep-drivers_net_s2io.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] net/s2io.c: replace schedule_timeout() 	with msleep()

msleep-drivers_net_slip.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] net/slip: replace schedule_timeout() with 	msleep()

msleep-drivers_net_tokenring_ibmtr.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: Re: [Kernel-janitor@sternweltens] [PATCH] net/ibmtr: replace schedule_timeout() 	with msleep()

msleep-drivers_net_tulip_de2104x.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] tulip/de2104x: replace schedule_timeout() 	with msleep()

msleep-drivers_net_wan_cosa.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] wan/cosa: replace schedule_timeout() with 	msleep()

msleep-drivers_net_wan_cycx_drv.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] wan/cycx_drv: replace schedule_timeout() 	with msleep()

msleep-drivers_net_wireless_airo.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] wireless/airo: replace schedule_timeout() 	with msleep()

msleep-drivers_net_wireless_airport.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] wireless/airport: replace 	schedule_timeout() with msleep()

msleep-drivers_net_wireless_prism54_islpci_dev.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] prism54/islpci_dev: replace 	schedule_timeout() with msleep()

msleep-drivers_parport_ieee1284_ops.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] parport/ieee1284_ops: replace 	schedule_timeout() with msleep()

msleep-drivers_pcmcia_cs.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] pcmcia/cs: replace schedule_timeout() 	with msleep()

msleep-drivers_pcmcia_ds.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] pcmcia/ds: replace schedule_timeout() 	with msleep()

msleep-drivers_pcmcia_i82365.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] pcmcia/i82365: replace schedule_timeout() 	with msleep()

msleep-drivers_pcmcia_sa1100_h3600.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] pcmcia/sa1100_h3600: replace 	schedule_timeout() with msleep()

msleep-drivers_scsi_eta_pio.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] scsi/eata_pio: replace schedule_timeout() 	with msleep()

msleep-drivers_scsi_ipr.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] scsi/ipr: replace schedule_timeout() with 	msleep()

msleep-drivers_scsi_mesh.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] scsi/mesh: replace schedule_timeout() 	with msleep()

msleep-drivers_scsi_osst.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] scsi/osst: replace schedule_timeout() 	with msleep()

msleep-drivers_scsi_qla2xxx_qla_init.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: Re: [Kernel-janitor@sternweltens] [PATCH] scsi/qla_init: replace 	schedule_timeout() with msleep()

msleep-drivers_scsi_qla2xxx_qla_os.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] scsi/qla_os: replace schedule_timeout() 	with msleep()

msleep-drivers_scsi_sata_promise.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] scsi/sata_promise: replace 	schedule_timeout() with msleep()

msleep-drivers_scsi_sata_sx4.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] scsi/sata_sx4: replace schedule_timeout() 	with msleep()

msleep-drivers_scsi_sd.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] scsi/sd: replace schedule_timeout() with 	msleep()

msleep-drivers_scsi_wd7000.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] scsi/wd7000: replace schedule_timeout() 	with msleep()

msleep-drivers_serial_pmac_zilog.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] serial/pmac_zilog: replace 	schedule_timeout() with msleep()

msleep-drivers_serial_serial_core.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitor@sternweltens] [PATCH] serial/serial_core: replace 	schedule_timeout() with msleep()

pr_debug-drivers_block_umem.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [Kernel-janitors] [patch 2.6.8-rc2] replace PRINTK with pr_debug in 	block/umem.c

pr_debug-drivers_isdn_tpam.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [Kernel-janitors] [patch 2.6.8-rc2] replace dprintk with pr_debug 	in drivers/scsi/tpam/

pr_debug-i386_kernel_microcode.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [Kernel-janitors] [patch 2.6.8-rc2] replace dprintk with pr_debug 	in microcode.c

remove-unused-include-drivers_media_videocodec.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [Kernel-janitors] [patch 2.6.8-rc2] kill KERNEL_VERSION duplicate 	in videocodec.c

set-current-state-drivers_usb_media_dabusb.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: Re: [Kernel-janitors] [PATCH] usb/dabusb: insert set_current_state() 	before schedule_timeout()

set-current-state-drivers_usb_misc_tiglusb.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH] usb/tiglusb: insert set_current_state() 	before schedule_timeout()

set-current-state-net_wan_farsync.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH] wan/farsync: insert set_current_state() 	before schedule_timeout()

use-msecs-to-jiffies-drivers_char_synclink.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH] synclink: replace jiffies_from_ms() with 	msecs_to_jiffies()

use-msecs-to-jiffies-drivers_macintosh_mediabay.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH] macintosh/mediabay: replace MS_TO_HZ() 	with msecs_to_jiffies()

use-msecs-to-jiffies-drivers_video_aty_radeon_base.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH] video/radeon_base: replace MS_TO_HZ() 	with msecs_to_jiffies()

use-msecs-to-jiffies-drivers_video_aty_radeonfb.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH] video/radeonfb: remove MS_TO_HZ()

use-msecs-to-jiffies-isdn_sc_card.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH] isdn/card: replace milliseconds() with 	msecs_to_jiffies()

use-msecs-to-jiffies-pcmcia_synclink_cs.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH] pcmcia/synclink_cs: replace 	jiffies_from_ms() with msecs_to_jiffies()

use-msecs-to-jiffies-pcmcia_synclinkmp.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [Kernel-janitors] [PATCH] pcmcia/synclinkmp: replace 	jiffies_from_ms() with msecs_to_jiffies()

add-msleep_interruptible.patch
  From:  Maximilian Attems <janitor@sternwelten.at>
  Subject: Add msleep_interruptible() function to kernel/timer.c


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
changed since 2.6.7-kjt2

merged in linus tree (2.6.8):

faulty-inits-fbmem.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [Kernel-janitors] [patch 2.6.6] remove faulty __init's from drivers/video/fbmem.c

remove-old-ifdefs-mtd-cfi.patch
  From: Domen Puncer <domen@coderock.org>

remove-old-ifdefs-mtdcore.patch
  From: Domen Puncer <domen@coderock.org>

min-max-macintosh_macserial.patch
  From: michael.veeck at gmx.net (Michael Veeck)
  Subject: [Kernel-janitors] [PATCH] drivers/macintosh/macserial.c
   MIN/MAX     

dropped some reworked list_for_each() patches from Domen Puncer.
others are incremental.

dropped, needs rework:
remove-check_region-char_specialix.patch
  From: Kristen Carlson <kristenc@cs.pdx.edu>
  Subject: Re: [Kernel-janitors] [PATCH] remove check_region specialix

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
todo:
- split kernel_thread() patches from Walter Harms
- finish list_for_each() usage (Domen Puncer)
- check the last_rx patches from Jay Bourque

