Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265210AbUATIH2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 03:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265221AbUATIH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 03:07:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:940 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265210AbUATIFT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 03:05:19 -0500
Date: Tue, 20 Jan 2004 00:05:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.6.1-mm5
Message-Id: <20040120000535.7fb8e683.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1/2.6.1-mm5/

Mainly a resync

- Various little fixes

- Various fixes to make 2.6.1-mm5 successfully build and run with current
  gcc CVS (gcc-3.5).

- Building the IDE drivers as modules should work now.




Changes since 2.6.1-mm4:


 linus.patch

 latest Linus tree

-qla2xxx-build-fix.patch
-sh-merge.patch
-sh-kyrofb-support.patch
-radeon-line-length-fix.patch
-loop-fix-hardsect.patch
-loop-fd-leak-fix.patch
-RD1-open-mm.patch
-RD2-release-mm.patch
-RD3-presto_journal_close-mm.patch
-RD4-f_mapping-mm.patch
-RD5-f_mapping2-mm.patch
-RD6-i_sem-mm.patch
-RD7-f_mapping3-mm.patch
-RD8-generic_osync_inode-mm.patch
-RD9-bd_acquire-mm.patch
-RD10-generic_write_checks-mm.patch
-RD11-I_BDEV-mm.patch
-cramfs-use-pagecache.patch
-raw-driver-refcounting-fix.patch
-input-mousedev-remove-jitter.patch
-input-mousedev-ps2-emulation-fix.patch
-input-01-i8042-suspend.patch
-input-02-i8042-option-parsing.patch
-input-03-psmouse-option-parsing.patch
-input-04-atkbd-option-parsing.patch
-input-05-missing-module-licenses.patch
-input-06-Kconfig-Synaptics-help.patch
-input-07-sis-aux-port.patch
-input-11-98busmouse-compile-fix.patch
-input-12-mouse-drivers-use-module_param.patch
-input-13-tsdev-use-module_param.patch
-keyboard-scancode-fixes.patch
-input-use-after-free-checks.patch
-cpu_sibling_map-fix.patch
-ppc64-WARN_ON.patch
-ppc64-IRQ_INPROGRESS.patch
-ppc64-zImage_default.patch
-ppc64-biarch.patch
-ppc64-PT_FPSCR_fix.patch
-ppc64-writelogbuffer.patch
-ppc64-phandle.patch
-ppc64-of_traversal_api.patch
-ppc64-of_traversal_api_2.patch
-ppc64-vty_node.patch
-ppc64-hvc_console.patch
-ppc64-device_is_compatible.patch
-ppc64-smp_call_function.patch
-ppc64-device_tree_updates.patch
-ppc64-device_tree_updates_2.patch
-ppc64-trivial.patch
-ppc64-device_tree_updates_3.patch
-ppc64-ioremap_rework.patch
-ppc64-rtas_flash.patch
-ppc64-cputable.patch
-ppc64-cputable_2.patch
-ppc64-remove_MAX_PROCESSORS.patch
-ppc64-rtas_functions.patch
-ppc64-rtas_rename.patch
-ppc64-stupidnumabug.patch
-ppc64-devinit_fixes.patch
-ppc64-syscall6.patch
-ppc64-sched_clock.patch
-ppc64-compat_update.patch
-ppc64-sys_rtas.patch
-ppc64-sharedproc.patch
-ppc64-logical_cpu.patch
-ppc64-UP_cleanup.patch
-ppc64-add_vmx.patch
-ppc64-missing_sync.patch
-ppc64-nvram_rewrite.patch
-ppc64-iseries_support.patch
-ppc64-hcall_constants.patch
-ppc64-iseries_cleanup.patch
-ppc64-device_tree_updates_fix.patch
-ppc64-iseries_cleanup_2.patch
-ppc64-remove-veth-proc.patch
-ppc64-add_hcall.patch
-ppc64-addvio.patch
-ppc64-iseries_pci.patch
-ppc64-lparcfg.patch
-ppc64-surveillance.patch
-ppc64-power4fix.patch
-ppc64-vmxsupport.patch
-ppc64-hash_page_race.patch
-ppc64-hash_page_rewrite.patch
-ppc64-mf_proc_cleanup.patch
-ppc64-prom_panic.patch
-ppc64-iseries_pci_2.patch
-ppc64-iseries_fixes.patch
-ppc64-viopath_fix.patch
-ppc64-makefile_fixes.patch
-ppc64-vmlinux_lds.patch
-ppc64-setup_cpu.patch
-ppc64-epoll.patch
-ppc64-compat_stat.patch
-ppc64-xmon_fixes.patch
-ppc64-rtas_delay.patch
-ppc64-bss_clear.patch
-ppc64-vio-fixup.patch
-jffs-use-daemonize.patch
-as-regression-fix.patch
-as-request-poisoning.patch
-as-request-poisoning-fix.patch
-as-fix-all-known-bugs.patch
-as-new-process-estimation.patch
-as-cooperative-thinktime.patch
-as-tuning.patch
-alpha-stack-dump.patch
-ppc-export-consistent_sync_page.patch
-ppc-use-EXPORT_SYMBOL_NOVERS.patch
-ppc-CONFIG_PPC_STD_MMU-fix.patch
-ppc-IBM-MPC-header-cleanups.patch
-percpu-gcc-34-warning-fix.patch
-nr_requests-oops-fix.patch
-netfilter_bridge-compile-fix.patch
-atapi-mo-support.patch
-mt-ranier-support.patch
-atapi-mo-support-update.patch
-ppp_async-locking-fix.patch
-make-try_to_free_pages-walk-zonelist.patch
-make-try_to_free_pages-walk-zonelist-fix.patch
-remove-CardServices-from-pcmcia-net-drivers.patch
-remove-CardServices-from-ide-cs.patch
-remove-CardServices-from-drivers-net-wireless.patch
-remove-CardServices-from-drivers-serial.patch
-remove-CardServices-from-drivers-serial-fix.patch
-remove-CardServices-from-axnet_cs.patch
-remove-CardServices-final.patch
-sysfs-class-01-simple.patch
-sysfs-class-02-input.patch
-sysfs-class-03-lp.patch
-sysfs-class-04-mem.patch
-sysfs-class-05-misc.patch
-sysfs-class-07-oss-sound.patch
-sysfs-class-08-alsa-sound.patch
-sysfs-class-09-cleanup-tty.patch
-tridentfb-non-flatpanel-fix.patch
-CONFIG_EPOLL-file_struct-members.patch
-kill_fasync-speedup.patch
-o21-sched.patch
-sched-clock-2.6.0-A1.patch
-sched-can-migrate-2.6.0-A2.patch
-sched-cleanup-2.6.0-A2.patch
-sched-style-2.6.0-A5.patch
-make-for_each_cpu-iterator-more-friendly.patch
-make-for_each_cpu-iterator-more-friendly-fix.patch
-make-for_each_cpu-iterator-more-friendly-fix-fix.patch
-use-for_each_cpu-in-right-places.patch
-for_each_cpu-oprofile-fix.patch
-for_each_cpu-oprofile-fix-2.patch
-ide-siimage-sil3114.patch
-decrypt-CONFIG_PDC202XX_FORCE-help.patch
-ide-pdc_old-pio-fix.patch
-ide-pdc_old-udma66-fix.patch
-ide-pdc_old-66mhz_clock-fix.patch
-ide-pdc_new-proc.patch
-kernel-locking-doc-end-tags-fix.patch
-rcupdate-c99-initialisers.patch
-68k-339.patch
-68k-340.patch
-68k-341.patch
-68k-342.patch
-68k-343.patch
-68k-344.patch
-68k-345.patch
-68k-346.patch
-68k-347.patch
-68k-348.patch
-68k-349.patch
-68k-350.patch
-68k-351.patch
-68k-352.patch
-68k-353.patch
-68k-354.patch
-68k-355.patch
-68k-361.patch
-68k-364.patch
-68k-367.patch
-68k-368.patch
-68k-369.patch
-68k-374.patch
-68k-375.patch
-68k-377.patch
-68k-379.patch
-68k-380.patch
-68k-381.patch
-68k-382.patch
-68k-383.patch
-68k-385.patch
-68k-386.patch
-68k-387.patch
-68k-390.patch
-printk_ratelimit.patch
-printk_ratelimit-fix.patch
-freevxfs-MODULE_ALIAS.patch
-trident-cleanup-indentation-D1-2.6.0.patch
-trident-sound-driver-fixes.patch
-trident-cleanup-2.patch
-compound-page-page_count-fix.patch
-MAINTAINERS-lanana-update.patch
-devfs-joystick-fix.patch
-s3-sleep-remove-debug-code.patch
-swsusp-doc-updates.patch
-watchdog-updates.patch
-watchdog-updates-2.patch
-ext2_new_inode-cleanup.patch
-ext2-s_next_generation-fix.patch
-ext3-s_next_generation-fix.patch
-alt-arrow-console-switch-fix.patch
-alt-arrow-console-switch-fix-2.patch
-ia32-remove-SIMNOW.patch
-softcursor-fix.patch
-ext2-debug-build-fix.patch
-efi-inline-fixes.patch
-do_timer_gettime-cleanup.patch
-set_cpus_allowed-locking-fix.patch
-rmmod-race-fix.patch
-remove-hpet-intel-check.patch
-devfs-d_revalidate-oops-fix.patch
-ali-m1533-hang-fix.patch
-start_this_handle-retval-fix.patch
-remove-eicon-isdn-driver.patch
-eicon-memory-access-size-fix.patch
-eicon-buffer-allocation-fixes.patch
-do_no_page-leak-fix.patch
-allow-SGI-IOC4-chipset-support.patch
-oss-dmabuf-deadlock-fix.patch
-workqueue-cleanup.patch
-tridentfb-documentation-fix.patch
-proc_pid_lookup-speedup.patch
-bio_endio-clarifications.patch
-rtc-leak-fixes.patch
-simplify-node-zone-fields-3.patch
-radeonfb-pdi-id-addition.patch
-mpt-fusion-update.patch
-alpha-module-relocation-overflow-fix.patch
-ppc32-of-bootwrapper-support.patch
-use-diff-dash-p.patch
-use-kconfig-range-for-NR_CPUS.patch
-bio-documentation-update.patch
-limit-hash-table-size-2.patch
-add-SIOCSIFNAME-compat-ioctl.patch
-init-zone-priorities.patch
-readahead-partial-backout.patch
-readahead-revert-lazy-readahead.patch
-menuconfig-exit-code-fix.patch
-p4-clockmod-cpu-detection-fix.patch
-suspend-resume-for-PIT.patch
-alpha-prefetch_spinlock-fix.patch
-proc-pid-maps-gate-fixes.patch
-tmpfs-readdir-atime-fix.patch
-blockdev-bd_private.patch
-ext3-journal-mode-fix.patch
-efi-conditional-cleanup.patch
-gcc-3_4-needs-attribute_used.patch
-serial-01-fixups.patch
-BUG-to-BUG_ON.patch
-sysrq_key_table_key2index-fix.patch
-set_scheduler-fix.patch
-usr-isapnp-modem-support.patch
-load_elf_interp-error-case-fix.patch
-remove-null-initialisers.patch
-ppc-cond_syscall-fix.patch
-selinux-01-resource-limit-control.patch
-selinux-02-netif-controls.patch
-selinux-03-node-controls.patch
-selinux-04-node_bind-control.patch
-selinux-05-socket_has_perm-cleanup.patch
-selinux-06-SO_PEERSEC-getpeersec.patch
-selinux-07-add-dname-to-audit-output.patch
-selinux-makefile-cleanup.patch
-selinux-improve-skb-audit-logging.patch
-selinux-SEND_MSG-RECV_MSG-controls.patch
-nfs-fix-bogus-setattr-calls.patch
-nfs-optimise-COMMIT-calls.patch
-nfs-open-intent-fix.patch
-nfs-readonly-mounts-fix.patch
-nfs-client-deadlock-fix.patch
-nfs-rpc-debug-oops-fix.patch
-m68knommu-module-support.patch
-m68knommu-module-support-2.patch
-m68knommu-sched_clock.patch
-m68knommu-include-fix.patch
-m68knommu-cpustats-fix.patch
-m68knommu-types-cleanup.patch
-m68knommu-find_extend_vma.patch
-s390-01-base.patch
-s390-02-common-io-layer.patch
-s390-03-console-driver.patch
-s390-04-dasd-driver.patch
-s390-05-tape-driver.patch
-s390-06-network-drivers.patch
-s390-07-zfcp-host-adapter.patch
-s390-07-zfcp-host-adapter-update.patch
-s390-08-new-3270-driver.patch
-s390-09-32-bit-emulation-fixes.patch
-s390-10-32-bit-ioctl-emulation-fixes.patch
-s390-11-tlb-flush-optimisation.patch
-s390-12-dirty-referenced-bits.patch
-s390-13-tlb-flush-race-fix.patch
-s390-14-rmap-optimisation.patch
-s390-14-rmap-optimisation-2.patch
-s390-15-superfluous-flush_tlb_range-calls.patch
-s390-16-follow_page-lockup-fix.patch
-const-fixes.patch
-sn01.patch
-sn03.patch
-sn05.patch
-sn06.patch
-sn07.patch
-sn08.patch
-sn09.patch
-sn10.patch
-sn11.patch
-sn12.patch
-sn13.patch
-sn14.patch
-sn15.patch
-sn16.patch
-sn17.patch
-sn18.patch
-sn19.patch
-sn20.patch
-sn21.patch
-sn22.patch
-sn23.patch
-sn24.patch
-sn25.patch
-sn26.patch
-sn27.patch
-sn28.patch
-sn29.patch
-sn30.patch
-sn31.patch
-sn32.patch
-sn33.patch
-sn34.patch
-sn35.patch
-sn36.patch
-sn37.patch
-sn38.patch
-sn39.patch
-sn40.patch
-sn41.patch
-sn42.patch
-sn43.patch
-sn44.patch
-sn45.patch
-sn46.patch
-sn47.patch
-sn48.patch
-sn49.patch
-sn50.patch
-sn51.patch
-sn52.patch
-sn53.patch
-sn54.patch
-sn55.patch
-sn56.patch
-sn57.patch
-sn58.patch
-sn59.patch
-sn60.patch
-sn61.patch
-sn62.patch
-sn63.patch
-sn65.patch
-sn66.patch
-sn67.patch
-sn68.patch
-sn69.patch
-sn70.patch
-sn71.patch
-sn73.patch
-sn74.patch
-sn75.patch
-document-efi-zero-page-usage.patch
-v4l-01-videodev-update.patch
-v4l-02-v4l2-update.patch
-v4l-03-video-buf-update.patch
-v4l-04-bttv-driver-update.patch
-v4l-05-infrared-remote-support.patch
-v4l-06-misc-i2c-fixes.patch
-v4l-07-tuner-update.patch
-v4l-08-bttv-IR-input-support.patch
-v4l-09-saa7134-update.patch
-v4l-10-conexant-2388x-driver.patch
-request-origination-determination-fix.patch
-ppc-module-skip-debug-sections.patch
-MAINTAINERS-oprofile-update.patch
-nfsd-01-stale-filehandles-fixes.patch
-nfsd-02-failed-lookup-status-fix.patch
-nfsd-03-follow_up-fix.patch
-nfsd-04-add-dnotify-events.patch
-nfsd-05-SUN-NFSv2-hack.patch
-nfsd-06-SVCFH_fmt-is-extern.patch
-proc_dma_open-simplification.patch
-rq_for_each_bio-fix.patch
-remove-afs-strdup.patch
-uninline-bitmap-functions.patch
-sock_put-inline-fix.patch

 Merged

+kgdb-warning-fixes.patch

 kgdb warning fixes for gcc-3.5

+input-fixes-and-updates.patch

 Rollup of variuos input layer fixes

+ppc64-execve-error-path-fix.patch
+ppc64-iseries-fixes.patch
+ppc64-hugepages-fix.patch
+ppc64-iseries-virtual-console.patch

 New PPC64 fixes

-ramdisk-leak-fix.patch

 Dropped, was wrong.

-sched-sync-rt-wakeup-fix.patch

 Dropped, was wrong.

-ide-siimage-stack-fix.patch

  Dropped, Bart is redoing this.

-laptop-mode-doc-update.patch
-laptop-mode-2-doc-updates.patch

 Folded into laptop-mode-2.patch

 raid6-readahead-fix.patch
+raid6-rebuild-needs-yield.patch
+raid6-x86_64-build-fix.patch

 RAID6 fixes

+kthread-block-all-signals.patch

 Fix kthread signalling problem

+cpu-options-default-to-y.patch

 When migrating from old .config's, select all CPU types.

-serial-02-fixups-fix.patch
-serial-02-fixes-fix-2.patch

 Folded into serial-02-fixups.patch

-serial-03-fixups-fix.patch
-serial-03-fixups-fix-2.patch

 Folded into serial-03-fixups.patch

+bw-qcam-typo-fix.patch

 Fix typo in PP4-bwqcam-RC1.patch

+md-06-do_md_run-fix-fix.patch

 Fix for md-06-do_md_run-fix.patch

+blk_congestion_wait-return-remaining.patch

 Make blk_congestion_wait() return the amount of time remaining to wait.

+kswapd-throttling-fixes.patch

 Make balance_pgdat() work as it was supposed to.   Slows it down :(

+bridge-build-fix.patch

 Compile fix

+move-XATTR_SECURITY_PREFIX.patch
+XATTR_SECURITY_PREFIX-default-hooks.patch

 Extended attribute work.

+kbuild-unmangle-include-options.patch

 `make O=' fixes

+powermate-payload-size-fix.patch

 Bring back this USB fix until Greg remembers to merge it.

+sunrpc-sleep_on-removal.patch

 Remove sleep_on() from the sunrpc code.

+x86_64-ptrace-fix.patch

 x86_64 fix

+gcc-35-bio_phys_segments.patch
+gcc-35-ident-warnings.patch
+gcc-35-binfmt_elf-warning-fix.patch
+gcc-35-pcm_misc-warnings.patch
+gcc-35-pcm_plugin-warnings.patch
+gcc-35-reiserfs-fixes.patch
+gcc-35-tcp_put_port-fix.patch
+gcc-35-ip6-ndisc-fix.patch
+gcc-35-ide-fix.patch
+gcc-35-elevator.patch
+gcc-35-keyboard-fixes.patch
+gcc-35-exit-fix.patch
+gcc-35-parport.patch
+gcc-34-compilation-fixes.patch
+gcc-35-seq_clientmgr.patch
+gcc-35-tg3.patch
+gcc-35-parport2.patch
+gcc-35-i810_accel.patch
+gcc-35-puts-fix.patch

 Fix build errors and warnings with latest gcc cvs.

+bitmap-parsing-printing-v4.patch

 Fix up the bitmap printing and parsing code.

+non-readable-binaries.patch

 Handle unreadable but executable binfmt_misc executables

+sendfile-locks_verify_area-fix.patch

 sendfile() file locking fix

+pc300_tty-is-broken.patch

 Mark this broken driver as being broken.

+dvb-01-update-documentation.patch
+dvb-02-update-saa7146.patch
+dvb-03-update-core.patch
+dvb-04-splitup-av7110-driver.patch
+dvb-05-TTUSB-update.patch

 DVB udpate

-modular-ide-is-broken.patch
+fix-improve-modular-ide.patch

 Make IDE work as a module again.

+ide-scsi-use-after-free-fix.patch

 ide-scsi fix.

+janitor-01-amd74xx-fix.patch
+janitor-02-apm-kernel_thread-check.patch
+janitor-03-mca-handle-oom.patch
+janitor-06-md-procfs-fixes.patch
+janitor-09-i387-usercopy-check.patch
+janitor-10-vm-doc-fix.patch
+janitor-11-unix98-spelling.patch
+janitor-12-md-ifdef-cleanup.patch
+janitor-13-stat-remove-flags.patch
+janitor-14-floppy-outb-macro-fixes.patch

 Janitorial fixes

+doc-remove-modules-conf-references.patch

 Fix documentary references to /etc/modules.conf

+ext3-chattr-aops-update.patch

 Fix ext3's `chattr +j' again.

+more-MODULE_ALIASes.patch

 More MODULE_ALIASes

+generic-exception-table-sorting-2-fix.patch

 Teach the exception table searching code that addresses can differ by more
 than 2GB.

+ipv6-sysctl-oops-fix.patch

 ipv6 opops fix.

+reiserfs-cleanup_bitmap_list-oops-fix.patch

 resierfs fix

+pcmcia-update.patch

 New PCMCIA code drop

+usb-legacy-support-doc.patch

 Add some documentation explaining why BIOS's "USB legacy mode" breaks
 things.

+isdn-url-fix.patch

 ISDN documentation fix

+p4-clockmod-more-than-two-siblings.patch

 Fix p4-clockmod for more than two siblings per package.

+limit-IO-error-printk-storms.patch

 Add ratelimiting to a few VFS I/O error messages.

+quota-locking-accounting-fix.patch

 Fix accounting and deadlock in quota code.

+smbfs-fix-noisiness.patch

 Remove user-triggerable printks in smbfs.

+sunrpc-rmmod-oops-fix.patch

 Fix an rmmod-time oops in sunrpc.

+simplify-net_ratelimit.patch

 use printk_ratelimit() in net_ratelimit(),

+aha1542-warning-fix.patch

 Fix a warning.

 4g4g-locked-userspace-copy.patch
-4g4g-acpi-low-mappings-fix.patch

 Folded into 4g-2.6.0-test2-mm2-A5.patch




All 284 patches:

linus.patch

mm.patch
  add -mmN to EXTRAVERSION

alsa-101.patch
  ALSA 1.0.1

alsa-cmipci-joystick-fix.patch

netdev.patch

kgdb-ga.patch
  kgdb stub for ia32 (George Anzinger's one)
  kgdbL warning fix
  kgdb buffer overflow fix
  kgdbL warning fix
  kgdb: CONFIG_DEBUG_INFO fix
  x86_64 fixes

kgdb-doc-fix.patch
  correct kgdb.txt Documentation link (against  2.6.1-rc1-mm2)

kgdboe-netpoll.patch
  kgdb-over-ethernet via netpoll

kgdboe-non-ia32-build-fix.patch

kgdb-x86_64-support.patch
  kgdb for x86_64 2.6 kernels

kgdb-x86_64-build-fix.patch
  fix x86_64 build with CONFIG_KGDB=n

kgdb-warning-fixes.patch
  kgdb warning fixes

must-fix.patch
  must fix lists update
  must fix list update
  mustfix update

must-fix-update-5.patch
  must-fix update

invalidate_inodes-speedup.patch
  invalidate_inodes speedup
  more invalidate_inodes speedup fixes

net-jiffy-normalisation-fix.patch
  NET: Normalize jiffies reported to userspace, in neighbor management code

input-fixes-and-updates.patch
  Input fixes and updates

synaptics-rate-switching.patch
  Synaptics rate switching

psmouse-drop-timed-out-bytes.patch
  psmouse: log and discard timed out bytes

psmouse-timeout-parity-fixes.patch
  input: psmouse timeout&parity fixes

acpi-20031203.patch

acpi-20031203-fix.patch

acpi-frees-irq0.patch
  acpi frees free irq0

ppc64-execve-error-path-fix.patch
  Fix for 32-bit execve() error path

ppc64-iseries-fixes.patch
  get PPC64 iSeries closer to building

ppc64-hugepages-fix.patch
  ppc64: Bug fix for hugepages on ppc64

ppc64-iseries-virtual-console.patch
  ppc64: iSeries virtual console

ppc64-bar-0-fix.patch
  Allow PCI BARs that start at 0

ppc64-reloc_hide.patch

cfq-4.patch
  CFQ io scheduler
  CFQ fixes

config_spinline.patch
  uninline spinlocks for profiling accuracy.

ramdisk-cleanup.patch

intel8x0-cleanup.patch
  intel8x0 cleanups

pdflush-diag.patch

zap_page_range-debug.patch
  zap_page_range() debug

asus-L5-fix.patch
  Asus L5 framebuffer fix

get_user_pages-handle-VM_IO.patch

support-zillions-of-scsi-disks.patch
  support many SCSI disks

pci_set_power_state-might-sleep.patch

CONFIG_STANDALONE-default-to-n.patch
  Make CONFIG_STANDALONE default to N

extra-buffer-diags.patch

CONFIG_SYSFS.patch
  From: Pat Mochel <mochel@osdl.org>
  Subject: [PATCH] Add CONFIG_SYSFS

CONFIG_SYSFS-boot-from-disk-fix.patch

slab-leak-detector.patch
  slab leak detector

loop-module-alias.patch
  loop needs MODULE_ALIAS_BLOCK

loop-remove-blkdev-special-case.patch

loop-highmem.patch
  remove useless highmem bounce from loop/cryptoloop

loop-bio-handling-fix.patch
  loop: BIO handling fix

loop-init-fix.patch
  loop.c doesn't fail init gracefully

acpi-pm-timer-3.patch
  ACPI PM timer version 3

scale-nr_requests.patch
  scale nr_requests with TCQ depth

truncate_inode_pages-check.patch

local_bh_enable-warning-fix.patch

pnp-fix-2.patch
  PnP Fixes #2

pnp-fix-3.patch
  PnP Fixes #3

alsa-pnp-fix.patch
  ALSA pnp fix

CardServices-compatibility-layer.patch
  CardServices compatibility layer

sysfs-class-06-raw.patch
  From: Greg KH <greg@kroah.com>
  Subject: [PATCH] add sysfs class support for raw devices [06/10]

sysfs-class-10-vc.patch
  From: Greg KH <greg@kroah.com>
  Subject: [PATCH] add sysfs class support for vc devices [10/10]

epoll-oneshot-support.patch
  One-shot support for epoll

sched-find_busiest_node-resolution-fix.patch
  sched: improved resolution in find_busiest_node

sched-domains.patch
  sched: scheduler domain support

sched-clock-fixes.patch
  fix sched_clock()

sched-build-fix.patch
  sched: fix for NR_CPUS > BITS_PER_LONG

sched-sibling-map-to-cpumask.patch
  sched: cpu_sibling_map to cpu_mask

p4-clockmod-sibling-map-fix.patch
  p4-clockmod sibling_map fix

sched-domains-i386-ht.patch
  sched: implement domains for i386 HT

acpi-numa-printk-level-fixes.patch
  ACPI NUMA quiet printk and cleanup

ide-siimage-seagate.patch

fa311-mac-address-fix.patch
  wrong mac address with netgear FA311 ethernet card

laptop-mode-2.patch
  laptop-mode for 2.6, version 6
  Documentation/laptop-mode.txt
  laptop-mode documentation updates

vt-locking-fixes-2.patch
  VT locking patch #2

pid_max-fix.patch
  Bug when setting pid_max > 32k

2.6.1-bk2-libata1.patch

use-soft-float.patch
  Use -msoft-float

DRM-cvs-update.patch
  DRM cvs update

sis-DRM-floating-point-removal.patch
  Remove float from sis DRM

drm-include-fix.patch

raid6-20040107.patch
  RAID-6

raid6-readahead-fix.patch
  RAID-6 readahead fix

raid6-rebuild-needs-yield.patch
  Port of md-02-rebuild-needs-yield.patch to RAID-6

raid6-x86_64-build-fix.patch
  RAID6 doesn't build on x86_64

kthread-primitive.patch
  kthread primitive

kthread-block-all-signals.patch
  kthread: block all signals

use-kthread-primitives.patch
  Use kthread primitives

lsi-megaraid-pci-id.patch
  LSI Logic MegaRAID3 PCI ID

ide-pci-modules-fix.patch
  fix issues with loading PCI IDE drivers as modules

sysfs-pin-kobject.patch
  sysfs: pin kobjects to fix use-after-free crashes

limit-hash-table-sizes.patch
  Limit hash table size

disable-G400-DRM-on-x86_64.patch
  Disable G400 DRM driver on x86-64

x86_64-merge.patch
  x86-64 merge for 2.6.1

slab-poison-hex-dumping.patch
  slab: hexdump for check_poison

truncated-module-check-2.patch
  check for truncated modules

pentium-m-support.patch
  add Pentium M and Pentium-4 M options

old-gcc-supports-k6.patch
  gcc 2.95 supports -march=k6 (no need for check_gcc)

amd-elan-is-a-different-subarch.patch
  AMD Elan is a different subarch

better-i386-cpu-selection.patch
  better i386 CPU selection

cpu-options-default-to-y.patch
  cpu options default to "yes"

serial-02-fixups.patch
  serial fixups (untested)
  serial-02 fixes
  serial-02 fixes

serial-03-fixups.patch
  more serial driver fixups
  serial-03 fixes
  serial-03 fixes

ia32-MSI-vector-handling-fix.patch
  ia32 MSI vector handling fix

nuke-noisy-printks.patch
  quiet down SMP boot messages

PP0-full_list-RC1.patch
  parport fixes [1/5]

PP1-parport_locking-RC1.patch
  parport fixes [2/5]

PP2-enumerate1-RC1.patch
  parport fixes [3/5]

PP2-enumerate1-RC1-fix.patch

PP3-parport_gsc-RC1.patch
  parport fixes [4/5]

PP4-bwqcam-RC1.patch
  parport fixes [5/5]

bw-qcam-typo-fix.patch
  bw-qcam typo fix

PP5-daisy-RC1.patch
  parport fixes [2/5]

PI0-schedule_claimed-RC1.patch
  paride cleanups and fixes [1/24]

PI1-expansion-RC1.patch
  paride cleanups and fixes [2/24]

PI2-crapectomy-RC1.patch
  paride cleanups and fixes [3/24]

PI3-ps_ready-RC1.patch
  paride cleanups and fixes [4/24]

PI4-pd_busy-RC1.patch
  paride cleanups and fixes [5/24]

PI5-do_pd_io-RC1.patch
  paride cleanups and fixes [6/24]

PI6-bogus_requests-RC1.patch
  paride cleanups and fixes [7/24]

PI7-claim_reorder-RC1.patch
  paride cleanups and fixes [8/24]

PI8-do_pd_request1-RC1.patch
  paride cleanups and fixes [9/24]

PI9-run_fsm-RC1.patch
  paride cleanups and fixes [10/24]

PI10-action-RC1.patch
  paride cleanups and fixes [2/24]

PI11-disconnect-RC1.patch
  paride cleanups and fixes [12/24]

PI12-unclaim-RC1.patch
  paride cleanups and fixes [13/24]

PI13-run_fsm-loop-RC1.patch
  paride cleanups and fixes [14/24]

PI14-next_request-RC1.patch
  paride cleanups and fixes [15/24]

PI15-do_pd_io-gone-RC1.patch
  paride cleanups and fixes [16/24]

PI16-pd_claimed-RC1.patch
  paride cleanups and fixes [17/24]

PI17-connect-RC1.patch
  paride cleanups and fixes [18/24]

PI18-reorder-RC1.patch
  paride cleanups and fixes [19/24]

PI19-special1-RC1.patch
  paride cleanups and fixes [20/24]

PI20-gendisk_setup-RC1.patch
  paride cleanups and fixes [21/24]

PI21-present-RC1.patch
  paride cleanups and fixes [22/24]

PI22-pd_init_units-RC1.patch
  paride cleanups and fixes [23/24]

PI23-special2-RC1.patch
  paride cleanups and fixes [24/24]

PI24-paride64-RC1.patch
  paride cleanups and fixes [25/24]

IMM0-lindent-RC1.patch
  drivers/scsi/imm.c cleanups and fixes [1/8]

IMM1-references-RC1.patch
  drivers/scsi/imm.c cleanups and fixes [2/8]

IMM2-claim-RC1.patch
  drivers/scsi/imm.c cleanups and fixes [3/8]

IMM3-scsi_module-RC1.patch
  drivers/scsi/imm.c cleanups and fixes [4/8]

IMM4-imm_probe-RC1.patch
  drivers/scsi/imm.c cleanups and fixes [5/8]

IMM5-imm_wakeup-RC1.patch
  drivers/scsi/imm.c cleanups and fixes [6/8]

IMM6-imm_hostdata-RC1.patch
  drivers/scsi/imm.c cleanups and fixes [7/8]

IMM7-imm_attach-RC1.patch
  drivers/scsi/imm.c cleanups and fixes [8/8]

PPA0-ppa_lindent-RC1.patch
  drivers/scsi/ppa.c cleanups and fixes [1/9]

PPA1-ppa_references-RC1.patch
  drivers/scsi/ppa.c cleanups and fixes [2/9]

PPA2-ppa_claim-RC1.patch
  drivers/scsi/ppa.c cleanups and fixes [3/9]

PPA3-ppa_scsi_module-RC1.patch
  drivers/scsi/ppa.c cleanups and fixes [4/9]

PPA4-ppa_probe-RC1.patch
  drivers/scsi/ppa.c cleanups and fixes [5/9]

PPA5-ppa_wakeup-RC1.patch
  drivers/scsi/ppa.c cleanups and fixes [6/9]

PPA6-ppa_hostdata-RC1.patch
  drivers/scsi/ppa.c cleanups and fixes [7/9]

PPA7-ppa_attach-RC1.patch
  drivers/scsi/ppa.c cleanups and fixes [8/9]

PPA8-ppa_lock_fix-RC1.patch
  drivers/scsi/ppa.c cleanups and fixes [9/9]

nfs-01-rpc_pipe_timeout.patch
  NFSv4/RPCSEC_GSS: userland upcall timeouts

nfs-02-auth_gss.patch
  RPCSEC_GSS: More fixes to the upcall mechanism.

nfs-03-pipe_close.patch
  RPCSEC_GSS: detect daemon death

nfs-04-fix_nfs4client.patch
  NFSv4: oops fix

nfs-05-fix_idmap.patch
  NFSv4: client name fixes

nfs-06-fix_idmap2.patch
  NFSv4: Bugfixes and cleanups client name to uid mapper.

nfs-07-gss_krb5.patch
  RPCSEC_GSS: Make it safe to share crypto tfms among multiple threads.

nfs-08-gss_missingkfree.patch
  RPCSEC_GSS: Oops. Major memory leak here.

nfs-09-memleaks.patch
  RPCSEC_GSS: Fix two more memory leaks found by the stanford checker.

nfs-10-refleaks.patch
  RPCSEC_GSS: Fix yet more memory leaks.

nfs-11-krb5_cleanup.patch
  RPCSEC_GSS: krb5 cleanups

nfs-12-gss_nokmalloc.patch
  RPCSEC_GSS: memory allocation fixes

nfs-13-krb5_integ.patch
  RPCSEC_GSS: Client-side only support for rpcsec_gss integrity protection.

nfs-14-clnt_seqno_to_req.patch
  RPCSEC_GSS: gss sequence number history fixes

nfs-15-encode_pages_tail.patch
  XDR: page encoding fix

nfs-16-rpc_clones.patch
  RPC: transport sharing

nfs-17-rpc_clone2.patch
  NFSv4/RPCSEC_GSS: use RPC cloning

nfs-18-renew_xdr.patch
  NFSv4: make RENEW a standalone RPC call

nfs-19-renewd.patch
  NFSv4: make lease renewal daemon per-server

nfs-20-fsinfo_xdr.patch
  NFSv4: Split the code for retrieving static server information out of the GETATTR compound.

nfs-21-setclientid_xdr.patch
  NFSv4: Make SETCLIENTID and SETCLIENTID_CONFIRM standalone operations

nfs-22-errno.patch
  NFSv4: errno fixes

nfs-23-open_reclaim.patch
  NFSv4: Preparation for the server reboot recovery code.

nfs-24-state_recovery.patch
  NFSv4: Basic code for recovering file OPEN state after a server reboot.

nfs-25-soft.patch
  RPC/NFSv4: Allow lease RENEW calls to be soft

nfs-26-sock_disconnect.patch
  RPC: TCP timeout fixes

nfs-27-atomic_open.patch
  NFSv4: Atomic open()

nfs-28-open_owner.patch
  NFSv4: Share open_owner structs

nfs-29-fix_idmap3.patch
  NFSv4: fix multi-partition mount oops

nfs_idmap-warning-fix.patch

nfs-30-lock.patch
  NFSv4: Add support for POSIX file locking.

nfs-old-gcc-fix.patch
  NFS: fix for older gcc's

nfs-31-attr.patch
  NFSv2/v3/v4: New attribute revalidation code

md-01-set_disk_faulty-return-code-fix.patch
  md: fix return code in set_disk_faulty()

md-02-rebuild-needs-yield.patch
  md: Don't allow raid5 rebuild to swamp raid5 stripe cache

md-03-resync-interrupt-fix.patch
  md: Make sure an interrupted resync doesn't seem to have completed.

md-04-typo-fix.patch
  md: Fix typo in comment

md-05-recovery-fix.patch
  md: Make sure md recovery happens appropriately.

md-06-do_md_run-fix.patch
  md: Don't do_md_stop and array when do_md_run fails.

md-06-do_md_run-fix-fix.patch
  md: we do need to call do_md_run after all

md-07-superblock-writing-fixes.patch
  md: Small fixes for timely writing of md superblocks.

md-08-remove-disks-array.patch
  md: Remove the 'disks' array from md which holds the gendisk structures.

md-09-discard-mddev_map-array.patch
  md: Discard the mddev_map array.

md-10-use-bd_disk-private_data.patch
  md: Use bd_disk->private data instead of bd_inode->u.generic_ip

ghash.patch
  ghash.h from 2.4

tty_io-uml-fix.patch
  uml: make tty_init callable from UML functions

uml-update.patch
  UML update

blk_congestion_wait-return-remaining.patch
  return remaining jiffies from blk_congestion_wait()

kswapd-throttling-fixes.patch
  kswapd throttling fixes

bridge-build-fix.patch
  Fixes net/bridge/ with CONFIG_SYSCTL=n

move-XATTR_SECURITY_PREFIX.patch
  From: Chris Wright <chrisw@osdl.org>
  Subject: [PATCH 1/2] Move XATTR_SECURITY_PREFIX macro to common location

XATTR_SECURITY_PREFIX-default-hooks.patch
  From: Chris Wright <chrisw@osdl.org>
  Subject: [PATCH 2/2] Default hooks protecting the XATTR_SECURITY_PREFIX namespace

kbuild-unmangle-include-options.patch
  kbuild: Unmangle include options for gcc

powermate-payload-size-fix.patch
  Griffin Powermate fix

sunrpc-sleep_on-removal.patch
  remove sleep_on from sunrpc

x86_64-ptrace-fix.patch
  Fix x86-64 ptrace

add-noinline-attribute.patch
  Add noinline attribute

use-funit-at-a-time.patch
  Use -funit-at-a-time when possible

add-config-for-mregparm-3.patch
  Add CONFIG for -mregparm=3

add-config-for-mregparm-3-make-EXPERIMENTAL.patch

add-module-magic-for-mregparm3.patch
  Add -mregparm info to module versioning

fix-x86_64-gcc-34-warnings.patch
  Fix gcc 3.4 warnings in x86-64

fix-more-gcc-34-warnings.patch
  Fix more gcc 3.4 warnings

gcc-34-string-fixes.patch
  string fixes for gcc 3.4

gcc-35-bio_phys_segments.patch
  gcc-3.5: fix extern inline decls

gcc-35-ident-warnings.patch
  gcc-3.5: #ident fixes

gcc-35-binfmt_elf-warning-fix.patch
  gcc-3.5: binfmt_elf warning fix

gcc-35-pcm_misc-warnings.patch
  gcc-3.5: pcm_misc.c warnings

gcc-35-pcm_plugin-warnings.patch

gcc-35-reiserfs-fixes.patch
  gcc-3.5: reiserfs fixes

gcc-35-tcp_put_port-fix.patch
  gcc-3.5: tcp_put_port() fix

gcc-35-ip6-ndisc-fix.patch
  gcc-3.5: ipv6/ndisc.c fixes

gcc-35-ide-fix.patch
  gcc-3.5: ide.h fixes

gcc-35-elevator.patch
  gcc-3.5: elevator.h fixes

gcc-35-keyboard-fixes.patch
  gcc-3.5: keyboard.c fixes

gcc-35-exit-fix.patch
  gcc-3.5: _exit fix

gcc-35-parport.patch
  Fix inlining failure (all GCCs) in parport

gcc-34-compilation-fixes.patch
  More 3.4 compilation fixes

gcc-35-seq_clientmgr.patch
  gcc-3.5: sound/core/seq/seq_clientmgr.c

gcc-35-tg3.patch
  gcc-3.5: tg3.c warnings

gcc-35-parport2.patch
  gcc-3.5: parport warnings

gcc-35-i810_accel.patch
  gcc-3.5: i810_accel fix

gcc-35-puts-fix.patch
  gcc-3.5: misc.c warning fix

bitmap-parsing-printing-v4.patch
  bitmap parsing/printing routines, version 4

non-readable-binaries.patch
  Handle non-readable binfmt_misc executables

sendfile-locks_verify_area-fix.patch
  sendfile calls lock_verify_area with wrong parameters

pc300_tty-is-broken.patch
  pc300_tty.c is broken

dvb-01-update-documentation.patch
  dbv: update documentation

dvb-02-update-saa7146.patch
  dvb: update saa7146 driver

dvb-03-update-core.patch
  dvb: update core

dvb-04-splitup-av7110-driver.patch
  dvb: av7110 driver splitup

dvb-05-TTUSB-update.patch
  dvb: TTUSB driver update

fix-improve-modular-ide.patch
  fix/improve modular IDE

ide-scsi-use-after-free-fix.patch
  ide-scsi use-after-free fix

janitor-01-amd74xx-fix.patch
  amd74xx: fix for !CONFIG_PROCFS

janitor-02-apm-kernel_thread-check.patch
  APM: handle kernel_thread failure

janitor-03-mca-handle-oom.patch
  MCA: handle bus failure

janitor-06-md-procfs-fixes.patch
  md: fixes for !CONFIG_PROCFS

janitor-09-i387-usercopy-check.patch
  i387: handle copy_from_user() error

janitor-10-vm-doc-fix.patch
  vm overcommit documentation corrections

janitor-11-unix98-spelling.patch
  spell Unix98 the same everywhere

janitor-12-md-ifdef-cleanup.patch
  md: remove unneeded ifdef/endif

janitor-13-stat-remove-flags.patch
  remove unused flags arg from fs/stat64*

janitor-14-floppy-outb-macro-fixes.patch
  correct floppy outb() macro arg names

doc-remove-modules-conf-references.patch
  Documentation: remove /etc/modules.conf refs

ext3-chattr-aops-update.patch
  ext3: update a_ops when running `chattr +j'

more-MODULE_ALIASes.patch
  add some more MODULE_ALIASes

generic-exception-table-sorting-2-fix.patch
  exception table search fix

ipv6-sysctl-oops-fix.patch
  ipv6: fix oops in register_proc_table

reiserfs-cleanup_bitmap_list-oops-fix.patch
  reiserfs: cleanup_bitmap_list() check for NULL argument.

pcmcia-update.patch
  PCMCIA updates

usb-legacy-support-doc.patch
  Document problems with USB legacy support

isdn-url-fix.patch
  drivers/isdn/Kconfig URL update: caltech.edu

p4-clockmod-more-than-two-siblings.patch
  p4-clockmodL handle more than two siblings

limit-IO-error-printk-storms.patch
  ratelimit I/O error printk's

quota-locking-accounting-fix.patch
  dquot: fix i_blocks accounting and locking

smbfs-fix-noisiness.patch
  smbfs: remove noisy printk's

sunrpc-rmmod-oops-fix.patch
  NFS/RPC modprobe -r sunrpc causes an oops

simplify-net_ratelimit.patch
  simplify net_ratelimit()

aha1542-warning-fix.patch
  aha1542.c warning fix

list_del-debug.patch
  list_del debug check

print-build-options-on-oops.patch

show_task-free-stack-fix.patch
  show_task() fix and cleanup

oops-dump-preceding-code.patch
  i386 oops output: dump preceding code

lockmeter.patch

4g-2.6.0-test2-mm2-A5.patch
  4G/4G split patch
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g/4g usercopy atomicity fix
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g/4g usercopy atomicity fix
  4G/4G preempt on vstack
  4G/4G: even number of kmap types
  4g4g: fix __get_user in slab
  4g4g: Remove extra .data.idt section definition
  4g/4g linker error (overlapping sections)
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g4g: show_registers() fix
  4g/4g usercopy atomicity fix
  4g4g: debug flags fix
  4g4g: Fix wrong asm-offsets entry
  cyclone time fixmap fix
  4G/4G preempt on vstack
  4G/4G: even number of kmap types
  4g4g: fix __get_user in slab
  4g4g: Remove extra .data.idt section definition
  4g/4g linker error (overlapping sections)
  4G/4G: remove debug code
  4g4g: pmd fix
  4g/4g: fixes from Bill
  4g4g: fpu emulation fix
  4g4g: show_registers() fix
  4g/4g usercopy atomicity fix
  4g4g: debug flags fix
  4g4g: Fix wrong asm-offsets entry
  cyclone time fixmap fix
  use direct_copy_{to,from}_user for kernel access in mm/usercopy.c
  4G/4G might_sleep warning fix
  4g/4g pagetable accounting fix
  Fix 4G/4G and WP test lockup
  4G/4G KERNEL_DS usercopy again
  Fix 4G/4G X11/vm86 oops
  Fix 4G/4G athlon triplefault
  4g4g SEP fix
  Fix 4G/4G split fix for pre-pentiumII machines
  4g/4g PAE ACPI low mappings fix

4g4g-locked-userspace-copy.patch
  Do a locked user-space copy for 4g/4g

ppc-fixes.patch
  make mm4 compile on ppc

O_DIRECT-race-fixes-rollup.patch
  DIO fixes forward port and AIO-DIO fix
  O_DIRECT race fixes comments
  O_DRIECT race fixes fix fix fix
  DIO locking rework
  O_DIRECT XFS fix

dio-aio-fixes.patch
  direct-io AIO fixes
  dio-aio fix fix

aio-fallback-bio_count-race-fix-2.patch
  AIO+DIO bio_count race fix

aio-sysctl-parms.patch
  aio sysctl parms



