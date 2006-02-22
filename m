Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbWBVUtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbWBVUtr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 15:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWBVUtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 15:49:47 -0500
Received: from nproxy.gmail.com ([64.233.182.201]:42073 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751433AbWBVUtq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 15:49:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=oR3e0rVykLrWz8r771e2eN1kqsQ3zgmN+Gvq0Iy18rw2UHoxaJ2tbxAhriuPqX8UKWEYX23SQOWVS42GKraZlf7rY7ghCQ2gcXGQiwDvNIkBGXPy2yIxZCnVJMmEz5wR7hi01HW86O9WySQKLdNcHx3j8sZ+IMRt+7izoyuI6fA=
Date: Wed, 22 Feb 2006 23:49:38 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: kernel-janitors@lists.osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.16-rc4-kj
Message-ID: <20060222204938.GA17230@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New patchset from kernel janitors is out: http://coderock.org/kj/2.6.16-rc4-kj/

The biggest part is BUG_ON conversion all over the tree.

I'm thinking about moving to git, since minor quilt nuisances are almost
at critical mass. :-\

-wavelan_cs_c_fix_gcc__warning_large_integer_implicitly_truncated_to_unsigned_type.patch
-usblp_use_wait_event_interruptible_timeout.patch
-parport_serial_fmt_warning_fixes_for_64_bit_platforms.patch
-fs_jffs_intrep_c_255_is_unsigned_char.patch
-drivers_usb_media__remove_linux_version_code_checks.patch
-drivers_net_tulip_uli526x_c_switch_to_module_param.patch
-drivers_net_acenic_fix_eeprom_byte_error_value.patch
-drivers_isdn_sc_ioctl_c_copy_from_user_size_fix.patch
-drivers_block_use_array_size.patch
-drivers_block_umem_c_check_pci_set_dma_mask_return_value_correctly.patch
-bonding_fix__get_settings_error_checking.patch
	Merged.
-remove_drivers_parport_parport_arc_c.patch
	Ian wants to reanimate driver.
-remove_arch_mips_pmc-sierra_yosemite_ht-irq_c.patch
-remove_arch_mips_arc_salone_c.patch
	Ralf doesn't like these.
+remove_second_masking_instance_of_variable_in_reg_divide_c.patch
+remove_second_masking_instance_of_variable_in_pci_root_c.patch
+remove_second_masking_instance_of_variable_i_from_intel_cacheinfo_c.patch
	Preparations for -Wshadow (?).
+remove_implicit_sign_bit_in_msp3400_h.patch
	1-bit bitfield cleanups.
+readme_s_new_newer__bzip2_format.patch
	bzip2 is not new anymore.
+printk_arch_arm_mach_footbridge_cats_pci_c.patch
+printk_arch_arm_kernel_smp_c.patch
	KERN_* additions.
+make_storage_class_first_in_pwc_timon_h.patch
+make_storage_class_first_in_pwc_kiara_h.patch
+make_storage_class_first_in_nfs4proc_c.patch
+make_storage_class_first_in_machine_kexec_c.patch
	Consistency in static/extern order patches.
+fix_warning_in_kernel_audit_c,_kauditd_thread.patch
	Warning fix.
+bug-on-sound-sparc-cs4231-c.patch
+bug-on-mm-vmalloc-c.patch
+bug-on-mm-swap-c.patch
+bug-on-mm-slab-c.patch
+bug-on-mm-mmap-c.patch
+bug-on-mm-mempool-c.patch
+bug-on-mm-memory-c.patch
+bug-on-mm-highmem-c.patch
+bug-on-lib-swiotlb-c.patch
+bug-on-kernel-timer-c.patch
+bug-on-kernel-signal-c.patch
+bug-on-kernel-ptrace-c.patch
+bug-on-kernel-printk-c.patch
+bug-on-kernel-fork-c.patch
+bug-on-kernel-cpu-c.patch
+bug-on-ipc-util-c.patch
+bug-on-ipc-shm-c.patch
+bug-on-ipc-sem-c.patch
+bug-on-ipc-msg-c.patch
+bug-on-fs-udf.patch
+bug-on-fs-sysv.patch
+bug-on-fs-sysfs.patch
+bug-on-fs-smbfs.patch
+bug-on-fs-jffs2.patch
+bug-on-fs-inode-c.patch
+bug-on-fs-hfsplus.patch
+bug-on-fs-hfs.patch
+bug-on-fs-freevxfs.patch
+bug-on-fs-fcntl-c.patch
+bug-on-fs-ext2.patch
+bug-on-fs-exec-c.patch
+bug-on-fs-dquot-c.patch
+bug-on-fs-direct-io-c.patch
+bug-on-fs-dcache-c.patch
+bug-on-fs-coda.patch
+bug-on-fs-buffer-c.patch
+bug-on-fs-binfmt_elf_fdpic-c.patch
+bug-on-drivers-video.patch
+bug-on-drivers-scsi.patch
+bug-on-drivers-s390-net-lcs-c.patch
+bug-on-drivers-s390-char-tape-block-c.patch
+bug-on-drivers-s390-block-dasd-erp-c.patch
+bug-on-drivers-s390-block-dasd-devmap-c.patch
+bug-on-drivers-s390-block-dasd-c.patch
+bug-on-drivers-parisc.patch
+bug-on-drivers-net.patch
+bug-on-drivers-mtd.patch
+bug-on-drivers-media.patch
+bug-on-drivers-md-raid6main-c.patch
+bug-on-drivers-md-raid5-c.patch
+bug-on-drivers-md-raid10-c.patch
+bug-on-drivers-md-raid1-c.patch
+bug-on-drivers-md-dm-target-c.patch
+bug-on-drivers-md-dm-table-c.patch
+bug-on-drivers-md-dm-path-selector-c.patch
+bug-on-drivers-md-dm-hw-handler-c.patch
+bug-on-drivers-md-bitmap-c.patch
+bug-on-drivers-isdn.patch
+bug-on-drivers-input-serio-hp_sdc_mlc-c.patch
+bug-on-drivers-input-serio-hil_mlc-c.patch
+bug-on-drivers-ide.patch
+bug-on-drivers-char.patch
+bug-on-drivers-block.patch
+bug-on-block-elevator-c.patch
+bug-on-arch-sparc-kernel-ioport-c.patch
	Conversion to BUG_ON().
+ide_cleanups___replace_hwgroup.patch
+ide_cleanups___remove_unneeded_bug_on.patch
+ide_cleanups___insert_bug_to___ide_set_handler.patch
	BUG_ON() misc cleanups.
+alter_prototypes_in_it87_c.patch
+alter_prototypes_in_fscpos_c.patch
+alter_prototypes_in_adm1026_c.patch
	Fixes from icc.

