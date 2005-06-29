Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262577AbVF2NQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbVF2NQn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 09:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbVF2NQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 09:16:42 -0400
Received: from coderock.org ([193.77.147.115]:46732 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262577AbVF2NOJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 09:14:09 -0400
Date: Wed, 29 Jun 2005 15:13:51 +0200
From: Domen Puncer <domen@coderock.org>
To: kj <kernel-janitors@lists.osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: 2.6.13-rc1
Message-ID: <20050629131351.GH3904@nd47.coderock.org>
Mail-Followup-To: kj <kernel-janitors@lists.osdl.org>,
	lkml <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Lots of merged patches! Yay!

A new release from kernel janitors (http://janitor.kernelnewbies.org/).


Patchset is at http://coderock.org/kj/2.6.13-rc1-kj/


new in this release:
--------------------
typo-Documentation_early-userspace_README
  From: Jim Cromie <jcromie@divsol.com>
  Subject: [KJ] [patch] early-userspace/README spelling err

typedef-sound_isa_sb_sb16_csp
  From: Alexey Dobriyan <adobriyan@gmail.com>
  Subject: [KJ] [PATCH 2/2] sb16_csp: untypedef

sizeof-arch_arm_common_sa1111
  From: Christophe Lucas <clucas@rotomalug.org>
  Subject: [KJ] [PATCH] sizeof(*dev) : arch/arm/common/sa1111.c

set_current_state-fs_reiserfs_journal
  From: Victor Fusco <victor@cetuc.puc-rio.br>
  Subject: Re: [KJ] [PATCH] fs/reiserfs/journal.c: replace direct assignment with (__set_current_state())

return_code-drivers_char_applicom
  From: Christophe Lucas <clucas@rotomalug.org>
  Subject: Re: [KJ] [PATCH] [RESEND] Audit return code : drivers/char/applicom.c

return-drivers_misc_hdpuftrs_hdpu_cpustate
  From: Christophe Lucas <clucas@rotomalug.org>
  Subject: [KJ] [PATCH][RESEND] Audit return code : drivers/misc/hdpuftrs/hdpu_cpustate.c

return-drivers_macintosh_apm_emu
  From: Christophe Lucas <clucas@rotomalug.org>
  Subject: [KJ] [PATCH][RESEND] Audit return code : drivers/macintosh/apm_emu.c

return-drivers_input_misc_hp_sdc_rtc
  From: Christophe Lucas <clucas@rotomalug.org>
  Subject: [KJ] [PATCH][RESEND] Audit return code : drivers/input/misc/hp_sdc_rtc.c

return-drivers_char_lcd
  From: Christophe Lucas <clucas@rotomalug.org>
  Subject: Re: [KJ] [PATCH] [RESEND] Audit return code : drivers/char/lcd.c

remove_macros-sound_isa_sb_sb16_csp
  From: Alexey Dobriyan <adobriyan@gmail.com>
  Subject: [KJ] [PATCH 1/2] sb16_csp: remove home-grown le??_to_cpu macros

readability-net_core_dev
  From: David <ddcc@mit.edu>
  Subject: Re: [KJ] [PATCH 2.4.28 1/1] networking: improve readability of dev_set_promiscuity() in net/core/dev.c

printk-drivers_block_pktcdvd
  From: Christophe Lucas <clucas@rotomalug.org>
  Subject: [KJ] [PATCH] printk : drivers/block/pktcdvd.c

msleep_interruptible-drivers_net_wan_cycx_drv
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: [UPDATE PATCH] net/cycx_drv: replace delay_cycx() with msleep_interruptible()

msleep_interruptible-drivers_net_ixgb_ixgb_ethtool
  From: Nishanth Aravamudan <nacc@us.ibm.com>
  Subject: Re: [patch 02/18] net/ixgb_ethtool: replace schedule_timeout() with msleep_interruptible()

module_param-drivers_net_pci-skeleton
  From: Victor Fusco <victor@cetuc.puc-rio.br>
  Subject: [KJ] [PATCH] drivers/net/pci-skeleton.c: MODULE_PARM -> module_param

gcc4-ipc_compat
  From: Jesse Millan <jessem@cs.pdx.edu>
  Subject: [KJ] [PATCH] GCC4 warning: control may reach end of non-void function 'put_compat_shminfo' being inlined

cleanup-include_net_slhc_vj.h
  From: Alexey Dobriyan <adobriyan@gmail.com>
  Subject: [KJ] [PATCH] include/net/slhc_vj.h: remove __ARGS

cleanup-drivers_usb_serial_cypress_m8
  From: Carlo Perassi <carlo@linux.it>
  Subject: [KJ] [PATCH] [RESEND] (2/2) - trailing, 80th and similar things

cleanup-drivers_net_wireless_atmel
  From: Carlo Perassi <carlo@linux.it>
  Subject: [KJ] [PATCH] (1/2) - trailing, 80th and similar things

bss-drivers_net_bonding_bond_main
  From: Carlo Perassi <carlo@linux.it>
  Subject: [KJ] [PATCH] [RESEND] bonding - uninitialize static variables

bss-drivers_ieee1394_sbp2
  From: Carlo Perassi <carlo@linux.it>
  Subject: [KJ] [PATCH] (4/4) ieee1394 - uninitialize static variables

bss-drivers_ieee1394_pcilynx
  From: Carlo Perassi <carlo@linux.it>
  Subject: [KJ] [PATCH] (3/4) ieee1394 - uninitialize static variables

bss-drivers_ieee1394_nodemgr
  From: Carlo Perassi <carlo@linux.it>
  Subject: [KJ] [PATCH] (2/4) ieee1394 - uninitialize static variables

bss-drivers_ieee1394_ieee1394_core
  From: Carlo Perassi <carlo@linux.it>
  Subject: [KJ] [PATCH] (1/4) ieee1394 - uninitialize static variables

kj_tag



merged:
-------
add_module_version-drivers_net_8139cp.patch
msleep+ssleep-drivers_net_appletalk_ltpc.patch
vfree-net_bridge_netfilter_ebtables.patch
msleep-drivers_scsi_ide-scsi.patch
msleep-net_appletalk_aarp.patch
printk-arch_ia64_kernel_smp.patch
dma_mask-drivers_message_fusion_mptbase.patch
time_after-drivers_media_dvb_dvb-core_dvb_frontend
dma_mask-sound_pci_ca0106_ca0106_main
condition_assignment-arch_h8300_platform_h8300h_ptrace_h8300h
gcc4-net_ipv4_route
list-for-each-entry-safe-fs_dquot.patch
msleep-drivers_net_3c505.patch
msleep_interruptible-drivers_net_pcnet32.patch
set_current_state-drivers_net_wan_farsync.patch
ssleep+msleep_interruptible-drivers_net_tokenring_lanstreamer.patch
ssleep-drivers_net_sb1000.patch
msleep-drivers_char_ds1620.patch
msleep-drivers_char_tty_io.patch
msleep-drivers_serial_68360serial.patch
msleep-drivers_serial_68328serial.patch
msleep_interruptible_comment-kernel_timer.patch
sparse-init_do_mounts_initrd.patch
sparse-arch_i386_kernel_traps.patch
sparse-arch_i386_kernel_apm.patch
sparse-arch_i386_mm_fault.patch
sparse-arch_i386_crypto_aes.patch
sparse-fs_qnx4_dir.patch
dma_mask-drivers_block_sx8.patch
msecs_to_jiffies-drivers_serial_icom.h.patch
printk-drivers_char_applicom.patch
printk-drivers_char_ftape_compressor_zftape-compress.patch
sparse-lib_sha1.patch
documentation-Documentation_networking_dmfe.txt
printk-arch_i386_mm_ioremap
dma_mask-sound_oss_via82cxxx_audio
dma_mask-sound_oss_esssolo1
dma_mask-sound_oss_es1371
dma_mask-sound_oss_es1370
dma_mask-sound_oss_cmpci
dma_mask-drivers_net_amd8111e
delete-Documentation_networking_wanpipe.txt_drivers_net_wan_Kconfig
delete-Documentation_networking_wanpipe.txt_00-INDEX
delete-Documentation_networking_wanpipe.txt
string-drivers_net_wireless_airo
size-arch_um_sys-i386_signal
dco-Documentation_SubmittingPatches
whitespace-arch_i386_boot_Makefile.patch
printk-arch_i386_mm_pgtable


dropped:
--------
gcc4-fs_bio.c
  gcc's fault
gcc4-fs_isofs_namei.c
  code needs cleanup anyway, so lets leave this one
string-kernel_power_disk
  makes longer binary (don't ask why)
dma_mask-drivers_block_cciss.patch
  patch to do this already in tree
comments-drivers_scsi_FlashPoint
defines-drivers_scsi_FlashPoint.patch
  all chunks failed because of Bunk's patch
types-drivers_scsi_FlashPoint
  only ;-) 167/226 failed, might be worth respinning
sleep_on-fs_lockd_clntlock.patch
  code was rewritten with wait_event, yay!
myri_code_cleanup.patch
  similar patch merged
msleep-drivers_net_slip.patch
  msleep_interruptible version of it merged
ssleep-kernel_power_smp.patch
  that code seems gone
dma_mask-drivers_usb_host_ehci-hcd.patch
  similar patch merged
remove_file-include_asm_arm_arch_epxa10db_mode_ctrl00.h.patch
remove_file-include_asm_arm_arch_epxa10db_pld_conf00.h.patch
  lets leave them, they might still be useful
msleep-drivers_block_xd2.patch
  schedule_timeout(1) was intended.
dma_mask-drivers_block_umem.patch
  code looks wrong, that needs to be sorted out first
sleep_on-drivers_cdrom_aztcd.patch
  it's still racy, need a condition
msleep_interruptible-drivers_net_wan_cycx_drv.patch
msleep_interruptible-drivers_net_ixgb_ixgb_ethtool.patch
  newer versions arrived


all patches:
------------
min-max-ide_ide-timing.h.patch
list-for-each-entry-drivers_net_ppp_generic.patch
list-for-each-entry-fs_jffs_intrep.patch
list-for-each-entry-fs_namespace.patch
list-for-each-fs_dcache.patch
msleep-drivers_ide_ide-tape.patch
pr_debug-drivers_block_umem.patch
list-for-each-drivers_net_tulip_de4x5.patch
min-max-arch_sh_boards_bigsur_io.patch
min-max-arch_sh_cchips_hd6446x_hd64465_io.patch
msleep-drivers_block_xd.patch
msleep-drivers_ide_ide-cs.patch
for-each-pci-dev-arch_i386_pci_acpi.patch
function-string-arch-mips.patch
msleep-drivers_net_wireless_prism54_islpci_dev.patch
msleep_interruptible-drivers_parport_ieee1284_ops.patch
msleep_interruptible-drivers_parport_parport_pc.patch
msleep_interruptible-drivers_sbus_char_aurora.patch
msleep+msleep_interruptible-drivers_net_tokenring_ibmtr.patch
pci_dev_present-drivers_ide_pci_alim15x3.patch
remove-pci-find-device-drivers_net_e1000_e1000_main.patch
remove-pci-find-device-drivers_net_gt96100eth.patch
set_current_state-drivers_net_irda_stir4200.patch
set_current_state-drivers_net_tokenring_tms380tr.patch
lib-parser-fs_devpts_inode.patch
comment-drivers_block_floppy.c.patch
remove_file-arch_arm26_boot_compressed_hw_bse.c.patch
remove_file-arch_mips_arc_salone.c.patch
remove_file-arch_mips_pmc_sierra_yosemite_ht_irq.c.patch
remove_file-arch_ppc_syslib_ppc4xx_pm.c.patch
remove_file-drivers_parport_parport_arc.c.patch
remove_file-fs_jffs2_histo.h.patch
remove_file-include_asm_arm_hardware_linkup_l1110.h.patch
remove_file-include_asm_mips_gfx.h.patch
remove_file-include_asm_mips_mach_au1x00_au1100_mmc.h.patch
remove_file-include_asm_mips_mipsprom.h.patch
remove_file-include_asm_mips_riscos_syscall.h.patch
remove_file-include_linux_netfilter_ipv4_ip_logging.h.patch
remove_file-include_linux_netfilter_ipv6_ip6_logging.h.patch
vfree-drivers_char_agp_backend.patch
vfree-drivers_scsi_qla2xxx_qla_os.patch
vfree-fs_reiserfs_super.patch
msleep-arch_arm_mach-sa1100_cpu-sa1110.patch
msleep-drivers_block_cciss.patch
msleep-drivers_block_paride_pf.patch
msleep-drivers_cdrom_sonycd535.patch
msleep-fs_smbfs_proc.patch
msleep-net_sunrpc_svcsock.patch
msleep_interruptible-drivers_block_swim3.patch
msleep_interruptible-drivers_sbus_char_envctrl.patch
msleep_interruptible-fs_lockd_clntproc.patch
msleep_ssleep-drivers_block_paride_pcd.patch
msleep_ssleep-drivers_block_paride_pt.patch
return_code-drivers_ide_pci_cs5520.patch
ssleep-drivers_scsi_qla1280.patch
wait_event-drivers_block_ps2esdi.patch
int_sleep_on-arch_cris_arch-v10_drivers_eeprom.patch
int_sleep_on-drivers_isdn_capi_capi.patch
int_sleep_on-drivers_isdn_i4l_isdn_common.patch
int_sleep_on-drivers_net_tokenring_lanstreamer.patch
lindent-arch_ppc_4xx_io_serial_sicc.patch
printk-drivers_acorn_block_fd1772.patch
printk-drivers_acorn_block_mfmhd.patch
sleep_on-drivers_block_xd.patch
sleep_on-drivers_cdrom_sjcd.patch
sleep_on-drivers_sbus_char_bpp.patch
sleep_on-drivers_sbus_char_vfc_i2c.patch
wait_event_int-drivers_block_acsi_slm.patch
wait_event_int_timeout-drivers_block_DAC960.patch
int_sleep_on-arch_mips_sibyte_sb1250_bcm1250_tbprof.patch
int_sleep_on-drivers_net_8139too.patch
int_sleep_on-drivers_net_tokenring_ibmtr.patch
int_sleep_on-fs_lockd_svc.patch
pci_register_driver-drivers_ide.patch
pci_register_driver-drivers_media_common_saa7146_core.patch
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
return_code-drivers_ide.patch
return_code-drivers_isdn_hisax.patch
return_code-drivers_isdn_i4l.patch
return_code-drivers_isdn_pcbit.patch
sleep_on-net_sunrpc_clnt.patch
int_sleep_on-drivers_cdrom_mcdx.patch
unused_define-drivers_block_floppy.patch
printk-drivers_video.patch
msleep-arch_m68k_atari_time.patch
msleep-drivers_acpi_osl.patch
msleep-drivers_block_paride_pg.patch
msleep-drivers_block_swim_iop.patch
sparse-fs_cifs_cifssmb.patch
sparse-fs_affs_super.patch
sparse-fs_befs_endian.h.patch
sparse-fs_cifs_cifssmb-2.patch
sparse-fs_cifs_netmisc.patch
sparse-fs_ext3_super.patch
sparse-fs_ext3_resize.patch
sparse-fs_hpfs_inode.patch
sparse-include_linux_smb_fs.h.patch
printk-drivers_char_watchdog_wdt285.patch
dma_mask-drivers_media_video_bttv-driver.patch
dma_mask-drivers_media_video_meye.patch
list_for_each-drivers_macintosh_via-pmu.patch
dma_mask-drivers_block_cpqarray.patch
dma_mask-drivers_net.patch
dma_mask-drivers_scsi.patch
jiffies_to_msecs-drivers_input_joydev.patch
printk-drivers_acpi_container.patch
printk-drivers_acpi_pci_link.patch
printk-drivers_block_DAC960.patch
printk-drivers_block_cciss.patch
printk-drivers_block_paride.patch
printk-drivers_media_dvb_ttpci_av7110_ipack.patch
time_after-drivers_net_ne2
time_after-drivers_net_wireless_strip
time_after-drivers_atm_idt77252
time_after-drivers_net_ne-h8300
dma_mask-drivers_net_ioc3-eth
time_after-drivers_net_arm_etherh
time_after-drivers_net_apne
time_after-drivers_net_ne
time_after-drivers_net_zorro8390
sti_cli-drivers_net_irda_ep7211_ir
ssleep-arch_ppc_8260_io_fcc_enet
set_current_state-drivers_char_ip2_i2lib
set_current_state-drivers_cdrom_sbpcd
set_current_state-drivers_acpi_osl
msleep_interruptible-drivers_parport_ieee1284
warning-fs_eventpoll.c
warning-fs_devfs_base.c
warning-fs_cifs_asn1.c
warning-drivers_isdn_hisax_hisax_fcpcipnp
warning-drivers_isdn_hisax_diva.c
return_code-drivers_net_tokenring_olympic
printk-drivers_net_hp100
string-arch_cris_arch-v10_drivers_axisflashmap
size-drivers_isdn_sc_ioctl
gcc4-fs_ext3_acl.c
gcc4-fs_ext2_acl.c
typo-Documentation_early-userspace_README
typedef-sound_isa_sb_sb16_csp
sizeof-arch_arm_common_sa1111
set_current_state-fs_reiserfs_journal
return_code-drivers_char_applicom
return-drivers_misc_hdpuftrs_hdpu_cpustate
return-drivers_macintosh_apm_emu
return-drivers_input_misc_hp_sdc_rtc
return-drivers_char_lcd
remove_macros-sound_isa_sb_sb16_csp
readability-net_core_dev
printk-drivers_block_pktcdvd
msleep_interruptible-drivers_net_wan_cycx_drv
msleep_interruptible-drivers_net_ixgb_ixgb_ethtool
module_param-drivers_net_pci-skeleton
gcc4-ipc_compat
cleanup-include_net_slhc_vj.h
cleanup-drivers_usb_serial_cypress_m8
cleanup-drivers_net_wireless_atmel
bss-drivers_net_bonding_bond_main
bss-drivers_ieee1394_sbp2
bss-drivers_ieee1394_pcilynx
bss-drivers_ieee1394_nodemgr
bss-drivers_ieee1394_ieee1394_core
kj_tag
