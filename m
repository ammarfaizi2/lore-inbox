Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263281AbSJOHjv>; Tue, 15 Oct 2002 03:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263283AbSJOHjv>; Tue, 15 Oct 2002 03:39:51 -0400
Received: from 213-187-164-2.dd.nextgentel.com ([213.187.164.2]:48268 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S263281AbSJOHjf>;
	Tue, 15 Oct 2002 03:39:35 -0400
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: cdrom_sysctl_register uses LOTS of CPU, and no cdrom is attached (2.4.20-pre10)
Date: Tue, 15 Oct 2002 09:49:16 +0200
User-Agent: KMail/1.4.1
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>,
       Harald Dankworth <harald@pronto.tv>,
       Atle =?iso-8859-1?q?Sj=F8n=F8st?= <atle@pronto.tv>
References: <Pine.LNX.4.44.0210150102120.1795-100000@montezuma.mastecende.com>
In-Reply-To: <Pine.LNX.4.44.0210150102120.1795-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_42J0XWSX4M4VJWFWMY2J"
Message-Id: <200210150949.16991.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_42J0XWSX4M4VJWFWMY2J
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday 15 October 2002 07:07, Zwane Mwaikambo wrote:
> On Mon, 14 Oct 2002, Roy Sigurd Karlsbakk wrote:
> > attached is the .config and these three readprofile output files
> > (pro[123]). see time to see the interval they have been created in
>
> These look like bungled up profiles of the magnitude that even i couldn=
't
> conjure up ;)

excuse me?
made a new one now.

why is cdrom_sysctl_register using all that cpu??? I mean - it's got noth=
ing=20
there to do!

--=20
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

--------------Boundary-00=_42J0XWSX4M4VJWFWMY2J
Content-Type: text/plain;
  charset="iso-8859-1";
  name="pro4"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="pro4"

     4 _stext                                     0.0833
    27 huft_build                                 0.0147
    76 inflate_codes                              0.0731
     1 inflate_dynamic                            0.0006
   236 gunzip                                     0.1855
   321 dump_thread                                1.1146
   181 __switch_to                                0.8702
     1 sys_rt_sigreturn                           0.0039
     1 setup_rt_frame                             0.0016
     3 do_signal                                  0.0047
     1 badsys                                     0.0667
  1404 alignment_check                          117.0000
    42 page_fault                                 3.5000
    29 machine_check                              2.4167
     9 spurious_interrupt_bug                     0.7500
    20 show_trace                                 0.0833
     1 show_stack                                 0.0078
    11 .text.lock.irq                             0.3548
  3225 save_v86_state                             6.7188
   607 sys_ipc                                    1.1158
   115 do_open                                    0.5529
     3 apm_get_info                               0.0134
   123 free_initrd_mem                            0.9609
    67 __verify_write                             0.2204
   631 do_page_fault                              0.5130
    37 remap_area_pages                           0.0826
   258 sys_sched_getparam                         1.0078
    25 sys_sched_get_priority_min                 0.5208
    82 sys_sched_rr_get_interval                  0.2697
   559 show_task                                  1.5190
   154 render_sigset_t                            1.2031
   429 reparent_to_init                           1.4112
   235 daemonize                                  2.0982
     8 wake_up_process                            0.1067
    57 request_dma                                0.8906
  2328 lookup_exec_domain                        14.5500
  2187 register_exec_domain                      27.3375
     1 print_tainted                              0.0089
     3 do_syslog                                  0.0038
     1 emit_log_char                              0.0089
     1 printk                                     0.0035
     1 console_unblank                            0.0156
     1 sys_create_module                          0.0025
     1 qm_modules                                 0.0033
     2 sys_query_module                           0.0057
     1 exit_notify                                0.0016
     1 sys_sysinfo                                0.0031
   215 sys_settimeofday                           1.0337
     1 tasklet_action                             0.0089
  8567 tasklet_hi_action                         76.4911
     2 tasklet_init                               0.0417
     2 __run_task_queue                           0.0208
   185 ksoftirqd                                  1.0511
    65 cpu_raise_softirq                          1.1207
     2 Letext                                     0.3333
    67 get_resource_list                          1.0469
    65 __request_resource                         0.8125
     1 release_resource                           0.0625
     4 check_resource                             0.0500
     1 update_wall_time_one_tick                  0.0057
     1 update_wall_time                           0.0156
   520 timer_bh                                   0.6019
    95 do_timer                                   0.8482
   203 sys_alarm                                  2.5375
     3 sys_getpid                                 0.0938
   104 sys_geteuid                                3.2500
     8 sys_getgid                                 0.2500
    22 unblock_all_signals                        0.2292
   296 collect_signal                             1.3214
   417 bad_signal                                 2.8958
   131 send_signal                                0.5117
     4 deliver_signal                             0.0417
     9 send_sig_info                              0.0563
     6 force_sig_info                             0.0417
     1 kill_pg_info                               0.0089
     2 wake_up_parent                             0.0312
     2 sys_rt_sigqueueinfo                        0.0074
    52 sys_rt_sigaction                           0.1625
    62 sys_ssetmask                               0.7750
     1 sys_signal                                 0.0208
    28 kill_proc_info                             0.1944
     2 sys_setregid                               0.0096
     1 sys_setresuid                              0.0022
     2 exec_usermodehelper                        0.0022
     1 call_usermodehelper                        0.0048
     2 vmtruncate_list                            0.0208
    33 vmtruncate                                 0.1146
     1 do_anonymous_page                          0.0045
    44 handle_mm_fault                            0.2292
     3 vmalloc_to_page                            0.0395
     1 unlock_vma_mappings                        0.0625
     2 get_unmapped_area                          0.0074
    21 find_vma                                   0.2188
    28 find_vma_prev                              0.1458
  1712 find_extend_vma                            9.7273
   281 unmap_fixup                                0.9243
    53 do_brk                                     0.1104
     2 build_mmap_rb                              0.0208
     4 exit_mmap                                  0.0139
     4 insert_vm_struct                           0.0315
    39 .text.lock.mmap                            0.6000
     2 add_page_to_hash_queue                     0.0417
     3 __remove_inode_page                        0.0375
     1 set_page_dirty                             0.0125
     1 invalidate_inode_pages                     0.0069
     1 truncate_list_pages                        0.0024
     4 invalidate_list_pages2                     0.0125
     1 do_buffer_fdatasync                        0.0089
     1 generic_buffer_fdatasync                   0.0052
     1 filemap_fdatasync                          0.0063
     1 __find_lock_page_helper                    0.0089
    17 find_or_create_page                        0.0817
     2 grab_cache_page_nowait                     0.0114
     1 mark_page_accessed                         0.0156
     1 do_generic_file_read                       0.0010
     1 generic_file_direct_IO                     0.0021
     6 sys_sendfile                               0.0121
    22 do_readahead                               0.1528
     1 madvise_fixup_end                          0.0042
     2 madvise_fixup_middle                       0.0057
    55 madvise_willneed                           0.1809
     3 sys_mincore                                0.0110
    15 read_cache_page                            0.0493
   157 generic_file_write                         0.0962
  3295 change_protection                          9.3608
    15 mprotect_fixup                             0.0146
     3 kmem_cache_create                          0.0037
     1 remove_exclusive_swap_page                 0.0048
   404 try_to_unuse                               0.6159
   874 sys_swapoff                                1.6066
     4 sys_swapon                                 0.0023
    23 get_swaphandle_info                        0.1198
    98 valid_swaphandles                          0.7259
     5 Letext                                     0.5556
     1 int_sqrt                                   0.0156
    44 badness                                    0.2292
     1 shmem_clear_swp                            0.0104
     6 shmem_unuse_inode                          0.0312
     2 shmem_unuse                                0.0250
     7 shmem_writepage                            0.0257
     8 shmem_getpage_locked                       0.0111
   325 shmem_file_write                           0.4416
    26 do_shmem_file_read                         0.1083
   374 shmem_statfs                               4.6750
    10 shmem_mknod                                0.0893
   379 shmem_rename                               2.9609
    59 shmem_symlink                              0.1229
   145 shmem_follow_link                          1.2946
   302 shmem_parse_options                        0.5551
     1 sys_statfs                                 0.0045
    13 sys_truncate64                             0.0339
     1 remove_super                               0.0069
     1 sys_ustat                                  0.0042
     1 get_anon_super                             0.0045
     2 do_kern_mount                              0.0078
    49 kill_super                                 0.2188
    38 .text.lock.super                           0.1631
  1835 do_open                                    5.4613
  3703 blkdev_put                                19.2865
     1 bdevname                                   0.0169
    15 sys_stat64                                 0.1339
     1 sys_fstat64                                0.0093
     2 copy_strings                               0.0046
     2 setup_arg_pages                            0.0060
     7 exec_mmap                                  0.0243
     7 flush_old_exec                             0.0115
     3 prepare_binprm                             0.0099
     3 compute_creds                              0.0089
     3 pipe_read                                  0.0054
    10 link_path_walk                             0.0046
     4 __emul_lookup_dentry                       0.0179
     1 lookup_one_len                             0.0089
     1 d_unhash                                   0.0104
     2 vfs_rmdir                                  0.0040
     2 file_ioctl                                 0.0057
     1 sys_poll                                   0.0014
     1 flock64_to_posix_lock                      0.0035
    47 locks_insert_lock                          0.7344
   225 locks_delete_lock                          1.0045
    10 posix_lock_file                            0.0084
     2 __get_lease                                0.0040
     2 fcntl_setlease                             0.0037
     1 fcntl_setlk                                0.0021
     1 fcntl_setlk64                              0.0021
     3 locks_remove_posix                         0.0089
     1 lock_get_status                            0.0022
     1 Letext                                     0.0030
     1 free_kiobuf_bhs                            0.0125
     1 expand_kiobuf                              0.0057
   997 show_vfsmnt                                1.1127
     5 may_umount                                 0.1562
   271 umount_tree                                1.4115
   495 do_umount                                  1.9336
   169 sys_umount                                 0.9602
    22 sys_oldumount                              0.6875
    16 mount_is_safe                              0.3333
    91 copy_tree                                  0.4740
   182 graft_tree                                 0.7109
   185 do_loopback                                0.5256
   122 do_remount                                 0.7625
   215 do_move_mount                              0.4072
     1 do_add_mount                               0.0030
     4 do_mount                                   0.0109
     1 bm_entry_read                              0.0039
     2 load_script                                0.0042
    15 load_elf_binary                            0.0051
     1 load_elf_library                           0.0020
    12 elf_core_dump                              0.0051
     1 proc_exe_link                              0.0063
     2 proc_root_link                             0.0208
     2 proc_pid_environ                           0.0250
     4 mounts_release                             0.0357
     1 proc_info_read                             0.0037
     1 mem_read                                   0.0030
     3 do_proc_readlink                           0.0134
     1 proc_symlink                               0.0078
     3 ext3_free_data                             0.0089
     1 ext3_free_branches                         0.0020
     1 ext3_do_update_inode                       0.0011
     3 ext3_setattr                               0.0072
     2 ext3_change_inode_journal_flag             0.0066
     1 ext3_ioctl                                 0.0009
    13 ext3_find_entry                            0.0185
     1 ext3_lookup                                0.0078
     2 ext3_create                                0.0069
     4 ext3_mkdir                                 0.0049
     3 empty_dir                                  0.0063
   321 ext3_orphan_add                            0.6472
     2 ext3_orphan_del                            0.0037
     4 journal_commit_transaction                 0.0011
     2 jread                                      0.0078
     4 count_tags                                 0.0500
     2 journal_recover                            0.0114
     2 journal_skip_recovery                      0.0179
     1 do_one_pass                                0.0009
     2 ext2_read_super                            0.0012
     7 zlib_fs_inflate_blocks                     0.0022
     1 zlib_fs_inflate_codes                      0.0005
     1 zlib_fs_inflate                            0.0011
     1 huft_build                                 0.0005
     1 isofs_dentry_cmp                           0.0312
     1 isofs_get_blocks                           0.0020
     1 isofs_read_level3_size                     0.0014
     1 parse_rock_ridge_inode_internal            0.0006
     2 nlmsvc_decode_testargs                     0.0039
     1 nlm4svc_decode_unlockargs                  0.0125
     1 nlm4svc_decode_shareargs                   0.0052
     3 nlm4svc_proc_unlock                        0.0170
     1 smb_proc_do_getattr                        0.0052
     5 smb_lookup                                 0.0240
  6377 autoconfig                                 6.3264
     1 pci_siig10x_fn                             0.0089
     2 pci_siig20x_fn                             0.0179
     2 serial_remove_one                          0.0125
    47 register_serial                            0.0773
    68 setledstate                                0.8500
    58 register_leds                              0.7250
    55 kbd_bh                                     0.2973
    41 Letext                                     0.6406
    18 pckbd_translate                            0.0625
     1 interpret_errors                           0.0016
     1 user_reset_fdc                             0.0078
     1 raw_cmd_ioctl                              0.0010
   154 fd_ioctl                                   0.0526
    72 compute_loop_size                          0.5625
    30 do_nbd_request                             0.1172
    23 nbd_ioctl                                  0.0236
    68 eepro100_init_one                          0.1288
   233 speedo_found1                              0.1324
    38 do_eeprom_cmd                              0.1827
     1 ide_scan_devices                           0.0052
     1 ide_dmafunc_verbose                        0.0063
     1 pdc202xx_tune_chipset                      0.0012
     2 pdc202xx_new_tune_chipset                  0.0020
     1 piix_get_info                              0.0009
     1 piix_tune_drive                            0.0023
   421 cdrom_sysctl_handler                       1.7542
6090389 cdrom_sysctl_register                    54378.4732
   104 pci_find_subsys                            0.8125
    42 pci_find_class                             0.8750
    56 call_policy                                0.1250
     1 usb_start_wait_urb                         0.0026
     2 usb_internal_control_msg                   0.0156
     1 usb_control_msg                            0.0069
   109 usb_get_device_descriptor                  3.4062
   391 usb_get_status                             4.8875
   260 usb_get_protocol                           3.2500
     1 usb_open                                   0.0042
     1 usb_hub_configure                          0.0016
     1 usb_hub_port_debounce                      0.0048
     1 usb_hcd_pci_resume                         0.0063
   708 hcd_submit_urb                             0.9219
     1 periodic_unlink                            0.0048
   232 td_submit_urb                              0.2736
    49 dl_transfer_length                         0.2188
    15 dl_del_urb                                 0.1562
    16 raid5_end_write_request                    0.0417
   161 xor_pII_mmx_5                              0.3049
    20 get_spare                                  0.1389
     1 md_sync_acct                               0.0089
     1 is_mddev_idle                              0.0057
     2 md_do_sync                                 0.0019
    13 unregister_netdevice                       0.0271
     1 __dev_mc_upload                            0.0208
     1 ip_frag_queue                              0.0012
    69 ip_frag_reasm                              0.1052
    92 ip_defrag                                  0.3286
    55 ip_forward                                 0.1211
    90 ip_options_echo                            0.1082
    17 ip_options_fragment                        0.1181
  1640 ip_options_compile                         1.0904
     3 ip_options_undo                            0.0170
    72 ip_options_get                             0.2647
    60 ip_forward_options                         0.1562
   114 ip_options_rcv_srr                         0.3574
     1 ip_dev_loopback_xmit                       0.0089
    25 ip_queue_xmit                              0.0214
     1 ip_cmsg_recv                               0.0078
    11 ip_cmsg_send                               0.0573
     8 ip_recv_error                              0.0161
     1 ip_setsockopt                              0.0004
     1 tcp_ioctl                                  0.0019
     2 inet_del_ifa                               0.0063
    23 inet_fill_ifaddr                           0.0399
     1 devinet_sysctl_forward                     0.0104
     8 devinet_sysctl_register                    0.0238
    68 inet_sock_release                          0.5312
    41 inet_create                                0.0732
     1 fib_create_info                            0.0012
     4 tux_error_report                           0.0147
     2 tux_state_change                           0.0030
     2 tux_ftp_data_ready                         0.0114
    11 tux_ftp_create_child                       0.0299
    13 link_tux_socket                            0.0542
     1 parse_request                              0.0008
    74 parse_http_message                         0.0032
     1 zap_userspace_req                          0.0104
    16 gen_bitlen                                 0.0323
     1 send_all_trees                             0.0015
    23 _tr_tally                                  0.0799
    41 compress_block                             0.0377
    13 set_data_type                              0.1016
     2 bi_flush                                   0.0139
6145734 total                                      3.8794

--------------Boundary-00=_42J0XWSX4M4VJWFWMY2J--

