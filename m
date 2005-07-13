Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262705AbVGMTw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbVGMTw2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 15:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262725AbVGMTuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 15:50:35 -0400
Received: from coderock.org ([193.77.147.115]:925 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262721AbVGMTtS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 15:49:18 -0400
Date: Wed, 13 Jul 2005 21:48:51 +0200
From: Domen Puncer <domen@coderock.org>
To: kj <kernel-janitors@lists.osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: 2.6.13-rc3-kj
Message-ID: <20050713194851.GH21831@homer.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A new release from kernel janitors (http://janitor.kernelnewbies.org/).

Lots of new patches this time!

Patchset is at http://coderock.org/kj/2.6.13-rc3-kj/


new in this release:
--------------------
flashpoint_01-remove_unused_things
From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [KJ] [PATCH 1/15] FlashPoint: remove unused things

flashpoint_02-remove_trivial_wrappers
From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [KJ] [PATCH 2/15] FlashPoint: remove trivial wrappers

flashpoint_03-remove_UCHAR
From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [KJ] [PATCH3 3/15] FlashPoint: remove UCHAR

flashpoint_04-remove_USHORT
From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [KJ] [PATCH 4/15] FlashPoint: remove USHORT

flashpoint_05-remove_UINT
From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [KJ] [PATCH 5/15] FlashPoint: remove UINT

flashpoint_06-remove_ULONG
From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [KJ] [PATCH 6/15] FlashPoint: remove ULONG

flashpoint_07-remove_ushort_ptr
From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [KJ] [PATCH 7/15] FlashPoint: remove ushort_ptr

flashpoint_08-use_standart_types
From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [KJ] [PATCH 8/15] FlashPoint: use standard fixed size types.

flashpoint_09-untypedef_SCCB
From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [KJ] [PATCH 9/15] FlashPoint: untypedef struct _SCCB

flashpoint_10-untypedef_SCCBMgr_info
From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [KJ] [PATCH 10/15] FlashPoint: untypedef struct SCCBMgr_info

flashpoint_11-untypedef_SCCBMgr_tar_info
From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [KJ] [PATCH 11/15] FlashPoint: untypedef struct SCCBMgr_tar_info

flashpoint_12-untypedef_NVRAMInfo
From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [KJ] [PATCH 12/15] FlashPoint: untypedef struct NVRAMInfo

flashpoint_13-untypedef_SCCBcard
From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [KJ] [PATCH 13/15] FlashPoint: untypedef struct SCCBcard

flashpoint_14-lindent
From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [KJ] [PATCH 14/15] ./scripts/Lindent drivers/scsi/FlashPoint.c

flashpoint_15-return_parenthesis
From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [KJ] [PATCH 15/15] FlashPoint: don't use parenthesis with "return"

wait_event-drivers_char_drm_i830_irq
From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: [KJ] [UPDATE PATCH 10/14] drm/i830_irq: use wait_event_interruptible_timeout()

time_after-drivers_usb_input_ati_remote
From: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>
Subject: [KJ] [PATCH] drivers/usb/input/ati_remote.c : Use of time_after and time_before macros

time_after-drivers_scsi_
From: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>
Subject: [KJ] [PATCH] drivers/scsi/: Use of time_after macro

time_after-drivers_net_wan_
From: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>
Subject: [KJ] [PATCH] drivers/net/wan/: use of time_after macro

time_after-drivers_net_tulip_pnic
From: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>
Subject: [KJ] [PATCH] drivers/net/tulip/pnic.c : Use of time_after macro

time_after-drivers_net_tokenring_olympic
From: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>
Subject: [KJ] [PATCH] drivers/net/tokenring/olympic.c : Use of time_after macro

time_after-drivers_net_tokenring_lanstreamer
From: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>
Subject: [KJ] [PATCH] drivers/net/tokenring/lanstreamer.c : Use of time_after macro

time_after-drivers_net_pcmcia_smc91c92_cs
From: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>
Subject: [KJ] [PATCH] drivers/net/pcmcia/smc91c92_cs.c : Use of time_after macro

time_after-drivers_net_pcmcia_3c589_cs
From: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>
Subject: [KJ] [PATCH] drivers/net/pcmcia/3c589_cs.c : Use of time_befor macro

time_after-drivers_net_ns83820
From: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>
Subject: [KJ] [PATCH] drivers/net/ns83820.c : Use of time_after_eq macro

time_after-drivers_net_hp100
From: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>
Subject: [KJ] [PATCH] drivers/net/hp100.c : Use of time_before macro

time_after-drivers_net_hamradio_mkiss
From: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>
Subject: [KJ] [PATCH] drivers/net/hamradio/mkiss.c : Use of time_before macro

time_after-drivers_net_hamradio_baycom_epp
From: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>
Subject: [KJ] [PATCH] drivers/net/hamradio/ : Use of time_after_eq macro

time_after-drivers_net_3c523
From: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>
Subject: Re: [KJ] [PATCH] drivers/net/3c523.c : Use of time_after macro

time_after-drivers_ieee1394_hosts
From: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>
Subject: [KJ] [PATCH] drivers/ieee1394/hosts.c : Use of time_before macro

time_after-drivers_ide_ide-tape
From: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>
Subject: [KJ] [PATCH] drivers/ide/ide-tape.c : Use of time_after macro

spelling-Documentation_
From: Tobias Klauser <tklauser@nuerscht.ch>
Subject: [KJ] [PATCH] Spelling fixes for Documentation/

sparse-sound_core_memalloc
From: Victor Fusco <victor@cetuc.puc-rio.br>
Subject: [KJ] [PATCH 20/20] alsa: Fix "nocast type" warnings

sparse-net_netlink_af_netlink
From: Victor Fusco <victor@cetuc.puc-rio.br>
Subject: [KJ] [PATCH 11/20] netlink: Fix "nocast type" warnings

sparse-mm_swap_state
From: Victor Fusco <victor@cetuc.puc-rio.br>
Subject: [KJ] [PATCH 14/20] mm/swap_state: Fix "nocast type" warnings

sparse-include_linux_skbuff.h
From: Victor Fusco <victor@cetuc.puc-rio.br>
Subject: [KJ] [PATCH 03/20] skbuff.h: Fix "nocast type" warnings

sparse-include_linux_radix-tree.h
From: Victor Fusco <victor@cetuc.puc-rio.br>
Subject: [KJ] [PATCH 13/20] lib/radix-tree: Fix "nocast type" warnings

sparse-fs_xfs_linux-2.6_kmem
From: Victor Fusco <victor@cetuc.puc-rio.br>
Subject: [KJ] [PATCH 01/20] xfs: Fix "nocast type" warnings

sparse-drivers_net_sungem.h
From: Victor Fusco <victor@cetuc.puc-rio.br>
Subject: [KJ] [PATCH 17/20] net/sungem: Fix "nocast type" warnings

sparse-drivers_net_ns83820
From: Victor Fusco <victor@cetuc.puc-rio.br>
Subject: [KJ] [PATCH 19/20] net/ns83820: Fix "nocast type" warnings

sparse-drivers_net_bonding_bond_main
From: Victor Fusco <victor@cetuc.puc-rio.br>
Subject: [KJ] [PATCH 18/20] bonding/bond_main: Fix "nocast type" warnings

sparse-drivers_md_dm-crypt
From: Victor Fusco <victor@cetuc.puc-rio.br>
Subject: [KJ] [PATCH 04/20] dm-crypt: Fix "nocast type" warnings

sparse-drivers_base_dmapool
From: Victor Fusco <victor@cetuc.puc-rio.br>
Subject: [KJ] [PATCH 16/20] dmapool: Fix "nocast type" warnings

sparse-drivers_atm_firestream
From: Victor Fusco <victor@cetuc.puc-rio.br>
Subject: [KJ] [PATCH 07/20] atm/firestream: Fix "nocast type" warnings

sparse-drivers_atm_ambassador
From: Victor Fusco <victor@cetuc.puc-rio.br>
Subject: [KJ] [PATCH 05/20] atm/ambassador: Fix "nocast type" warnings

return_code-net_sctp_objcnt
From: Christophe Lucas <clucas@rotomalug.org>
Subject: [KJ] [patch 2.6.13-rc1 01/23][RESEND] net/sctp/objcnt: Audit return code of create_proc_*

return_code-drivers_net_wireless_atmel
From: Christophe Lucas <clucas@rotomalug.org>
Subject: [KJ] [patch 2.6.13-rc1 02/23][RESEND] wireless/atmel: Audit return code of create_proc_*

return_code-drivers_mca_mca-proc
From: Christophe Lucas <clucas@rotomalug.org>
Subject: [KJ] [patch 2.6.13-rc1 04/23] mca/mca-proc: Audit return code of create_proc_*

return_code-drivers_block_cpqarray
From: Christophe Lucas <clucas@rotomalug.org>
Subject: [KJ] [patch 2.6.13-rc1 05/23][RESEND] block/cpqarray: Audit return code of create_proc_*

return_code-drivers_block_cciss
From: Christophe Lucas <clucas@rotomalug.org>
Subject: [KJ] [patch 2.6.13-rc1 06/23] block/cciss: Audit return code of create_proc_*

return_code-arch_sparc_kernel_ioport
From: Christophe Lucas <clucas@rotomalug.org>
Subject: [KJ] [patch 2.6.13-rc1 11/23][RESEND] sparc/kernel/ioport: Audit return code of create_proc_*

return_code-arch_sh_
From: Christophe Lucas <clucas@rotomalug.org>
Subject: [KJ] [patch 2.6.13-rc1 13/23][RESEND] arch/sh: Audit return code of create_proc_*

return_code-arch_sh64_
From: Christophe Lucas <clucas@rotomalug.org>
Subject: [KJ] [patch 2.6.13-rc1 16/23][RESEND] sh64: Audit return code of create_proc_*

return_code-arch_parisc_kernel_pci-dma
From: Christophe Lucas <clucas@rotomalug.org>
Subject: [KJ] [patch 2.6.13-rc1 18/23] parisc/kernel/pci-dma: Audit return code of create_proc_*

return_code-arch_arm_
From: Christophe Lucas <clucas@rotomalug.org>
Subject: [KJ] [patch 2.6.13-rc1 22/23] arm/kernel: Audit return code of create_proc_*

return_code-arch_arm26_kernel_ecard
From: Christophe Lucas <clucas@rotomalug.org>
Subject: [KJ] [patch 2.6.13-rc1 23/23][RESEND] Audit return code of create_proc_*

remove_brackets-drivers_acpi_system
From: Christophe Lucas <clucas@rotomalug.org>
Subject: [KJ] [patch 2.6.13-rc1 07/23][RESEND] drivers/acpi/system.c : remove unused brackets

printk-arch_um_
From: Christophe Lucas <clucas@rotomalug.org>
Subject: [KJ] [patch 2.6.13-rc1 10/23][RESEND] printk : arch/um/

pci_dma_supported-drivers_media_video_bttv-driver
From: Tobias Klauser <tklauser@nuerscht.ch>
Subject: [KJ] [PATCH] drivers/media/video/bttv-driver: Remove unneeded call to pci_dma_supported()

msleep-drivers_telephony_ixj
From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: [KJ] [UPDATE PATCH 14/14] telephony/ixj: use msleep() instead of schedule_timeout()

msleep-drivers_scsi_qla2xxx_qla_os
From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: [KJ] [PATCH 13/14] scsi/qla2xxx: use msleep{, interruptible}() instead of schedule_timeout()

msleep-drivers_scsi_osst
From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: [KJ] [PATCH 12/14] scsi/osst: use msleep() instead of schedule_timeout()

msleep-drivers_scsi_lpfc_lpfc_scsi
From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: [KJ] [PATCH 11/14] scsi/lpfc_scsi: use msleep() instead of schedule_timeout()

msleep-drivers_block_cciss
From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: [KJ] [PATCH 9/14] block/cciss: use msleep() instead of schedule_timeout()

msleep-arch_x86_64_kernel_smpboot
From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: [KJ] [PATCH 5/14] x86_64/smpboot: use msleep() instead of schedule_timeout()

msleep-arch_i386_kernel_smpboot
From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: [KJ] [PATCH 4/14] i386/smpboot: use msleep() instead of schedule_timeout()

gcc4-include_asm-x86_64_bitops.h
From: Jesse Millan <jessem@cs.pdx.edu>
Subject: [KJ] [PATCH] GCC4 sched.c (x86_64) warning: control may reach end of non-void function 'sched_find_first_bit' being inlined

gcc4-drivers_net_wireless_wavelan_cs.c
From: Jesse Millan <jessem@cs.pdx.edu>
Subject: [KJ] [PATCH] [RESEND] GCC4 wavelan_cs.c warning: large integer implicitly truncated to unsigned type

dma_mask-drivers_block_umem
From: Tobias Klauser <tklauser@nuerscht.ch>
Subject: [KJ] [PATCH] drivers/block/umem.c: Use DMA_{32,64}BIT_MASK and correct call to pci_set_dma_mask()

cli-drivers_net_fec
Subject: Re: [KJ] [PATCH] cli() cleanup in and fec.c
From: Brandon Niemczyk <brandon@snprogramming.com>

kj_tag



merged:
-------
pci_register_driver-drivers_media_common_saa7146_core.patch
pci_register_driver-drivers_mtd_maps.patch
dma_mask-drivers_media_video_bttv-driver.patch
printk-drivers_media_dvb_ttpci_av7110_ipack.patch
gcc4-ipc_compat
bss-drivers_ieee1394_sbp2
bss-drivers_ieee1394_pcilynx
bss-drivers_ieee1394_nodemgr
bss-drivers_ieee1394_ieee1394_core
sparse-net
sparse-drivers_ieee1394_raw1394


dropped:
--------
sparse-fs_ext3_super.patch
  non-trivial changes in file
sparse-mm_slab
  some __nocasts were merged, if patch is still needed, please redo
sparse-drivers_usb_core_ur
  rejects all but 1 hunk, still needed?
kmalloc-drivers_acpi_toshiba_acpi.c
  similar (previous version?) patch merged
return_code-arch_m68k_mac_iop
  adds warning
sparse-include_linux_textsearch.h
  new warnings
sparse-security_selinux_hooks
  new warnings


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
sleep_on-drivers_sbus_char_vfc_i2c.patch
wait_event_int-drivers_block_acsi_slm.patch
wait_event_int_timeout-drivers_block_DAC960.patch
int_sleep_on-arch_mips_sibyte_sb1250_bcm1250_tbprof.patch
int_sleep_on-drivers_net_8139too.patch
int_sleep_on-drivers_net_tokenring_ibmtr.patch
int_sleep_on-fs_lockd_svc.patch
pci_register_driver-drivers_ide.patch
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
sparse-fs_ext3_resize.patch
sparse-fs_hpfs_inode.patch
sparse-include_linux_smb_fs.h.patch
printk-drivers_char_watchdog_wdt285.patch
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
return-drivers_input_misc_hp_sdc_rtc
return-drivers_char_lcd
remove_macros-sound_isa_sb_sb16_csp
printk-drivers_block_pktcdvd
msleep_interruptible-drivers_net_wan_cycx_drv
msleep_interruptible-drivers_net_ixgb_ixgb_ethtool
module_param-drivers_net_pci-skeleton
cleanup-drivers_usb_serial_cypress_m8
cleanup-drivers_net_wireless_atmel
bss-drivers_net_bonding_bond_main
sparse-kernel_audit
sparse-include_net_bluetooth_bluetooth.h
sparse-fs_reiserfs_fix_node
sparse-drivers_char_n_tty
sparse-drivers_bluetooth_hci_usb
sparse-drivers_bluetooth_bpa10x
sparse-drivers_block_ll_rw_blk
sparse-drivers_block_deadline-iosched
sparse-drivers_block_cfq-iosched
sparse-drivers_block_as-iosched
set_current_state-kernel_module.c
indent-drivers_char_Makefile
casts-drivers_usb_serial_usb-serial
flashpoint_01-remove_unused_things
flashpoint_02-remove_trivial_wrappers
flashpoint_03-remove_UCHAR
flashpoint_04-remove_USHORT
flashpoint_05-remove_UINT
flashpoint_06-remove_ULONG
flashpoint_07-remove_ushort_ptr
flashpoint_08-use_standart_types
flashpoint_09-untypedef_SCCB
flashpoint_10-untypedef_SCCBMgr_info
flashpoint_11-untypedef_SCCBMgr_tar_info
flashpoint_12-untypedef_NVRAMInfo
flashpoint_13-untypedef_SCCBcard
flashpoint_14-lindent
flashpoint_15-return_parenthesis
wait_event-drivers_char_drm_i830_irq
time_after-drivers_usb_input_ati_remote
time_after-drivers_scsi_
time_after-drivers_net_wan_
time_after-drivers_net_tulip_pnic
time_after-drivers_net_tokenring_olympic
time_after-drivers_net_tokenring_lanstreamer
time_after-drivers_net_pcmcia_smc91c92_cs
time_after-drivers_net_pcmcia_3c589_cs
time_after-drivers_net_ns83820
time_after-drivers_net_hp100
time_after-drivers_net_hamradio_mkiss
time_after-drivers_net_hamradio_baycom_epp
time_after-drivers_net_3c523
time_after-drivers_ieee1394_hosts
time_after-drivers_ide_ide-tape
spelling-Documentation_
sparse-sound_core_memalloc
sparse-net_netlink_af_netlink
sparse-mm_swap_state
sparse-include_linux_skbuff.h
sparse-include_linux_radix-tree.h
sparse-fs_xfs_linux-2.6_kmem
sparse-drivers_net_sungem.h
sparse-drivers_net_ns83820
sparse-drivers_net_bonding_bond_main
sparse-drivers_md_dm-crypt
sparse-drivers_base_dmapool
sparse-drivers_atm_firestream
sparse-drivers_atm_ambassador
return_code-net_sctp_objcnt
return_code-drivers_net_wireless_atmel
return_code-drivers_mca_mca-proc
return_code-drivers_block_cpqarray
return_code-drivers_block_cciss
return_code-arch_sparc_kernel_ioport
return_code-arch_sh_
return_code-arch_sh64_
return_code-arch_parisc_kernel_pci-dma
return_code-arch_arm_
return_code-arch_arm26_kernel_ecard
remove_brackets-drivers_acpi_system
printk-arch_um_
pci_dma_supported-drivers_media_video_bttv-driver
msleep-drivers_telephony_ixj
msleep-drivers_scsi_qla2xxx_qla_os
msleep-drivers_scsi_osst
msleep-drivers_scsi_lpfc_lpfc_scsi
msleep-drivers_block_cciss
msleep-arch_x86_64_kernel_smpboot
msleep-arch_i386_kernel_smpboot
gcc4-include_asm-x86_64_bitops.h
gcc4-drivers_net_wireless_wavelan_cs.c
dma_mask-drivers_block_umem
cli-drivers_net_fec
kj_tag
