Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbVCRTxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbVCRTxo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 14:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbVCRTxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 14:53:44 -0500
Received: from coderock.org ([193.77.147.115]:25221 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262062AbVCRTsz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 14:48:55 -0500
Date: Fri, 18 Mar 2005 20:48:31 +0100
From: Domen Puncer <domen@coderock.org>
To: kj <kernel-janitors@lists.osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: 2.6.12-rc1-kj
Message-ID: <20050318194831.GA20291@nd47.coderock.org>
Mail-Followup-To: kj <kernel-janitors@lists.osdl.org>,
	lkml <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A new release from kernel janitors (http://janitor.kernelnewbies.org/).

206 patches in this release.
88 patches were merged since 2.6.11-kj! Thanks to all maintainers!

Patchset is at http://coderock.org/kj/2.6.12-rc1-kj/


new in this release:
--------------------
dma_mask-drivers_net.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: drivers/net/: Use the DMA_{64,32}BIT_MASK constants

dma_mask-drivers_scsi.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: drivers/scsi/: Use the DMA_{64,32}BIT_MASK constants

printk-drivers_video.patch
  From: James Nelson <james4765@cwazy.co.uk>
  Subject: drivers/video/: Clean up printk()'s

msleep-arch_m68k_atari_time.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [UPDATE PATCH] m68k/time: replace schedule_timeout() with 	msleep_interruptible()

msleep-drivers_acpi_osl.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [UPDATE PATCH] acpi/osl: correct HZ dependencies

msleep-drivers_block_paride_pg.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] paride/pg: replace pg_sleep() with msleep()

msleep-drivers_block_swim_iop.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] block/swim_iop: replace schedule_timeout() with 	msleep_interruptible()

wait_event-drivers_char_drm_drm_os_linux.h.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] drm/drm_os_linux: use 	wait_event_interruptible_timeout()

msleep-drivers_char_ds1620.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] char/ds1620: use msleep() instead of schedule_timeout()

msleep-drivers_char_tty_io.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] char/tty_io: replace schedule_timeout() with 	msleep_interruptible()

msleep-drivers_serial_68360serial.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] serial/68360serial: replace schedule_timeout() with 	msleep_interruptible()

msleep-drivers_serial_68328serial.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] serial/68328serial: replace schedule_timeout() with 	msleep_interruptible()

msleep_interruptible_comment-kernel_timer.patch
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [KJ] [PATCH] kernel/timer: fix msleep_interruptible() comment

return_code-drivers_telephony_ixj.patch
  From: "Stephen Biggs" <yrgrknmxpzlk@gawab.com>
  Subject: [KJ] [UPDATED PATCH] ixj* - compile warning cleanup

whitespace-arch_i386_boot_bootsect.S.patch
  From: Daniel Dickman <didickman@yahoo.com>
  Subject: [KJ] [PATCH 2.6.11-bk1] CodingStyle: trivial whitespace fixups

dma_mask-drivers_ide_pci_cs5520.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] Re: [PATCH UPDATE] drivers/ide/cs5520.c : Use the DMA_{64, 	32}BIT_MASK constants

typo-include_linux_mm.h.patch
  From: Martin Hicks <mort@wildopensource.com>
  Subject: [KJ] [PATCH/2.6.11] Spelling cleanups in shrinker code

sparse-init_do_mounts_initrd.patch
  From: Alexey Dobriyan <adobriyan@mail.ru>
  Subject: [KJ] [PATCH 1/] init/do_mounts_initrd.c: fix sparse warning

sparse-arch_i386_kernel_traps.patch
  From: Alexey Dobriyan <adobriyan@mail.ru>
  Subject: [KJ] [PATCH 2/] arch/i386/kernel/traps.c: fix sparse warnings

sparse-arch_i386_kernel_apm.patch
  From: Alexey Dobriyan <adobriyan@mail.ru>
  Subject: [KJ] [PATCH 3/] arch/i386/kernel/apm.c: fix sparse warnings

sparse-arch_i386_mm_fault.patch
  From: Alexey Dobriyan <adobriyan@mail.ru>
  Subject: [KJ] [PATCH 4/] arch/i386/mm/fault.c: fix sparse warnings

sparse-arch_i386_crypto_aes.patch
  From: Alexey Dobriyan <adobriyan@mail.ru>
  Subject: [KJ] [PATCH 5/] arch/i386/crypto/aes.c: fix sparse warnings

sparse-fs_cifs_cifssmb.patch
  From: Alexey Dobriyan <adobriyan@mail.ru>
  Subject: [KJ] [PATCH 6/] __le'ify posix_acl_xattr_entry, 	posix_acl_xattr_header

sparse-fs_affs_super.patch
  From: Alexey Dobriyan <adobriyan@mail.ru>
  Subject: [KJ] [PATCH 7/] fs/affs/super.c: fix sparse warning

sparse-fs_befs_endian.h.patch
  From: Alexey Dobriyan <adobriyan@mail.ru>
  Subject: [KJ] [PATCH 8/] fs/befs/endian.h: fix sparse warnings

sparse-fs_cifs_cifssmb-2.patch
  From: Alexey Dobriyan <adobriyan@mail.ru>
  Subject: [KJ] [PATCH 9/] fs/cifs/cifssmb.c: fix the rest of sparse warnings

sparse-security_selinux_ss_policydb.patch
  From: Alexey Dobriyan <adobriyan@mail.ru>
  Subject: [KJ] [PATCH] security/selinux/ss/policydb.c: fix sparse warnings

sparse-fs_cifs_netmisc.patch
  From: Alexey Dobriyan <adobriyan@mail.ru>
  Subject: [KJ] [PATCH] fs/cifs/netmisc.c: fix sparse warning

sparse-fs_ext3_super.patch
  From: Alexey Dobriyan <adobriyan@mail.ru>
  Subject: [KJ] [PATCH] fs/ext3/super.c: fix sparse warnings

sparse-fs_ext3_resize.patch
  From: Alexey Dobriyan <adobriyan@mail.ru>
  Subject: [KJ] [PATCH] fs/ext3/resize.c: fix sparse warnings

sparse-fs_hpfs_inode.patch
  From: Alexey Dobriyan <adobriyan@mail.ru>
  Subject: [KJ] [PATCH] fs/hpfs/inode.c: fix sparse warnings

sparse-fs_qnx4_dir.patch
  From: Alexey Dobriyan <adobriyan@mail.ru>
  Subject: [KJ] [PATCH] fs/qnx4/*: fix sparse warnings

sparse-include_linux_smb_fs.h.patch
  From: Alexey Dobriyan <adobriyan@mail.ru>
  Subject: [KJ] [PATCH] fs/smbfs/*: fix sparse warnings

sparse-security_selinux_ss_ebitmap.patch
  From: Alexey Dobriyan <adobriyan@mail.ru>
  Subject: [KJ] [PATCH] security/selinux/ss/ebitmap.c: fix sparse warnings

sparse-security_selinux_ss_avtab.patch
  From: Alexey Dobriyan <adobriyan@mail.ru>
  Subject: [KJ] [PATCH] security/selinux/ss/avtab.c: fix sparse warnings

sparse-security_selinux_ss_conditional.patch
  From: Alexey Dobriyan <adobriyan@mail.ru>
  Subject: [KJ] [PATCH] security/selinux/ss/conditional.c: fix sparse warnings

sparse-crypto_sha256.patch
  From: Alexey Dobriyan <adobriyan@mail.ru>
  Subject: [KJ] [PATCH] crypto/sha256.c: fix sparse warnings

sparse-crypto_sha512.patch
  From: Alexey Dobriyan <adobriyan@mail.ru>
  Subject: [KJ] [PATCH] crypto/sha512.c: fix sparse warnings

sparse-crypto_blowfish.patch
  From: Alexey Dobriyan <adobriyan@mail.ru>
  Subject: [KJ] [PATCH] crypto/blowfish.c: fix sparse warnings

sparse-crypto_tea.patch
  From: Alexey Dobriyan <adobriyan@mail.ru>
  Subject: [KJ] [PATCH] crypto/tea.c: fix sparse warnings

sparse-drivers_atm_zatm.patch
  From: Alexey Dobriyan <adobriyan@mail.ru>
  Subject: [KJ] [PATCH] drivers/atm/zatm.c: fix sparse warning

sparse-drivers_atm_nicstar.patch
  From: Alexey Dobriyan <adobriyan@mail.ru>
  Subject: [KJ] [PATCH] drivers/atm/nicstar.c: fix some sparse warnings

sparse-drivers_atm_ambassador.patch
  From: Alexey Dobriyan <adobriyan@mail.ru>
  Subject: [KJ] [PATCH] drivers/atm/ambassador.c: fix sparse warnings

dma_mask-drivers_scsi_lasi700.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [PATCH] drivers/scsi/lasi700.c: Use the DMA_32BIT_MASK constant

printk-arch_ia64_kernel_smp.patch
  From: Christophe Lucas <clucas@rotomalug.org>
  Subject: [KJ] [PATCH] printk : arch/ia64/kernel/smp.c

printk-drivers_char_watchdog_wdt285.patch
  From: Christophe Lucas <clucas@rotomalug.org>
  Subject: [KJ] [PATCH] printk : drivers/char/watchdog/wdt285.c

dma_mask-drivers_ieee1394_pcilynx.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [UPDATE PATCH] drivers/ieee1394/pcilynx.c: Use the 	DMA_32BIT_MASK constant

dma_mask-drivers_media_video_bttv-driver.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [UPDATE PATCH] drivers/media/video/bttv-driver.c: Use the 	DMA_32BIT_MASK constant

dma_mask-drivers_message_fusion_mptbase.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [UPDATE PATCH] drivers/message/fusion/mptbase.c: Use the 	DMA_{64, 32}BIT_MASK constants

dma_mask-drivers_block_cciss.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [UPDATE PATCH 1/3] drivers/block/cciss.c: Use the DMA_{64, 	32}BIT_MASK constants

dma_mask-drivers_block_sx8.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [UPDATE PATCH 2/3] drivers/block/sx8.c: Use the DMA_{64, 	32}BIT_MASK constants

dma_mask-drivers_block_umem.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [UPDATE PATCH 3/3] drivers/block/umem.c: Use the DMA_{64, 	32}BIT_MASK constants

dma_mask-drivers_media_video_meye.patch
  From: Tobias Klauser <tklauser@nuerscht.ch>
  Subject: [KJ] [UPDATE PATCH] drivers/media/video/meye.c: Use the 	DMA_32BIT_MASK constant

list_for_each-drivers_macintosh_via-pmu.patch
  From: Domen Puncer <domen@coderock.org>
  Subject: Re: [Fwd: [patch 1/3] list_for_each_entry: drivers-macintosh-via-pmu.c]

kj_tag.patch
  -kj



merged:
-------
list-for-each-entry-drivers_chan_kern
list-for-each-entry-safe-arch_i386_mm_pageattr
msleep_interruptible-drivers_macintosh_mediabay
msleep-drivers_media_radio_radio-zoltrix
msleep-drivers_net_irda_act200l-sir
msleep-drivers_net_irda_irtty-sir
msleep-drivers_net_irda_ma600-sir
msleep-drivers_net_irda_pcmcia_xirc2ps_cs
msleep-drivers_net_irda_sir_dev
msleep-drivers_net_ni65
msleep-drivers_net_ns83820
msleep_interruptible-drivers_net_irda_tekram-sir
msleep_interruptible-drivers_tc_zs
remove-pci-find-device-drivers_net_tg3
fix-comment-fs_jbd_journal
msleep_interruptible-drivers_net_ewrk3
reorder-state-drivers_char_snsc
docs-fs_super
remove_file-arch_sh64_lib_old_checksum.c
remove_file-drivers_char_hp600_keyb.c
remove_file-sound_oss_maestro_tables.h
cleanup-drivers_media_radio_miropcm20-radio.c
msleep-drivers_net_cs89x0
msleep-drivers_net_wan_cosa
typo_suppport-bttv_dvb
vfree-drivers_ieee1394_dma
vfree-drivers_media_dvb_ttpci_budget-core
vfree-drivers_media_video_stradis
vfree-sound_oss_gus_wave
extern-include_linux_generic_serial.h.old
msleep-drivers_net_s2io
msleep-drivers_serial_crisv10
msleep-drivers_usb_serial_cypress_m8
msleep-fs_jfs_jfs_logmgr
msleep-fs_nfsd_vfs
msleep_interruptible-drivers_w1_w1_therm
msleep_interruptible-sound_isa_gus_gus_reset
set_current_state-drivers_char_ftape_lowlevel_fdc-io
set_current_state-sound_isa_gus_gus_pcm
set_current_state-sound_isa_wavefront_wavefront_synth
ssleep-arch_i386_kernel_traps
ssleep-drivers_message_fusion_mptbase
unused_pointer-sound_usb_usx2y_usbusx2yaudio
wait_event_timeout-drivers_usb_image_mdc800
wait_event_timeout-drivers_usb_input_ati_remote
wait_event_timeout-drivers_usb_misc_auerswald
wait_event_timeout-drivers_usb_net_kaweth
kill_kernel_parameter-sf16fm
int_sleep_on-drivers_char_istallion
int_sleep_on-drivers_media_video_planb
int_sleep_on-drivers_media_video_zoran_device
int_sleep_on-drivers_media_video_zoran_driver
int_sleep_on-drivers_media_video_zr36120
spin_lock_init-include_linux_wait.h
wait_event_int_timeout-sound_core_rawmidi
dma_mask-drivers_atm_lanai
int_sleep_on-drivers_char_lp
int_sleep_on-drivers_media_video_zoran_card
pci_register_driver-drivers_atm
pci_register_driver-drivers_eisa
pci_register_driver-drivers_input_gameport
pci_register_driver-drivers_input_serio
pci_register_driver-drivers_isdn_hardware_avm
pci_register_driver-drivers_macintosh_macio_asic
pci_register_driver-drivers_media_video_cx88
pci_register_driver-drivers_message_fusion
pci_register_driver-drivers_pci_pcie
pci_register_driver-drivers_pcmcia
pci_register_driver-drivers_w1
sleep_on-drivers_media_video_saa7110
strtok-scripts_mod_sumversion
unused_variable-drivers_char_mxser
dma_mask-drivers_scsi_ahci
dma_mask-drivers_scsi_sata_vsc
pci_register_driver-drivers_char_watchdog
pci_register_driver-drivers_parisc
pci_register_driver-drivers_scsi_sym53c8xx_2
ssleep-drivers_net_wireless_orinoco_plx
ssleep-drivers_net_wireless_orinoco_tmd
msleep_ssleep-drivers_net_wireless_airo
vfree-drivers_char_agp_generic
msleep-fs_cifs_transport
msleep_interruptible-drivers_char_sx
msleep_interruptible-drivers_scsi_st
spin_lock_init-arch_um_drivers_port_kern
ssleep-fs_nfsd_nfs4callback
ssleep-sound_isa_sb_emu8000
pci_register_driver-drivers_char_agp


dropped:
--------
wait_event-arch_m68k_atari_stdma.patch
wait_event-drivers_block_amiflop.patch
wait_event-drivers_block_ataflop.patch
wait_event-drivers_scsi_atari_scsi.patch
wait_event_int-drivers_block_swim_iop.patch
wait_event-drivers_acorn_block_fd1772.patch
wait_event_int-drivers_block_swim3.patch
int_sleep_on-drivers_cdrom_cdu31a.patch
  wait_event with interrupts disabled
extinguish_warnings-include_linux_module.h.patch
  similar already in Sam's tree
return_code-arch_i386_math-emu.patch
  could potentialy cause subtle breakage (it did before)
return_code-sound_oss_emu10k1.patch
  needs printk_ratelimit, and some CodingStyle fixes
pci_register_driver-drivers_block.patch
  needs splitting, umem.c part could return retval
list-for-each-drivers_net_ipv6_ip6_fib.patch
  not quite right; superseeded by another patch
vfree-drivers_media_dvb_ttpci_av7110.patch
vfree-drivers_media_dvb_ttpci_av7110_ipack.patch
  obsolete
msleep-fs_xfs_linux-2.6_xfs_buf.patch
msleep_interruptible-fs_xfs_linux-2.6_xfs_super.patch
  wrong - msleep and waitqueues don't mix
wait_event_int_timeout-drivers_input_joystick_iforce_iforce-packets.patch
  some issues
return_code-net_ipv6_ip6_flowlabel.patch
  wrong
remove_file-arch_ppc_kernel_find_name.c.patch
  developers' aid
pci_register_driver-drivers_net_wireless_prism54.patch
pci_register_driver-drivers_scsi.patch
pci_register_driver-drivers_scsi_aacraid.patch
pci_register_driver-drivers_scsi_aic7xxx.patch
pci_register_driver-drivers_scsi_megaraid.patch
pci_register_driver-drivers_scsi_qla2xxx.patch
  are not 2.4 compatible
msleep-drivers_scsi_osst.patch
  reworked*
int_sleep_on-drivers_usb_class_usb-midi.patch
  issues
schedule_cleanup-drivers_usb_class_usblp.c.patch
wait_event_int_t-drivers_usb_class_usblp.patch
  these two need to be combined*
wait_event_timeout-drivers_char_hvsi.patch
  rowerked*
task_unint-drivers_base_dmapool.patch
  dropped
vfree-drivers_isdn_i4l_isdn_bsdcomp.patch
  maintainer doesn't like it
pci_register_driver-drivers_isdn_tpam.patch
  obsolete, tpam is to be removed
docs-kernel_sysctl.patch
  probably need to be reworked*
msleep-drivers_block_paride_pg
set_current_state-drivers_block_swim_iop.patch
  nacc made better patch
set_current_state-drivers_block_swim3.patch
  msleep_interruptible-drivers_block_swim3.patch removes the code it patches
list-for-each-entry-drivers_macintosh_via-pmu.patch
  failed compile test :-(


all patches:
------------
min-max-ide_ide-timing.h.patch
list-for-each-entry-drivers_net_ppp_generic.patch
list-for-each-entry-fs_jffs_intrep.patch
list-for-each-entry-fs_namespace.patch
list-for-each-entry-safe-fs_dquot.patch
list-for-each-fs_dcache.patch
msleep-drivers_ide_ide-tape.patch
pr_debug-drivers_block_umem.patch
list-for-each-drivers_net_tulip_de4x5.patch
min-max-arch_sh_boards_bigsur_io.patch
min-max-arch_sh_cchips_hd6446x_hd64465_io.patch
msleep-drivers_block_xd.patch
msleep-drivers_ide_ide-cs.patch
add_module_version-drivers_net_8139cp.patch
for-each-pci-dev-arch_i386_pci_acpi.patch
for-each-pci-dev-arch_i386_pci_i386.patch
function-string-arch-mips.patch
msleep-drivers_net_3c505.patch
msleep-drivers_net_ixgb_ixgb_osdep.patch
msleep-drivers_net_wireless_prism54_islpci_dev.patch
msleep_interruptible-drivers_net_ixgb_ixgb_ethtool.patch
msleep_interruptible-drivers_net_pcnet32.patch
msleep_interruptible-drivers_net_wan_cycx_drv.patch
msleep_interruptible-drivers_parport_ieee1284_ops.patch
msleep_interruptible-drivers_parport_ieee1284.patch
msleep_interruptible-drivers_parport_parport_pc.patch
msleep_interruptible-drivers_s390_net_ctctty.patch
msleep_interruptible-drivers_sbus_char_aurora.patch
msleep+msleep_interruptible-drivers_net_tokenring_ibmtr.patch
msleep+ssleep-drivers_net_appletalk_ltpc.patch
pci_dev_present-drivers_ide_pci_alim15x3.patch
remove-pci-find-device-drivers_net_e1000_e1000_main.patch
remove-pci-find-device-drivers_net_gt96100eth.patch
remove-pci-find-device-drivers_net_ixgb_ixgb_main.patch
set_current_state-drivers_net_irda_stir4200.patch
set_current_state-drivers_net_tokenring_tms380tr.patch
set_current_state-drivers_net_wan_farsync.patch
ssleep+msleep_interruptible-drivers_net_tokenring_lanstreamer.patch
lib-parser-fs_devpts_inode.patch
ssleep-drivers_scsi_qla2xxx_qla_os.patch
myri_code_cleanup.patch
printk-drivers-scsi-zalon.patch
comment-drivers_block_floppy.c.patch
remove_file-arch_arm26_boot_compressed_hw_bse.c.patch
remove_file-arch_mips_arc_salone.c.patch
remove_file-arch_mips_pmc_sierra_yosemite_ht_irq.c.patch
remove_file-arch_ppc64_boot_no_initrd.c.patch
remove_file-arch_ppc_syslib_ppc4xx_pm.c.patch
remove_file-arch_ppc_syslib_ppc4xx_serial.c.patch
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
msleep-drivers_ieee1394_sbp2.patch
vfree-drivers_char_agp_backend.patch
vfree-drivers_media_dvb_dvb-core_dmxdev.patch
vfree-drivers_media_dvb_dvb-core_dvb_ca_en50221.patch
vfree-drivers_scsi_qla2xxx_qla_os.patch
vfree-drivers_video_sis_sis_main.patch
vfree-fs_reiserfs_super.patch
vfree-net_bridge_netfilter_ebtables.patch
msleep-arch_arm_mach-sa1100_cpu-sa1110.patch
msleep-drivers_block_cciss.patch
msleep-drivers_block_paride_pf.patch
msleep-drivers_block_xd2.patch
msleep-drivers_cdrom_sonycd535.patch
msleep-drivers_net_slip.patch
msleep-drivers_scsi_ide-scsi.patch
msleep-fs_smbfs_proc.patch
msleep-net_appletalk_aarp.patch
msleep-net_sunrpc_svcsock.patch
msleep_interruptible-drivers_block_swim3.patch
msleep_interruptible-drivers_sbus_char_envctrl.patch
msleep_interruptible-fs_lockd_clntproc.patch
msleep_ssleep-drivers_block_paride_pcd.patch
msleep_ssleep-drivers_block_paride_pt.patch
remove_duplicate_delay-drivers_net_sk98lin_skethtool.patch
return_code-drivers_ide_pci_cs5520.patch
ssleep-drivers_net_sb1000.patch
ssleep-drivers_scsi_qla1280.patch
ssleep-kernel_power_smp.patch
wait_event-drivers_block_ps2esdi.patch
int_sleep_on-arch_cris_arch-v10_drivers_eeprom.patch
int_sleep_on-drivers_ieee1394_video1394.patch
int_sleep_on-drivers_isdn_capi_capi.patch
int_sleep_on-drivers_isdn_i4l_isdn_common.patch
int_sleep_on-drivers_net_tokenring_lanstreamer.patch
lindent-arch_ppc_4xx_io_serial_sicc.patch
printk-drivers_acorn_block_fd1772.patch
printk-drivers_acorn_block_mfmhd.patch
sleep_on-drivers_block_xd.patch
sleep_on-drivers_cdrom_aztcd.patch
sleep_on-drivers_cdrom_mcd.patch
sleep_on-drivers_cdrom_sjcd.patch
sleep_on-drivers_net_shaper.patch
sleep_on-drivers_sbus_char_bpp.patch
sleep_on-drivers_sbus_char_vfc_i2c.patch
wait_event_int-drivers_block_acsi_slm.patch
wait_event_int_timeout-drivers_block_DAC960.patch
defines-drivers_scsi_FlashPoint.patch
dma_mask-drivers_net_tokenring_lanstreamer.patch
dma_mask-drivers_net_wireless_prism54_islpci_hotplug.patch
int_sleep_on-arch_mips_sibyte_sb1250_bcm1250_tbprof.patch
int_sleep_on-drivers_i2c_busses_i2c-elektor.patch
int_sleep_on-drivers_i2c_busses_i2c-ite.patch
int_sleep_on-drivers_net_8139too.patch
int_sleep_on-drivers_net_tokenring_ibmtr.patch
int_sleep_on-drivers_usb_misc_rio500.patch
int_sleep_on-drivers_usb_serial_digi_acceleport.patch
int_sleep_on-fs_lockd_svc.patch
pci_register_driver-drivers_ide.patch
pci_register_driver-drivers_ieee1394.patch
pci_register_driver-drivers_media_common_saa7146_core.patch
pci_register_driver-drivers_media_dvb_b2c2_skystar2.patch
pci_register_driver-drivers_media_dvb_bt8xx_bt878.patch
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
pci_register_driver-drivers_parport.patch
pci_register_driver-drivers_video.patch
pci_register_driver-drivers_video_aty.patch
pci_register_driver-drivers_video_console.patch
pci_register_driver-drivers_video_intelfb.patch
pci_register_driver-drivers_video_kyro.patch
pci_register_driver-drivers_video_sis.patch
printk-drivers_video_tridentfb.patch
return_code-drivers_ide.patch
return_code-drivers_isdn_hisax.patch
return_code-drivers_isdn_i4l.patch
return_code-drivers_isdn_pcbit.patch
return_code-drivers_usb_image.patch
sleep_on-fs_lockd_clntlock.patch
sleep_on-net_sunrpc_clnt.patch
int_sleep_on-drivers_cdrom_mcdx.patch
unused_define-drivers_block_floppy.patch
dma_mask-drivers_net.patch
dma_mask-drivers_scsi.patch
printk-drivers_video.patch
msleep-arch_m68k_atari_time.patch
msleep-drivers_acpi_osl.patch
msleep-drivers_block_paride_pg.patch
msleep-drivers_block_swim_iop.patch
wait_event-drivers_char_drm_drm_os_linux.h.patch
msleep-drivers_char_ds1620.patch
msleep-drivers_char_tty_io.patch
msleep-drivers_serial_68360serial.patch
msleep-drivers_serial_68328serial.patch
msleep_interruptible_comment-kernel_timer.patch
return_code-drivers_telephony_ixj.patch
whitespace-arch_i386_boot_bootsect.S.patch
dma_mask-drivers_ide_pci_cs5520.patch
typo-include_linux_mm.h.patch
sparse-init_do_mounts_initrd.patch
sparse-arch_i386_kernel_traps.patch
sparse-arch_i386_kernel_apm.patch
sparse-arch_i386_mm_fault.patch
sparse-arch_i386_crypto_aes.patch
sparse-fs_cifs_cifssmb.patch
sparse-fs_affs_super.patch
sparse-fs_befs_endian.h.patch
sparse-fs_cifs_cifssmb-2.patch
sparse-security_selinux_ss_policydb.patch
sparse-fs_cifs_netmisc.patch
sparse-fs_ext3_super.patch
sparse-fs_ext3_resize.patch
sparse-fs_hpfs_inode.patch
sparse-fs_qnx4_dir.patch
sparse-include_linux_smb_fs.h.patch
sparse-security_selinux_ss_ebitmap.patch
sparse-security_selinux_ss_avtab.patch
sparse-security_selinux_ss_conditional.patch
sparse-crypto_sha256.patch
sparse-crypto_sha512.patch
sparse-crypto_blowfish.patch
sparse-crypto_tea.patch
sparse-drivers_atm_zatm.patch
sparse-drivers_atm_nicstar.patch
sparse-drivers_atm_ambassador.patch
dma_mask-drivers_scsi_lasi700.patch
printk-arch_ia64_kernel_smp.patch
printk-drivers_char_watchdog_wdt285.patch
dma_mask-drivers_ieee1394_pcilynx.patch
dma_mask-drivers_media_video_bttv-driver.patch
dma_mask-drivers_message_fusion_mptbase.patch
dma_mask-drivers_block_cciss.patch
dma_mask-drivers_block_sx8.patch
dma_mask-drivers_block_umem.patch
dma_mask-drivers_media_video_meye.patch
list_for_each-drivers_macintosh_via-pmu.patch
kj_tag.patch
