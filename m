Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbVLDBtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbVLDBtn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 20:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbVLDBtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 20:49:43 -0500
Received: from gambit.vianw.pt ([195.22.31.34]:52622 "EHLO gambit.vianw.pt")
	by vger.kernel.org with ESMTP id S1751308AbVLDBtm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 20:49:42 -0500
Message-ID: <43924B2C.9000300@esoterica.pt>
Date: Sun, 04 Dec 2005 01:49:32 +0000
From: Paulo da Silva <psdasilva@esoterica.pt>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Cannot run linux 2.6.14.3 UML on a x86_64
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following boot output from
uml linux 2.6.14.3 from a x86_64.

After this, the linux task is looping consuming
100% CPU.

Thanks for any help


01:37:14 Dom Dez 04 Gandalf /VMs/UML $ ./uml
Checking PROT_EXEC mmap in /tmp...OK
UML running in TT mode
tracing thread pid = 19526
[42949372.960000] Checking that ptrace can change system call numbers...OK
[42949372.960000] Checking syscall emulation patch for ptrace...missing
[42949372.960000] Linux version 2.6.14.3 (psergio@Gandalf) (gcc version 
3.4.4 (Gentoo 3.4.4-r1, ssp-3.4.4-1.0, pie-8.7.8)) #1 Sun Dec 4 01:27:59 
WET 2005
[42949372.960000] Built 1 zonelists
[42949372.960000] Kernel command line: ubd0=/VMs/UML/UML1 mem=250M 
eth0=tuntap,,,192.168.1.100 root=98:0
[42949372.960000] PID hash table entries: 1024 (order: 10, 32768 bytes)
[42949372.960000] Dentry cache hash table entries: 32768 (order: 6, 
262144 bytes)
[42949372.960000] Inode-cache hash table entries: 16384 (order: 5, 
131072 bytes)
[42949372.960000] Memory: 243712k available
[42949373.190000] Mount-cache hash table entries: 256
[42949373.190000] Checking that host ptys support output SIGIO...Yes
[42949373.190000] Checking that host ptys support SIGIO on close...No, 
enabling workaround
[42949373.190000] Checking for /dev/anon on the host...Not available 
(open failed with errno 2)
[42949373.190000] softlockup thread 0 started up.
[42949373.190000] Disabling 2.6 AIO in tt mode
[42949373.190000] 2.6 host AIO support not used - falling back to I/O thread
[42949373.190000] NET: Registered protocol family 16
[42949373.190000] mconsole (version 2) initialized on 
/home/psergio/.uml/Pulga/mconsole
[42949373.190000] Netdevice 0 : TUN/TAP backend - IP = 192.168.1.100
[42949373.190000] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[42949373.190000] Initializing Cryptographic API
[42949373.200000] io scheduler noop registered
[42949373.200000] io scheduler anticipatory registered
[42949373.200000] io scheduler deadline registered
[42949373.200000] io scheduler cfq registered
[42949373.200000] RAMDISK driver initialized: 16 RAM disks of 4096K size 
1024 blocksize
[42949373.200000] loop: loaded (max 8 devices)
[42949373.200000] NET: Registered protocol family 2
[42949373.420000] IP route cache hash table entries: 2048 (order: 2, 
16384 bytes)
[42949373.420000] TCP established hash table entries: 8192 (order: 4, 
65536 bytes)
[42949373.420000] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[42949373.420000] TCP: Hash tables configured (established 8192 bind 8192)
[42949373.420000] TCP reno registered
[42949373.420000] TCP bic registered
[42949373.420000] NET: Registered protocol family 1
[42949373.420000] NET: Registered protocol family 17
[42949373.420000] NET: Registered protocol family 15
[42949373.420000] Initialized stdio console driver
[42949373.420000] Console initialized on /dev/tty0
[42949373.420000] Initializing software serial port version 1
[42949373.420000]  ubda: unknown partition table
[42949373.460000] VFS: Mounted root (ext2 filesystem) readonly.
[42949373.490000] request_module: runaway loop modprobe binfmt-464c
[42949373.490000] request_module: runaway loop modprobe binfmt-464c
[42949373.490000] request_module: runaway loop modprobe binfmt-464c
[42949373.490000] request_module: runaway loop modprobe binfmt-464c
[42949373.490000] request_module: runaway loop modprobe binfmt-464c
[42949478.090000] oom-killer: gfp_mask=0xd0, order=0
[42949478.090000] Mem-info:
[42949478.090000] DMA per-cpu:
[42949478.090000] cpu 0 hot: low 62, high 186, batch 31 used:94
[42949478.090000] cpu 0 cold: low 0, high 62, batch 31 used:23
[42949478.090000] Normal per-cpu: empty
[42949478.090000] HighMem per-cpu: empty
[42949478.090000] Free pages:        1964kB (0kB HighMem)
[42949478.090000] Active:7 inactive:7 dirty:0 writeback:0 unstable:0 
free:491 slab:60250 mapped:0 pagetables:0
[42949478.090000] DMA free:1964kB min:2020kB low:2524kB high:3028kB 
active:28kB inactive:28kB present:256000kB pages_scanned:42 
all_unreclaimable? no
[42949478.090000] lowmem_reserve[]: 0 0 0
[42949478.090000] Normal free:0kB min:0kB low:0kB high:0kB active:0kB 
inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
[42949478.090000] lowmem_reserve[]: 0 0 0
[42949478.090000] HighMem free:0kB min:128kB low:160kB high:192kB 
active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
[42949478.090000] lowmem_reserve[]: 0 0 0
[42949478.090000] DMA: 1*4kB 1*8kB 0*16kB 1*32kB 0*64kB 1*128kB 1*256kB 
1*512kB 1*1024kB 0*2048kB 0*4096kB = 1964kB
[42949478.090000] Normal: empty
[42949478.090000] HighMem: empty
[42949478.090000] Swap cache: add 0, delete 0, find 0/0, race 0+0
[42949478.090000] Free swap  = 0kB
[42949478.090000] Total swap = 0kB
[42949478.090000] Free swap:            0kB
[42949478.090000] 64000 pages of RAM
[42949478.090000] 0 pages of HIGHMEM
[42949478.090000] 2984 reserved pages
[42949478.090000] 7 pages shared
[42949478.090000] 0 pages swap cached
[42949488.060000] BUG: soft lockup detected on CPU#0!
[42949488.060000]
[42949488.060000] Modules linked in:
[42949488.060000] Pid: 5, comm: khelper Not tainted 2.6.14.3
[42949488.060000] RIP: 0000:[<0000000000000202>]
[42949488.060000] RSP: 0000000000000008  EFLAGS: 613c3440
[42949488.060000] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 
00000000439248d2
[42949488.060000] RDX: 0000000000003ff8 RSI: 0000000000000000 RDI: 
0000000000000000
[42949488.060000] RBP: 00000000613c0000 R08: 00000000613c31b0 R09: 
0000000000000001
[42949488.060000] R10: 00000000613c31c0 R11: 00000000613c3450 R12: 
00000000613c34e0
[42949488.060000] R13: 00000000601b8520 R14: 00000000613c34e0 R15: 
00000000601b8520
[42949488.060000] Call Trace:
[42949488.060000] 613c3168:  [<6004fd44>] softlockup_tick+0x64/0x70
[42949488.060000] 613c3188:  [<60039718>] do_timer+0x48/0x110
[42949488.060000] 613c31a8:  [<6001673b>] boot_timer_handler+0x1b/0x20
[42949488.060000] 613c31e8:  [<601b8520>] __restore_rt+0x0/0x9
[42949488.060000] 613c31f8:  [<601b8520>] __restore_rt+0x0/0x9
[42949488.060000] 613c32a8:  [<600157f8>] set_signals+0x68/0x180
[42949488.060000] 613c32e8:  [<6003930a>] update_wall_time+0x1a/0x60
[42949488.060000] 613c3308:  [<60039718>] do_timer+0x48/0x110
[42949488.060000] 613c3348:  [<601b8520>] __restore_rt+0x0/0x9
[42949488.060000] 613c3358:  [<601b8520>] __restore_rt+0x0/0x9
[42949488.060000] 613c3378:  [<601b8520>] __restore_rt+0x0/0x9
[42949488.060000] 613c3388:  [<60015713>] enable_mask+0x43/0x60
[42949488.060000] 613c3398:  [<601b879d>] sigemptyset+0x15/0x34
[42949488.060000] 613c33a8:  [<60015813>] set_signals+0x83/0x180
[42949488.060000] 613c33d8:  [<601b879d>] sigemptyset+0x15/0x34
[42949488.060000] 613c33e8:  [<60015681>] change_signals+0x51/0x80
[42949488.060000] 613c3418:  [<60015713>] enable_mask+0x43/0x60
[42949488.060000] 613c3428:  [<601b879d>] sigemptyset+0x15/0x34
[42949488.060000] 613c3438:  [<600157f5>] set_signals+0x65/0x180
[42949488.060000] 613c34e8:  [<60016959>] time_unlock+0x9/0x10
[42949488.060000] 613c34f8:  [<6001646f>] do_gettimeofday+0x7f/0x90
[42949488.060000] 613c3518:  [<600346c5>] getnstimeofday+0x15/0x40
[42949488.060000] 613c3548:  [<60045d3a>] 
do_posix_clock_monotonic_gettime_parts+0x2a/0x70
[42949488.060000] 613c3578:  [<60045d98>] 
do_posix_clock_monotonic_get+0x18/0x60
[42949488.060000] 613c35a8:  [<60045df1>] 
do_posix_clock_monotonic_gettime+0x11/0x20
[42949488.060000] 613c35b8:  [<6005501e>] select_bad_process+0x1e/0x120
[42949488.060000] 613c35c8:  [<6005531a>] oom_kill_process+0x5a/0x70
[42949488.060000] 613c35f8:  [<60055355>] out_of_memory+0x25/0xa0
[42949488.060000] 613c3628:  [<60056468>] __alloc_pages+0x3f8/0x440
[42949488.060000] 613c3668:  [<60015713>] enable_mask+0x43/0x60
[42949488.060000] 613c3690:  [<60019740>] new_thread_proc+0x0/0x50
[42949488.060000] 613c36a8:  [<600564cf>] __get_free_pages+0x1f/0x60
[42949488.060000] 613c36b8:  [<600133c0>] alloc_stack+0x20/0x50
[42949488.060000] 613c36d8:  [<60019a17>] copy_thread_tt+0xa7/0x200
[42949488.060000] 613c3748:  [<60013711>] copy_thread+0x81/0xa0
[42949488.060000] 613c3898:  [<6002c3e9>] copy_process+0x549/0x10b0
[42949488.060000] 613c38d8:  [<60015713>] enable_mask+0x43/0x60
[42949488.060000] 613c38e8:  [<601b879d>] sigemptyset+0x15/0x34
[42949488.060000] 613c38f8:  [<600158dc>] set_signals+0x14c/0x180
[42949488.060000] 613c3918:  [<60015713>] enable_mask+0x43/0x60
[42949488.060000] 613c3928:  [<601b879d>] sigemptyset+0x15/0x34
[42949488.060000] 613c3938:  [<600158dc>] set_signals+0x14c/0x180
[42949488.060000] 613c39e8:  [<6001947c>] switch_to_tt+0x11c/0x190
[42949488.060000] 613c3a48:  [<6002d07b>] do_fork+0x9b/0x240
[42949488.060000] 613c3a88:  [<601b879d>] sigemptyset+0x15/0x34
[42949488.060000] 613c3a98:  [<60015713>] enable_mask+0x43/0x60
[42949488.060000] 613c3ab8:  [<60015813>] set_signals+0x83/0x180
[42949488.060000] 613c3b08:  [<60041e40>] __call_usermodehelper+0x0/0x60
[42949488.060000] 613c3b18:  [<6001345c>] kernel_thread+0x6c/0x80
[42949488.060000] 613c3b48:  [<60041e65>] __call_usermodehelper+0x25/0x60
[42949488.060000] 613c3b68:  [<6004239f>] worker_thread+0x28f/0x350
[42949488.060000] 613c3bf0:  [<60029ef0>] default_wake_function+0x0/0x10
[42949488.060000] 613c3c20:  [<60029ef0>] default_wake_function+0x0/0x10
[42949488.060000] 613c3c58:  [<60042110>] worker_thread+0x0/0x350
[42949488.060000] 613c3c78:  [<6004693c>] kthread+0xbc/0xf0
[42949488.060000] 613c3ca8:  [<60046880>] kthread+0x0/0xf0
[42949488.060000] 613c3cc8:  [<60027e30>] run_kernel_thread+0x40/0x50
[42949488.060000] 613c3cd8:  [<60046880>] kthread+0x0/0xf0
[42949488.060000] 613c3cf0:  [<60046880>] kthread+0x0/0xf0
[42949488.060000] 613c3d18:  [<60027e1d>] run_kernel_thread+0x2d/0x50
[42949488.060000] 613c3d98:  [<60046880>] kthread+0x0/0xf0
[42949488.060000] 613c3da8:  [<600156ce>] unblock_signals+0xe/0x10
[42949488.060000] 613c3db8:  [<60019706>] new_thread_handler+0x166/0x1a0
[42949488.060000] 613c3e38:  [<601b8520>] __restore_rt+0x0/0x9
[42949488.060000] 613c3ee8:  [<601b8655>] sigprocmask+0x11/0x3c
[42949488.060000]

