Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262326AbVAJQsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262326AbVAJQsj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 11:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbVAJQsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 11:48:38 -0500
Received: from coderock.org ([193.77.147.115]:61371 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262326AbVAJQrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 11:47:20 -0500
Date: Mon, 10 Jan 2005 17:47:03 +0100
From: Domen Puncer <domen@coderock.org>
To: kj <kernel-janitors@lists.osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [announce] 2.6.10-bk13-kj
Message-ID: <20050110164703.GD14307@nd47.coderock.org>
Mail-Followup-To: kj <kernel-janitors@lists.osdl.org>,
	lkml <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patchset of 171 patches is at http://coderock.org/kj/2.6.10-bk13-kj/

Quick patch summary: about 30 new, 30 merged, 30 dropped.
Seems like most external trees are merged in -linus, so i'll start
(re)sending old patches.


new in this release:
--------------------
msleep-drivers_atm_ambassador.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [UPDATE PATCH] atm/ambassador: use msleep() instead of 	schedule_timeout()

msleep-drivers_ide_ide-cd.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [UPDATE PATCH] ide/ide-cd: use ssleep() instead of 	schedule_timeout()

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

vfree-arch_ia64_sn_kernel_sn2_sn_hwperf.patch
  From: jlamanna@gmail.com
  Subject: [KJ] [PATCH] [RESEND] [11/29] sn_hwperf.c - vfree() checking 	cleanups

vfree-arch_s390_kernel_module.patch
  From: jlamanna@gmail.com
  Subject: [KJ] [PATCH] [RESEND] [18/29] module.c - vfree() checking cleanups

vfree-drivers_atm_idt77252.patch
  From: jlamanna@gmail.com
  Subject: [KJ] [PATCH] [RESEND] [26/29] idt77252.c - vfree() checking cleanups

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

vfree-drivers_usb_media_ov511.patch
  From: jlamanna@gmail.com
  Subject: [KJ] [PATCH] [RESEND] [25/29] ov511.c - vfree() checking cleanups

vfree-drivers_video_sis_sis_main.patch
  From: jlamanna@gmail.com
  Subject: [KJ] [PATCH] [RESEND] [22/29] sis_main.c - vfree() checking cleanups

vfree-fs_reiserfs_super.patch
  From: jlamanna@gmail.com
  Subject: [KJ] [PATCH] [RESEND] [19/29] super.c - vfree() checking cleanups

vfree-mm_swapfile.patch
  From: jlamanna@gmail.com
  Subject: [KJ] [PATCH] [RESEND] [17/29] swapfile.c - vfree() checking cleanups

vfree-net_bridge_netfilter_ebtables.patch
  From: jlamanna@gmail.com
  Subject: [KJ] [PATCH] [RESEND] [14/29] ebtables.c - vfree() checking cleanups

vfree-sound_oss_gus_wave.patch
  From: jlamanna@gmail.com
  Subject: [KJ] [PATCH] [RESEND] [21/29] gus_wave.c - vfree() checking cleanups

vfree-sound_oss_pss.patch
  From: jlamanna@gmail.com
  Subject: [KJ] [PATCH] [RESEND] [29/29] pss.c - vfree() checking cleanups

kj_tag.patch
  -kj



merged:
-------
msleep-drivers_mtd_chips_amd_flash
msleep-drivers_mtd_chips_cfi_cmdset_0002
msleep-drivers_mtd_chips_cfi_cmdset_0020
for-each-pci-dev-drivers_char_agp_generic
for-each-pci-dev-drivers_char_agp_isoch
msleep-drivers_scsi_ibmvscsi
msleep_interruptible-drivers_net_e1000_e1000_ethtool
msleep+msleep_interruptible-drivers_net_e100
pci_get_device-drivers_char_agp_amd64-agp
pci_get_device-drivers_char_agp_intel-agp
pci_get_device-drivers_char_agp_intel-mch-agp
kconfig-arch_sh_drivers_pci
msleep-sound_sparc_cs4231
typo-sound_isa_es18xx.c
typos-arch_ppc_platforms_prep_setup.c
typo-arch_ppc_syslib_ppc4xx_dma.c
typo-arch_sh_boards_renesas_hs7751rvoip_io.c
typo-drivers_char_ipmi_ipmi_si_intf.c
typo-drivers_net_wireless_wavelan_cs.c
typo-drivers_usb_net_usbnet.c
typo-sound_isa_cs423x_cs4231_lib.c
typo_au1000-arch_mips
remove_file-fs_jfs_jfs_defragfs.h
remove_file-include_asm_arm26_ian_char.h
remove_file-include_sound_soundmem.h
remove_file-net_sunrpc_auth_gss_gss_pseudoflavors.c
remove_file-net_sunrpc_auth_gss_sunrpcgss_syms.c
remove_file-sound_core_seq_oss_seq_oss_misc.c


dropped:
--------
remove_file-arch_alpha_lib_dbg_stackcheck.S
remove_file-arch_alpha_lib_dbg_stackkill.S
remove_file-arch_alpha_lib_stacktrace.c
  useful for debugging

remove_file-arch_m68knommu_platform_68EZ328_ucsimm_crt0_himem.S.patch
  already deleted

remove_file-arch_m68knommu_platform_68VZ328_ucdimm_crt0_himem.S.patch
  reworked, so no longer unused

remove_file-drivers_net_gt64240eth.h
  will be used

remove_file-drivers_video_riva_nv4ref.h
  documentation

remove_file-include_asm_alpha_numnodes.h
  bogus patch

remove_file-include_asm_um_arch_signal_i386.h
remove_file-include_asm_um_archparam_i386.h
remove_file-include_asm_um_archparam_ppc.h
remove_file-include_asm_um_module_generic.h
remove_file-include_asm_um_module_i386.h
remove_file-include_asm_um_processor_i386.h
remove_file-include_asm_um_processor_ppc.h
remove_file-include_asm_um_ptrace_i386.h
remove_file-include_asm_um_sigcontext_i386.h
remove_file-include_asm_um_sigcontext_ppc.h
remove_file-include_asm_um_system_i386.h
remove_file-include_asm_um_system_ppc.h
  are used (symlinks)

remove_file-include_linux_byteorder_pdp_endian.h
  completes the set of endian types

remove_file-sound_pci_cs46xx_imgs_cwcemb80.h
  this dsp image could still be used

remove_file-drivers_video_aty_xlinit.c
  used in -mm

msleep-drivers_mtd_chips_cfi_cmdset_0001
  not needed anymore

msleep-drivers_net_e1000_e1000_osdep
  merged

msleep_interruptible-drivers_net_gt96100eth
  a version of it merged

module_parm-net_ne2k-pci
module_parm-net_wireless_atmel_cs
module_parm-net_wireless_orinoco
module_parm-net_wireless_wavelan.p.h
module_parm-net_wireless_wl3501_cs
module_param-drivers_net_3c59x.c
  similar patch merged

strlcpy-net_wireless_wavelan
  similar patch merged

cleanup-drivers_media_radio_radio-sf16fmi.c
  needs reworking



all patches:
------------
remove-old-ifdefs-aic7xxx_osm_pci.patch
min-max-ide_ide-timing.h.patch
list-for-each-entry-drivers_chan_kern.patch
list-for-each-entry-drivers_macintosh_via-pmu.patch
list-for-each-entry-drivers_net_ppp_generic.patch
list-for-each-entry-fs_jffs_intrep.patch
list-for-each-entry-fs_namespace.patch
list-for-each-entry-safe-arch_i386_mm_pageattr.patch
list-for-each-entry-safe-fs_coda_psdev.patch
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
msleep_interruptible-drivers_base_dmapool.patch
msleep_interruptible-drivers_block_cciss.patch
msleep_interruptible-drivers_block_pcd.patch
msleep_interruptible-drivers_block_pf.patch
msleep_interruptible-drivers_block_pg.patch
msleep_interruptible-drivers_block_pt.patch
msleep_interruptible-drivers_cdrom_sonycd535.patch
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
msleep-drivers_scsi_ide-scsi.patch
msleep-drivers_scsi_imm.patch
msleep-drivers_scsi_osst.patch
msleep-drivers_scsi_ppa.patch
msleep-drivers_scsi_qla1280.patch
msleep_interruptible-drivers_net_irda_tekram-sir.patch
msleep_interruptible-drivers_net_ixgb_ixgb_ethtool.patch
msleep_interruptible-drivers_net_pcnet32.patch
msleep_interruptible-drivers_net_sb1000.patch
msleep_interruptible-drivers_net_slip.patch
msleep_interruptible-drivers_net_wan_cycx_drv.patch
msleep_interruptible-drivers_parport_ieee1284_ops.patch
msleep_interruptible-drivers_parport_ieee1284.patch
msleep_interruptible-drivers_parport_parport_pc.patch
msleep_interruptible-drivers_s390_net_ctctty.patch
msleep_interruptible-drivers_sbus_char_aurora.patch
msleep_interruptible-drivers_sbus_char_envctrl.patch
msleep_interruptible-drivers_scsi_dpt_i2o.patch
msleep_interruptible-drivers_scsi_st.patch
msleep_interruptible-drivers_tc_zs.patch
msleep+msleep_interruptible-drivers_net_tokenring_ibmtr.patch
msleep+ssleep-drivers_net_appletalk_ltpc.patch
pci_dev_present-arch_ia64_hp_common_sba_iommu.patch
pci_dev_present-arch_ia64_pci_pci.patch
pci_dev_present-drivers_ide_pci_alim15x3.patch
remove-pci-find-device-arch_sparc64_kernel_ebus.patch
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
msleep_interruptible-drivers_cdrom_sonycd535_2.patch
msleep_interruptible-drivers_message_fusion_mptbase.patch
msleep_interruptible-drivers_net_ewrk3.patch
reorder-state-drivers_char_snsc.patch
reorder-state-drivers_video_pxafb.patch
reorder-state-drivers_video_sa1100fb.patch
set_current_state-drivers_input_joystick_iforce_iforce-packets.patch
ssleep-drivers_scsi_qla2xxx_qla_os.patch
docs-fs_super.patch
docs-kernel_sysctl.patch
kconfig-arch_sparc64.patch
myri_code_cleanup.patch
printk-drivers-scsi-zalon.patch
comment-drivers_block_floppy.c.patch
schedule_cleanup-drivers_usb_class_usblp.c.patch
typo-arch_ppc64_kernel_rtasd.c.patch
remove_file-arch_arm26_boot_compressed_hw_bse.c.patch
remove_file-arch_m68k_apollo_dn_debug.c.patch
remove_file-arch_m68k_sun3x_sun3x_ksyms.c.patch
remove_file-arch_mips_arc_salone.c.patch
remove_file-arch_mips_pmc_sierra_yosemite_ht_irq.c.patch
remove_file-arch_ppc64_boot_no_initrd.c.patch
remove_file-arch_ppc_kernel_find_name.c.patch
remove_file-arch_ppc_syslib_ppc4xx_pm.c.patch
remove_file-arch_ppc_syslib_ppc4xx_serial.c.patch
remove_file-arch_sh64_lib_old_checksum.c.patch
remove_file-arch_um_include_umn.h.patch
remove_file-arch_x86_64_lib_old_checksum.c.patch
remove_file-drivers_char_hp600_keyb.c.patch
remove_file-drivers_char_rio_cdproto.h.patch
remove_file-drivers_char_rsf16fmi.h.patch
remove_file-drivers_parport_parport_arc.c.patch
remove_file-drivers_pcmcia_au1000_generic.c.patch
remove_file-drivers_pcmcia_au1000_pb1x00.c.patch
remove_file-drivers_scsi_dpt_dpt_osdutil.h.patch
remove_file-fs_jffs2_histo.h.patch
remove_file-include_asm_arm_arch_epxa10db_mode_ctrl00.h.patch
remove_file-include_asm_arm_arch_epxa10db_pld_conf00.h.patch
remove_file-include_asm_arm_hardware_linkup_l1110.h.patch
remove_file-include_asm_m68k_atari_SCCserial.h.patch
remove_file-include_asm_m68knommu_io_hw_swap.h.patch
remove_file-include_asm_m68knommu_semp3.h.patch
remove_file-include_asm_mips_gfx.h.patch
remove_file-include_asm_mips_it8172_it8172_lpc.h.patch
remove_file-include_asm_mips_mach_au1x00_au1100_mmc.h.patch
remove_file-include_asm_mips_mipsprom.h.patch
remove_file-include_asm_mips_ng1.h.patch
remove_file-include_asm_mips_ng1hw.h.patch
remove_file-include_asm_mips_riscos_syscall.h.patch
remove_file-include_asm_parisc_bootdata.h.patch
remove_file-include_asm_ppc64_iSeries_iSeries_fixup.h.patch
remove_file-include_linux_netfilter_ipv4_ip_logging.h.patch
remove_file-include_linux_netfilter_ipv6_ip6_logging.h.patch
remove_file-include_linux_umsdos_fs_i.h.patch
remove_file-sound_oss_maestro_tables.h.patch
cleanup-drivers_media_radio_miropcm20-radio.c.patch
cleanup-drivers_atm_he.c.patch
array_size-fs_proc_base.c.bak.patch
remove_sprintf-fs_proc_proc_tty.c.bak.patch
msleep-drivers_atm_ambassador.patch
msleep-drivers_ide_ide-cd.patch
msleep-drivers_ieee1394_sbp2.patch
msleep-drivers_net_cs89x0.patch
msleep-drivers_net_wan_cosa.patch
msleep_ssleep-drivers_net_wireless_airo.patch
typo_suppport-bttv_dvb.patch
vfree-arch_ia64_sn_kernel_sn2_sn_hwperf.patch
vfree-arch_s390_kernel_module.patch
vfree-drivers_atm_idt77252.patch
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
vfree-drivers_usb_media_ov511.patch
vfree-drivers_video_sis_sis_main.patch
vfree-fs_reiserfs_super.patch
vfree-mm_swapfile.patch
vfree-net_bridge_netfilter_ebtables.patch
vfree-sound_oss_gus_wave.patch
vfree-sound_oss_pss.patch
kj_tag.patch
