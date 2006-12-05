Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968340AbWLEEkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968340AbWLEEkf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 23:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968341AbWLEEke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 23:40:34 -0500
Received: from smtp.osdl.org ([65.172.181.25]:50271 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968340AbWLEEkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 23:40:32 -0500
Date: Mon, 4 Dec 2006 20:40:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: -mm merge plans for 2.6.20
Message-Id: <20061204204024.2401148d.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



add-bottom_half.h.patch
drm-sis-linkage-fix.patch
skip-data-conversion-in-compat_sys_mount-when-data_page-is-null.patch

 Will merge

revert-generic_file_buffered_write-handle-zero-length-iovec-segments.patch
revert-generic_file_buffered_write-deadlock-on-vectored-write.patch
generic_file_buffered_write-cleanup.patch
mm-only-mm-debug-write-deadlocks.patch
mm-fix-pagecache-write-deadlocks.patch
mm-fix-pagecache-write-deadlocks-comment.patch
mm-fix-pagecache-write-deadlocks-xip.patch
mm-fix-pagecache-write-deadlocks-mm-pagecache-write-deadlocks-efault-fix.patch
mm-fix-pagecache-write-deadlocks-zerolength-fix.patch
mm-fix-pagecache-write-deadlocks-stale-holes-fix.patch
fs-prepare_write-fixes.patch
fs-prepare_write-fixes-fuse-fix.patch
fs-prepare_write-fixes-jffs-fix.patch
fs-prepare_write-fixes-fat-fix.patch
fs-fix-cont-vs-deadlock-patches.patch

 This is the writev-speedup and pagefault-in-write() deadlock fix.  Not ready.

acpi-clear-gpe-before-disabling-it.patch
acpi-fix-single-linked-list-manipulation.patch
acpi-processor-prevent-loading-module-on-failures.patch
make-drivers-acpi-baycdrive_bays-static.patch
acpi-replace-kmallocmemset-with-kzalloc.patch
make-drivers-acpi-eccec_ecdt-static.patch
drivers-acpi-oslc-fix-a-null-check.patch
acpi-dont-select-pm.patch
implementation-of-acpi_video_get_next_level.patch
video-sysfs-support-take-2-add-dev-argument-for-backlight_device_register.patch
add-display-output-class-support.patch
add-output-class-document.patch
add-support-for-asus-a6va-m6v-w5f-v6v-laptops-in-asus-acpi.patch
add-support-for-acpi_load_table-acpi_unload_table_id.patch
altix-acpi-ssdt-pci-device-support.patch
altix-add-acpi-ssdt-pci-device-support-hotplug.patch

 Sent to APCI maintainers

cpufreq-fix-bug-in-duplicate-freq-elimination-code-in-acpi-cpufreq.patch
remove-hotplug-cpu-crap-from-cpufreq.patch
cpufreq-select-consistently-re-2619-rc5-mm1.patch
cpufreq-set-policy-curfreq-on-initialization.patch
bug-fix-for-acpi-cpufreq-and-cpufreq_stats-oops-on-frequency-change-notification.patch

Sent to cpufreq maintainer

ppc-m48t35-add-missing-bracket.patch
ppc-cs4218_tdm-remove-extra-brace.patch
powerpc-replace-kmallocmemset-with-kzalloc.patch

 Am holding onto these until the powerpc git tree gets un-messied up.

fix2-gregkh-driver-modules-state.patch
platform_driver_probe-can-save-codespace-save-codespace.patch
driver-core-per-subsystem-multithreaded-probing.patch
driver-core-dont-fail-attaching-the-device-if-it.patch
make-platform_device_add_data-accept-a-const-pointer.patch

 Sent to Greg.

drm-fix-return-value-check.patch
drm-handle-pci_enable_device-failure.patch

 Sent to Dave.

ia64-resolve-name-clash-by-renaming-is_available_memory.patch
ia64-replace-kmallocmemset-with-kzalloc.patch

 Sent to Tony

crash-on-evdev-disconnect.patch

 Sent to Dmitry.

kconfig-new-function-bool-conf_get_changedvoid.patch
kconfig-make-sym_change_count-static-let-it-be-altered-by-2-functions-only.patch
kconfig-add-void-conf_set_changed_callbackvoid-fnvoid-use-it-in-qconfcc.patch
kconfig-set-gconfs-save-widgets-sensitivity-according-to-configs-changed-state.patch
pa-risc-fix-bogus-warnings-from-modpost.patch
kconfig-refactoring-for-better-menu-nesting.patch
kbuild-fix-rr-is-now-default.patch
kbuild-dont-put-temp-files-in-the-source-tree.patch
actually-delete-the-as-instr-ld-option-tmp-file.patch

 Sent to Sam, but Sam's presently busy.  I might need to make some kbuild
 decisions..

pci-move-pci_vdevice-from-libata-to-core.patch
pata_cs5530-suspend-resume-support-tweak.patch
pata_sil680-suspend-resume-tidy.patch
ata-fix-platform_device_register_simple-error-check.patch
initializer-entry-defined-twice-in-pata_rz1000.patch
ata_piix-ide-mode-sata-patch-for-intel-ich9.patch
pata_via-suspend-resume-support-fix.patch
sata_nv-add-suspend-resume-support.patch
trivial-piix-swap-bogus-dot-for-comma-space.patch
pata_ali-small-fixes.patch
pata_via-via-8251-bridged-systems-are-now-out-and-about.patch
pata_it8213-add-new-driver-for-the-it8213-card.patch
pata_it8213-add-new-driver-for-the-it8213-card-tidy.patch

 Sent to Jeff

via-pata-controller-xfer-fixes.patch
via-pata-controller-xfer-fixes-fix.patch
libata_resume_fix.patch
ahci-ati-sb600-sata-support-for-various-modes.patch

 libata random cruft.  Am sitting on these until things get resolved one way
 or the other.

git-mtd-ssfdc-build-fix.patch
mtd-esb2rom-uses-pci.patch
remove-mtd-jffs2-userh.patch
jffs2-replace-kmallocmemset-with-kzalloc.patch

 Sent to David.

libphy-dont-do-that.patch
3x59x-fix-pci-resource-management.patch
update-smc91x-driver-with-arm-versatile-board-info.patch
8139too-force-media-setting-fix.patch
sundance-change-phy-address-search-from-phy=1-to-phy=0.patch
bonding-incorrect-bonding-state-reported-via-ioctl.patch
declance-fix-pmax-and-pmad-support.patch
declance-support-the-i-o-asic-lance-w-o-turbochannel.patch
sk98lin-debug-build-fix.patch
net-smc91x-add-missing-bracket.patch

 Sent to Jeff

nfs-kill-obsolete-nfs_paranoia.patch
nfs-represent-64-bit-fileids-as-64-bit-inode-numbers-on-32-bit-systems.patch
gss_spkm3-fix-error-handling-in-module-init.patch
auth_gss-unregister-gss_domain-when-unloading-module.patch
fix-sunrpc-wakeup-execute-race-condition.patch

 Sent to Trond

8250-uart-backup-timer.patch
serial-trivial-code-flow-simplification.patch
make-sure-uart-is-powered-up-when-dumping-mctrl-status.patch
perle-multimodem-card-pci-ras-detection.patch
serial-replace-kmallocmemset-with-kzalloc.patch

 Serial patches, and we don't have a serial maintainer.  Hopefully Russell
 will have time to comment on these, otherwise I'll take a shot at it.

pci-quirks-fix-the-festering-mess-that-claims-to-handle-ide-quirks-ide-fix.patch
pci-introduce-pci_find_present.patch
pci-fix-multiple-problems-with-via-hardware.patch
fix-gregkh-pci-pci-enable-disable-device-is-nestable.patch
pci-check-szhi-when-sz-is-0-when-64-bit-iomem-bigger-than-4g.patch
dont-export-device-ids-to-userspace.patch
sys-bus-pci-drivers-driver-new_id-search-dynamics-ids-first.patch
be-a-bit-defensive-in-quirk_nvidia_ck804-so-we-dont-risk-dereferencing-a-null-pdev.patch

 Sent to Greg.

s390-preparatory-cleanup-in-common-i-o-layer.patch
s390-make-the-per-subchannel-lock-dynamic.patch
s390-dynamic-subchannel-mapping-of-ccw-devices.patch
s390-use-dev-groups-for-subchannel-attributes.patch
s390-update-cio-documentation.patch

 Sent to Martin.

drivers-scsi-small-cleanups.patch
drivers-scsi-aic7xxx-aic79xx_corec-make-ahd_match_scb-static.patch
scsi-clean-up-warnings-in-advansys-driver.patch
drivers-scsi-advansysc-cleanups.patch
megaraid-fix-warnings-when-config_proc_fs=n.patch
drivers-scsi-pcmcia-nsp_csh-removal-of-old.patch
remove-unnecessary-check-in-drivers-scsi-sgc.patch
remove-extra-newline-from-info-message.patch
fix-scsi-scsi_transporth-compile-error.patch
pci_module_init-convertion-in-the-legacy-megaraid-driver.patch
pci_module_init-convertion-in-tmscsimc.patch
drivers-scsi-dpt_i2oc-remove-dead-code.patch
mpt-fusion-handle-pci-layer-error-on-resume.patch
drivers-scsi-ncr5380c-replacing-yield-with-a.patch
drivers-scsi-megaraidc-replacing-yield-with-a.patch
scsi-whitespace-cleanup-in-the-dpt-driver.patch
scsi-fix-uaccess-handling.patch
drivers-scsi-mca_53c9xc-save_flags-cli-removal.patch
drivers-scsi-aic7xxx-make-functions-static.patch
scsi-advansys-wrap-pci-table-inside-ifdef-config_pci.patch
scsi-in2000-scsi_cmnd-convertion.patch
make-qla2x00_reg_remote_port-static.patch
iscsi-fix-crypto_alloc_hash-error-check.patch
scsi-sic7xxx-stray-bracket-fix.patch
scsi-53c7xx-brackets-fix.patch
fix-sense-key-medium-error-processing-and-retry.patch
sym53c8xx_2-claims-cpqarray-device.patch
aic79xx-wrong-max-memory-at-driver-init.patch
drivers-scsi-wd33c93c-cleanups.patch
scsi-megaraid-fix-mmio-casts.patch
scsi-cover-up-bugs-fix-up-compiler-warnings-in-megaraid-driver.patch

 Sent to James.

nokia-e70-is-an-unusual-device.patch
usb-auerswald-replace-kmallocmemset-with-kzalloc.patch
usb-fix-ohcih-over-use-warnings.patch
usb_rtl8150-must-select-mii.patch

 Sent to Greg.

hostap-replace-kmallocmemset-with-kzalloc.patch
prism54-replace-kmallocmemset-with-kzalloc.patch
ipw2200-replace-kmallocmemset-with-kcalloc.patch
softmac-fix-unbalanced-mutex_lock-unlock-in-ieee80211softmac_wx_set_mlme.patch

 Not sent to John - I forgot.

fix-x86_64-mm-patch-inline-replacements-for-section-warnings.patch
fix-x86_64-mm-i386-config-core2.patch
genapic-optimize-fix-apic-mode-setup.patch
mtrr-replace-kmallocmemset-with-kzalloc.patch
i386-correct-documentation-for-bzimage-protocol-v205.patch
fix-asm-constraints-in-i386-atomic_add_return.patch
i386-msr-remove-unused-variable.patch
arch-i386-kernel-remove-remaining-pc98-code.patch
i386-replace-kmallocmemset-with-kzalloc.patch
cleanup-arch-i386-kernel-smpbootcsmp_tune_scheduling.patch
make-i386-default-to-highmem4g-instead-of-nohighmem.patch
convert-i386-pda-code-to-use-%fs.patch
x86_64-check-vector-in-setup_ioapic_dest-to-verify-if-need-setup_io_apic_irq.patch
x86_64-make-the-numa-hash-function-nodemap-allocation.patch
x86_64-make-the-numa-hash-function-nodemap-allocation-fix.patch
include-asm-x86_64-cpufeatureh-isnt-a-userspace-header.patch
i386-kernel-smpc-dont-use-set_irq_regs.patch
fix-numaq-build-error.patch
x86_64-i386-kernel-mode-faults-pollute-current-thead.patch

 Sent to Andi.

memory-page-alloc-minor-cleanups.patch
memory-page-alloc-minor-cleanups-fix.patch
__unmap_hugepage_range-add-comment.patch
get-rid-of-zone_table.patch

 Shall merge.

deal-with-cases-of-zone_dma-meaning-the-first-zone.patch
get-rid-of-zone_table-fix-3.patch
introduce-config_zone_dma.patch
optional-zone_dma-in-the-vm.patch
optional-zone_dma-in-the-vm-no-gfp_dma-check-in-the-slab-if-no-config_zone_dma-is-set.patch
optional-zone_dma-in-the-vm-no-gfp_dma-check-in-the-slab-if-no-config_zone_dma-is-set-reduce-config_zone_dma-ifdefs.patch
optional-zone_dma-for-ia64.patch
remove-zone_dma-remains-from-parisc.patch
remove-zone_dma-remains-from-sh-sh64.patch
set-config_zone_dma-for-arches-with-generic_isa_dma.patch
zoneid-fix-up-calculations-for-zoneid_pgshift.patch

 Might drop, don't know yet.  These make a mess of core MM for dubiuous gain.

memory-page_alloc-zonelist-caching-speedup.patch
memory-page_alloc-zonelist-caching-reorder-structure.patch
oom-dont-kill-unkillable-children-or-siblings.patch
oom-cleanup-messages.patch
oom-less-memdie.patch
mm-incorrect-vm_fault_oom-returns-from-drivers.patch
grab-swap-token-reordered.patch
new-scheme-to-preempt-swap-token.patch
new-scheme-to-preempt-swap-token-tidy.patch
mm-add-arch_alloc_page.patch
balance_pdgat-cleanup.patch
shared-page-table-for-hugetlb-page-v4.patch
htlb-forget-rss-with-pt-sharing.patch
slab-debug-and-arch_slab_minalign-dont-get-along.patch
mm-slab-eliminate-lock_cpu_hotplug-from-slab.patch
add-noaliencache-boot-option-to-disable-numa-alien-caches.patch
mm-arch-do_page_fault-vs-in_atomic.patch
mm-pagefault_disableenable.patch
mm-pagefault_disableenable-s390-fix.patch
mm-kummap_atomic-vs-in_atomic.patch
fix-kunmap_atomics-use-of-kpte_clear_flush.patch
allowing-user-processes-to-rise-their-oom_adj-value.patch
mlock-cleanup.patch
oom-can-panic-due-to-processes-stuck-in-__alloc_pages.patch
always-print-out-the-header-line-in-proc-swaps.patch
leak-tracking-for-kmalloc_node.patch
leak-tracking-for-kmalloc_node-fix.patch
add-numa-node-information-to-struct-device.patch
add-numa-node-information-to-struct-device-tidy.patch
node-aware-skb-allocation.patch
node-aware-skb-allocation-fix-for-device-tree-changes.patch
allow-null-pointers-in-percpu_free.patch
enables-booting-a-numa-system-where-some-nodes-have-no.patch
make-mm-thrashcglobal_faults-static.patch
remove-bio_cachep-from-slabh.patch
move-sighand_cachep-to-include-signalh.patch
move-vm_area_cachep-to-include-mmh.patch
move-files_cachep-to-include-fileh.patch
move-filep_cachep-to-include-fileh.patch
move-fs_cachep-to-linux-fs_structh.patch
move-names_cachep-to-linux-fsh.patch
remove-uses-of-kmem_cache_t-from-mm-and-include-linux-slabh.patch
drain_node_page-drain-pages-in-batch-units.patch
numa-node-ids-are-int-page_to_nid-and-zone_to_nid-should-return-int.patch
silence-unused-pgdat-warning-from-alloc_bootmem_node-and-friends.patch
reject-corrupt-swapfiles-earlier.patch
mm-cleanup-indentation-on-switch-for-cpu-operations.patch
kill-install_file_ptes-pte_val.patch
slab-remove-slab_no_grow.patch
slab-remove-slab_level_mask.patch
slab-remove-slab_noio.patch
slab-remove-slab_nofs.patch
slab-remove-slab_user.patch
slab-remove-slab_atomic.patch
slab-remove-slab_kernel.patch
slab-remove-slab_dma.patch
slab-remove-kmem_cache_t.patch
slab-deprecate-kmem_cache-t.patch
slab-fixup-two-issues-in-kmalloc_node--__cache_alloc_node.patch
gfp_thisnode-must-not-trigger-global-reclaim.patch
slab-better-fallback-allocation-behavior.patch
mm-make-compound-page-destructor-handling-explicit.patch
mm-make-compound-page-destructor-handling-explicit-tidy.patch
save-some-bytes-in-struct-mm_struct.patch

 Memory management queue.  Shall merge, subject to re-review

mm-call-into-direct-reclaim-without-pf_memalloc-set.patch
mm-cleanup-and-document-reclaim-recursion.patch
congestion-wait-dont-wait-when-there-are-no-pages-under-writeback.patch

 Might merge - need to check these out a bit more closely.

radix-tree-rcu-lockless-readside.patch

 There's no reason to merge this yet.

acx1xx-wireless-driver.patch

 This is -mm-only material.

security-keys-user-kmemdup.patch
implement-file-posix-capabilities.patch

 Security - shall merge.

arch-frv-kernel-futexc-must-include-linux-uaccessh.patch
avr32-fixup-kprobes-preemption-handling.patch
h8300-stray-bracket-fix.patch
alpha-switch-to-pci_get-api.patch
m68k-replace-kmallocmemset-with-kzalloc.patch
uml-fix-prototypes.patch
fix-v850-compilation.patch

 Misc arch fixes - shall merge.

uswsusp-add-pmops-prepareenterfinish-support-aka-platform-mode.patch
swsusp-use-partition-device-and-offset-to-identify-swap-areas.patch
swsusp-rearrange-swap-handling-code.patch
swsusp-use-block-device-offsets-to-identify-swap-locations-rev-2.patch
swsusp-add-resume_offset-command-line-parameter-rev-2.patch
swsusp-document-support-for-swap-files-rev-2.patch
swsusp-add-ioctl-for-swap-files-support.patch
swsusp-update-userland-interface-documentation.patch
swsusp-improve-handling-of-highmem.patch
swsusp-improve-handling-of-highmem-fix.patch
swsusp-use-__gfp_wait.patch
swsusp-fix-platform-mode.patch
add-include-linux-freezerh-and-move-definitions-from.patch
add-include-linux-freezerh-and-move-definitions-from-ueagle-fix.patch
add-include-linux-freezerh-and-move-definitions-from-ucb1400_ts-fix.patch
quieten-freezer-if-config_pm_debug.patch
swsusp-cleanup-whitespace-in-freezer-output.patch
swsusp-thaw-userspace-and-kernel-space-separately.patch
swsusp-support-i386-systems-with-pae-or-without-pse.patch
suspend-dont-change-cpus_allowed-for-task-initiating-the-suspend.patch
swsusp-measure-memory-shrinking-time.patch
suspend-to-disk-fails-if-gdb-is-suspended-with-a-traced-child.patch
convert-pm_sem-to-a-mutex.patch
convert-pm_sem-to-a-mutex-fix.patch
swsusp-untangle-thaw_processes.patch
swsusp-untangle-freeze_processes.patch
swsusp-fix-coding-style-in-suspendc.patch
swsusp-fix-labels.patch
s2ram-debugging-documentation.patch
pm-fix-swsusp-debug-mode-testproc.patch
swsusp-kill-write-only-variable.patch
support-for-freezeable-workqueues.patch
use-freezeable-workqueues-in-xfs.patch

 power/swsusp - shall merge.

cciss-version-change.patch
cciss-reference-driver-support.patch
cciss-increase-number-of-commands-on-controller.patch
cciss-fix-pci-ssid-for-the-e500-controller.patch
cciss-disable-dma-prefetch-on-p600.patch
cciss-set-sector_size-to-2048-for-performance.patch
cciss-set-sector_size-to-2048-for-performance-tidy.patch
cciss-change-cciss_open-for-consistency.patch
cciss-remove-unused-revalidate_allvol-function.patch
cciss-add-support-for-1024-logical-volumes.patch
cciss-cleanup-cciss_interrupt-mode.patch

 Shall merge.

deprecate-smbfs-in-favour-of-cifs.patch
deprecate-smbfs-in-favour-of-cifs-docs.patch

 Am still waiting to hear from sfrench on the appropriateness of this.

edac-new-opteron-athlon64-memory-controller-driver.patch
drivers-edac-make-code-static.patch

 This stuff seems to be permanently stalled by Andi/Alan disagreement.

pci_module_init-convertion-for-k8_edacc.patch
fix-rescan_partitions-to-return-errors-properly.patch
fix-check_partition-routines.patch
serial-uartlite-driver.patch
serial-uartlite-driver-fix.patch
fix-serial-uartlite-after-global-pt_regs.patch
serial-uartlite-support-multiple-devices.patch
serial-uartlite-initialize-port-parameters-in-console_setup.patch
ioremap-balanced-with-iounmap-for-drivers-char-rio-rio_linuxc.patch
ioremap-balanced-with-iounmap-for-drivers-char-moxac.patch
ioremap-balanced-with-iounmap-for-drivers-char-istallionc.patch
sound-oss-btaudioc-ioremap-balanced-with-iounmap.patch
lockdep-annotate-nfs-nfsd-in-kernel-sockets.patch
lockdep-annotate-nfs-nfsd-in-kernel-sockets-tidy.patch
honour-mnt_noexec-for-access.patch
ext2-fsid-for-statvfs.patch
ext3-fsid-for-statvfs.patch
ext4-fsid-for-statvfs.patch
kernel-proc-kallsyms-reports-lower-case.patch
i2o-more-error-checking.patch
pnp-handle-sysfs-errors.patch
rtc-handle-sysfs-errors.patch
sound-oss-emu10k1-handle-userspace-copy-errors.patch
spi-improve-sysfs-compiler-complaint-handling.patch
drivers-add-lcd-support-3.patch
drivers-add-lcd-support-3-Kconfig-fix.patch
drivers-add-lcd-support-update-4.patch
drivers-add-lcd-support-update-5.patch
drivers-add-lcd-support-update6.patch
drivers-add-lcd-support-update-7.patch
drivers-add-lcd-support-update-8.patch
constify-inode-accessors.patch
ide-complete-switch-to-pci_get.patch
remove-drivers-pci-searchcpci_find_device_reverse.patch
fuse-update-userspace-interface-to-version-78.patch
fuse-minor-cleanup-in-fuse_dentry_revalidate.patch
fuse-add-support-for-block-device-based-filesystems.patch
fuse-add-blksize-option.patch
fuse-add-bmap-support.patch
fuse-add-destroy-operation.patch
fuse-fix-compile-without-config_block.patch
sysrq-x-show-blocked-tasks.patch
#sysrq-t-broke-and-no-one-noticed.patch
file-kill-unnecessary-timer-in-fdtable_defer.patch
remove-double-cast-to-same-type.patch
io-storage-documentation-update-to-as-ioschedtxt.patch
export-pm_suspend-for-the-shared-apm-emulation.patch
patch-to-fix-reiserfs-bad-path-release-panic-on-2619-rc1.patch
via82cxxx-handle-error-condition-properly.patch
lockdep-fix-ide-proc-interaction.patch
pull-in-necessary-header-files-for-cdevh.patch
cpuset-minor-code-refinements.patch
remove-superfluous-lock_super-in-ext2-and-ext3-xattr-code.patch
correct-bus_num-and-buffer-bug-in-spi-core.patch
spi-set-kset-of-master-class-dev-explicitly.patch
paride-rename-pi_register-and-pi_unregister.patch
paride_register-shuffle-return-values.patch
lockdep-internal-locking-fixes.patch
lockdep-misc-fixes-in-lockdepc.patch
cpuset-remove-sched-domain-hooks-from-cpusets.patch
binfmt_elf-randomize-pie-binaries.patch
handle-ext3-directory-corruption-better.patch
handle-ext4-directory-corruption-better.patch
tifm-fix-null-ptr-and-style.patch
function-v9fs_get_idpool-returns-int-not-u32-as-called-twice.patch
disable-clone_child_cleartid-for-abnormal-exit.patch
binfmt-fix-uaccess-handling.patch
compat-fix-uaccess-handling.patch
profile-fix-uaccess-handling.patch
kconfig-printk_time-depends-on-printk.patch
parport_pc-add-support-for-ox16pci952-parallel-port.patch
probe_kernel_address-needs-to-do-set_fs.patch
slab-use-probe_kernel_address.patch
paride-return-proper-error-code.patch
read_cache_pages-cleanup.patch
taskstats_exit_alloc-optimize-simplify.patch
taskstats-cleanup-do_exit-path.patch
taskstats-cleanup-signal-stats-allocation.patch
taskstats-factor-out-reply-assembling.patch
taskstats-use-nla_reserve-for-reply-assembling.patch
taskstats-cleanup-reply-assembling.patch
cpuset-allow-a-larger-buffer-for-writes-to-cpuset-files.patch
compile-time-check-re-world-writeable-module-params.patch
lockdep-annotate-bcsp-driver.patch
exar-quad-port-serial.patch
exar-quad-port-serial-fix.patch
fs-trivial-vsnprintf-conversion.patch
hpfs-bring-hpfs_error-into-shape.patch
hpfs-fix-printk-format-warnings.patch
drivers-cdrom-trivial-vsnprintf-conversion.patch
vfs-extra-check-inside-dentry_unhash.patch
correct-misc_register-return-code-handling-in-several-drivers.patch
more-list-debugging-context.patch
get_options-to-allow-a-hypenated-range-for-isolcpus.patch
vfs_getattr-remove-dead-code.patch
ext3-uninline-large-functions.patch
ext4-uninline-large-functions.patch
uninline-module_put.patch
i2lib-unused-variable-cleanup.patch
make-initramfs-printk-a-warning-on-incorrect-cpio-type.patch
corrupted-cramfs-filesystems-cause-kernel-oops.patch
lockdep-print-current-locks-on-in_atomic-warnings.patch
lockdep-name-some-old-style-locks.patch
documentation-remount_fs-needs-lock_kernel.patch
sleep-profiling.patch
sleep-profiling-fixes.patch
sleep-profiling-fix.patch
ext4_ext_split-remove-dead-code.patch
debug-workqueue-locking-sanity.patch
debug-workqueue-locking-sanity-fix.patch
hz-300hz-support.patch
pcengines-wrap-led-support.patch
pcengines-wrap-led-support-fix.patch
driver-base-memoryc-remove-warnings-of.patch
remove-kernel-syscalls.patch
remove-kernel-syscalls-x86_64-fix.patch
protect-ext2-ioctl-modifying-append_only-immutable-etc-with-i_mutex.patch
remove-hash_highmem.patch
retries-in-ext3_prepare_write-violate-ordering-requirements.patch
retries-in-ext3_prepare_write-violate-ordering-requirements-fix.patch
ktime-fix-signed--unsigned-mismatch-in-ktime_to_ns.patch
qconf-support-old-qt.patch
remove-the-syslog-interface-when-printk-is-disabled.patch
ver_linux-additions.patch
initrd-remove-unused-false-condition-for.patch
fix-the-size-limit-of-compat-space-msgsize.patch
elf-always-define-elf_addr_t-in-linux-elfh.patch
elf-include-terminating-zero-in-n_namesz.patch
elf-fix-kcore-note-size-calculation.patch
elf-fix-kcore-note-size-calculation-fix.patch
reiserfs-add-missing-d-cache-flushing.patch
reiserfs-add-missing-d-cache-flushing-tweak.patch
the-scheduled-removal-of-some-oss-options.patch
make-1-bit-bitfields-unsigned.patch
hvcs-char-driver-janitoring-move-block-of-code.patch
hvcs-char-driver-janitoring-rm-compiler-warnings.patch
kprobes-enable-booster-on-the-preemptible-kernel.patch
declare-smp_call_function_single-in-generic-code.patch
up-smp_call_function_single-should-disable-interrupts.patch
smp_call_function_single-check-that-local-interrupts-are-enabled.patch
hotplug-cpu-clean-up-hotcpu_notifier-use.patch
hotplug-cpu-clean-up-hotcpu_notifier-use-vs-gregkh-driver-cpu-topology-consider-sysfs_create_group-return-value.patch
ext3-fix-reservation-extension.patch
ext4-fix-reservation-extension.patch
allow-hwrandom-core-to-be-a-module.patch
make-mm-shmemcshmem_xattr_security_handler-static.patch
remove-kernel-lockdepclockdep_internal.patch
make-kernel-signalckill_proc_info-static.patch
i2o-handle-__copy_from_user.patch
i2o-fix-i2o_config-without-adaptec-extension.patch
make-ecryptfs_version_str_map-static.patch
make-fs-jbd-transactionc__journal_temp_unlink_buffer-static.patch
make-fs-jbd2-transactionc__jbd2_journal_temp_unlink_buffer-static.patch
fs-lockd-hostc-make-2-functions-static.patch
make-fs-proc-basecproc_pid_instantiate-static.patch
parport-section-mismatches-with-hotplug=n.patch
agp-amd64-section-mismatches-with-hotplug=n.patch
add-rtc-omap-driver.patch
add-return-value-checking-of-get_user-in.patch
add-return-value-checking-of-get_user-in-fix.patch
ciss-require-same-scsi-module-support.patch
export-toshiba-smm-support-for-neofb-module.patch
kernel-doc-add-fusion-and-i2o-to-kernel-api-book.patch
kernel-doc-fix-fusion-and-i2o-docs.patch
kernel-api-book-remove-videodev-chapter.patch
rcu-add-a-prefetch-in-rcu_do_batch.patch
dont-insert-pipe-dentries-into-dentry_hashtable.patch
dcache-avoid-rcu-for-never-hashed-dentries.patch
net-dont-insert-socket-dentries-into-dentry_hashtable.patch
kernel-core-replace-kmallocmemset-with-kzalloc.patch
kernel-doc-stricter-function-pointer-recognition.patch
fs-reorder-some-struct-inode-fields-to-speedup-i_size-manipulations.patch
add-struct-dev-pointer-to-dma_is_consistent.patch
pass-struct-dev-pointer-to-dma_cache_sync.patch
handle-per-subsystem-mutexes-for-config_hotplug_cpu-not-set.patch
handle-per-subsystem-mutexes-for-config_hotplug_cpu-not-set-tidy.patch
dz-fixes-to-make-it-work.patch
dz-fixes-to-make-it-work-fix.patch
reiser-replace-kmallocmemset-with-kzalloc.patch
futex-init-error-check.patch
spi-check-platform_device_register_simple-error.patch
synclink_gt-fix-init-error-handling.patch
sysctl-string-length-calculated-is-wrong-if-it-contains-negative-numbers.patch
sched-correct-output-of-show_state.patch
reiserfs-do-not-add-save-links-for-o_direct-writes.patch
reiserfs-do-not-add-save-links-for-o_direct-writes-fix.patch
rtc-rs5c372-change-register-reading-method.patch
reporting-bugs-request-config-file.patch
remove-useless-carta_random32h.patch
lib-functions-always-build-hweight-for-loadable-modules.patch
jbd2-wait-for-already-submitted-t_sync_datalist-buffer.patch
ext4-balloc-reset-windowsz-when-full.patch
ext4-balloc-fix-off-by-one-against-grp_goal.patch
ext4-balloc-fix-off-by-one-against-rsv_end.patch
ext4-balloc-say-rb_entry-not-list_entry.patch
ext4-balloc-use-io_error-label.patch
ext4-balloc-fix-_with_rsv-freeze.patch
better-config_w1_slave_ds2433_crc-handling.patch
lockdep-more-chains.patch
lockdep-show-more-details-about-self-test-failures.patch
ide_scsi-allow-it-to-be-used-for-non-cd-only.patch
ide_scsi-allow-it-to-be-used-for-non-cd-only-fix.patch
make-8250_pnp-serial-driver-work-after.patch
make-8250_pnp-serial-driver-work-after-tidy.patch
maintainers-update-the-i2c-and-hwmon-subsystems-info.patch
autofs-fix-error-code-path-in-autofs_fill_sb.patch
autofs-fix-error-code-path-in-autofs_fill_sb-fix.patch
doc-atomic_add_unless-doesnt-imply-mb-on-failure.patch
softirq-remove-bug_ons-which-can-incorrectly-trigger.patch
rtc-ds1743-support.patch
char-ip2-remove-broken-macro.patch
save-some-bytes-in-struct-inode.patch
winbond-ide-depends-on-idedma.patch
readme-updated.patch
amba-pl010-clear-error-flags-on-rx-error.patch
gcc-4-1-0-is-bust.patch
fs-sysv-doc-cleanup.patch
proper-prototype-for-remove_inode_dquot_ref.patch
remove-drivers-char-riscom8cbaud_table.patch
arch-i386-kernel-rebootc-should-include-linux-rebooth.patch
trivial-cleanup-in-the-pci-ids-for-the-cs5535.patch
fs-ufs-add-missing-bracket.patch
m68knommu-scatterlist-add-missing-bracket.patch
fs-reiserfs-add-missing-brackets.patch
kbuild-add-3-more-header-files-to-get-properly-unifdefed.patch
ext3-4-dont-do-orphan-processing-on-readonly-devices.patch
remove-export_unused_symboled-symbols.patch
fs-remove-unused-variable.patch
sys-remove-unused-variable.patch
add-sparse-annotations-to-srcu-wrapper-functions-in-rcutorture.patch
new-updated-devicestxt-lanana.patch
include-asm-cris-extern-inline-static-inline.patch
include-asm-h8300-extern-inline-static-inline.patch
include-asm-powerpc-extern-inline-static-inline.patch
remove-nfsd_optimize_space.patch
generic-hdlc-synclink-config-mismatch-fix.patch
maintainers-remove-the-non-existing-sun3-list.patch
futex-remove-unneeded-barrier.patch
cleanup-include-asm-generic-atomich.patch
paride-remove-parport-ifdefs.patch
remove-drivers-block-paride-jumbo.patch
affs-replace-kmallocmemset-with-kzalloc.patch
arm26-replace-kmallocmemset-with-kzalloc.patch
jffs-replace-kmallocmemset-with-kzalloc.patch
struct-seq_operations-and-struct-file_operations-constification.patch
struct-seq_operations-and-struct-file_operations-constification-fix.patch
struct-seq_operations-and-struct-file_operations-constification-fix-2.patch
fs-make-nls_cp936c-handle-some-u00xy-characters-and-u20ac.patch
cleanup-asm-setuph-userspace-visibility-v2.patch
do_coredump-and-not-stopping-rewrite-attacks.patch
kexec--kdump-unify-elf-note-code.patch
enable-raid-autorun-on-mac-partition-tables.patch
aio-kill-pointless-ki_nbytes-assignment-in-aio_setup_single_vector.patch
aio-remove-ki_retried-debugging-member.patch
ext4-fix-credit-calculation-in-ext4_ext_calc_credits_for_insert.patch
update-ext-mailing-list-address.patch
update-ext-mailing-list-address-fix.patch

 Misc.  Shall merge, subject to re-review.

ipmi-fix-device-model-name.patch
ipmi-remove-interface-number-limits.patch
ipmi-pass-sysfs-name-from-lower-level-driver.patch
ipmi-allow-hot-system-interface-remove.patch
ipmi-add-maintenance-mode.patch
ipmi-fix-request-events.patch
ipmi-add-poll-delay.patch
ipmi-system-interface-hotplug.patch
ipmi-add-pigeonpoint-poweroff.patch
ipmi-fix-pci-warning.patch
ipmi-fix-bt-long-busy.patch
ipmi-increase-kcs-message-size.patch
ipmi-fix-proc_fs=n-warnings.patch

 Shall merge

jbd-wait-for-already-submitted-t_sync_datalist-buffer.patch
ext3-balloc-reset-windowsz-when-full.patch
ext3-balloc-fix-off-by-one-against-grp_goal.patch
ext3-balloc-fix-off-by-one-against-rsv_end.patch
ext3-balloc-say-rb_entry-not-list_entry.patch
ext3-balloc-use-io_error-label.patch
ext3-balloc-fix-_with_rsv-freeze.patch

 Shall merge.

io-accounting-core-statistics.patch
clean-up-__set_page_dirty_nobuffers.patch
io-accounting-write-accounting.patch
io-accounting-write-cancel-accounting.patch
io-accounting-read-accounting-2.patch
io-accounting-read-accounting-nfs-fix.patch
io-accounting-read-accounting-nfs-fix-fix.patch
io-accounting-read-accounting-cifs-fix.patch
io-accounting-direct-io.patch
io-accounting-report-in-procfs.patch
cleanup-taskstatsh.patch
io-accounting-via-taskstats.patch
getdelays-various-fixes.patch
io-accounting-add-to-getdelays.patch

 I need to get these sent out for proper review.  Shall merge, all being well.

move-page-writeback-acounting-out-of-macros.patch
per-backing_dev-dirty-and-writeback-page-accounting.patch

 This is some stuff I'm working on to address writeback latency problems. 
 Not ready yet.

ext2-reservations.patch
ext2-fix-reservation-extension.patch
make-ext2_get_blocks-static.patch
ext2-balloc-fix-_with_rsv-freeze.patch
ext2-balloc-reset-windowsz-when-full.patch
ext2-balloc-fix-off-by-one-against-rsv_end.patch
ext2-balloc-fix-off-by-one-against-grp_goal.patch
ext2-balloc-say-rb_entry-not-list_entry.patch
ext2-balloc-use-io_error-label.patch

 Not for 2.6.20.  In fact it's unclear whether this should ever be merged -
 ext2 is more an "example filesytem" nowadays.  We'll see.

ext4-if-expression-format.patch
ext4-kmalloc-to-kzalloc.patch
ext4-eliminate-inline-functions.patch

 ext4 maintenance.  Shall merge.

tty-signal-tty-locking.patch
tty-signal-tty-locking-3270-fix.patch
do_task_stat-dont-take-tty_mutex.patch
do_acct_process-dont-take-tty_mutex.patch
trivial-make-set_special_pids-static.patch
sys_unshare-remove-a-broken-clone_sighand-code.patch

 tty rework - shall merge

pktcdvd-reusability-of-procfs-functions.patch
pktcdvd-make-procfs-interface-optional.patch
pktcdvd-bio-write-congestion-using-blk_congestion_wait.patch
pktcdvd-bio-write-congestion-using-blk_congestion_wait-fix.patch
pktcdvd-add-sysfs-and-debugfs-interface.patch

 Shall merge

remove-the-old-bd_mutex-lockdep-annotation.patch
new-bd_mutex-lockdep-annotation.patch
remove-lock_key-approach-to-managing-nested-bd_mutex-locks.patch
simplify-some-aspects-of-bd_mutex-nesting.patch
use-mutex_lock_nested-for-bd_mutex-to-avoid-lockdep-warning.patch
avoid-lockdep-warning-in-md.patch
bdev-fix-bd_part_count-leak.patch

 Shall merge.

generic-bug-implementation.patch
generic-bug-implementation-handle-bug=n.patch
generic-bug-implementation-include-linux-bugh-must-always-include-linux-moduleh.patch
generic-bug-for-i386.patch
generic-bug-for-x86-64.patch
uml-add-generic-bug-support.patch
use-generic-bug-for-ppc.patch
fix-generic-warn_on-message.patch

 Shall merge.

#generic-bug-for-powerpc.patch
#generic-bug-for-powerpc-fix.patch

 Shall then send these to the powerpc guys to look at - it crashes for me.

bit-revese-library.patch
crc32-replace-bitreverse-by-bitrev32.patch
video-use-bitrev8.patch
net-use-bitrev8.patch
net-use-bitrev8-tidy.patch
isdn-hisax-use-bitrev8.patch
atm-ambassador-use-bitrev8.patch
isdn-gigaset-use-bitrev8.patch

 Shall merge.

fsstack-introduce-fsstack_copy_attrinode_.patch
fsstack-introduce-fsstack_copy_attrinode_-tidy.patch
fsstack-introduce-fsstack_copy_attrinode_-fs-stackc-should-include-linux-fs_stackh.patch
ecryptfs-use-fsstacks-generic-copy-inode-attr.patch
ecryptfs-use-fsstacks-generic-copy-inode-attr-tidy-fix.patch
ecryptfs-use-fsstacks-generic-copy-inode-attr-tidy-fix-fix.patch
struct-path-rename-reiserfss-struct-path.patch
struct-path-rename-dms-struct-path.patch
struct-path-move-struct-path-from-fs-nameic-into.patch
struct-path-make-ecryptfs-a-user-of-struct-path.patch
vfs-change-struct-file-to-use-struct-path.patch
sysfs-change-uses-of-f_dentry.patch
proc-change-uses-of-f_dentry-vfsmnt-to-use-f_path.patch
ext2-change-uses-of-f_dentry-vfsmnt-to-use-f_path.patch
ext3-change-uses-of-f_dentry-vfsmnt-to-use-f_path.patch
ext4-change-uses-of-f_dentry-vfsmnt-to-use-f_path.patch
fat-change-uses-of-f_dentryvfsmnt-to-use-f_path.patch
isofs-change-uses-of-f_dentry.patch
nfs-change-uses-of-f_dentryvfsmnt-to-use-f_path.patch
nfsd-change-uses-of-f_dentry-vfsmnt-to-use-f_path.patch
ntfs-change-uses-of-f_dentry-vfsmnt-to-use-f_path.patch
i386-change-uses-of-f_dentry-vfsmnt-to-use-f_path.patch
x86_64-change-uses-of-f_dentry.patch
kernel-change-uses-of-f_dentry.patch
mm-change-uses-of-f_dentryvfsmnt-to-use-f_path.patch
9p-change-uses-of-f_dentryvfsmnt-to-use-f_path.patch
affs-change-uses-of-f_dentry-vfsmnt-to-use-f_path.patch
autofs-change-uses-of-f_dentry.patch
autofs4-change-uses-of-f_dentry.patch
configfs-change-uses-of-f_dentry.patch
cifs-change-uses-of-f_dentry-vfsmnt-to-use-f_path.patch
ecryptfs-change-uses-of-f_dentry.patch
xfs-change-uses-of-f_dentryvfsmnt-to-use-f_path.patch
struct-path-convert-adfs.patch
struct-path-convert-afs.patch
struct-path-convert-alpha.patch
struct-path-convert-atm.patch
struct-path-convert-befs.patch
struct-path-convert-bfs.patch
struct-path-convert-block.patch
struct-path-convert-block_drivers.patch
struct-path-convert-char-drivers.patch
struct-path-convert-coda.patch
struct-path-convert-cosa.patch
struct-path-convert-cramfs.patch
struct-path-convert-cris.patch
struct-path-convert-drm.patch
struct-path-convert-efs.patch
struct-path-convert-freevxfs.patch
struct-path-convert-frv.patch
struct-path-convert-fuse.patch
struct-path-convert-gfs2.patch
struct-path-convert-hfs.patch
struct-path-convert-hfsplus.patch
struct-path-convert-hostfs.patch
struct-path-convert-hpfs.patch
struct-path-convert-hppfs.patch
struct-path-convert-hugetlbfs.patch
struct-path-convert-i2c-drivers.patch
struct-path-convert-ia64.patch
struct-path-convert-ieee1394.patch
struct-path-convert-infiniband.patch
struct-path-convert-ipc.patch
struct-path-convert-ipmi.patch
struct-path-convert-isapnp.patch
struct-path-convert-isdn.patch
struct-path-convert-ixj.patch
struct-path-convert-jffs.patch
struct-path-convert-jffs2.patch
struct-path-convert-jfs.patch
struct-path-convert-kernel.patch
struct-path-convert-lockd.patch
struct-path-convert-md.patch
struct-path-convert-minix.patch
struct-path-convert-mips.patch
struct-path-convert-mm.patch
struct-path-convert-nbd.patch
struct-path-convert-ncpfs.patch
struct-path-convert-net.patch
struct-path-convert-netfilter.patch
struct-path-convert-netlink.patch
struct-path-convert-ocfs2.patch
struct-path-convert-openpromfs.patch
struct-path-convert-oprofile.patch
struct-path-convert-parisc.patch
struct-path-convert-pci.patch
struct-path-convert-pcmcia.patch
struct-path-convert-powerpc.patch
struct-path-convert-ppc.patch
struct-path-convert-qnx4.patch
struct-path-convert-ramfs.patch
struct-path-convert-reiserfs.patch
struct-path-convert-romfs.patch
struct-path-convert-s390-drivers.patch
struct-path-convert-s390.patch
struct-path-convert-sbus.patch
struct-path-convert-scsi.patch
struct-path-convert-selinux.patch
struct-path-convert-sh.patch
struct-path-convert-smbfs.patch
struct-path-convert-sound.patch
struct-path-convert-sparc.patch
struct-path-convert-sparc64.patch
struct-path-convert-sunrpc.patch
struct-path-convert-sysv.patch
struct-path-convert-udf.patch
struct-path-convert-ufs.patch
struct-path-convert-unix.patch
struct-path-convert-usb.patch
struct-path-convert-v4l.patch
struct-path-convert-video.patch
struct-path-convert-zorro.patch

 Shall merge.  I guess.  Doesn't seem very useful.

log2-implement-a-general-integer-log2-facility-in-the-kernel.patch
log2-implement-a-general-integer-log2-facility-in-the-kernel-fix.patch
log2-implement-a-general-integer-log2-facility-in-the-kernel-vs-git-cryptodev.patch
log2-implement-a-general-integer-log2-facility-in-the-kernel-ppc-fix.patch
log2-alter-roundup_pow_of_two-so-that-it-can-use-a-ilog2-on-a-constant.patch
log2-alter-get_order-so-that-it-can-make-use-of-ilog2-on-a-constant.patch
log2-provide-ilog2-fallbacks-for-powerpc.patch

 Shall merge.

add-process_session-helper-routine.patch
add-process_session-helper-routine-deprecate-old-field.patch
add-process_session-helper-routine-deprecate-old-field-tidy.patch
add-process_session-helper-routine-deprecate-old-field-fix-warnings.patch
add-process_session-helper-routine-deprecate-old-field-fix-warnings-2.patch
add-process_session-helper-routine-deprecate-old-field-fix-warnings-fix.patch
rename-struct-namespace-to-struct-mnt_namespace.patch
add-an-identifier-to-nsproxy.patch
rename-struct-pspace-to-struct-pid_namespace.patch
add-pid_namespace-to-nsproxy.patch
use-current-nsproxy-pid_ns.patch
add-child-reaper-to-pid_namespace.patch
sys_setpgid-eliminate-unnecessary-do_each_task_pidpidtype_pgid.patch
session_of_pgrp-kill-unnecessary-do_each_task_pidpidtype_pgid.patch

 Shall merge.

generic-ioremap_page_range-mips-conversion.patch
generic-ioremap_page_range-parisc-conversion.patch
generic-ioremap_page_range-s390-conversion.patch
generic-ioremap_page_range-sh-conversion.patch
generic-ioremap_page_range-sh64-conversion.patch

 Shall merge.

mxser-correct-tty-driver-name.patch
pci-mxser-pci-refcounts.patch
mxser-make-an-experimental-clone.patch
mxser-session-warning-fix.patch
char-mxser_new-correct-include-file.patch
char-mxser_new-upgrade-to-191.patch
char-mxser_new-rework-to-allow-dynamic-structs.patch
char-mxser_new-use-__devinit-macros.patch
char-mxser_new-pci_request_region-for-pci-regions.patch
char-mxser_new-check-request_region-retvals.patch
char-mxser_new-kill-unneeded-memsets.patch
char-mxser_new-revert-spin_lock-changes.patch
char-mxser_new-remove-request-for-testers-line.patch
char-mxser_new-debug-printk-dependent-on-debug.patch
char-mxser_new-alter-license-terms.patch
char-mxser_new-code-upside-down.patch
char-mxser_new-cmspar-is-defined.patch
char-remove-unneded-termbits-redefinitions-mxser_new.patch
char-mxser_new-eliminate-tty-ldisc-deref.patch
char-mxser_new-testbit-for-bit-testing.patch
char-mxser_new-correct-fail-paths.patch
char-mxser_new-dont-check-tty_unregister-retval.patch
char-mxser_new-compress-isa-finding.patch
char-mxser_new-register-tty-devices-on-the-fly.patch
char-mxser_new-compact-structures-round2.patch
char-mxser_new-reverse-if-else-paths-patch.patch
char-mxser_new-comments-cleanup.patch
char-mxser_new-correct-intr-handler-proto.patch
char-mxser_new-delete-ttys-and-termios.patch
char-mxser_new-pci-probing.patch
char-mxser_new-clean-macros.patch
maintainers-add-me-to-isicom-mxser.patch
mxser_new-correct-tty-driver-name.patch
char-stallion-use-pr_debug-macro.patch
char-stallion-remove-unneeded-casts.patch
char-stallion-kill-typedefs.patch
char-stallion-move-init-deinit.patch
char-stallion-uninline-functions.patch
char-stallion-mark-functions-as-init.patch
char-stallion-remove-many-prototypes.patch

 Shall merge.

tty-preparatory-structures-for-termios-revamp.patch
tty-preparatory-structures-for-termios-revamp-strip-fix.patch
tty-switch-to-ktermios-and-new-framework.patch
tty-switch-to-ktermios-and-new-framework-warning-fix.patch
tty-switch-to-ktermios-and-new-framework-irda-fix.patch
tty-switch-to-ktermios.patch
tty-switch-to-ktermios-nozomi-fix.patch
tty-switch-to-ktermios-bluetooth-fix.patch
tty-switch-to-ktermios-sclp-fix.patch
tty-switch-to-ktermios-3270-fix.patch
tty-switch-to-ktermios-powerpc-fix.patch
tty-switch-to-ktermios-uml-fix.patch
tty-switch-to-ktermios-uml-fix-2.patch
tty_ioctl-use-termios-for-the-old-structure-and-termios2.patch
tty_ioctl-use-termios-for-the-old-structure-and-termios2-fix.patch
tty_ioctl-use-termios-for-the-old-structure-and-termios2-update.patch
termios-enable-new-style-termios-ioctls-on-x86-64.patch

 termios -> ktermios work.  Shall merge.

char-isicom-expand-function.patch
char-isicom-rename-init-function.patch
char-isicom-remove-isa-code.patch
char-isicom-remove-unneeded-memset.patch
char-isicom-move-to-tty_register_device.patch
char-isicom-use-pci_request_region.patch
char-isicom-check-kmalloc-retval.patch
char-isicom-use-completion.patch
char-isicom-simplify-timer.patch
char-isicom-remove-cvs-stuff.patch
char-isicom-fix-tty-index-check.patch
char-sx-convert-to-pci-probing.patch
char-sx-use-kcalloc.patch
char-sx-mark-functions-as-devinit.patch
char-sx-use-eisa-probing.patch
char-sx-ifdef-isa-code.patch
char-sx-lock-boards-struct.patch
char-sx-remove-duplicite-code.patch
char-sx-whitespace-cleanup.patch
char-sx-simplify-timer-logic.patch
char-sx-fix-return-in-module-init.patch
char-sx-use-pci_iomap.patch
char-sx-request-regions.patch
char-stallion-convert-to-pci-probing.patch
char-stallion-prints-cleanup.patch
char-stallion-implement-fail-paths.patch
char-stallion-correct-__init-macros.patch
char-stallion-functions-cleanup.patch
char-stallion-fix-fail-paths.patch
char-stallion-brd-struct-locking.patch
char-stallion-remove-syntactic-sugar.patch
char-stallion-variables-cleanup.patch
char-stallion-use-dynamic-dev.patch
char-istallion-convert-to-pci-probing.patch
char-istallion-remove-the-mess.patch
char-istallion-eliminate-typedefs.patch
char-istallion-variables-cleanup.patch
char-istallion-ifdef-eisa-code.patch
char-istallion-brdnr-locking.patch
char-istallion-free-only-isa.patch
char-istallion-correct-fail-paths.patch
char-istallion-fix-enabling.patch
char-istallion-move-init-and-exit-code.patch
char-istallion-change-init-sequence.patch
char-istallion-dynamic-tty-device.patch
char-istallion-use-mod_timer.patch
char-cyclades-save-indent-levels.patch
char-cyclades-lindent-the-code.patch
char-cyclades-cleanup.patch
char-cyclades-fix-warnings.patch

 Shall merge.

drivers-isdn-handcrafted-min-max-macro-removal.patch
drivers-isdn-handcrafted-min-max-macro-removal-fix.patch
isdn-fix-missing-unregister_capi_driver.patch
isdn-avoid-a-potential-null-ptr-deref-in-ippp.patch
drivers-isdn-trivial-vsnprintf-conversion.patch
isdn-replace-kmallocmemset-with-kzalloc.patch
i4l-remove-the-broken-hisax_amd7930-option.patch
isdn-fix-warnings.patch

 ISDN.  Shall merge.

lockdep-annotate-nfsd4-recover-code.patch
nfs2-calculate-w-a-bit-later-in-nfsaclsvc_encode_getaclres.patch
nfs3-calculate-w-a-bit-later-in-nfs3svc_encode_getaclres.patch
nfsd-replace-kmallocmemset-with-kcalloc.patch

 nfsd - shall merge.

fault-injection-documentation-and-scripts.patch
fault-injection-capabilities-infrastructure.patch
fault-injection-capabilities-infrastructure-tidy.patch
fault-injection-capabilities-infrastructure-tweaks.patch
fault-injection-capability-for-kmalloc.patch
fault-injection-capability-for-kmalloc-failslab-remove-__gfp_highmem-filtering.patch
fault-injection-capability-for-alloc_pages.patch
fault-injection-capability-for-disk-io.patch
fault-injection-process-filtering-for-fault-injection-capabilities.patch
fault-injection-stacktrace-filtering.patch
fault-injection-stacktrace-filtering-reject-failure-if-any-caller-lies-within-specified-range.patch
fault-injection-Kconfig-cleanup.patch
fault-injection-stacktrace-filtering-kconfig-fix.patch
fault-injection-Kconfig-cleanup-config_fault_injection-help-text.patch

 Shall merge.

schedc-correct-comment-for-this_rq_lock-routine.patch
sched-fix-migration-cost-estimator.patch
sched-domain-move-sched-group-allocations-to-percpu-area.patch
move_task_off_dead_cpu-should-be-called-with-disabled-ints.patch
sched-domain-increase-the-smt-busy-rebalance-interval.patch
#
sched-avoid-taking-rq-lock-in-wake_priority_sleeper.patch
sched-remove-staggering-of-load-balancing.patch
sched-disable-interrupts-for-locking-in-load_balance.patch
sched-extract-load-calculation-from-rebalance_tick.patch
sched-move-idle-status-calculation-into-rebalance_tick.patch
sched-use-softirq-for-load-balancing.patch
sched-call-tasklet-less-frequently.patch
sched-add-option-to-serialize-load-balancing.patch
sched-add-option-to-serialize-load-balancing-fix.patch
sched-improve-migration-accuracy.patch
sched-improve-migration-accuracy-tidy.patch
sched-improve-migration-accuracy-fix.patch
sched-decrease-number-of-load-balances.patch
#
sched-optimize-activate_task-for-rt-task.patch
kernel-schedc-whitespace-cleanups.patch
kernel-schedc-whitespace-cleanups-more.patch

 CPU scheduler - shall merge subject to maintainer re-review.

sysctl-simplify-sysctl_uts_string.patch
sysctl-implement-sysctl_uts_string.patch
sysctl-simplify-ipc-ns-specific-sysctls.patch
sysctl-fix-sys_sysctl-interface-of-ipc-sysctls.patch
sysctl-fix-sys_sysctl-interface-of-ipc-sysctls-fix-2.patch

 sysctl cleanup - shall merge.

readahead-kconfig-options.patch
readahead-kconfig-options-fix.patch
radixtree-introduce-scan-hole-data-functions.patch
mm-introduce-probe_page.patch
mm-introduce-pg_readahead.patch
readahead-add-look-ahead-support-to-__do_page_cache_readahead.patch
readahead-insert-cond_resched-calls.patch
readahead-minmax_ra_pages.patch
readahead-events-accounting.patch
readahead-events-accounting-make-readahead_debug_level-static.patch
readahead-rescue_pages.patch
readahead-sysctl-parameters.patch
readahead-sysctl-parameters-use-ctl_unnumbered.patch
readahead-sysctl-parameters-fix.patch
readahead-min-max-sizes.patch
readahead-state-based-method-aging-accounting.patch
readahead-state-based-method-routines.patch
readahead-state-based-method.patch
readahead-context-based-method.patch
readahead-context-based-method-locking-fix.patch
readahead-context-based-method-locking-fix-2.patch
readahead-initial-method-guiding-sizes.patch
readahead-initial-method-thrashing-guard-size.patch
readahead-initial-method-user-recommended-size.patch
readahead-initial-method.patch
readahead-backward-prefetching-method.patch
readahead-thrashing-recovery-method.patch
readahead-call-scheme.patch
readahead-call-scheme-ifdef-fix.patch
readahead-call-scheme-build-fix.patch
readahead-laptop-mode.patch
readahead-loop-case.patch
readahead-nfsd-case.patch
readahead-nfsd-case-fix.patch
readahead-nfsd-case-fix-uninitialized-ra_min-ra_max.patch
readahead-turn-on-by-default.patch
readahead-remove-size-limit-on-read_ahead_kb.patch
readahead-remove-size-limit-of-max_sectors_kb-on-read_ahead_kb.patch

 Shall hold in -mm.

reiser4-sb_sync_inodes.patch
reiser4-export-remove_from_page_cache.patch
reiser4-export-remove_from_page_cache-fix.patch
reiser4-export-radix_tree_preload.patch
reiser4-export-find_get_pages.patch
make-copy_from_user_inatomic-not-zero-the-tail-on-i386-vs-reiser4.patch
reiser4.patch
reiser4-configh.patch
resier4-add-include-linux-freezerh-and-move-definitions-from.patch
reiser4-reiser4_drop_page-dont-call-remove_from_page_cache.patch
make-kmem_cache_destroy-return-void-reiser4.patch
reiser4-hardirq-include-fix.patch
reiser4-fix-trivial-tyops-which-were-hard-to-hit.patch
reiser4-run-truncate_inode_pages-in-reiser4_delete_inode.patch
reiser4-bug-fixes.patch
reiser4-fix-gcc-ws-compains.patch
fs-reiser4-possible-cleanups.patch
reiser4-get_sb_dev-fix.patch
reiser4-vs-zoned-allocator.patch
inode_diet-replace-inodeugeneric_ip-with-inodei_private-reiser4.patch
inode-diet-eliminate-i_blksize-and-use-a-per-superblock-default-reiser4.patch
reiser4-vs-streamline-generic_file_-interfaces-and-filemap.patch
reiser4-vs-streamline-generic_file_-interfaces-and-filemap-fix.patch
reiser4-rename-generic_sounding_globalspatch.patch
reiser4-get-rid-of-semaphores-wherever-it-is-possible.patch
reiser4-decribe-new-atom-locking-and-nested-atom-locks-to-lock-validator.patch
reiser4-use-generic-file-read.patch
reiser4-use-generic-file-read-fix-readpages-unix-file.patch
reiser4-simplify-reading-of-partially-converted-files.patch
reiser4-use-page_offset.patch
reiser4-use-reiser4_gfp_mask_get-in-reiser4-inode-allocation.patch
reiser4-re-add-page_count-check-to-reiser4_releasepage.patch
reiser4-restore-fibmap-ioctl-support-for-packed-files.patch
reiser4-possible-cleanups-2.patch
reiser4-format-subversion-numbers-heir-set-and-file-conversion.patch
reiser4-format-subversion-numbers-heir-set-and-file-conversion-fix-readpages-cryptcompress.patch
reiser4-cleanups-in-lzo-compression-library.patch
reiser4-get-rid-of-deprecated-crypto-api.patch
reiser4-get-rid-of-deprecated-crypto-api-build-fix.patch
reiser4-fix-missed-unlock-and-exit_context.patch
reiser4-use-list_head-instead-of-struct-blocknr.patch
reiser4-use-list_empty-instead-of-list_empty_careful-for.patch
reiser4-update-comments-fix-write-and-truncate-cryptcompress.patch
reiser4-temp-fix.patch
fs-reiser4-possible-cleanups-2.patch
fs-reiser4-more-possible-cleanups.patch
reiser4-use-null-for-pointers.patch

 Shall hold in -mm.

ide-hpt3xxn-clocking-fixes.patch
ide-fix-hpt37x-timing-tables.patch
ide-optimize-hpt37x-timing-tables.patch
ide-fix-hpt3xx-hotswap-support.patch
ide-fix-the-case-of-multiple-hpt3xx-chips-present.patch
ide-hpt3xx-fix-pci-clock-detection.patch
ide-hpt3xx-fix-pci-clock-detection-fix-2.patch
piix-fix-82371mx-enablebits.patch
piix-remove-check-for-broken-mw-dma-mode-0.patch
piix-slc90e66-pio-mode-fallback-fix.patch
hpt3xx-rework-rate-filtering.patch
hpt3xx-rework-rate-filtering-tidy.patch
hpt3xx-print-the-real-chip-name-at-startup.patch
hpt3xx-switch-to-using-pci_get_slot.patch
hpt3xx-cache-channels-mcr-address.patch
hpt3x7-merge-speedproc-handlers.patch
hpt370-clean-up-dma-timeout-handling.patch
hpt3xx-init-code-rewrite.patch
jmicron-warning-fix.patch

 Scary IDE changes.  Shall poll Alan again.

ide-more-conversion-to-pci_get-apis.patch
pdc202xx_new-fix-pio-mode-setup.patch
ide-cd-handle-strange-interrupt-on-the-intel-esb2.patch

 Shall merge.

ioremap-balanced-with-iounmap-for-drivers-video-virgefb.patch
ioremap-balanced-with-iounmap-for-drivers-video-vesafb.patch
ioremap-balanced-with-iounmap-for-drivers-video-tridentfb.patch
ioremap-balanced-with-iounmap-for-drivers-video-tgafb.patch
ioremap-balanced-with-iounmap-for-drivers-video-stifb.patch
ioremap-balanced-with-iounmap-for-drivers-video-retz3fb.patch
ioremap-balanced-with-iounmap-for-drivers-video-pvr2fb.patch
ioremap-balanced-with-iounmap-for-drivers-video-platinumfb.patch
ioremap-balanced-with-iounmap-for-drivers-video-offb.patch
ioremap-balanced-with-iounmap-for-drivers-video-macfb.patch
ioremap-balanced-with-iounmap-for-drivers-video-hpfb.patch
ioremap-balanced-with-iounmap-for-drivers-video-fm2fb.patch
ioremap-balanced-with-iounmap-for-drivers-video-ffb.patch
ioremap-balanced-with-iounmap-for-drivers-video-cyberfb.patch
ioremap-balanced-with-iounmap-for-drivers-video-cirrusfb.patch
ioremap-balanced-with-iounmap-for-drivers-video-atyfb_base.patch
ioremap-balanced-with-iounmap-for-drivers-video-atafb.patch
ioremap-balanced-with-iounmap-for-drivers-video-amifb.patch
ioremap-balanced-with-iounmap-for-drivers-video-S3triofb.patch
atyfb-rivafb-minor-fixes.patch
igafb-switch-to-pci_get-api.patch
video-sis-remove-unnecessary-variables-in-sis_ddc2delay.patch
pmagb-b-fb-fix-a-default-clock.patch
video-get-the-default-mode-from-the-right-database.patch
s3c2410fb-add-support-for-stn-displays.patch
fbcmapc-mark-structs-const-or.patch
various-fbdev-files-mark-structs.patch
various-fbdev-files-mark-structs-fix.patch
constify-and-annotate-__read_mostly.patch
annotate-some-variables-in-vesafb.patch
constify-vga16fbc.patch
au1100fb-fix-to-remove-flickering.patch
mbxfb-fix-hscoeff3-register-address.patch
mbxfb-add-more-registers-bits.patch
mbxfb-add-more-registers-to-debugfs.patch
mbxfb-add-yuv-video-overlay-support.patch
mbxfb-document-the-new-ioctl.patch
atyfb-remove-fixme.patch
atyfb-fix-compiler-warnings.patch
atyfb-fix-sparse-warnings.patch
atyfb-fix-blanking-level.patch
atyfb-remove-pointless-aty_init.patch
atyfb-fix-__init-and-__devinit.patch
atyfb-remove-aty_cmap_regs.patch
atyfb-improve-atyfb_atari_probe.patch
atyfb-improve-power-management.patch
drivers-video-use-kmemdup.patch
visws-sgivwfb-is-module-needs-exports.patch
backlight-lcd-remove-dependenct-from-the-framebuffer-layer.patch
backlight-lcd-remove-dependenct-from-the-framebuffer-layer-tidy.patch
softcursorc-avoid-unaligned-accesses.patch
backlight-do-not-power-off-backlight-when-unregistering-try-3.patch
fb-get-the-geode-gx-frambuffer-size-from-the-bios.patch
gxfb-fixups-for-the-amd-geode-gx.patch
gxfb-fixups-for-the-amd-geode-gx-tidy.patch
gxfb-support-flat-panel-timings.patch
gxfb-support-flat-panel-timings-tidy.patch
gxfb-support-command-line-options.patch
gxfb-support-command-line-options-tidy.patch
gxfb-fixup-flatpanel-detection.patch
gxfb-turn-on-the-flatpanel-power-and-data.patch
video-select-set-for-vesa-fb.patch
video-cyberfb-broken-macro-removal.patch
video-neofb-stray-bracket-fix.patch
video-pm3fb-macros-fix.patch

 Shall merge.

dm-io-fix-bi_max_vecs.patch
dm-tidy-core-formatting.patch
dm-suspend-parameter-change.patch
dm-map-and-endio-return-code-clarification.patch
dm-map-and-endio-symbolic-return-codes.patch
dm-ioctl-add-noflush-suspend.patch
dm-suspend-add-noflush-pushback.patch
dm-mpath-use-noflush-suspending.patch
dm-snapshot-abstract-memory-release.patch
dm-log-rename-complete_resync_work.patch
dm-raid1-reset-sync_search-on-resume.patch
make-drivers-md-dm-snapcksnapd-static.patch

 Shall merge.

md-tidy-up-device-change-notification-when-an-md-array-is-stopped.patch
md-define-raid5_mergeable_bvec.patch
md-handle-bypassing-the-read-cache-assuming-nothing-fails.patch
md-allow-reads-that-have-bypassed-the-cache-to-be-retried-on-failure.patch
md-allow-reads-that-have-bypassed-the-cache-to-be-retried-on-failure-fix.patch
md-allow-reads-that-have-bypassed-the-cache-to-be-retried-on-failure-misc-fixes-for-aligned-read-handling-including-raid6-read-corruption.patch
md-allow-reads-that-have-bypassed-the-cache-to-be-retried-on-failure-misc-fixes-for-error-handling-of-aligned-reads.patch
md-enable-bypassing-cache-for-reads.patch
md-fix-innocuous-bug-in-raid6-stripe_to_pdidx.patch
md-conditionalize-some-code.patch

 I have a note here "The MD patches probably broke jurriaan
 <thunder7@xs4all.nl>'s setup".  Need to work out whether that got resolved.

md-change-lifetime-rules-for-md-devices.patch

 This caused oopses for Jiri Kosina <jikos@jikos.cz>

md-dm-reduce-stack-usage-with-stacked-block-devices.patch

 Shall hold in -mm.

statistics-infrastructure-prerequisite-list.patch
statistics-infrastructure-prerequisite-parser.patch
statistics-infrastructure-prerequisite-timestamp.patch
statistics-infrastructure-make-printk_clock-a-generic-kernel-wide-nsec-resolution.patch
statistics-infrastructure-make-printk_clock-a-generic-kernel-wide-nsec-resolution-ia64-fix.patch
statistics-infrastructure-documentation.patch
statistics-infrastructure.patch
statistics-infrastructure-fix-buffer-overflow-in-histogram-with-linear.patch
statistics-infrastructure-fix-buffer-overflow-in-histogram-with-linear-tidy.patch
statistics-infrastructure-adapt-output-format-of-utilisation-indicator.patch
statistics-use-the-enhanced-percpu-interface.patch
statistics-replace-inode-ugeneric_ip-with-i_private.patch
statistics-infrastructure-exploitation-zfcp.patch
zfcp-gather-hba-specific-latencies-in-statistics.patch

 Still trying to generate a case for merging this.

extend-notifier_call_chain-to-count-nr_calls-made.patch
extend-notifier_call_chain-to-count-nr_calls-made-fixes.patch
extend-notifier_call_chain-to-count-nr_calls-made-fixes-2.patch
define-and-use-new-eventscpu_lock_acquire-and-cpu_lock_release.patch
define-and-use-new-eventscpu_lock_acquire-and-cpu_lock_release-fix.patch
eliminate-lock_cpu_hotplug-in-kernel-schedc.patch
eliminate-lock_cpu_hotplug-in-kernel-schedc-fix.patch
handle-cpu_lock_acquire-and-cpu_lock_release-in-workqueue_cpu_callback.patch

 Shall merge.

mark-pci_module_init-deprecated.patch

 Send to Greg.

dio-centralize-completion-in-dio_complete.patch
dio-call-blk_run_address_space-once-per-op.patch
dio-formalize-bio-counters-as-a-dio-reference-count.patch
dio-remove-duplicate-bio-wait-code.patch
dio-only-call-aio_complete-after-returning-eiocbqueued.patch
dio-lock-refcount-operations.patch

 Shall merge.

fdtable-delete-pointless-code-in-dup_fd.patch
fdtable-make-fdarray-and-fdsets-equal-in-size.patch
fdtable-remove-the-free_files-field.patch
fdtable-implement-new-pagesize-based-fdtable-allocator.patch
fdtable-implement-new-pagesize-based-fdtable-allocator-fix.patch
fdtable-implement-new-pagesize-based-fdtable-allocator-bound-minimum-allocation-size.patch
fdtable-implement-new-pagesize-based-fdtable-allocator-avoid-fdset-cacheline-ping-pong.patch

 Shall merge.

gtod-exponential-update_wall_time.patch

 Roman wanted this dropped, and afaik that's unresolved.

gtod-persistent-clock-support-core.patch
gtod-persistent-clock-support-core-remove-kernel-timercwall_jiffies.patch
gtod-persistent-clock-support-i386.patch
gtod-persistent-clock-support-i386-i386-unexport-read_persistent_clock.patch
time-uninline-jiffiesh.patch
time-uninline-jiffiesh-fix.patch
time-fix-msecs_to_jiffies-bug.patch
time-fix-timeout-overflow.patch
cleanup-uninline-irq_enter-and-move-it-into-a-function.patch
dynticks-extend-next_timer_interrupt-to-use-a-reference-jiffie.patch
dynticks-extend-next_timer_interrupt-to-use-a-reference-jiffie-remove-incorrect-warning-in-kernel-timerc.patch
dynticks-extend-next_timer_interrupt-to-use-a-reference-jiffie-make-kernel-timerc__next_timer_interrupt-static.patch
hrtimers-namespace-and-enum-cleanup.patch
hrtimers-clean-up-locking.patch
hrtimers-clean-up-locking-fix.patch
updated-hrtimers-state-tracking.patch
updated-hrtimers-clean-up-callback-tracking.patch
updated-hrtimers-move-and-add-documentation.patch
updated-add-a-framework-to-manage-clock-event-devices.patch
updated-acpi-include-apich.patch
updated-acpi-keep-track-of-timer-broadcast.patch
updated-acpi-add-state-propagation-for-dynamic-broadcasting.patch
updated-i386-cleanup-apic-code.patch
updated-i386-convert-to-clock-event-devices.patch
updated-i386-convert-to-clock-event-devices-fix.patch
updated-i386-convert-to-clock-event-devices-arch-i386-kernel-apicc-make-a-function-static.patch
updated-i386-convert-to-clock-event-devices-remove-arch-i386-kernel-time_hpetchpet_reenable.patch
updated-pm_timer-allow-early-access-and-move-externs-to-a-header-file.patch
updated-i386-rework-local-apic-calibration.patch
updated-high-res-timers-core.patch
updated-high-res-timers-core-high-res-timers-do-itimer-rearming-in-process-context.patch
updated-gtod-mark-tsc-unusable-for-highres-timers.patch
high-res-timers-utilize-tsc-clocksource-again.patch
high-res-timers-utilize-tsc-clocksource-again-fix.patch
updated-dynticks-core-code.patch
updated-dynticks-core-code-fix-resume-bug.patch
updated-dyntick-add-nohz-stats-to-proc-stat.patch
updated-dynticks-i386-arch-code.patch
updated-dynticks-fix-nmi-watchdog.patch
updated-high-res-timers-dynticks-enable-i386-support.patch
updated-debugging-feature-timer-stats.patch

 Shall merge, I guess.  My confidence is low, but it's Kconfigurable and it
 needs to get sorted out.

clockevents-core-check-for-clock-event-device-handler-being-non-null-before-calling-it.patch
round_jiffies-infrastructure.patch
round_jiffies-infrastructure-fix.patch
user-of-the-jiffies-rounding-patch-ata-subsystem.patch
user-of-the-jiffies-rounding-code-jbd.patch
user-of-the-jiffies-rounding-code-networking.patch
user-of-the-jiffies-rounding-patch-slab.patch
clocksource-add-usage-of-config_sysfs.patch
clocksource-small-cleanup-2.patch
clocksource-small-cleanup-2-fix.patch
clocksource-small-acpi_pm-cleanup.patch

 Shall merge.

kvm-userspace-interface.patch
kvm-userspace-interface-make-enum-values-in-userspace-interface-explicit.patch
kvm-intel-virtual-mode-extensions-definitions.patch
kvm-kvm-data-structures.patch
kvm-random-accessors-and-constants.patch
kvm-virtualization-infrastructure.patch
kvm-virtualization-infrastructure-kvm-fix-guest-cr4-corruption.patch
kvm-virtualization-infrastructure-include-desch.patch
kvm-virtualization-infrastructure-fix-segment-state-changes-across-processor-mode-switches.patch
kvm-virtualization-infrastructure-fix-asm-constraints-for-segment-loads.patch
kvm-virtualization-infrastructure-fix-mmu-reset-locking-when-setting-cr0.patch
kvm-memory-slot-management.patch
kvm-memory-slot-management-zero-guest-memory-before-use.patch
kvm-vcpu-creation-and-maintenance.patch
kvm-vcpu-creation-and-maintenance-segment-access-cleanup.patch
kvm-workaround-cr0cd-cache-disable-bit-leak-from-guest-to.patch
kvm-vcpu-execution-loop.patch
kvm-define-exit-handlers.patch
kvm-define-exit-handlers-pass-fs-gs-segment-bases-to-x86-emulator.patch
kvm-less-common-exit-handlers.patch
kvm-less-common-exit-handlers-handle-rdmsrmsr_efer.patch
kvm-mmu.patch
kvm-mmu-mmu-honor-global-bit-on-huge-pages.patch
kvm-x86-emulator.patch
kvm-x86-emulator-x86-emulator-handle-smsw.patch
kvm-clarify-licensing.patch
kvm-x86-emulator-fix-emulator-mov-cr-decoding.patch
kvm-plumbing.patch
kvm-dynamically-determine-which-msrs-to-load-and-save.patch
kvm-fix-calculation-of-initial-value-of-rdx-register.patch
kvm-avoid-using-vmx-instruction-directly.patch
kvm-avoid-using-vmx-instruction-directly-fix-asm-constraints.patch
kvm-expose-interrupt-bitmap.patch
kvm-add-time-stamp-counter-msr-and-accessors.patch
kvm-expose-msrs-to-userspace.patch
kvm-expose-msrs-to-userspace-v2.patch
kvm-create-kvm-intelko-module.patch
kvm-make-dev-registration-happen-when-the-arch.patch
kvm-make-hardware-detection-an-arch-operation.patch
kvm-make-the-per-cpu-enable-disable-functions-arch.patch
kvm-make-the-hardware-setup-operations-non-percpu.patch
kvm-make-the-guest-debugger-an-arch-operation.patch
kvm-make-msr-accessors-arch-operations.patch
kvm-make-the-segment-accessors-arch-operations.patch
kvm-cache-guest-cr4-in-vcpu-structure.patch
kvm-cache-guest-cr0-in-vcpu-structure.patch
kvm-add-get_segment_base-arch-accessor.patch
kvm-add-idt-and-gdt-descriptor-accessors.patch
kvm-make-syncing-the-register-file-to-the-vcpu.patch
kvm-make-the-vcpu-execution-loop-an-arch-operation.patch
kvm-make-the-vcpu-execution-loop-an-arch-operation-build-fix.patch
kvm-move-the-vmx-exit-handlers-to-vmxc.patch
kvm-make-vcpu_setup-an-arch-operation.patch
kvm-make-__set_cr0-and-dependencies-arch-operations.patch
kvm-make-__set_cr4-an-arch-operation.patch
kvm-make-__set_efer-an-arch-operation.patch
kvm-make-__set_efer-an-arch-operation-build-fix.patch
kvm-make-set_cr3-and-tlb-flushing-arch-operations.patch
kvm-make-inject_page_fault-an-arch-operation.patch
kvm-make-inject_gp-an-arch-operation.patch
kvm-use-the-idt-and-gdt-accessors-in-realmode-emulation.patch
kvm-use-the-general-purpose-register-accessors-rather.patch
kvm-move-the-vmx-tsc-accessors-to-vmxc.patch
kvm-access-rflags-through-an-arch-operation.patch
kvm-move-the-vmx-segment-field-definitions-to-vmxc.patch
kvm-add-an-arch-accessor-for-cs-d-b-and-l-bits.patch
kvm-add-a-set_cr0_no_modeswitch-arch-accessor.patch
kvm-make-vcpu_load-and-vcpu_put-arch-operations.patch
kvm-make-vcpu-creation-and-destruction-arch-operations.patch
kvm-move-vmcs-static-variables-to-vmxc.patch
kvm-make-is_long_mode-an-arch-operation.patch
kvm-use-the-tlb-flush-arch-operation-instead-of-an.patch
kvm-remove-guest_cpl.patch
kvm-move-vmcs-accessors-to-vmxc.patch
kvm-move-vmx-helper-inlines-to-vmxc.patch
kvm-remove-vmx-includes-from-arch-independent-code.patch
kvm-amd-svm-add-architecture-definitions-for-amd-svm.patch
kvm-amd-svm-enhance-x86-emulator.patch
kvm-amd-svm-enhance-x86-emulator-fix-mov-to-from-control-register-emulation.patch
kvm-amd-svm-add-missing-tlb-flushes-to-the-guest-mmu.patch
kvm-amd-svm-add-data-structures.patch
kvm-amd-svm-implementation.patch
kvm-amd-svm-implementation-avoid-three-more-new-instructions.patch
kvm-amd-svm-implementation-more-i386-fixes.patch
kvm-amd-svm-implementation-printk-log-levels.patch
kvm-amd-svm-plumbing.patch
kvm-fix-null-and-c99-init-sparse-warnings.patch
kvm-load-i386-segment-bases.patch

 Shall fold into a single patch and merge it.

mprotect-patch-for-use-by-slim.patch
integrity-service-api-and-dummy-provider.patch
integrity-service-api-and-dummy-provider-cleanup-use-of-configh.patch
integrity-service-api-and-dummy-provider-compilation-warning-fix.patch
slim-main-patch.patch
slim-main-patch-socket_post_create-hook-return-code.patch
slim-main-patch-misc-cleanups-requested-at-inclusion-time.patch
slim-main-patch-handle-failure-to-register.patch
slim-main-patch-fix-bug-with-mm_users-usage.patch
slim-main-patch-security-slim-slm_mainc-make-2-functions-static.patch
slim-secfs-patch.patch
slim-secfs-patch-slim-correct-use-of-snprintf.patch
slim-secfs-patch-cleanup-use-of-configh.patch
slim-make-and-config-stuff.patch
slim-make-and-config-stuff-makefile-fix.patch
slim-debug-output.patch
slim-fix-security-issue-with-the-task_post_setuid-hook.patch
slim-secfs-inode-i_private-build-fix.patch
slim-documentation.patch
fdtable-make-fdarray-and-fdsets-equal-in-size-slim.patch

 Shall hold in -mm.


