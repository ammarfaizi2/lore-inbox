Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262249AbVCBKAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262249AbVCBKAi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 05:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbVCBKAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 05:00:38 -0500
Received: from coderock.org ([193.77.147.115]:49045 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262249AbVCBJ6Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 04:58:24 -0500
Date: Wed, 2 Mar 2005 10:57:10 +0100
From: Domen Puncer <domen@coderock.org>
To: kj <kernel-janitors@lists.osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: 2.6.11-kj
Message-ID: <20050302095710.GA3745@nd47.coderock.org>
Mail-Followup-To: kj <kernel-janitors@lists.osdl.org>,
	lkml <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A new release from kernel janitors (http://janitor.kernelnewbies.org/).

Apologies to janitors that this took so long.
This time we have a new record: 354 patches!
I'll start sending/resending what's not already in -mm soon.

Patchset is at http://coderock.org/kj/2.6.11-kj/


new in this release:
--------------------
msleep-drivers_ieee1394_sbp2.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [UPDATE PATCH] ieee1394/sbp2: use ssleep() instead of 	schedule_timeout()

msleep-drivers_net_cs89x0.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 5/28] net/cs89x0: replace schedule_timeout() with 	msleep()

msleep-drivers_net_wan_cosa.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 4/28] net/cosa: replace schedule_timeout() with msleep()

msleep_ssleep-drivers_net_wireless_airo.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 3/28] net/airo: replace schedule_timeout() with 	msleep()/ssleep()

typo_suppport-bttv_dvb.patch
  From: Carlo Perassi <carlo@linux.it>
  Subject: [KJ] [patch] trivial typos

vfree-drivers_char_agp_backend.patch
  From: jlamanna@gmail.com
  Subject: [KJ] [PATCH] [RESEND] [23/29] backend.c - vfree() checking cleanups

vfree-drivers_char_agp_generic.patch
  From: jlamanna@gmail.com
  Subject: [KJ] [PATCH] [RESEND] [28/29] generic.c - vfree() checking cleanups

vfree-drivers_ieee1394_dma.patch
  From: jlamanna@gmail.com
  Subject: [KJ] [PATCH] [RESEND] [9/29] dma.c - vfree() checking cleanups

vfree-drivers_isdn_i4l_isdn_bsdcomp.patch
  From: jlamanna@gmail.com
  Subject: [KJ] [PATCH] [RESEND] [1/29] isdn_bsdcomp.c - vfree() checking 	cleanups

vfree-drivers_media_dvb_dvb-core_dmxdev.patch
  From: jlamanna@gmail.com
  Subject: [KJ] [PATCH] [RESEND] [12/29] dmxdev.c - vfree() checking cleanups

vfree-drivers_media_dvb_dvb-core_dvb_ca_en50221.patch
  From: jlamanna@gmail.com
  Subject: [KJ] [PATCH] [RESEND] [4/29] dvb_ca_en50221.c - vfree() checking 	cleanups

vfree-drivers_media_dvb_ttpci_av7110.patch
  From: jlamanna@gmail.com
  Subject: [KJ] [PATCH] [RESEND] [5/29] av7110.c - vfree() checking cleanups

vfree-drivers_media_dvb_ttpci_av7110_ipack.patch
  From: jlamanna@gmail.com
  Subject: [KJ] [PATCH] [RESEND] [8/29] av7110_ipack.c - vfree() checking 	cleanups

vfree-drivers_media_dvb_ttpci_budget-core.patch
  From: jlamanna@gmail.com
  Subject: [KJ] [PATCH] [RESEND] [27/29] budget-core.c - vfree() checking 	cleanups

vfree-drivers_media_video_stradis.patch
  From: jlamanna@gmail.com
  Subject: [KJ] [PATCH] [RESEND] [24/29] stradis.c - vfree() checking cleanups

vfree-drivers_scsi_qla2xxx_qla_os.patch
  From: jlamanna@gmail.com
  Subject: [KJ] [PATCH] [RESEND] [15/29] qla_os.c - vfree() checking cleanups

vfree-drivers_video_sis_sis_main.patch
  From: jlamanna@gmail.com
  Subject: [KJ] [PATCH] [RESEND] [22/29] sis_main.c - vfree() checking cleanups

vfree-fs_reiserfs_super.patch
  From: jlamanna@gmail.com
  Subject: [KJ] [PATCH] [RESEND] [19/29] super.c - vfree() checking cleanups

vfree-net_bridge_netfilter_ebtables.patch
  From: jlamanna@gmail.com
  Subject: [KJ] [PATCH] [RESEND] [14/29] ebtables.c - vfree() checking cleanups

vfree-sound_oss_gus_wave.patch
  From: jlamanna@gmail.com
  Subject: [KJ] [PATCH] [RESEND] [21/29] gus_wave.c - vfree() checking cleanups

extern-include_linux_generic_serial.h.old.patch
  From: Adrian Bunk <bunk@stusta.de>
  Subject: [KJ] [2.6 patch] generic_serial.h: kill incorrect gs_debug reference

msleep-arch_arm_mach-sa1100_cpu-sa1110.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 1/22] arm/cpu-sa1110: replace schedule_timeout() with 	msleep()

msleep-drivers_block_cciss.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 3/22] block/cciss: replace schedule_timeout() with 	msleep()

msleep-drivers_block_paride_pf.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [UPDATE PATCH] block/pf: replace pf_sleep() with msleep()

msleep-drivers_block_paride_pg.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [UPDATE PATCH] block/pg: replace pg_sleep() with msleep()

msleep-drivers_block_xd2.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 6/22] block/xd: replace schedule_timeout() with msleep()

msleep-drivers_cdrom_sonycd535.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [UPDATE PATCH] cdrom/sonycd535: replace schedule_timeout() 	with msleep()

msleep-drivers_net_s2io.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [UPDATE PATCH 14/21] net/s2io: replace schedule_timeout() with 	msleep()

msleep-drivers_net_slip.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [UPDATE PATCH] net/slip: replace schedule_timeout() with 	msleep()

msleep-drivers_scsi_ide-scsi.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: Re: [KJ] [announce] [patch] scsi/ide-scsi: use msleep()

msleep-drivers_scsi_osst.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [UPDATE PATCH] scsi/osst: replace schedule_timeout() with 	msleep()

msleep-drivers_serial_crisv10.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 25/39] serial/crisv10: replace schedule_timeout() with 	msleep()

msleep-drivers_usb_serial_cypress_m8.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 21/21] usb/cypress_m8: replace schedule_timeout() with 	msleep()

msleep-fs_cifs_transport.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 9/40] fs/transport: replace schedule_timeout() with 	msleep()

msleep-fs_jfs_jfs_logmgr.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 6/40] fs/jfs_logmgr: replace schedule_timeout() with 	msleep()

msleep-fs_nfsd_vfs.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 10/40] fs/vfs: replace schedule_timeout() with msleep()

msleep-fs_smbfs_proc.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 8/40] fs/proc: replace schedule_timeout() with msleep()

msleep-fs_xfs_linux-2.6_xfs_buf.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 11/40] fs/xfs_buf: replace schedule_timeout() with 	msleep()

msleep-net_appletalk_aarp.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 16/39] net/aarp: replace schedule_timeout() with 	msleep()

msleep-net_sunrpc_svcsock.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 23/39] net/svcsock: replace schedule_timeout() with 	msleep()

msleep_interruptible-drivers_block_swim3.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 5/22] block/swim3: replace schedule_timeout() with 	msleep_interruptible()

msleep_interruptible-drivers_char_sx.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 11/21] char/sx: replace schedule_timeout() with 	msleep_interruptible()

msleep_interruptible-drivers_sbus_char_envctrl.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [UPDATE PATCH] sbus/envctrl: replace schedule_timeout() with 	msleep_interruptible()

msleep_interruptible-drivers_scsi_st.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [UPDATE PATCH] scsi/st: replace schedule_timeout() with 	msleep_interruptible()

msleep_interruptible-drivers_w1_w1_therm.patch
  From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
  Subject: [KJ] Re: [PATCH 39/39] w1/w1_therm: replace schedule_timeout() with  msleep_interruptible()

msleep_interruptible-fs_lockd_clntproc.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 5/40] fs/clntproc: replace schedule_timeout() with 	msleep_interruptible()

msleep_interruptible-fs_xfs_linux-2.6_xfs_super.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 12/40] fs/xfs_super: replace schedule_timeout() with 	msleep_interruptible()

msleep_interruptible-sound_isa_gus_gus_reset.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 28/39] sound/gus_reset: replace schedule_timeout() with 	msleep_interruptible()

msleep_ssleep-drivers_block_paride_pcd.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [UPDATE PATCH] block/pcd: replace pcd_sleep() with 	msleep()/ssleep()

msleep_ssleep-drivers_block_paride_pt.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [UPDATE PATCH] block/pt: replace pt_sleep() with 	msleep()/ssleep()

remove_duplicate_delay-drivers_net_sk98lin_skethtool.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 15/21] net/skethtool: remove duplicate delay

return_code-drivers_ide_pci_cs5520.patch
  From: Amit Gud <amitg@calsoftinc.com>
  Subject: [KJ] [PATCH] Resend: drivers/ide/pci/cs5520.c fix return code value

set_current_state-drivers_char_ftape_lowlevel_fdc-io.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 7/22] ftape/fdc-io: insert set_current_state() before 	schedule_timeout()

set_current_state-sound_isa_gus_gus_pcm.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 27/39] sound/gus_pcm: insert set_current_state() before 	schedule_timeout()

set_current_state-sound_isa_wavefront_wavefront_synth.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 31/39] sound/wavefront_synth: insert 	set_current_state() before schedule_timeout()

spin_lock_init-arch_um_drivers_port_kern.patch
  From: Amit Gud <amitg@calsoftinc.com>
  Subject: [KJ] [PATCH] unified spinlock initialization 	arch/um/drivers/port_kern.c

ssleep-arch_i386_kernel_traps.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 12/21] i386/traps: replace schedule_timeout() with 	ssleep()

ssleep-drivers_message_fusion_mptbase.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [UPDATE PATCH] message/mptbase: replace schedule_timeout() 	with ssleep()

ssleep-drivers_net_sb1000.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [UPDATE PATCH] net/sb1000: replace nicedelay() with ssleep()

ssleep-drivers_scsi_qla1280.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [UPDATE PATCH] scsi/qla1280: replace schedule_timeout() with 	ssleep()

ssleep-fs_nfsd_nfs4callback.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 7/40] fs/nfs4callback: replace schedule_timeout() with 	ssleep()

ssleep-kernel_power_smp.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 14/39] kernel/smp: replace schedule_timeout() with 	ssleep()

ssleep-sound_isa_sb_emu8000.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 26/39] sound/emu8000: replace schedule_timeout() with 	msleep()

task_unint-drivers_base_dmapool.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [UPDATE PATCH] drivers/dmapool: use TASK_UNINTERRUPTIBLE 	instead of TASK_INTERRUPTIBLE

unused_pointer-sound_usb_usx2y_usbusx2yaudio.patch
  From: Carlo Perassi <carlo@linux.it>
  Subject: [KJ] [trivial patch] unused pointer

wait_event-arch_m68k_atari_stdma.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 15/39] m68k/stdma: replace sleep_on() with wait_event()

wait_event-drivers_acorn_block_fd1772.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 1/40] acorn/fd1772: replace sleep_on() with wait_event()

wait_event-drivers_block_ps2esdi.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 4/40] block/ps2esdi: replace sleep_on() with 	wait_event()

wait_event-drivers_scsi_atari_scsi.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 24/39] scsi/atari_scsi: use wait_event()

wait_event_int_t-drivers_usb_class_usblp.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 38/39] usb/usblp: use wait_event_interruptible_timeout()

wait_event_timeout-drivers_char_hvsi.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 8/22] char/hvsi: use wait_event_timeout()

wait_event_timeout-drivers_usb_image_mdc800.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 37/39] usb/mdc800: use wait_event_timeout()

wait_event_timeout-drivers_usb_input_ati_remote.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 33/39] usb/ati_remote: use wait_event_timeout()

wait_event_timeout-drivers_usb_misc_auerswald.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 34/39] usb/auerswald: use wait_event_timeout()

wait_event_timeout-drivers_usb_net_kaweth.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 36/39] usb/kaweth: use wait_event_timeout()

kill_kernel_parameter-sf16fm.patch
  From: sebek64@post.cz (Marcel Sebek)
  Subject: Re: [KJ] [PATCH] radio-sf16fmi cleanup

int_sleep_on-arch_cris_arch-v10_drivers_eeprom.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] 17/34: cris/eeprom: replace interruptible_sleep_on() 	with wait_event_interruptible()

int_sleep_on-drivers_cdrom_cdu31a.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] 12/34: cdrom/cdu31a: replace interruptible_sleep_on() 	with wait_event_interruptible()

int_sleep_on-drivers_char_istallion.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] 16/34: char/istallion: replace 	interruptible_sleep_on() with wait_event_interruptible()

int_sleep_on-drivers_ieee1394_video1394.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] 18/34: ieee1394/video1394: replace 	interruptible_sleep_on() with wait_event_interruptible()

int_sleep_on-drivers_isdn_capi_capi.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 20/34] isdn/capi: replace interruptible_sleep_on() with 	wait_event_interruptible()

int_sleep_on-drivers_isdn_i4l_isdn_common.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 21/34] isdn/isdn_common: replace 	interruptible_sleep_on() with wait_event()

int_sleep_on-drivers_media_video_planb.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 22/34] media/planb: replace interruptible_sleep_on() 	with wait_event()

int_sleep_on-drivers_media_video_zoran_device.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 23/34] media/zoran_device: replace 	interruptible_sleep_on() with wait_event_interruptible()

int_sleep_on-drivers_media_video_zoran_driver.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 24/34] media/zoran_driver: replace 	interruptible_sleep_on_timeout() with 	wait_event_interruptible_timeout()

int_sleep_on-drivers_media_video_zr36120.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 25/34] media/zr36120: replace interruptible_sleep_on() 	with wait_event_interruptible()

int_sleep_on-drivers_net_tokenring_lanstreamer.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 27/34] net/lanstreamer: replace 	interruptible_sleep_on_timeout() with 	wait_event_interruptible_timeout()

lindent-arch_ppc_4xx_io_serial_sicc.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH] ppc: Lindent cleanup to arch/ppc/4xx_io/serial_sicc.c

printk-drivers_acorn_block_fd1772.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 1/2][RESEND] acorn: clean up printk()'s in 	drivers/acorn/block/fd1772.c

printk-drivers_acorn_block_mfmhd.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 2/2][RESEND] acorn: clean up printk()'s in 	drivers/acorn/block/mfmhd.c

printk-drivers_video_atafb.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 3/53] atafb: Clean up printk()'s in 	drivers/video/atafb.c

printk-drivers_video_aty_mach64_ct.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 5/53] atyfb: Clean up printk()'s in 	drivers/video/aty/mach64_ct.c

printk-drivers_video_aty_radeon_monitor.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 7/53] radeonfb: Clean up printk()'s in 	drivers/video/aty/radeon_monitor.c

printk-drivers_video_aty_radeon_pm.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 8/53] radeonfb: Clean up printk()'s in 	drivers/video/aty/radeon_pm.c

printk-drivers_video_bw2.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 42/53] bw2: Clean up printk()'s in drivers/video/bw2.c

printk-drivers_video_cg3.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 11/53] cg3: Clean up printk()'s in drivers/video/cg3.c

printk-drivers_video_cg6.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 12/53] cg6: Clean up printk()'s in drivers/video/cg6.c

printk-drivers_video_cirrusfb.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 13/53] cirrusfb: Clean up printk()'s in 	drivers/video/cirrusfb.c

printk-drivers_video_clps711xfb.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 14/53] clps711xfb: Clean up printk()'s in 	drivers/video/clps711xfb.c

printk-drivers_video_console_fbcon.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 15/53] fbcon: Clean up printk()'s in 	drivers/video/console/fbcon.c

printk-drivers_video_console_mdacon.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 16/53] mdacon: Clean up printk()'s in 	drivers/video/console/mdacon.c

printk-drivers_video_console_newport_con.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 17/53] ng1: Clean up printk()'s in 	drivers/video/console/newport_con.c

printk-drivers_video_cyber2000fb.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 18/53] cyber2000fb: Clean up printk()'s in 	drivers/video/cyber2000fb.c

printk-drivers_video_dnfb.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 20/53] dnfb: Clean up printk()'s in drivers/video/dnfb.c

printk-drivers_video_fbmem.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 21/53] fb: Clean up printk()'s in drivers/video/fbmem.c

printk-drivers_video_fbmon.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 22/53] fb: Clean up printk()'s in drivers/video/fbmon.c

printk-drivers_video_ffb.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 23/53] ffb: Clean up printk()'s in drivers/video/ffb.c

printk-drivers_video_fm2fb.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 24/53] fm2fb: Clean up printk()'s in 	drivers/video/fm2fb.c

printk-drivers_video_igafb.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 27/53] igafb: Clean up printk()'s in 	drivers/video/igafb.c

printk-drivers_video_imsttfb.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 28/53] imsttfb: Clean up printk()'s in 	drivers/video/imsttfb.c

printk-drivers_video_intelfb_intelfbhw.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 29/53] intelfb: Clean up printk()'s in 	drivers/video/intelfb/intelfbhw.c

printk-drivers_video_kyro_fbdev.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 30/53] kyrofb: Clean up printk()'s in 	drivers/video/kyro/fbdev.c

printk-drivers_video_leo.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 31/53] leo: Clean up printk()'s in drivers/video/leo.c

printk-drivers_video_macfb.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 32/53] macfb: Clean up printk()'s in 	drivers/video/macfb.c

printk-drivers_video_matrox_matroxfb_base.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 33/53] matroxfb: Clean up printk()'s in 	drivers/video/matrox/matroxfb_base.c

printk-drivers_video_modedb.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 34/53] fb: Clean up printk()'s in drivers/video/modedb.c

printk-drivers_video_neofb.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 35/53] neofb: Clean up printk()'s in 	drivers/video/neofb.c

printk-drivers_video_p9100.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 36/53] p9100: Clean up printk()'s in 	drivers/video/p9100.c

printk-drivers_video_platinumfb.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 37/53] platinumfb: Clean up printk()'s in 	drivers/video/platinumfb.c

printk-drivers_video_pm3fb.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 38/53] pm3fb: Clean up printk()'s in 	drivers/video/pm3fb.c

printk-drivers_video_pmag-ba-fb.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 39/53] pmag-ba: Clean up printk()'s in 	drivers/video/pmag-ba-fb.c

printk-drivers_video_pmagb-b-fb.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 40/53] pmagb-ba: Clean up printk()'s in 	drivers/video/pmagb-b-fb.c

printk-drivers_video_pvr2fb.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 41/53] pvr2fb: Clean up printk()'s in 	drivers/video/pvr2fb.c

printk-drivers_video_radeonfb.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 9/53] radeonfb: Clean up printk()'s in 	drivers/video/radeonfb.c

printk-drivers_video_retz3fb.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 43/53] retz3fb: Clean up printk()'s in 	drivers/video/retz3fb.c

printk-drivers_video_riva_fbdev.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 44/53] rivafb: Clean up printk()'s in 	drivers/video/riva/fbdev.c

printk-drivers_video_savage_savagefb.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 46/53] savagefb: Clean up printk()'s in 	drivers/video/savage/savagefb.c

printk-drivers_video_sstfb.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 47/53] sstfb: Clean up printk()'s in 	drivers/video/sstfb.c

printk-drivers_video_sun3fb.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 48/53] sun3fb: Clean up printk()'s in 	drivers/video/sun3fb.c

printk-drivers_video_tcx.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 49/53] tcx: Clean up printk()'s in drivers/video/tcx.c

printk-drivers_video_tdfxfb.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 50/53] tdfxfb: Clean up printk()'s in 	drivers/video/tdfxfb.c

printk-drivers_video_virgefb.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 51/53] virgefb: Clean up printk()'s in 	drivers/video/virgefb.c

printk-drivers_video_w100fb.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 52/53] w100fb: Clean up printk()'s in 	drivers/video/w100fb.c

sleep_on-drivers_block_xd.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] 10/34: block/xd: remove sleep_on() usage

sleep_on-drivers_cdrom_aztcd.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] 11/34: cdrom/aztcd: remove sleep_on() usage

sleep_on-drivers_cdrom_mcd.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] 13/34: cdrom/mcd: remove sleep_on() usage

sleep_on-drivers_cdrom_sjcd.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] 15/34: cdrom/sjcd: remove sleep_on() usage

sleep_on-drivers_net_shaper.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 29/34] net/shaper: replace sleep_on() with wait_event()

sleep_on-drivers_sbus_char_bpp.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 30/34] sbus/bpp: remove sleep_on() usage

sleep_on-drivers_sbus_char_vfc_i2c.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 31/33] sbus/vfc_i2c: remove sleep_on() usage

spin_lock_init-include_linux_wait.h.patch
  From: Amit Gud <amitg@calsoftinc.com>
  Subject: [KJ] [PATCH] Unified spinlock initialization include/linux/wait.h

wait_event-drivers_block_amiflop.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] 5/34: block/amiflop: replace sleep_on() with 	wait_event()

wait_event-drivers_block_ataflop.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] 6/34: block/ataflop: replace sleep_on() with 	wait_event()

wait_event_int-drivers_block_acsi_slm.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] 4/34: block/acsi_slm: replace interruptible_sleep_on() 	with wait_event_interruptible()

wait_event_int-drivers_block_swim3.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] 8/34: block/swim3: replace interruptible_sleep_on() 	with wait_event_interruptible()

wait_event_int-drivers_block_swim_iop.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] 9/34: block/swim_iop: replace interruptible_sleep_on() 	with wait_event_interruptible()

wait_event_int_timeout-drivers_block_DAC960.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [UPDATE PATCH 3/34]: block/DAC960: remove sleep_on*() usage

wait_event_int_timeout-drivers_input_joystick_iforce_iforce-packets.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [UPDATE PATCH] input/iforce-packets: use 	wait_event_interruptible_timeout()

wait_event_int_timeout-sound_core_rawmidi.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 32/33] sound/rawmidi: replace 	interruptible_sleep_on_timeout() with 	wait_event_interruptible_timeout()

defines-drivers_scsi_FlashPoint.patch
  From: Alexey Dobriyan <adobriyan@mail.ru>
  Subject: [KJ] [PATCH] FlashPoint.c: remove _useless_ #define's.

dma_mask-drivers_atm_lanai.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [PATCH] drivers/atm/lanai.c: Use the DMA_{64, 	32}BIT_MASK constants

dma_mask-drivers_net_8139cp.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [PATCH 1/16] drivers/net/8139cp: Use the DMA_{64, 	32}BIT_MASK constants

dma_mask-drivers_net_acenic.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [PATCH 2/16] drivers/net/acenic: Use the DMA_{64, 	32}BIT_MASK constants

dma_mask-drivers_net_e100.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [PATCH 3/16] drivers/net/e100: Use the DMA_{64, 	32}BIT_MASK constants

dma_mask-drivers_net_hp100.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [PATCH 4/16] drivers/net/hp100: Use the DMA_{64, 	32}BIT_MASK constants

dma_mask-drivers_net_ns83820.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [PATCH 5/16] drivers/net/ns83820: Use the DMA_{64, 	32}BIT_MASK constants

dma_mask-drivers_net_s2io.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [PATCH 6/16] drivers/net/s2io: Use the DMA_{64, 	32}BIT_MASK constants

dma_mask-drivers_net_sk98lin_skge.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [PATCH 7/16] drivers/net/sk98lin/skge: Use the DMA_{64, 	32}BIT_MASK constants

dma_mask-drivers_net_sungem.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [PATCH 8/16] drivers/net/sungem: Use the DMA_{64, 	32}BIT_MASK constants

dma_mask-drivers_net_tg3.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [PATCH 9/16] drivers/net/tg3: Use the DMA_{64, 	32}BIT_MASK constants

dma_mask-drivers_net_tlan.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [PATCH 10/16] drivers/net/tlan: Use the DMA_{64, 	32}BIT_MASK constants

dma_mask-drivers_net_tokenring_lanstreamer.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [PATCH 11/16] drivers/net/tokenring/lanstreamer: Use the 	DMA_{64, 32}BIT_MASK constants

dma_mask-drivers_net_tulip_dmfe.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [PATCH 12/16] drivers/net/tulip/dmfe: Use the DMA_{64, 	32}BIT_MASK constants

dma_mask-drivers_net_tulip_winbond-840.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [PATCH 13/16] drivers/net/tulip/winbond-840: Use the DMA_{64, 	32}BIT_MASK constants

dma_mask-drivers_net_via-rhine.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [PATCH 14/16] drivers/net/via-rhine: Use the DMA_{64, 	32}BIT_MASK constants

dma_mask-drivers_net_wan_wanxl.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [PATCH 15/16] drivers/net/wan/wanxl: Use the DMA_{64, 	32}BIT_MASK constants

dma_mask-drivers_net_wireless_prism54_islpci_hotplug.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [PATCH 16/16] drivers/net/wireless/prism54/islpci_hotplug: Use 	the DMA_{64, 32}BIT_MASK constants

extinguish_warnings-include_linux_module.h.patch
  From: "Stephen Biggs" <yrgrknmxpzlk@gawab.com>
  Subject: [KJ] [PATCH] include/linux/module.h - compile warning cleanup

int_sleep_on-arch_mips_sibyte_sb1250_bcm1250_tbprof.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 20/20] mips/bcm1250_tbprof: remove 	interruptible_sleep_on() usage

int_sleep_on-drivers_char_lp.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 1/20] char/lp: remove interruptible_sleep_on_timeout() 	usage

int_sleep_on-drivers_i2c_busses_i2c-elektor.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 11/20] i2c/i2c-elektor: remove 	interruptible_sleep_on_timeout() usage

int_sleep_on-drivers_i2c_busses_i2c-ite.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 12/20] i2c/i2c-ite: remove 	interruptible_sleep_on_timeout() usage

int_sleep_on-drivers_media_video_zoran_card.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 17/20] media/zoran_card: remove 	interruptible_sleep_on_timeout() usage

int_sleep_on-drivers_net_8139too.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 3/20] net/8139too: remove 	interruptible_sleep_on_timeout() usage

int_sleep_on-drivers_net_tokenring_ibmtr.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 4/20] net/ibmtr: remove 	interruptible_sleep_on_timeout() usage

int_sleep_on-drivers_usb_class_usb-midi.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 8/20] usb/usb-midi: remove 	interruptible_sleep_on_timeout() usage

int_sleep_on-drivers_usb_misc_rio500.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 7/20] usb/rio500: remove 	interruptible_sleep_on_timeout() usage

int_sleep_on-drivers_usb_serial_digi_acceleport.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 6/20] usb/digi_acceleport: remove 	interruptible_sleep_on_timeout() usage

int_sleep_on-fs_lockd_svc.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 10/20] lockd/svc: remove 	interruptible_sleep_on_timeout() usage

pci_register_driver-drivers_atm.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] drivers/atm/*: convert to pci_register_driver

pci_register_driver-drivers_block.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] drivers/block/*: convert to pci_register_driver

pci_register_driver-drivers_char_agp.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] drivers/char/agp/*: convert to pci_register_driver

pci_register_driver-drivers_char_watchdog.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] drivers/char/watchdog/*: convert to pci_register_driver

pci_register_driver-drivers_eisa.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] drivers/eisa/*: convert to pci_register_driver

pci_register_driver-drivers_ide.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] drivers/ide/*: convert to pci_register_driver

pci_register_driver-drivers_ieee1394.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] drivers/char/ieee1394/*: convert to pci_register_driver

pci_register_driver-drivers_input_gameport.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] drivers/input/gameport/*: convert to pci_register_driver

pci_register_driver-drivers_input_serio.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] drivers/input/serio/*: convert to pci_register_driver

pci_register_driver-drivers_isdn_hardware_avm.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] drivers/isdn/hardware/avm/*: convert to pci_register_driver

pci_register_driver-drivers_isdn_tpam.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] drivers/isdn/tpam/*: convert to pci_register_driver

pci_register_driver-drivers_macintosh_macio_asic.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] drivers/macintoshisdn/*: convert to pci_register_driver

pci_register_driver-drivers_media_common_saa7146_core.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] [RESEND] pci_register_driver() for drivers/media/common/saa7146_core.c

pci_register_driver-drivers_media_dvb_b2c2_skystar2.patch
  From: Christophe Lucas <clucas@altern.org>
  Subject: [KJ] [PATCH] pci_register_driver() for drivers/media/dvb/b2c2/

pci_register_driver-drivers_media_dvb_bt8xx_bt878.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] pci_register_driver() for drivers/media/dvb/bt8xx/bt878.c

pci_register_driver-drivers_media_video_cx88.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] media/video/cx88*: convert pci_module_init to pci_register_driver

pci_register_driver-drivers_message_fusion.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] drivers/message/fusion/*: convert to pci_register_driver

pci_register_driver-drivers_mtd_maps.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] drivers/mtd/maps/*: convert to pci_register_driver

pci_register_driver-drivers_net.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] drivers/net/*: convert to pci_register_driver

pci_register_driver-drivers_net_arcnet.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] drivers/net/arcnet/*: convert to pci_register_driver

pci_register_driver-drivers_net_irda.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] drivers/net/irda/*: convert to pci_register_driver

pci_register_driver-drivers_net_skfp.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] drivers/net/skfp/*: convert to pci_register_driver

pci_register_driver-drivers_net_tokenring.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] drivers/net/tokenring/*: convert to pci_register_driver

pci_register_driver-drivers_net_tulip.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] drivers/net/tulip/*: convert to pci_register_driver

pci_register_driver-drivers_net_wan.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH][RESEND] drivers/net/wan/*: convert to pci_register_driver

pci_register_driver-drivers_net_wan_lmc.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] drivers/net/wan/lmc/*: convert to pci_register_driver

pci_register_driver-drivers_net_wireless.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] drivers/net/wireless/*: convert to pci_register_driver

pci_register_driver-drivers_net_wireless_prism54.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] drivers/net/wireless/prism54/*: convert to pci_register_driver

pci_register_driver-drivers_parisc.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] drivers/parisc/*: convert to pci_register_driver

pci_register_driver-drivers_parport.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] drivers/parport/*: convert to pci_register_driver

pci_register_driver-drivers_pci_pcie.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] drivers/pci/pcie/*: convert to pci_register_driver

pci_register_driver-drivers_pcmcia.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] drivers/pcmcia/*: convert to pci_register_driver

pci_register_driver-drivers_scsi.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] drivers/scsi/*: convert to pci_register_driver

pci_register_driver-drivers_scsi_aacraid.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] drivers/scsi/aacraid/*: convert to pci_register_driver

pci_register_driver-drivers_scsi_aic7xxx.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] drivers/scsi/aic7xxx/*: convert to pci_register_driver

pci_register_driver-drivers_scsi_megaraid.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] drivers/scsi/megaraid/*: convert to pci_register_driver

pci_register_driver-drivers_scsi_qla2xxx.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] drivers/scsi/qla2xxx/*: convert to pci_register_driver

pci_register_driver-drivers_scsi_sym53c8xx_2.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] drivers/scsi/sym53c8xx_2/*: convert to pci_register_driver

pci_register_driver-drivers_video.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] drivers/video/*: convert to pci_register_driver

pci_register_driver-drivers_video_aty.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] drivers/video/aty/*: convert to pci_register_driver

pci_register_driver-drivers_video_console.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] drivers/video/console/*: convert to pci_register_driver

pci_register_driver-drivers_video_intelfb.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] drivers/video/intelfb/*: convert to pci_register_driver

pci_register_driver-drivers_video_kyro.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] drivers/video/kyro/*: convert to pci_register_driver

pci_register_driver-drivers_video_sis.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] drivers/video/sis/*: convert to pci_register_driver

pci_register_driver-drivers_w1.patch
  From: Christophe Lucas <c.lucas@ifrance.com>
  Subject: [KJ] [PATCH] drivers/w1/*: convert to pci_register_driver

printk-drivers_video_tridentfb.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: [KJ] [PATCH 53/53][RESEND] tridentfb: Clean up printk()'s in 	drivers/video/tridentfb.c

remove_old_strings-drivers_telephony_ixj.patch
  From: "Stephen Biggs" <yrgrknmxpzlk@gawab.com>
  Subject: [KJ] [PATCH]  ixj* - compile warning cleanup

return_code-arch_i386_math-emu.patch
  From: "Stephen Biggs" <yrgrknmxpzlk@gawab.com>
  Subject: [KJ] [PATCH][RESUBMIT][1/21] arch/i386/math-emu/* - compile warning cleanup

return_code-drivers_ide.patch
  From: "Stephen Biggs" <yrgrknmxpzlk@gawab.com>
  Subject: [KJ] [PATCH][RESUBMIT][4/21] drivers/ide/* - compile warning cleanup

return_code-drivers_isdn_hisax.patch
  From: "Stephen Biggs" <yrgrknmxpzlk@gawab.com>
  Subject: [KJ] [PATCH][RESUBMIT][5/21] drivers/isdn/hisax/* - compile warning cleanup

return_code-drivers_isdn_i4l.patch
  From: "Stephen Biggs" <yrgrknmxpzlk@gawab.com>
  Subject: [KJ] [PATCH][RESUBMIT][6/21] drivers/isdn/i4l/* - compile warning cleanup

return_code-drivers_isdn_pcbit.patch
  From: "Stephen Biggs" <yrgrknmxpzlk@gawab.com>
  Subject: [KJ] [PATCH][RESUBMIT][7/21] drivers/isdn/pcbit/* - compile warning cleanup

return_code-drivers_usb_image.patch
  From: "Stephen Biggs" <yrgrknmxpzlk@gawab.com>
  Subject: [KJ] [PATCH][RESUBMIT][15/21] drivers/usb/image/* - compile warning cleanup

return_code-net_ipv6_ip6_flowlabel.patch
  From: "Stephen Biggs" <yrgrknmxpzlk@gawab.com>
  Subject: [patch] net/ipv6/ip6_flowlabel.c: copy_to_user return code

return_code-sound_oss_emu10k1.patch
  From: "Stephen Biggs" <yrgrknmxpzlk@gawab.com>
  Subject: [KJ] [PATCH][RESUBMIT][20/21] sound/oss/emu10k1/* - compile warning cleanup

sleep_on-drivers_media_video_saa7110.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] media/saa7110: remove sleep_on*() usage

sleep_on-fs_lockd_clntlock.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] fs/clntlock: remove sleep_on*() usage

sleep_on-net_sunrpc_clnt.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] net/clnt: remove sleep_on*() usage

strtok-scripts_mod_sumversion.patch
  From: Nicolas Kaiser <nikai@nikai.net>
  Subject: [KJ] [UPDATE PATCH] scripts/mod/sumversion.c: replace strtok() with  strsep()

unused_variable-drivers_char_mxser.patch
  From: "Stephen Biggs" <yrgrknmxpzlk@gawab.com>
  Subject: [KJ] [PATCH][RESUBMIT][3/21] drivers/char/* - compile warning cleanup

int_sleep_on-drivers_cdrom_mcdx.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 16/20] cdrom/mcdx: remove 	interruptible_sleep_on_timeout() usage

dma_mask-drivers_scsi_BusLogic.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [PATCH 08/19] drivers/scsi/BusLogic: Use the DMA_{64, 	32}BIT_MASK constants

dma_mask-drivers_scsi_a100u2w.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [PATCH 01/19] drivers/scsi/a100u2w: Use the DMA_{64, 	32}BIT_MASK constants

dma_mask-drivers_scsi_aacraid_aachba.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [PATCH 02/19] drivers/scsi/acraid/aachba: Use the DMA_{64, 	32}BIT_MASK constants

dma_mask-drivers_scsi_aacraid_linit.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [PATCH 03/19] drivers/scsi/aacraid/linit: Use the DMA_{64, 	32}BIT_MASK constants

dma_mask-drivers_scsi_ahci.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [PATCH 04/19] drivers/scsi/ahci: Use the DMA_{64, 	32}BIT_MASK constants

dma_mask-drivers_scsi_aic7xxx_aic79xx_osm.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [PATCH 05/19] drivers/scsi/aic7xxx/aic79xx_osm: Use the 	DMA_{64, 32}BIT_MASK constants

dma_mask-drivers_scsi_aic7xxx_aic7xxx_osm.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [PATCH 06/19] drivers/scsi/aic7xxx/aic7xxx_osm: Use the 	DMA_{64, 32}BIT_MASK constants

dma_mask-drivers_scsi_atp870u.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [PATCH 07/19] drivers/scsi/atp870u: Use the DMA_{64, 	32}BIT_MASK constants

dma_mask-drivers_scsi_dpt_i2o.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [PATCH 09/19] drivers/scsi/dpt_i2o: Use the DMA_{64, 	32}BIT_MASK constants

dma_mask-drivers_scsi_eata.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [PATCH 10/19] drivers/scsi/eata: Use the DMA_{64, 	32}BIT_MASK constants

dma_mask-drivers_scsi_gdth.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [PATCH 11/19] drivers/scsi/gdth: Use the DMA_{64, 	32}BIT_MASK constants

dma_mask-drivers_scsi_initio.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [PATCH 12/19] drivers/scsi/initio: Use the DMA_{64, 	32}BIT_MASK constants

dma_mask-drivers_scsi_ips.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [PATCH 13/19] drivers/scsi/ips: Use the DMA_{64, 	32}BIT_MASK constants

dma_mask-drivers_scsi_megaraid.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [PATCH 15/19] drivers/scsi/megaraid: Use the DMA_{64, 	32}BIT_MASK constants

dma_mask-drivers_scsi_megaraid_megaraid_mbox.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [PATCH 14/19] drivers/scsi/megaraid/megaraid_mbox: Use the 	DMA_{64, 32}BIT_MASK constants

dma_mask-drivers_scsi_nsp32.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [PATCH 16/19] drivers/scsi/nsp32: Use the DMA_{64, 	32}BIT_MASK constants

dma_mask-drivers_scsi_qla1280.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [PATCH 17/19] drivers/scsi/qla1280: Use the DMA_{64, 	32}BIT_MASK constants

dma_mask-drivers_scsi_qlogicfc.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [PATCH 18/19] drivers/scsi/qlogicfc: Use the DMA_{64, 	32}BIT_MASK constants

dma_mask-drivers_scsi_sata_vsc.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [PATCH 19/19] drivers/scsi/sata_vsc: Use the DMA_{64, 	32}BIT_MASK constants

unused_define-drivers_block_floppy.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: [KJ] [patch] remove unused LOCAL_END_REQUEST

kj_tag.patch
  -kj



merged:
-------
vfree-drivers_media_dvb_dvb-core_dvb_demux
wait_event_int_t-net_bluetooth_cmtp_capi
remove_file-drivers_scsi_dpt_dpt_osdutil.h
remove_file-include_asm_mips_it8172_it8172_lpc.h
remove_file-include_asm_mips_ng1.h
remove_file-include_asm_mips_ng1hw.h
vfree-arch_s390_kernel_module
vfree-drivers_isdn_hardware_eicon_platform.h
vfree-sound_oss_pss
msleep-arch_ia64_kernel_smpboot
msleep-arch_ppc64_kernel_iSeries_pci_reset
msleep-arch_ppc64_kernel_pSeries_smp
msleep-arch_ppc64_kernel_smp
msleep-drivers_char_sonypi
msleep-net_atm_resources
msleep_ssleep-net_ipv4_ipconfig
reorder_set_current_state-drivers_atm_he
ssleep-arch_ppc64_kernel_traps
ssleep-net_ipv4_ipvs_ip_vs_sync
set_current_state-drivers_input_joystick_iforce_iforce-packets
int_sleep_on-net_core_pktgen
pci_register_driver-drivers_serial


dropped:
--------
msleep_interruptible-drivers_scsi_dpt_i2o
  no longer applies
remove_file-drivers_pcmcia_au1000_pb1x00.c
  someone's still patching it
wait_event_int_t-drivers_input_joystick_iforce_iforce.h.patch
  obsoleted by newer patch
wait_event-drivers_block_amiflop
  obsoleted


all patches:
------------
min-max-ide_ide-timing.h.patch
list-for-each-entry-drivers_chan_kern.patch
list-for-each-entry-drivers_macintosh_via-pmu.patch
list-for-each-entry-drivers_net_ppp_generic.patch
list-for-each-entry-fs_jffs_intrep.patch
list-for-each-entry-fs_namespace.patch
list-for-each-entry-safe-arch_i386_mm_pageattr.patch
list-for-each-entry-safe-fs_dquot.patch
list-for-each-fs_dcache.patch
msleep-drivers_ide_ide-tape.patch
pr_debug-drivers_block_umem.patch
list-for-each-drivers_net_ipv6_ip6_fib.patch
list-for-each-drivers_net_tulip_de4x5.patch
min-max-arch_sh_boards_bigsur_io.patch
min-max-arch_sh_cchips_hd6446x_hd64465_io.patch
msleep-drivers_block_xd.patch
msleep-drivers_ide_ide-cs.patch
msleep_interruptible-drivers_macintosh_mediabay.patch
set_current_state-drivers_block_swim3.patch
set_current_state-drivers_block_swim_iop.patch
add_module_version-drivers_net_8139cp.patch
for-each-pci-dev-arch_i386_pci_acpi.patch
for-each-pci-dev-arch_i386_pci_i386.patch
function-string-arch-mips.patch
msleep-drivers_media_radio_radio-zoltrix.patch
msleep-drivers_net_3c505.patch
msleep-drivers_net_irda_act200l-sir.patch
msleep-drivers_net_irda_irtty-sir.patch
msleep-drivers_net_irda_ma600-sir.patch
msleep-drivers_net_irda_pcmcia_xirc2ps_cs.patch
msleep-drivers_net_irda_sir_dev.patch
msleep-drivers_net_ixgb_ixgb_osdep.patch
msleep-drivers_net_ni65.patch
msleep-drivers_net_ns83820.patch
msleep-drivers_net_wireless_prism54_islpci_dev.patch
msleep_interruptible-drivers_net_irda_tekram-sir.patch
msleep_interruptible-drivers_net_ixgb_ixgb_ethtool.patch
msleep_interruptible-drivers_net_pcnet32.patch
msleep_interruptible-drivers_net_wan_cycx_drv.patch
msleep_interruptible-drivers_parport_ieee1284_ops.patch
msleep_interruptible-drivers_parport_ieee1284.patch
msleep_interruptible-drivers_parport_parport_pc.patch
msleep_interruptible-drivers_s390_net_ctctty.patch
msleep_interruptible-drivers_sbus_char_aurora.patch
msleep_interruptible-drivers_tc_zs.patch
msleep+msleep_interruptible-drivers_net_tokenring_ibmtr.patch
msleep+ssleep-drivers_net_appletalk_ltpc.patch
pci_dev_present-drivers_ide_pci_alim15x3.patch
remove-pci-find-device-drivers_net_e1000_e1000_main.patch
remove-pci-find-device-drivers_net_gt96100eth.patch
remove-pci-find-device-drivers_net_ixgb_ixgb_main.patch
remove-pci-find-device-drivers_net_tg3.patch
set_current_state-drivers_net_irda_stir4200.patch
set_current_state-drivers_net_tokenring_tms380tr.patch
set_current_state-drivers_net_wan_farsync.patch
ssleep-drivers_net_wireless_orinoco_plx.patch
ssleep-drivers_net_wireless_orinoco_tmd.patch
ssleep+msleep_interruptible-drivers_net_tokenring_lanstreamer.patch
fix-comment-fs_jbd_journal.patch
lib-parser-fs_devpts_inode.patch
msleep_interruptible-drivers_net_ewrk3.patch
reorder-state-drivers_char_snsc.patch
ssleep-drivers_scsi_qla2xxx_qla_os.patch
docs-fs_super.patch
docs-kernel_sysctl.patch
myri_code_cleanup.patch
printk-drivers-scsi-zalon.patch
comment-drivers_block_floppy.c.patch
schedule_cleanup-drivers_usb_class_usblp.c.patch
remove_file-arch_arm26_boot_compressed_hw_bse.c.patch
remove_file-arch_mips_arc_salone.c.patch
remove_file-arch_mips_pmc_sierra_yosemite_ht_irq.c.patch
remove_file-arch_ppc64_boot_no_initrd.c.patch
remove_file-arch_ppc_kernel_find_name.c.patch
remove_file-arch_ppc_syslib_ppc4xx_pm.c.patch
remove_file-arch_ppc_syslib_ppc4xx_serial.c.patch
remove_file-arch_sh64_lib_old_checksum.c.patch
remove_file-drivers_char_hp600_keyb.c.patch
remove_file-drivers_parport_parport_arc.c.patch
remove_file-fs_jffs2_histo.h.patch
remove_file-include_asm_arm_arch_epxa10db_mode_ctrl00.h.patch
remove_file-include_asm_arm_arch_epxa10db_pld_conf00.h.patch
remove_file-include_asm_arm_hardware_linkup_l1110.h.patch
remove_file-include_asm_m68knommu_io_hw_swap.h.patch
remove_file-include_asm_m68knommu_semp3.h.patch
remove_file-include_asm_mips_gfx.h.patch
remove_file-include_asm_mips_mach_au1x00_au1100_mmc.h.patch
remove_file-include_asm_mips_mipsprom.h.patch
remove_file-include_asm_mips_riscos_syscall.h.patch
remove_file-include_asm_ppc64_iSeries_iSeries_fixup.h.patch
remove_file-include_linux_netfilter_ipv4_ip_logging.h.patch
remove_file-include_linux_netfilter_ipv6_ip6_logging.h.patch
remove_file-sound_oss_maestro_tables.h.patch
cleanup-drivers_media_radio_miropcm20-radio.c.patch
msleep-drivers_ieee1394_sbp2.patch
msleep-drivers_net_cs89x0.patch
msleep-drivers_net_wan_cosa.patch
msleep_ssleep-drivers_net_wireless_airo.patch
typo_suppport-bttv_dvb.patch
vfree-drivers_char_agp_backend.patch
vfree-drivers_char_agp_generic.patch
vfree-drivers_ieee1394_dma.patch
vfree-drivers_isdn_i4l_isdn_bsdcomp.patch
vfree-drivers_media_dvb_dvb-core_dmxdev.patch
vfree-drivers_media_dvb_dvb-core_dvb_ca_en50221.patch
vfree-drivers_media_dvb_ttpci_av7110.patch
vfree-drivers_media_dvb_ttpci_av7110_ipack.patch
vfree-drivers_media_dvb_ttpci_budget-core.patch
vfree-drivers_media_video_stradis.patch
vfree-drivers_scsi_qla2xxx_qla_os.patch
vfree-drivers_video_sis_sis_main.patch
vfree-fs_reiserfs_super.patch
vfree-net_bridge_netfilter_ebtables.patch
vfree-sound_oss_gus_wave.patch
extern-include_linux_generic_serial.h.old.patch
msleep-arch_arm_mach-sa1100_cpu-sa1110.patch
msleep-drivers_block_cciss.patch
msleep-drivers_block_paride_pf.patch
msleep-drivers_block_paride_pg.patch
msleep-drivers_block_xd2.patch
msleep-drivers_cdrom_sonycd535.patch
msleep-drivers_net_s2io.patch
msleep-drivers_net_slip.patch
msleep-drivers_scsi_ide-scsi.patch
msleep-drivers_scsi_osst.patch
msleep-drivers_serial_crisv10.patch
msleep-drivers_usb_serial_cypress_m8.patch
msleep-fs_cifs_transport.patch
msleep-fs_jfs_jfs_logmgr.patch
msleep-fs_nfsd_vfs.patch
msleep-fs_smbfs_proc.patch
msleep-fs_xfs_linux-2.6_xfs_buf.patch
msleep-net_appletalk_aarp.patch
msleep-net_sunrpc_svcsock.patch
msleep_interruptible-drivers_block_swim3.patch
msleep_interruptible-drivers_char_sx.patch
msleep_interruptible-drivers_sbus_char_envctrl.patch
msleep_interruptible-drivers_scsi_st.patch
msleep_interruptible-drivers_w1_w1_therm.patch
msleep_interruptible-fs_lockd_clntproc.patch
msleep_interruptible-fs_xfs_linux-2.6_xfs_super.patch
msleep_interruptible-sound_isa_gus_gus_reset.patch
msleep_ssleep-drivers_block_paride_pcd.patch
msleep_ssleep-drivers_block_paride_pt.patch
remove_duplicate_delay-drivers_net_sk98lin_skethtool.patch
return_code-drivers_ide_pci_cs5520.patch
set_current_state-drivers_char_ftape_lowlevel_fdc-io.patch
set_current_state-sound_isa_gus_gus_pcm.patch
set_current_state-sound_isa_wavefront_wavefront_synth.patch
spin_lock_init-arch_um_drivers_port_kern.patch
ssleep-arch_i386_kernel_traps.patch
ssleep-drivers_message_fusion_mptbase.patch
ssleep-drivers_net_sb1000.patch
ssleep-drivers_scsi_qla1280.patch
ssleep-fs_nfsd_nfs4callback.patch
ssleep-kernel_power_smp.patch
ssleep-sound_isa_sb_emu8000.patch
task_unint-drivers_base_dmapool.patch
unused_pointer-sound_usb_usx2y_usbusx2yaudio.patch
wait_event-arch_m68k_atari_stdma.patch
wait_event-drivers_acorn_block_fd1772.patch
wait_event-drivers_block_ps2esdi.patch
wait_event-drivers_scsi_atari_scsi.patch
wait_event_int_t-drivers_usb_class_usblp.patch
wait_event_timeout-drivers_char_hvsi.patch
wait_event_timeout-drivers_usb_image_mdc800.patch
wait_event_timeout-drivers_usb_input_ati_remote.patch
wait_event_timeout-drivers_usb_misc_auerswald.patch
wait_event_timeout-drivers_usb_net_kaweth.patch
kill_kernel_parameter-sf16fm.patch
int_sleep_on-arch_cris_arch-v10_drivers_eeprom.patch
int_sleep_on-drivers_cdrom_cdu31a.patch
int_sleep_on-drivers_char_istallion.patch
int_sleep_on-drivers_ieee1394_video1394.patch
int_sleep_on-drivers_isdn_capi_capi.patch
int_sleep_on-drivers_isdn_i4l_isdn_common.patch
int_sleep_on-drivers_media_video_planb.patch
int_sleep_on-drivers_media_video_zoran_device.patch
int_sleep_on-drivers_media_video_zoran_driver.patch
int_sleep_on-drivers_media_video_zr36120.patch
int_sleep_on-drivers_net_tokenring_lanstreamer.patch
lindent-arch_ppc_4xx_io_serial_sicc.patch
printk-drivers_acorn_block_fd1772.patch
printk-drivers_acorn_block_mfmhd.patch
printk-drivers_video_atafb.patch
printk-drivers_video_aty_mach64_ct.patch
printk-drivers_video_aty_radeon_monitor.patch
printk-drivers_video_aty_radeon_pm.patch
printk-drivers_video_bw2.patch
printk-drivers_video_cg3.patch
printk-drivers_video_cg6.patch
printk-drivers_video_cirrusfb.patch
printk-drivers_video_clps711xfb.patch
printk-drivers_video_console_fbcon.patch
printk-drivers_video_console_mdacon.patch
printk-drivers_video_console_newport_con.patch
printk-drivers_video_cyber2000fb.patch
printk-drivers_video_dnfb.patch
printk-drivers_video_fbmem.patch
printk-drivers_video_fbmon.patch
printk-drivers_video_ffb.patch
printk-drivers_video_fm2fb.patch
printk-drivers_video_igafb.patch
printk-drivers_video_imsttfb.patch
printk-drivers_video_intelfb_intelfbhw.patch
printk-drivers_video_kyro_fbdev.patch
printk-drivers_video_leo.patch
printk-drivers_video_macfb.patch
printk-drivers_video_matrox_matroxfb_base.patch
printk-drivers_video_modedb.patch
printk-drivers_video_neofb.patch
printk-drivers_video_p9100.patch
printk-drivers_video_platinumfb.patch
printk-drivers_video_pm3fb.patch
printk-drivers_video_pmag-ba-fb.patch
printk-drivers_video_pmagb-b-fb.patch
printk-drivers_video_pvr2fb.patch
printk-drivers_video_radeonfb.patch
printk-drivers_video_retz3fb.patch
printk-drivers_video_riva_fbdev.patch
printk-drivers_video_savage_savagefb.patch
printk-drivers_video_sstfb.patch
printk-drivers_video_sun3fb.patch
printk-drivers_video_tcx.patch
printk-drivers_video_tdfxfb.patch
printk-drivers_video_virgefb.patch
printk-drivers_video_w100fb.patch
sleep_on-drivers_block_xd.patch
sleep_on-drivers_cdrom_aztcd.patch
sleep_on-drivers_cdrom_mcd.patch
sleep_on-drivers_cdrom_sjcd.patch
sleep_on-drivers_net_shaper.patch
sleep_on-drivers_sbus_char_bpp.patch
sleep_on-drivers_sbus_char_vfc_i2c.patch
spin_lock_init-include_linux_wait.h.patch
wait_event-drivers_block_amiflop.patch
wait_event-drivers_block_ataflop.patch
wait_event_int-drivers_block_acsi_slm.patch
wait_event_int-drivers_block_swim3.patch
wait_event_int-drivers_block_swim_iop.patch
wait_event_int_timeout-drivers_block_DAC960.patch
wait_event_int_timeout-drivers_input_joystick_iforce_iforce-packets.patch
wait_event_int_timeout-sound_core_rawmidi.patch
defines-drivers_scsi_FlashPoint.patch
dma_mask-drivers_atm_lanai.patch
dma_mask-drivers_net_8139cp.patch
dma_mask-drivers_net_acenic.patch
dma_mask-drivers_net_e100.patch
dma_mask-drivers_net_hp100.patch
dma_mask-drivers_net_ns83820.patch
dma_mask-drivers_net_s2io.patch
dma_mask-drivers_net_sk98lin_skge.patch
dma_mask-drivers_net_sungem.patch
dma_mask-drivers_net_tg3.patch
dma_mask-drivers_net_tlan.patch
dma_mask-drivers_net_tokenring_lanstreamer.patch
dma_mask-drivers_net_tulip_dmfe.patch
dma_mask-drivers_net_tulip_winbond-840.patch
dma_mask-drivers_net_via-rhine.patch
dma_mask-drivers_net_wan_wanxl.patch
dma_mask-drivers_net_wireless_prism54_islpci_hotplug.patch
extinguish_warnings-include_linux_module.h.patch
int_sleep_on-arch_mips_sibyte_sb1250_bcm1250_tbprof.patch
int_sleep_on-drivers_char_lp.patch
int_sleep_on-drivers_i2c_busses_i2c-elektor.patch
int_sleep_on-drivers_i2c_busses_i2c-ite.patch
int_sleep_on-drivers_media_video_zoran_card.patch
int_sleep_on-drivers_net_8139too.patch
int_sleep_on-drivers_net_tokenring_ibmtr.patch
int_sleep_on-drivers_usb_class_usb-midi.patch
int_sleep_on-drivers_usb_misc_rio500.patch
int_sleep_on-drivers_usb_serial_digi_acceleport.patch
int_sleep_on-fs_lockd_svc.patch
pci_register_driver-drivers_atm.patch
pci_register_driver-drivers_block.patch
pci_register_driver-drivers_char_agp.patch
pci_register_driver-drivers_char_watchdog.patch
pci_register_driver-drivers_eisa.patch
pci_register_driver-drivers_ide.patch
pci_register_driver-drivers_ieee1394.patch
pci_register_driver-drivers_input_gameport.patch
pci_register_driver-drivers_input_serio.patch
pci_register_driver-drivers_isdn_hardware_avm.patch
pci_register_driver-drivers_isdn_tpam.patch
pci_register_driver-drivers_macintosh_macio_asic.patch
pci_register_driver-drivers_media_common_saa7146_core.patch
pci_register_driver-drivers_media_dvb_b2c2_skystar2.patch
pci_register_driver-drivers_media_dvb_bt8xx_bt878.patch
pci_register_driver-drivers_media_video_cx88.patch
pci_register_driver-drivers_message_fusion.patch
pci_register_driver-drivers_mtd_maps.patch
pci_register_driver-drivers_net.patch
pci_register_driver-drivers_net_arcnet.patch
pci_register_driver-drivers_net_irda.patch
pci_register_driver-drivers_net_skfp.patch
pci_register_driver-drivers_net_tokenring.patch
pci_register_driver-drivers_net_tulip.patch
pci_register_driver-drivers_net_wan.patch
pci_register_driver-drivers_net_wan_lmc.patch
pci_register_driver-drivers_net_wireless.patch
pci_register_driver-drivers_net_wireless_prism54.patch
pci_register_driver-drivers_parisc.patch
pci_register_driver-drivers_parport.patch
pci_register_driver-drivers_pci_pcie.patch
pci_register_driver-drivers_pcmcia.patch
pci_register_driver-drivers_scsi.patch
pci_register_driver-drivers_scsi_aacraid.patch
pci_register_driver-drivers_scsi_aic7xxx.patch
pci_register_driver-drivers_scsi_megaraid.patch
pci_register_driver-drivers_scsi_qla2xxx.patch
pci_register_driver-drivers_scsi_sym53c8xx_2.patch
pci_register_driver-drivers_video.patch
pci_register_driver-drivers_video_aty.patch
pci_register_driver-drivers_video_console.patch
pci_register_driver-drivers_video_intelfb.patch
pci_register_driver-drivers_video_kyro.patch
pci_register_driver-drivers_video_sis.patch
pci_register_driver-drivers_w1.patch
printk-drivers_video_tridentfb.patch
remove_old_strings-drivers_telephony_ixj.patch
return_code-arch_i386_math-emu.patch
return_code-drivers_ide.patch
return_code-drivers_isdn_hisax.patch
return_code-drivers_isdn_i4l.patch
return_code-drivers_isdn_pcbit.patch
return_code-drivers_usb_image.patch
return_code-net_ipv6_ip6_flowlabel.patch
return_code-sound_oss_emu10k1.patch
sleep_on-drivers_media_video_saa7110.patch
sleep_on-fs_lockd_clntlock.patch
sleep_on-net_sunrpc_clnt.patch
strtok-scripts_mod_sumversion.patch
unused_variable-drivers_char_mxser.patch
int_sleep_on-drivers_cdrom_mcdx.patch
dma_mask-drivers_scsi_BusLogic.patch
dma_mask-drivers_scsi_a100u2w.patch
dma_mask-drivers_scsi_aacraid_aachba.patch
dma_mask-drivers_scsi_aacraid_linit.patch
dma_mask-drivers_scsi_ahci.patch
dma_mask-drivers_scsi_aic7xxx_aic79xx_osm.patch
dma_mask-drivers_scsi_aic7xxx_aic7xxx_osm.patch
dma_mask-drivers_scsi_atp870u.patch
dma_mask-drivers_scsi_dpt_i2o.patch
dma_mask-drivers_scsi_eata.patch
dma_mask-drivers_scsi_gdth.patch
dma_mask-drivers_scsi_initio.patch
dma_mask-drivers_scsi_ips.patch
dma_mask-drivers_scsi_megaraid.patch
dma_mask-drivers_scsi_megaraid_megaraid_mbox.patch
dma_mask-drivers_scsi_nsp32.patch
dma_mask-drivers_scsi_qla1280.patch
dma_mask-drivers_scsi_qlogicfc.patch
dma_mask-drivers_scsi_sata_vsc.patch
unused_define-drivers_block_floppy.patch
kj_tag.patch
