Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbVAVX5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbVAVX5Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 18:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbVAVX5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 18:57:24 -0500
Received: from coderock.org ([193.77.147.115]:31124 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261159AbVAVXys (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 18:54:48 -0500
Date: Sun, 23 Jan 2005 00:54:26 +0100
From: Domen Puncer <domen@coderock.org>
To: kj <kernel-janitors@lists.osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: 2.6.11-rc2-kj
Message-ID: <20050122235426.GB22170@nd47.coderock.org>
Mail-Followup-To: kj <kernel-janitors@lists.osdl.org>,
	lkml <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another release from kernel janitors (http://kerneljanitors.org/)
This one contains 194 patches.
Mail me if I missed any patches.

Feedback is appreciated, especially for some not so trivial patches like
wait_event ones.


Patchset is at http://coderock.org/kj/2.6.11-rc2-kj/

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

vfree-arch_s390_kernel_module.patch
  From: jlamanna@gmail.com
  Subject: [KJ] [PATCH] [RESEND] [18/29] module.c - vfree() checking cleanups

vfree-drivers_char_agp_backend.patch
  From: jlamanna@gmail.com
  Subject: [KJ] [PATCH] [RESEND] [23/29] backend.c - vfree() checking cleanups

vfree-drivers_char_agp_generic.patch
  From: jlamanna@gmail.com
  Subject: [KJ] [PATCH] [RESEND] [28/29] generic.c - vfree() checking cleanups

vfree-drivers_ieee1394_dma.patch
  From: jlamanna@gmail.com
  Subject: [KJ] [PATCH] [RESEND] [9/29] dma.c - vfree() checking cleanups

vfree-drivers_isdn_hardware_eicon_platform.h.patch
  From: jlamanna@gmail.com
  Subject: [KJ] [PATCH] [RESEND] [2/29] platform.h - vfree() checking cleanups

vfree-drivers_isdn_i4l_isdn_bsdcomp.patch
  From: jlamanna@gmail.com
  Subject: [KJ] [PATCH] [RESEND] [1/29] isdn_bsdcomp.c - vfree() checking 	cleanups

vfree-drivers_media_dvb_dvb-core_dmxdev.patch
  From: jlamanna@gmail.com
  Subject: [KJ] [PATCH] [RESEND] [12/29] dmxdev.c - vfree() checking cleanups

vfree-drivers_media_dvb_dvb-core_dvb_ca_en50221.patch
  From: jlamanna@gmail.com
  Subject: [KJ] [PATCH] [RESEND] [4/29] dvb_ca_en50221.c - vfree() checking 	cleanups

vfree-drivers_media_dvb_dvb-core_dvb_demux.patch
  From: jlamanna@gmail.com
  Subject: [KJ] [PATCH] [RESEND] [20/29] dvb_demux.c - vfree() checking 	cleanups

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

vfree-sound_oss_pss.patch
  From: jlamanna@gmail.com
  Subject: [KJ] [PATCH] [RESEND] [29/29] pss.c - vfree() checking cleanups

extern-include_linux_generic_serial.h.old.patch
  From: Adrian Bunk <bunk@stusta.de>
  Subject: [KJ] [2.6 patch] generic_serial.h: kill incorrect gs_debug reference

msleep-arch_arm_mach-sa1100_cpu-sa1110.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 1/22] arm/cpu-sa1110: replace schedule_timeout() with 	msleep()

msleep-arch_ia64_kernel_smpboot.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 13/21] ia64/smpboot: replace schedule_timeout() with 	msleep()

msleep-arch_ppc64_kernel_iSeries_pci_reset.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 16/21] ppc64/iSeries_pci_reset: replace 	schedule_timeout() with msleep()

msleep-arch_ppc64_kernel_pSeries_smp.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 17/21] ppc64/pSeries_smp: replace schedule_timeout() 	with msleep()

msleep-arch_ppc64_kernel_smp.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 19/21] ppc64/smp: replace schedule_timeout() with 	msleep()

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

msleep-drivers_char_sonypi.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 10/21] char/sonypi: replace schedule_timeout() with 	msleep()

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

msleep-net_atm_resources.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 22/39] net/resources: replace schedule_timeout() with 	msleep()

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

msleep_ssleep-net_ipv4_ipconfig.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 21/39] net/ipconfig: replace schedule_timeout() with 	msleep()

remove_duplicate_delay-drivers_net_sk98lin_skethtool.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 15/21] net/skethtool: remove duplicate delay

reorder_set_current_state-drivers_atm_he.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 2/22] atm/he: reorder add_wait_queue() and 	set_current_state()

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

ssleep-arch_ppc64_kernel_traps.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 20/21] ppc64/traps: replace schedule_timeout() with 	ssleep()

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

ssleep-net_ipv4_ipvs_ip_vs_sync.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 20/39] net/ip_vs_sync: replace schedule_timeout() with 	ssleep()

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

wait_event-drivers_block_amiflop.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 3/40] block/amiflop: replace sleep_on() with 	wait_event()

wait_event-drivers_block_ps2esdi.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 4/40] block/ps2esdi: replace sleep_on() with 	wait_event()

wait_event-drivers_scsi_atari_scsi.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 24/39] scsi/atari_scsi: use wait_event()

wait_event_int_t-drivers_input_joystick_iforce_iforce.h.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 13/39] input/iforce-packets: use 	wait_event_interruptible_timeout()

wait_event_int_t-drivers_usb_class_usblp.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH 38/39] usb/usblp: use wait_event_interruptible_timeout()

wait_event_int_t-net_bluetooth_cmtp_capi.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [UPDATE PATCH 17/39] net/capi: use 	wait_event_interruptible_timeout()

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
  Subject: Re: [KJ] [PATCH] radio-sf16fmi cleanup

kj_tag.patch
  -kj



merged:
-------
list-for-each-entry-safe-fs_coda_psdev
reorder-state-drivers_video_pxafb
reorder-state-drivers_video_sa1100fb
kconfig-arch_sparc64
typo-arch_ppc64_kernel_rtasd.c
remove_file-arch_m68k_apollo_dn_debug.c
remove_file-arch_m68k_sun3x_sun3x_ksyms.c
remove_file-arch_um_include_umn.h
remove_file-arch_x86_64_lib_old_checksum.c
remove_file-drivers_char_rio_cdproto.h
remove_file-drivers_char_rsf16fmi.h
remove_file-include_asm_m68k_atari_SCCserial.h
remove_file-include_asm_parisc_bootdata.h
remove_file-include_linux_umsdos_fs_i.h
array_size-fs_proc_base.c.bak
remove_sprintf-fs_proc_proc_tty.c.bak
msleep-drivers_atm_ambassador
msleep-drivers_ide_ide-cd
vfree-arch_ia64_sn_kernel_sn2_sn_hwperf
vfree-drivers_atm_idt77252
vfree-drivers_usb_media_ov511
vfree-mm_swapfile
pci_dev_present-arch_ia64_hp_common_sba_iommu.patch
pci_dev_present-arch_ia64_pci_pci.patch
remove-old-ifdefs-aic7xxx_osm_pci.patch


dropped:
--------
msleep-drivers_scsi_ppa.patch
  by nacc

remove-pci-find-device-arch_sparc64_kernel_ebus
  missing pci_dev_put

msleep-drivers_scsi_ide-scsi.patch
msleep-drivers_scsi_imm.patch
msleep-drivers_scsi_osst.patch
msleep-drivers_scsi_qla1280.patch
msleep-drivers_scsi_osst.patch
msleep_interruptible-drivers_base_dmapool.patch
msleep_interruptible-drivers_block_cciss.patch
msleep_interruptible-drivers_block_pcd.patch
msleep_interruptible-drivers_block_pf.patch
msleep_interruptible-drivers_block_pcd.patch
msleep_interruptible-drivers_block_pt.patch
msleep_interruptible-drivers_block_pg.patch
msleep_interruptible-drivers_cdrom_sonycd535.patch
msleep_interruptible-drivers_cdrom_sonycd535_2.patch
msleep_interruptible-drivers_message_fusion_mptbase.patch
msleep_interruptible-drivers_net_sb1000.patch
msleep_interruptible-drivers_net_slip.patch
msleep_interruptible-drivers_sbus_char_envctrl.patch
msleep_interruptible-drivers_scsi_st.patch
  nacc reworked them

remove_file-drivers_pcmcia_au1000_generic.c
  does not apply

cleanup-drivers_atm_he.c.patch
  parts of it merged


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
msleep_interruptible-drivers_scsi_dpt_i2o.patch
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
set_current_state-drivers_input_joystick_iforce_iforce-packets.patch
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
remove_file-drivers_pcmcia_au1000_pb1x00.c.patch
remove_file-drivers_scsi_dpt_dpt_osdutil.h.patch
remove_file-fs_jffs2_histo.h.patch
remove_file-include_asm_arm_arch_epxa10db_mode_ctrl00.h.patch
remove_file-include_asm_arm_arch_epxa10db_pld_conf00.h.patch
remove_file-include_asm_arm_hardware_linkup_l1110.h.patch
remove_file-include_asm_m68knommu_io_hw_swap.h.patch
remove_file-include_asm_m68knommu_semp3.h.patch
remove_file-include_asm_mips_gfx.h.patch
remove_file-include_asm_mips_it8172_it8172_lpc.h.patch
remove_file-include_asm_mips_mach_au1x00_au1100_mmc.h.patch
remove_file-include_asm_mips_mipsprom.h.patch
remove_file-include_asm_mips_ng1.h.patch
remove_file-include_asm_mips_ng1hw.h.patch
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
vfree-arch_s390_kernel_module.patch
vfree-drivers_char_agp_backend.patch
vfree-drivers_char_agp_generic.patch
vfree-drivers_ieee1394_dma.patch
vfree-drivers_isdn_hardware_eicon_platform.h.patch
vfree-drivers_isdn_i4l_isdn_bsdcomp.patch
vfree-drivers_media_dvb_dvb-core_dmxdev.patch
vfree-drivers_media_dvb_dvb-core_dvb_ca_en50221.patch
vfree-drivers_media_dvb_dvb-core_dvb_demux.patch
vfree-drivers_media_dvb_ttpci_av7110.patch
vfree-drivers_media_dvb_ttpci_av7110_ipack.patch
vfree-drivers_media_dvb_ttpci_budget-core.patch
vfree-drivers_media_video_stradis.patch
vfree-drivers_scsi_qla2xxx_qla_os.patch
vfree-drivers_video_sis_sis_main.patch
vfree-fs_reiserfs_super.patch
vfree-net_bridge_netfilter_ebtables.patch
vfree-sound_oss_gus_wave.patch
vfree-sound_oss_pss.patch
extern-include_linux_generic_serial.h.old.patch
msleep-arch_arm_mach-sa1100_cpu-sa1110.patch
msleep-arch_ia64_kernel_smpboot.patch
msleep-arch_ppc64_kernel_iSeries_pci_reset.patch
msleep-arch_ppc64_kernel_pSeries_smp.patch
msleep-arch_ppc64_kernel_smp.patch
msleep-drivers_block_cciss.patch
msleep-drivers_block_paride_pf.patch
msleep-drivers_block_paride_pg.patch
msleep-drivers_block_xd2.patch
msleep-drivers_cdrom_sonycd535.patch
msleep-drivers_char_sonypi.patch
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
msleep-net_atm_resources.patch
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
msleep_ssleep-net_ipv4_ipconfig.patch
remove_duplicate_delay-drivers_net_sk98lin_skethtool.patch
reorder_set_current_state-drivers_atm_he.patch
return_code-drivers_ide_pci_cs5520.patch
set_current_state-drivers_char_ftape_lowlevel_fdc-io.patch
set_current_state-sound_isa_gus_gus_pcm.patch
set_current_state-sound_isa_wavefront_wavefront_synth.patch
spin_lock_init-arch_um_drivers_port_kern.patch
ssleep-arch_i386_kernel_traps.patch
ssleep-arch_ppc64_kernel_traps.patch
ssleep-drivers_message_fusion_mptbase.patch
ssleep-drivers_net_sb1000.patch
ssleep-drivers_scsi_qla1280.patch
ssleep-fs_nfsd_nfs4callback.patch
ssleep-kernel_power_smp.patch
ssleep-net_ipv4_ipvs_ip_vs_sync.patch
ssleep-sound_isa_sb_emu8000.patch
task_unint-drivers_base_dmapool.patch
unused_pointer-sound_usb_usx2y_usbusx2yaudio.patch
wait_event-arch_m68k_atari_stdma.patch
wait_event-drivers_acorn_block_fd1772.patch
wait_event-drivers_block_amiflop.patch
wait_event-drivers_block_ps2esdi.patch
wait_event-drivers_scsi_atari_scsi.patch
wait_event_int_t-drivers_input_joystick_iforce_iforce.h.patch
wait_event_int_t-drivers_usb_class_usblp.patch
wait_event_int_t-net_bluetooth_cmtp_capi.patch
wait_event_timeout-drivers_char_hvsi.patch
wait_event_timeout-drivers_usb_image_mdc800.patch
wait_event_timeout-drivers_usb_input_ati_remote.patch
wait_event_timeout-drivers_usb_misc_auerswald.patch
wait_event_timeout-drivers_usb_net_kaweth.patch
kill_kernel_parameter-sf16fm.patch
kj_tag.patch
