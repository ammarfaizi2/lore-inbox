Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbVFSWJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVFSWJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 18:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbVFSWJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 18:09:58 -0400
Received: from coderock.org ([193.77.147.115]:9875 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261333AbVFSWJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 18:09:22 -0400
Date: Mon, 20 Jun 2005 00:09:07 +0200
From: Domen Puncer <domen@coderock.org>
To: kj <kernel-janitors@lists.osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: 2.6.12-kj
Message-ID: <20050619220907.GA3906@nd47.coderock.org>
Mail-Followup-To: kj <kernel-janitors@lists.osdl.org>,
	lkml <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A new release from kernel janitors (http://janitor.kernelnewbies.org/).


Patchset is at http://coderock.org/kj/2.6.12-kj/



new in this release:
--------------------
string-kernel_power_disk
  From: Ricardo Nabinger Sanchez <rnsanchez@terra.com.br>
  Subject: [KJ] [PATCH] kernel/power/disk.c string fix and if-less iterator

string-drivers_net_wireless_airo
  From: Domen Puncer <domen@coderock.org>
  Subject: [KJ] [patch] wireless: char* -> char[] conversion in airo.c

string-arch_cris_arch-v10_drivers_axisflashmap
  From: Ricardo Nabinger Sanchez <rnsanchez@terra.com.br>
  Subject: [KJ] [PATCH 2.6.11.10] arch/cris: fixes static strings declaration

size-drivers_isdn_sc_ioctl
  From: Domen Puncer <domen@coderock.org>
  Subject: [KJ] [patch] isdn: copy_from_user size fix in sc/ioctl.c

size-arch_um_sys-i386_signal
  From: Domen Puncer <domen@coderock.org>
  Subject: [KJ] [patch] um: copy_from_user size fix in signal.c

gcc4-net_ipv4_route
  From: Chuck Short <zulcss@gmail.com>
  Subject: [KJ] [PATCH] net/ipv4/route warnings

gcc4-fs_isofs_namei.c
  From: Jesse Millan <jessem@cs.pdx.edu>
  Subject: [KJ] [PATCH] Fix misleading gcc4 warning: (160) offset and block may be used uninitialized in this function

gcc4-fs_ext3_acl.c
  From: Jesse Millan <jessem@cs.pdx.edu>
  Subject: [KJ] [PATCH] Fix misleading gcc4 warning, size may be used uninitialized (ext3)

gcc4-fs_ext2_acl.c
  From: Jesse Millan <jessem@cs.pdx.edu>
  Subject: [KJ] [PATCH] Fix gcc4 warning, size may be used uninitialized (ext2)

gcc4-fs_bio.c
  From: Jesse Millan <jessem@cs.pdx.edu>
  Subject: [KJ] [PATCH] Fix misleading gcc4 warning, idx may be used uninitialized

dco-Documentation_SubmittingPatches
  From: Alexey Dobriyan <adobriyan@gmail.com>
  Subject: [KJ] [PATCH] DCO: use IANA-reserved second level domain name

kj_tag



merged:
-------
msleep_interruptible-drivers_s390_net_ctctty.patch
dma_mask-drivers_scsi_ahci.patch
dma_mask-drivers_scsi_sata_vsc.patch
remove-pci-find-device-drivers_net_ixgb_ixgb_main.patch


dropped:
--------
msleep-drivers_net_ixgb_ixgb_osdep.patch
  similar patch merged
sleep_on-drivers_net_shaper.patch
  there's no sleep_on anymore (nor is there a wait_event :-) )


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
function-string-arch-mips.patch
msleep-drivers_net_3c505.patch
msleep-drivers_net_wireless_prism54_islpci_dev.patch
msleep_interruptible-drivers_net_ixgb_ixgb_ethtool.patch
msleep_interruptible-drivers_net_pcnet32.patch
msleep_interruptible-drivers_net_wan_cycx_drv.patch
msleep_interruptible-drivers_parport_ieee1284_ops.patch
msleep_interruptible-drivers_parport_parport_pc.patch
msleep_interruptible-drivers_sbus_char_aurora.patch
msleep+msleep_interruptible-drivers_net_tokenring_ibmtr.patch
msleep+ssleep-drivers_net_appletalk_ltpc.patch
pci_dev_present-drivers_ide_pci_alim15x3.patch
remove-pci-find-device-drivers_net_e1000_e1000_main.patch
remove-pci-find-device-drivers_net_gt96100eth.patch
set_current_state-drivers_net_irda_stir4200.patch
set_current_state-drivers_net_tokenring_tms380tr.patch
set_current_state-drivers_net_wan_farsync.patch
ssleep+msleep_interruptible-drivers_net_tokenring_lanstreamer.patch
lib-parser-fs_devpts_inode.patch
myri_code_cleanup.patch
comment-drivers_block_floppy.c.patch
remove_file-arch_arm26_boot_compressed_hw_bse.c.patch
remove_file-arch_mips_arc_salone.c.patch
remove_file-arch_mips_pmc_sierra_yosemite_ht_irq.c.patch
remove_file-arch_ppc_syslib_ppc4xx_pm.c.patch
remove_file-drivers_parport_parport_arc.c.patch
remove_file-fs_jffs2_histo.h.patch
remove_file-include_asm_arm_arch_epxa10db_mode_ctrl00.h.patch
remove_file-include_asm_arm_arch_epxa10db_pld_conf00.h.patch
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
return_code-drivers_ide_pci_cs5520.patch
ssleep-drivers_net_sb1000.patch
ssleep-drivers_scsi_qla1280.patch
ssleep-kernel_power_smp.patch
wait_event-drivers_block_ps2esdi.patch
int_sleep_on-arch_cris_arch-v10_drivers_eeprom.patch
int_sleep_on-drivers_isdn_capi_capi.patch
int_sleep_on-drivers_isdn_i4l_isdn_common.patch
int_sleep_on-drivers_net_tokenring_lanstreamer.patch
lindent-arch_ppc_4xx_io_serial_sicc.patch
printk-drivers_acorn_block_fd1772.patch
printk-drivers_acorn_block_mfmhd.patch
sleep_on-drivers_block_xd.patch
sleep_on-drivers_cdrom_aztcd.patch
sleep_on-drivers_cdrom_sjcd.patch
sleep_on-drivers_sbus_char_bpp.patch
sleep_on-drivers_sbus_char_vfc_i2c.patch
wait_event_int-drivers_block_acsi_slm.patch
wait_event_int_timeout-drivers_block_DAC960.patch
defines-drivers_scsi_FlashPoint.patch
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
sleep_on-fs_lockd_clntlock.patch
sleep_on-net_sunrpc_clnt.patch
int_sleep_on-drivers_cdrom_mcdx.patch
unused_define-drivers_block_floppy.patch
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
sparse-init_do_mounts_initrd.patch
sparse-arch_i386_kernel_traps.patch
sparse-arch_i386_kernel_apm.patch
sparse-arch_i386_mm_fault.patch
sparse-arch_i386_crypto_aes.patch
sparse-fs_cifs_cifssmb.patch
sparse-fs_affs_super.patch
sparse-fs_befs_endian.h.patch
sparse-fs_cifs_cifssmb-2.patch
sparse-fs_cifs_netmisc.patch
sparse-fs_ext3_super.patch
sparse-fs_ext3_resize.patch
sparse-fs_hpfs_inode.patch
sparse-fs_qnx4_dir.patch
sparse-include_linux_smb_fs.h.patch
printk-arch_ia64_kernel_smp.patch
printk-drivers_char_watchdog_wdt285.patch
dma_mask-drivers_media_video_bttv-driver.patch
dma_mask-drivers_message_fusion_mptbase.patch
dma_mask-drivers_block_sx8.patch
dma_mask-drivers_block_umem.patch
dma_mask-drivers_media_video_meye.patch
list_for_each-drivers_macintosh_via-pmu.patch
dma_mask-drivers_block_cciss.patch
dma_mask-drivers_block_cpqarray.patch
dma_mask-drivers_net.patch
dma_mask-drivers_scsi.patch
dma_mask-drivers_usb_host_ehci-hcd.patch
jiffies_to_msecs-drivers_input_joydev.patch
msecs_to_jiffies-drivers_serial_icom.h.patch
printk-drivers_acpi_container.patch
printk-drivers_acpi_pci_link.patch
printk-drivers_block_DAC960.patch
printk-drivers_block_cciss.patch
printk-drivers_block_paride.patch
printk-drivers_char_applicom.patch
printk-drivers_char_ftape_compressor_zftape-compress.patch
printk-drivers_media_dvb_ttpci_av7110_ipack.patch
sparse-lib_sha1.patch
whitespace-arch_i386_boot_Makefile.patch
time_after-drivers_net_ne2
time_after-drivers_net_wireless_strip
time_after-drivers_atm_idt77252
time_after-drivers_net_ne-h8300
dma_mask-drivers_net_ioc3-eth
comments-drivers_scsi_FlashPoint
types-drivers_scsi_FlashPoint
time_after-drivers_net_arm_etherh
time_after-drivers_net_apne
time_after-drivers_media_dvb_dvb-core_dvb_frontend
time_after-drivers_net_ne
time_after-drivers_net_zorro8390
sti_cli-drivers_net_irda_ep7211_ir
ssleep-arch_ppc_8260_io_fcc_enet
set_current_state-drivers_char_ip2_i2lib
set_current_state-drivers_cdrom_sbpcd
set_current_state-drivers_acpi_osl
msleep_interruptible-drivers_parport_ieee1284
documentation-Documentation_networking_dmfe.txt
warning-fs_eventpoll.c
warning-fs_devfs_base.c
warning-fs_cifs_asn1.c
warning-drivers_isdn_hisax_hisax_fcpcipnp
warning-drivers_isdn_hisax_diva.c
return_code-drivers_net_tokenring_olympic
printk-drivers_net_hp100
printk-arch_i386_mm_pgtable
printk-arch_i386_mm_ioremap
dma_mask-sound_pci_ca0106_ca0106_main
dma_mask-sound_oss_via82cxxx_audio
dma_mask-sound_oss_esssolo1
dma_mask-sound_oss_es1371
dma_mask-sound_oss_es1370
dma_mask-sound_oss_cmpci
dma_mask-drivers_net_amd8111e
delete-Documentation_networking_wanpipe.txt_drivers_net_wan_Kconfig
delete-Documentation_networking_wanpipe.txt_00-INDEX
delete-Documentation_networking_wanpipe.txt
condition_assignment-arch_h8300_platform_h8300h_ptrace_h8300h
string-kernel_power_disk
string-drivers_net_wireless_airo
string-arch_cris_arch-v10_drivers_axisflashmap
size-drivers_isdn_sc_ioctl
size-arch_um_sys-i386_signal
gcc4-net_ipv4_route
gcc4-fs_isofs_namei.c
gcc4-fs_ext3_acl.c
gcc4-fs_ext2_acl.c
gcc4-fs_bio.c
dco-Documentation_SubmittingPatches
kj_tag
