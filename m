Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262513AbVGFUtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbVGFUtB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 16:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbVGFUTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:19:49 -0400
Received: from rigel.cs.pdx.edu ([131.252.208.59]:7587 "EHLO rigel.cs.pdx.edu")
	by vger.kernel.org with ESMTP id S262519AbVGFURX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 16:17:23 -0400
Message-ID: <42CC3C34.8050302@cs.pdx.edu>
Date: Wed, 06 Jul 2005 13:16:52 -0700
From: Jesse Millan <jessem@cs.pdx.edu>
Reply-To: jessem@cs.pdx.edu
Organization: Portland State University
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Domen Puncer <domen@coderock.org>
CC: kj <kernel-janitors@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [KJ] 2.6.13-rc2-kj (Broken Link)
References: <20050706200006.GA12464@homer.coderock.org>
In-Reply-To: <20050706200006.GA12464@homer.coderock.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Domen Puncer wrote:
> A new release from kernel janitors (http://janitor.kernelnewbies.org/).
> 
> 
> Patchset is at http://coderock.org/kj/2.6.13-rc2-kj/
> 
> 
> new in this release:
> --------------------
> sparse-net
>   From: Victor Fusco <victor@cetuc.puc-rio.br>
>   Subject: Re: [KJ] [PATCH 2.6.13-rc1 14/17] fix sparse warnings [UPDATE 2/2]
> 
> sparse-mm_slab
>   From: Victor Fusco <victor@cetuc.puc-rio.br>
>   Subject: [KJ] [PATCH 2.6.13-c1 2/17] fix sparse warnings [UPDATE]
> 
> sparse-kernel_audit
>   From: Victor Fusco <victor@cetuc.puc-rio.br>
>   Subject: [KJ] [PATCH 2.6.13-rc1 13/17] fix sparse warnings (__nocast type)
> 
> sparse-include_net_bluetooth_bluetooth.h
>   From: Victor Fusco <victor@cetuc.puc-rio.br>
>   Subject: [KJ] [PATCH 2.6.13-rc1 17/17] fix sparse warnings (__nocast type)
> 
> sparse-fs_reiserfs_fix_node
>   From: Victor Fusco <victor@cetuc.puc-rio.br>
>   Subject: Re: [KJ] [PATCH 2.6.13-rc1 9/17] fix sparse warnings (__nocast type)
> 
> sparse-drivers_ieee1394_raw1394
>   From: Victor Fusco <victor@cetuc.puc-rio.br>
>   Subject: Re: [KJ] [PATCH 2.6.13-rc1 16/17] fix sparse warnings (__nocast type)
> 
> sparse-drivers_char_n_tty
>   From: Victor Fusco <victor@cetuc.puc-rio.br>
>   Subject: [KJ] [PATCH 2.6.13-rc1 10/17] fix sparse warnings (__nocast type)
> 
> sparse-drivers_bluetooth_hci_usb
>   From: Victor Fusco <victor@cetuc.puc-rio.br>
>   Subject: [KJ] [PATCH 2.6.13-rc1 11/17] fix sparse warnings (__nocast type)
> 
> sparse-drivers_bluetooth_bpa10x
>   From: Victor Fusco <victor@cetuc.puc-rio.br>
>   Subject: [KJ] [PATCH 2.6.13-rc1 12/17] fix sparse warnings (__nocast type)
> 
> sparse-drivers_block_ll_rw_blk
>   From: Victor Fusco <victor@cetuc.puc-rio.br>
>   Subject: Re: [KJ] [PATCH 2.6.13-c1 5/17] fix sparse warnings [UPDATE]
> 
> sparse-drivers_block_deadline-iosched
>   From: Victor Fusco <victor@cetuc.puc-rio.br>
>   Subject: [KJ] [PATCH 2.6.13-rc1 8/17] fix sparse warnings (__nocast type)
> 
> sparse-drivers_block_cfq-iosched
>   From: Victor Fusco <victor@cetuc.puc-rio.br>
>   Subject: [KJ] [PATCH 2.6.13-rc1 7/17] fix sparse warnings (__nocast type)
> 
> sparse-drivers_block_as-iosched
>   From: Victor Fusco <victor@cetuc.puc-rio.br>
>   Subject: [KJ] [PATCH 2.6.13-c1 6/17] fix sparse warnings (__nocast type)
> 
> set_current_state-kernel_module.c
>   From: aLeJ <fuzzy.alej@gmail.com>
>   Subject: [KJ] kernel/module.c use __set_current_state() instead of direct assigment
> 
> indent-drivers_char_Makefile
>   From: Jim Cromie <jcromie@divsol.com>
>   Subject: [KJ] cleanup indenting on drivers/char/Makefile
> 
> casts-drivers_usb_serial_usb-serial
>   From: Tobias Klauser <tklauser@nuerscht.ch>
>   Subject: [KJ] [PATCH] drivers/serial/usb-serial: Remove unneeded void 2.6.13-rc2-kj description dropped mail merged notes patches patches-backup-if-i-fuck-up patches.comments pbomb-2.6.12 series series.backup.backup-coz-ill-fuck-up series.old casts
> 
> kj_tag
> 
> 
> 
> merged:
> -------
> msleep-arch_arm_mach-sa1100_cpu-sa1110.patch
> readability-net_core_dev
> cleanup-include_net_slhc_vj.h
> 
> 
> dropped:
> --------
> return-drivers_macintosh_apm_emu
>   driver can still do useful things if misc_register fails.
> sleep_on-drivers_sbus_char_bpp.patch
>   sleep_on() is gone from there
> 
> 
> all patches:
> ------------
> min-max-ide_ide-timing.h.patch
> list-for-each-entry-drivers_net_ppp_generic.patch
> list-for-each-entry-fs_jffs_intrep.patch
> list-for-each-entry-fs_namespace.patch
> list-for-each-fs_dcache.patch
> msleep-drivers_ide_ide-tape.patch
> pr_debug-drivers_block_umem.patch
> list-for-each-drivers_net_tulip_de4x5.patch
> min-max-arch_sh_boards_bigsur_io.patch
> min-max-arch_sh_cchips_hd6446x_hd64465_io.patch
> msleep-drivers_block_xd.patch
> msleep-drivers_ide_ide-cs.patch
> for-each-pci-dev-arch_i386_pci_acpi.patch
> function-string-arch-mips.patch
> msleep-drivers_net_wireless_prism54_islpci_dev.patch
> msleep_interruptible-drivers_parport_ieee1284_ops.patch
> msleep_interruptible-drivers_parport_parport_pc.patch
> msleep_interruptible-drivers_sbus_char_aurora.patch
> msleep+msleep_interruptible-drivers_net_tokenring_ibmtr.patch
> pci_dev_present-drivers_ide_pci_alim15x3.patch
> remove-pci-find-device-drivers_net_e1000_e1000_main.patch
> remove-pci-find-device-drivers_net_gt96100eth.patch
> set_current_state-drivers_net_irda_stir4200.patch
> set_current_state-drivers_net_tokenring_tms380tr.patch
> lib-parser-fs_devpts_inode.patch
> comment-drivers_block_floppy.c.patch
> remove_file-arch_arm26_boot_compressed_hw_bse.c.patch
> remove_file-arch_mips_arc_salone.c.patch
> remove_file-arch_mips_pmc_sierra_yosemite_ht_irq.c.patch
> remove_file-arch_ppc_syslib_ppc4xx_pm.c.patch
> remove_file-drivers_parport_parport_arc.c.patch
> remove_file-fs_jffs2_histo.h.patch
> remove_file-include_asm_arm_hardware_linkup_l1110.h.patch
> remove_file-include_asm_mips_gfx.h.patch
> remove_file-include_asm_mips_mach_au1x00_au1100_mmc.h.patch
> remove_file-include_asm_mips_mipsprom.h.patch
> remove_file-include_asm_mips_riscos_syscall.h.patch
> remove_file-include_linux_netfilter_ipv4_ip_logging.h.patch
> remove_file-include_linux_netfilter_ipv6_ip6_logging.h.patch
> vfree-drivers_char_agp_backend.patch
> vfree-drivers_scsi_qla2xxx_qla_os.patch
> vfree-fs_reiserfs_super.patch
> msleep-drivers_block_cciss.patch
> msleep-drivers_block_paride_pf.patch
> msleep-drivers_cdrom_sonycd535.patch
> msleep-fs_smbfs_proc.patch
> msleep-net_sunrpc_svcsock.patch
> msleep_interruptible-drivers_block_swim3.patch
> msleep_interruptible-drivers_sbus_char_envctrl.patch
> msleep_interruptible-fs_lockd_clntproc.patch
> msleep_ssleep-drivers_block_paride_pcd.patch
> msleep_ssleep-drivers_block_paride_pt.patch
> return_code-drivers_ide_pci_cs5520.patch
> ssleep-drivers_scsi_qla1280.patch
> wait_event-drivers_block_ps2esdi.patch
> int_sleep_on-arch_cris_arch-v10_drivers_eeprom.patch
> int_sleep_on-drivers_isdn_capi_capi.patch
> int_sleep_on-drivers_isdn_i4l_isdn_common.patch
> int_sleep_on-drivers_net_tokenring_lanstreamer.patch
> lindent-arch_ppc_4xx_io_serial_sicc.patch
> printk-drivers_acorn_block_fd1772.patch
> printk-drivers_acorn_block_mfmhd.patch
> sleep_on-drivers_block_xd.patch
> sleep_on-drivers_cdrom_sjcd.patch
> sleep_on-drivers_sbus_char_vfc_i2c.patch
> wait_event_int-drivers_block_acsi_slm.patch
> wait_event_int_timeout-drivers_block_DAC960.patch
> int_sleep_on-arch_mips_sibyte_sb1250_bcm1250_tbprof.patch
> int_sleep_on-drivers_net_8139too.patch
> int_sleep_on-drivers_net_tokenring_ibmtr.patch
> int_sleep_on-fs_lockd_svc.patch
> pci_register_driver-drivers_ide.patch
> pci_register_driver-drivers_media_common_saa7146_core.patch
> pci_register_driver-drivers_mtd_maps.patch
> pci_register_driver-drivers_net.patch
> pci_register_driver-drivers_net_arcnet.patch
> pci_register_driver-drivers_net_irda.patch
> pci_register_driver-drivers_net_skfp.patch
> pci_register_driver-drivers_net_tokenring.patch
> pci_register_driver-drivers_net_tulip.patch
> pci_register_driver-drivers_net_wan.patch
> pci_register_driver-drivers_net_wan_lmc.patch
> pci_register_driver-drivers_net_wireless.patch
> pci_register_driver-drivers_parport.patch
> return_code-drivers_ide.patch
> return_code-drivers_isdn_hisax.patch
> return_code-drivers_isdn_i4l.patch
> return_code-drivers_isdn_pcbit.patch
> sleep_on-net_sunrpc_clnt.patch
> int_sleep_on-drivers_cdrom_mcdx.patch
> unused_define-drivers_block_floppy.patch
> printk-drivers_video.patch
> msleep-arch_m68k_atari_time.patch
> msleep-drivers_acpi_osl.patch
> msleep-drivers_block_paride_pg.patch
> msleep-drivers_block_swim_iop.patch
> sparse-fs_cifs_cifssmb.patch
> sparse-fs_affs_super.patch
> sparse-fs_befs_endian.h.patch
> sparse-fs_cifs_cifssmb-2.patch
> sparse-fs_cifs_netmisc.patch
> sparse-fs_ext3_super.patch
> sparse-fs_ext3_resize.patch
> sparse-fs_hpfs_inode.patch
> sparse-include_linux_smb_fs.h.patch
> printk-drivers_char_watchdog_wdt285.patch
> dma_mask-drivers_media_video_bttv-driver.patch
> dma_mask-drivers_media_video_meye.patch
> list_for_each-drivers_macintosh_via-pmu.patch
> dma_mask-drivers_block_cpqarray.patch
> dma_mask-drivers_net.patch
> dma_mask-drivers_scsi.patch
> jiffies_to_msecs-drivers_input_joydev.patch
> printk-drivers_acpi_container.patch
> printk-drivers_acpi_pci_link.patch
> printk-drivers_block_DAC960.patch
> printk-drivers_block_cciss.patch
> printk-drivers_block_paride.patch
> printk-drivers_media_dvb_ttpci_av7110_ipack.patch
> time_after-drivers_net_ne2
> time_after-drivers_net_wireless_strip
> time_after-drivers_atm_idt77252
> time_after-drivers_net_ne-h8300
> dma_mask-drivers_net_ioc3-eth
> time_after-drivers_net_arm_etherh
> time_after-drivers_net_apne
> time_after-drivers_net_ne
> time_after-drivers_net_zorro8390
> sti_cli-drivers_net_irda_ep7211_ir
> ssleep-arch_ppc_8260_io_fcc_enet
> set_current_state-drivers_char_ip2_i2lib
> set_current_state-drivers_cdrom_sbpcd
> set_current_state-drivers_acpi_osl
> msleep_interruptible-drivers_parport_ieee1284
> warning-fs_eventpoll.c
> warning-fs_devfs_base.c
> warning-fs_cifs_asn1.c
> warning-drivers_isdn_hisax_hisax_fcpcipnp
> warning-drivers_isdn_hisax_diva.c
> return_code-drivers_net_tokenring_olympic
> printk-drivers_net_hp100
> string-arch_cris_arch-v10_drivers_axisflashmap
> size-drivers_isdn_sc_ioctl
> gcc4-fs_ext3_acl.c
> gcc4-fs_ext2_acl.c
> typo-Documentation_early-userspace_README
> typedef-sound_isa_sb_sb16_csp
> sizeof-arch_arm_common_sa1111
> set_current_state-fs_reiserfs_journal
> return_code-drivers_char_applicom
> return-drivers_misc_hdpuftrs_hdpu_cpustate
> return-drivers_input_misc_hp_sdc_rtc
> return-drivers_char_lcd
> remove_macros-sound_isa_sb_sb16_csp
> printk-drivers_block_pktcdvd
> msleep_interruptible-drivers_net_wan_cycx_drv
> msleep_interruptible-drivers_net_ixgb_ixgb_ethtool
> module_param-drivers_net_pci-skeleton
> gcc4-ipc_compat
> cleanup-drivers_usb_serial_cypress_m8
> cleanup-drivers_net_wireless_atmel
> bss-drivers_net_bonding_bond_main
> bss-drivers_ieee1394_sbp2
> bss-drivers_ieee1394_pcilynx
> bss-drivers_ieee1394_nodemgr
> bss-drivers_ieee1394_ieee1394_core
> sparse-net
> sparse-mm_slab
> sparse-kernel_audit
> sparse-include_net_bluetooth_bluetooth.h
> sparse-fs_reiserfs_fix_node
> sparse-drivers_ieee1394_raw1394
> sparse-drivers_char_n_tty
> sparse-drivers_bluetooth_hci_usb
> sparse-drivers_bluetooth_bpa10x
> sparse-drivers_block_ll_rw_blk
> sparse-drivers_block_deadline-iosched
> sparse-drivers_block_cfq-iosched
> sparse-drivers_block_as-iosched
> set_current_state-kernel_module.c
> indent-drivers_char_Makefile
> casts-drivers_usb_serial_usb-serial
> kj_tag
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Kernel-janitors mailing list
> Kernel-janitors@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/kernel-janitors


http://coderock.org/kj/2.6.13-rc2-kj/

Not Found
The requested URL /kj/2.6.13-rc2-kj/ was not found on this server.

-- 
Jesse Millan
CNS Unix Team
Portland State University
Phone: (503) 725-9151
Mobile: (503) 453-0748
GPG key: www.system-calls.com/gpg.php

grep --recursive --ignore-case 'SHOULD WORK' /usr/src/linux/* | wc
