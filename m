Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129699AbRBCXBS>; Sat, 3 Feb 2001 18:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130843AbRBCXBJ>; Sat, 3 Feb 2001 18:01:09 -0500
Received: from femail1.rdc1.on.home.com ([24.2.9.88]:15590 "EHLO
	femail1.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S129699AbRBCXAt>; Sat, 3 Feb 2001 18:00:49 -0500
Message-ID: <3A7C8D8D.60797138@Home.net>
Date: Sat, 03 Feb 2001 18:00:30 -0500
From: Shawn Starr <Shawn.Starr@Home.net>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: PS hanging in 2.4.1 - HAPPENING NOW!!!
In-Reply-To: <3A7C8AC4.D3CAAF57@Home.net>
Content-Type: multipart/mixed;
 boundary="------------919FDCFF00446FE3C78B1B1D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------919FDCFF00446FE3C78B1B1D
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Here's more info with the SYSQ in kern.log, This is the only info I have that
the kernel reports right now.

Shawn.

Shawn Starr wrote:

> [root@coredump spstarr]# killall -9 gnomeicu
>
> ... waiting...
>
> spstarr     67 -bash            read_chan
> root        68 /sbin/mingetty t read_chan
> root        69 /sbin/mingetty t read_chan
> root        73 inetd            do_select
> root        74 xfs              do_select
> spstarr     83 -bash            wait4
> daemon     561 named -u daemon  rt_sigsuspend
> daemon     562 named -u daemon  do_poll
> daemon     563 named -u daemon  rt_sigsuspend
> daemon     564 named -u daemon  nanosleep
> daemon     565 named -u daemon  do_select
> root     26231 ./a.out          wait_for_connect
> spstarr   9297 /bin/sh /usr/X11 wait4
> spstarr   9300 xinit /usr/X11R6 wait4
> root      9301 X :0             do_select
> spstarr   9303 gnome-session    do_poll
> spstarr   9309 esd -terminate - down_interruptible
> spstarr   9311 gnome-smproxy -- do_select
> spstarr   9325 /usr/local/bin/s do_select
> spstarr   9327 panel --sm-confi do_poll
> spstarr   9329 gnome-name-servi do_poll
> spstarr   9332 tasklist_applet  do_poll
> spstarr   9334 quicklaunch_appl unix_stream_data_wait
>
> [root@coredump /root]# uptime
>   5:45pm  up 4 days,  7:04,  4 users,  load average: 3.37, 1.81, 0.92
>
> Huh??/ why is my load average gone up?!?
>
> the load average just went crazy..
>
> uname -a
> Linux coredump 2.4.1 #1 Tue Jan 30 10:21:42 EST 2001 i586 unknown
>
> Help, I forgot the small script Linus made to see the /proc values:
>
> XMMS *WAS* running at the time of this lock. Im waiting further
> instructions.
>
> Shawn.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

--------------919FDCFF00446FE3C78B1B1D
Content-Type: text/plain; charset=iso-8859-15;
 name="dump"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dump"

Feb  3 17:55:58 coredump kernel: SysRq: unRaw saK Boot Sync Unmount showPc showTasks showMem loglevel0-8 tErm kIll killalL
Feb  3 17:55:59 coredump last message repeated 2 times
Feb  3 17:56:12 coredump kernel: SysRq: Show Memory
Feb  3 17:56:12 coredump kernel: Mem-info:
Feb  3 17:56:12 coredump kernel: Free pages:         968kB (     0kB HighMem)
Feb  3 17:56:12 coredump kernel: ( Active: 5079, inactive_dirty: 146, inactive_clean: 450, free: 242 (224 448 672) )
Feb  3 17:56:12 coredump kernel: 6*4kB 0*8kB 1*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB = 552kB)
Feb  3 17:56:12 coredump kernel: 18*4kB 5*8kB 3*16kB 2*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB = 416kB)
Feb  3 17:56:12 coredump kernel: = 0kB)
Feb  3 17:56:12 coredump kernel: Swap cache: add 427812, delete 426104, find 235021/938247
Feb  3 17:56:12 coredump kernel: Free swap:        37704kB
Feb  3 17:56:12 coredump kernel: 16384 pages of RAM
Feb  3 17:56:12 coredump kernel: 0 pages of HIGHMEM
Feb  3 17:56:12 coredump kernel: 1480 reserved pages
Feb  3 17:56:12 coredump kernel: 13751 pages shared
Feb  3 17:56:12 coredump kernel: 1708 pages swap cached
Feb  3 17:56:12 coredump kernel: 0 pages in page table cache
Feb  3 17:56:13 coredump kernel: Buffer memory:      604kB
Feb  3 17:56:22 coredump kernel: SysRq: Show Regs
Feb  3 17:56:22 coredump kernel: 
Feb  3 17:56:22 coredump kernel: EIP: 0010:[default_idle+47/68] CPU: 0 EFLAGS: 00003246
Feb  3 17:56:22 coredump kernel: EAX: 00000000 EBX: c0478000 ECX: c0ce0260 EDX: c025c3e0
Feb  3 17:56:22 coredump kernel: ESI: c0107120 EDI: ffffe000 EBP: 0008e000 DS: 0018 ES: 0018
Feb  3 17:56:22 coredump kernel: CR0: 8005003b CR2: 4004ab80 CR3: 007ac000 CR4: 00000010
Feb  3 17:56:22 coredump kernel: Call Trace: [cpu_idle+62/84] [empty_bad_page+0/4096] [L6+0/2] 
Feb  3 17:57:05 coredump kernel: SysRq: Show State
Feb  3 17:57:05 coredump kernel: 
Feb  3 17:57:05 coredump kernel:                          free                        sibling
Feb  3 17:57:05 coredump kernel:   task             PC    stack   pid father child younger older
Feb  3 17:57:05 coredump kernel: init      S C1177F28  4648     1      0  9622  (NOTLB)        
Feb  3 17:57:05 coredump kernel: Call Trace: [schedule_timeout+118/152] [process_timeout+0/100] [do_select+413/476] [sys_select+842/1172] [sys_stat64+107/120] [system_call+62/80] 
Feb  3 17:57:05 coredump kernel: keventd   S 00010000  6572     2      1        (L-TLB)       3
Feb  3 17:57:05 coredump kernel: Call Trace: [context_thread+261/424] [kernel_thread+40/56] 
Feb  3 17:57:05 coredump kernel: kswapd    S C1165FA8  5472     3      1        (L-TLB)       4     2
Feb  3 17:57:05 coredump kernel: Call Trace: [schedule_timeout+118/152] [process_timeout+0/100] [interruptible_sleep_on_timeout+79/128] [kswapd+213/244] [kernel_thread+40/56] 
Feb  3 17:57:05 coredump kernel: kreclaimd  S 00000286  5924     4      1        (L-TLB)       5     3
Feb  3 17:57:05 coredump kernel: Call Trace: [interruptible_sleep_on+74/120] [kreclaimd+75/160] [kernel_thread+40/56] 
Feb  3 17:57:05 coredump kernel: bdflush   S C1160000  5392     5      1        (L-TLB)       6     4
Feb  3 17:57:05 coredump kernel: Call Trace: [bdflush+238/248] [kernel_thread+40/56] 
Feb  3 17:57:05 coredump kernel: kupdate   S C115FFC4  5492     6      1        (L-TLB)       7     5
Feb  3 17:57:05 coredump kernel: Call Trace: [schedule_timeout+118/152] [process_timeout+0/100] [kupdate+141/280] [kernel_thread+40/56] 
Feb  3 17:57:05 coredump kernel: kreiserfsd  S C3F65FAC  5380     7      1        (L-TLB)      51     6
Feb  3 17:57:05 coredump kernel: Call Trace: [schedule_timeout+118/152] [process_timeout+0/100] [interruptible_sleep_on_timeout+79/128] [reiserfs_journal_commit_thread+201/252] [kernel_thread+40/56] 
Feb  3 17:57:05 coredump kernel: syslogd   S 7FFFFFFF   336    51      1        (NOTLB)      55     7
Feb  3 17:57:05 coredump kernel: Call Trace: [schedule_timeout+23/152] [do_select+413/476] [sys_select+842/1172] [system_call+62/80] 
Feb  3 17:57:05 coredump kernel: klogd     R C3A1A000     0    55      1        (NOTLB)      65    51
Feb  3 17:57:05 coredump kernel: Call Trace: [add_wait_queue+59/68] [do_syslog+204/972] [kmsg_read+17/24] [sys_read+150/204] [system_call+62/80] 
Feb  3 17:57:05 coredump kernel: bash      S 00000000  4716    65      1  9615  (NOTLB)      66    55
Feb  3 17:57:05 coredump kernel: Call Trace: [sys_wait4+901/948] [system_call+62/80] 
Feb  3 17:57:05 coredump kernel: bash      S 00000000     4    66      1  9616  (NOTLB)      67    65
Feb  3 17:57:05 coredump kernel: Call Trace: [sys_wait4+901/948] [system_call+62/80] 
Feb  3 17:57:05 coredump kernel: bash      S 00000000  2224    67      1  9620  (NOTLB)      68    66
Feb  3 17:57:05 coredump kernel: Call Trace: [sys_wait4+901/948] [system_call+62/80] 
Feb  3 17:57:06 coredump kernel: bash      S 00000000  3596    68      1  9648  (NOTLB)      69    67
Feb  3 17:57:06 coredump kernel: Call Trace: [sys_wait4+901/948] [system_call+62/80] 
Feb  3 17:57:06 coredump kernel: bash      S 7FFFFFFF     4    69      1  9679  (NOTLB)      73    68
Feb  3 17:57:06 coredump kernel: Call Trace: [schedule_timeout+23/152] [add_wait_queue+59/68] [read_chan+897/1844] [tty_read+176/208] [sys_read+150/204] [system_call+62/80] 
Feb  3 17:57:06 coredump kernel: inetd     S 7FFFFFFF  4804    73      1        (NOTLB)      74    69
Feb  3 17:57:06 coredump kernel: Call Trace: [schedule_timeout+23/152] [do_select+413/476] [sys_select+842/1172] [sys_rt_sigprocmask+328/484] [system_call+62/80] 
Feb  3 17:57:06 coredump kernel: xfs       S C36B5F28  4724    74      1        (NOTLB)      83    73
Feb  3 17:57:06 coredump kernel: Call Trace: [schedule_timeout+118/152] [process_timeout+0/100] [do_select+413/476] [sys_select+842/1172] [system_call+62/80] 
Feb  3 17:57:06 coredump kernel: bash      S 00000000  4724    83      1  9297  (NOTLB)     561    74
Feb  3 17:57:06 coredump kernel: Call Trace: [sys_wait4+901/948] [system_call+62/80] 
Feb  3 17:57:06 coredump kernel: named     S C1F61FB0     0   561      1   562  (NOTLB)   26231    83
Feb  3 17:57:06 coredump kernel: Call Trace: [sys_rt_sigsuspend+239/268] [system_call+62/80] 
Feb  3 17:57:06 coredump kernel: named     S C305BF30  2672   562    561   565  (NOTLB)        
Feb  3 17:57:06 coredump kernel: Call Trace: [schedule_timeout+118/152] [process_timeout+0/100] [do_poll+186/220] [sys_poll+467/720] [system_call+62/80] 
Feb  3 17:57:06 coredump kernel: named     S C39B9FB0     0   563    562        (NOTLB)     564
Feb  3 17:57:06 coredump kernel: Call Trace: [sys_rt_sigsuspend+239/268] [system_call+62/80] 
Feb  3 17:57:06 coredump kernel: named     S C2FF3F88  2672   564    562        (NOTLB)     565   563
Feb  3 17:57:06 coredump kernel: Call Trace: [schedule_timeout+118/152] [process_timeout+0/100] [sys_nanosleep+254/404] [system_call+62/80] 
Feb  3 17:57:06 coredump kernel: named     S 7FFFFFFF  2672   565    562        (NOTLB)           564
Feb  3 17:57:07 coredump kernel: Call Trace: [schedule_timeout+23/152] [do_select+413/476] [sys_select+842/1172] [system_call+62/80] 
Feb  3 17:57:07 coredump kernel: a.out     S 7FFFFFFF     0 26231      1        (NOTLB)    9309   561
Feb  3 17:57:07 coredump kernel: Call Trace: [schedule_timeout+23/152] [add_wait_queue_exclusive+59/68] [wait_for_connect+185/324] [tcp_accept+124/368] [inet_accept+46/240] [sys_accept+102/252] [do_page_fault+312/1020] 
Feb  3 17:57:07 coredump kernel:        [do_page_fault+0/1020] [kmem_cache_free+181/192] [sys_rt_sigaction+124/212] [sys_socketcall+180/512] [system_call+54/80] [system_call+62/80] 
Feb  3 17:57:07 coredump kernel: startx    S 00000000     0  9297     83  9300  (NOTLB)        
Feb  3 17:57:07 coredump kernel: Call Trace: [sys_wait4+901/948] [system_call+62/80] 
Feb  3 17:57:07 coredump kernel: xinit     S 00000000     0  9300   9297  9303  (NOTLB)        
Feb  3 17:57:07 coredump kernel: Call Trace: [sys_wait4+901/948] [system_call+62/80] 
Feb  3 17:57:07 coredump kernel: X         S C0CE1F28     4  9301   9300        (NOTLB)    9303
Feb  3 17:57:07 coredump kernel: Call Trace: [schedule_timeout+118/152] [process_timeout+0/100] [do_select+413/476] [sys_select+842/1172] [system_call+62/80] 
Feb  3 17:57:07 coredump kernel: gnome-session  S 7FFFFFFF     0  9303   9300        (NOTLB)          9301
Feb  3 17:57:07 coredump kernel: Call Trace: [schedule_timeout+23/152] [do_poll+133/220] [do_poll+186/220] [sys_poll+467/720] [system_call+62/80] 
Feb  3 17:57:07 coredump kernel: esd       S C3AFDC10     0  9309      1        (NOTLB)    9311 26231
Feb  3 17:57:07 coredump kernel: Call Trace: [__down_interruptible+111/244] [__down_failed_interruptible+7/12] [stext_lock+2615/3960] [write_chan+0/516] [sys_write+143/196] [system_call+62/80] 
Feb  3 17:57:07 coredump kernel: gnome-smproxy  S 7FFFFFFF     0  9311      1        (NOTLB)    9325  9309
Feb  3 17:57:07 coredump kernel: Call Trace: [schedule_timeout+23/152] [do_select+413/476] [sys_select+842/1172] [system_call+62/80] 
Feb  3 17:57:07 coredump kernel: sawfish   S C3007F28   692  9325      1        (NOTLB)    9327  9311
Feb  3 17:57:08 coredump kernel: Call Trace: [schedule_timeout+118/152] [process_timeout+0/100] [do_select+413/476] [sys_select+842/1172] [system_call+62/80] 
Feb  3 17:57:08 coredump kernel: panel     S 7FFFFFFF     0  9327      1        (NOTLB)    9329  9325
Feb  3 17:57:08 coredump kernel: Call Trace: [schedule_timeout+23/152] [add_wait_queue+59/68] [unix_stream_data_wait+166/216] [unix_stream_recvmsg+378/904] [sock_recvmsg+61/172] [sock_read+132/144] [sys_read+150/204] 
Feb  3 17:57:08 coredump kernel:        [system_call+62/80] 
Feb  3 17:57:08 coredump kernel: gnome-name-serv  S 7FFFFFFF     0  9329      1        (NOTLB)    9332  9327
Feb  3 17:57:08 coredump kernel: Call Trace: [schedule_timeout+23/152] [do_poll+133/220] [do_poll+186/220] [sys_poll+467/720] [system_call+62/80] 
Feb  3 17:57:08 coredump kernel: tasklist_applet  S 7FFFFFFF     0  9332      1        (NOTLB)    9338  9329
Feb  3 17:57:08 coredump kernel: Call Trace: [schedule_timeout+23/152] [do_poll+133/220] [do_poll+186/220] [sys_poll+467/720] [system_call+62/80] 
Feb  3 17:57:08 coredump kernel: gnomeicu  S 0000CD17     0  9338      1        (NOTLB)    9340  9332
Feb  3 17:57:08 coredump kernel: Call Trace: [search_by_key+203/3232] [search_for_position_by_key+170/916] [make_cpu_key+57/64] [_get_block_create_0+136/1072] [_get_block_create_0+162/1072] [remove_wait_queue+40/48] [__wait_on_buffer+128/140] 
Feb  3 17:57:08 coredump kernel:        [<f0000000>] [reiserfs_get_block+158/3408] [search_for_position_by_key+170/916] [search_for_position_by_key+570/916] [make_cpu_key+57/64] [kmem_cache_alloc+75/116] [get_unused_buffer_head+52/144] [create_buffers+96/444] 
Feb  3 17:57:08 coredump kernel:        [block_read_full_page+246/552] [add_to_page_cache_unique+202/212] [reiserfs_readpage+15/20] [reiserfs_get_block+0/3408] [read_cluster_nonblocking+258/324] [filemap_nopage+332/1032] [do_no_page+77/192] [handle_mm_fault+232/340] 
Feb  3 17:57:08 coredump kernel:        [do_page_fault+312/1020] [do_page_fault+0/1020] [start_request+388/508] [intlat_local_irq_disable+16/20] [ide_do_request+685/752] [schedule+639/964] [remove_wait_queue+40/48] [error_code+52/64] 
Feb  3 17:57:09 coredump kernel:        [__generic_copy_from_user+52/60] [opost_block+67/384] [handle_mm_fault+232/340] [add_wait_queue+59/68] [write_chan+365/516] [tty_write+341/448] [write_chan+0/516] [sys_write+143/196] 
Feb  3 17:57:09 coredump kernel:        [system_call+62/80] 
Feb  3 17:57:09 coredump kernel: xchat     S 7FFFFFFF     0  9340      1        (NOTLB)    9342  9338
Feb  3 17:57:09 coredump kernel: Call Trace: [schedule_timeout+23/152] [add_wait_queue+59/68] [unix_stream_data_wait+166/216] [unix_stream_recvmsg+378/904] [sock_recvmsg+61/172] [sock_read+132/144] [sys_read+150/204] 
Feb  3 17:57:09 coredump kernel:        [system_call+62/80] 
Feb  3 17:57:09 coredump kernel: gnome-terminal  S 7FFFFFFF   192  9342      1  9345  (NOTLB)    9510  9340
Feb  3 17:57:09 coredump kernel: Call Trace: [schedule_timeout+23/152] [do_poll+133/220] [do_poll+186/220] [sys_poll+467/720] [system_call+62/80] 
Feb  3 17:57:09 coredump kernel: gnome-pty-helpe  S 7FFFFFFF     0  9344   9342        (NOTLB)    9345
Feb  3 17:57:09 coredump kernel: Call Trace: [schedule_timeout+23/152] [add_wait_queue+59/68] [unix_stream_data_wait+166/216] [unix_stream_recvmsg+378/904] [sock_recvmsg+61/172] [sock_read+132/144] [sys_read+150/204] 
Feb  3 17:57:09 coredump kernel:        [system_call+62/80] 
Feb  3 17:57:09 coredump kernel: bash      S 00000000  5216  9345   9342  9651  (NOTLB)          9344
Feb  3 17:57:09 coredump kernel: Call Trace: [sys_wait4+901/948] [system_call+62/80] 
Feb  3 17:57:09 coredump kernel: netscape  S C1EA3EF0     0  9510      1  9511  (NOTLB)    9603  9342
Feb  3 17:57:09 coredump kernel: Call Trace: [schedule_timeout+118/152] [process_timeout+0/100] [do_select+413/476] [sys_select+842/1172] [old_select+85/108] [system_call+62/80] 
Feb  3 17:57:09 coredump kernel: netscape  S C262FEF0     0  9511   9510        (NOTLB)        
Feb  3 17:57:09 coredump kernel: Call Trace: [schedule_timeout+118/152] [process_timeout+0/100] [do_select+413/476] [sys_select+842/1172] [old_select+85/108] [system_call+62/80] 
Feb  3 17:57:09 coredump kernel: xterm     S 7FFFFFFF    16  9603      1  9604  (NOTLB)    9611  9510
Feb  3 17:57:09 coredump kernel: Call Trace: [schedule_timeout+23/152] [do_select+413/476] [sys_select+842/1172] [system_call+62/80] 
Feb  3 17:57:10 coredump kernel: bash      S 00000000     0  9604   9603  9606  (NOTLB)        
Feb  3 17:57:10 coredump kernel: Call Trace: [sys_wait4+901/948] [system_call+62/80] 
Feb  3 17:57:10 coredump kernel: bash      S 00000000     0  9606   9604  9612  (NOTLB)        
Feb  3 17:57:10 coredump kernel: Call Trace: [sys_wait4+901/948] [system_call+62/80] 
Feb  3 17:57:10 coredump kernel: gnomeicu  S 7FFFFFFF     0  9611      1        (NOTLB)    9622  9603
Feb  3 17:57:10 coredump kernel: Call Trace: [schedule_timeout+23/152] [add_wait_queue+59/68] [unix_stream_data_wait+166/216] [unix_stream_recvmsg+378/904] [sock_recvmsg+61/172] [sock_read+132/144] [sys_read+150/204] 
Feb  3 17:57:10 coredump kernel:        [system_call+62/80] 
Feb  3 17:57:10 coredump kernel: killall   D C3F4D81C     0  9612   9606        (NOTLB)        
Feb  3 17:57:10 coredump kernel: Call Trace: [__down+113/212] [__down_failed+8/12] [stext_lock+2135/3960] [proc_info_read+86/276] [sys_read+150/204] [system_call+62/80] 
Feb  3 17:57:10 coredump kernel: ps        D C3F4D81C     0  9615     65        (NOTLB)        
Feb  3 17:57:10 coredump kernel: Call Trace: [intlat_local_irq_enable+18/24] [__down+113/212] [__down_failed+8/12] [stext_lock+2135/3960] [proc_info_read+86/276] [sys_read+150/204] [system_call+62/80] 
Feb  3 17:57:10 coredump kernel: bash      S 00000000     0  9616     66  9617  (NOTLB)        
Feb  3 17:57:10 coredump kernel: Call Trace: [sys_wait4+901/948] [system_call+62/80] 
Feb  3 17:57:10 coredump kernel: ps        D C3F4D81C     0  9617   9616        (NOTLB)        
Feb  3 17:57:10 coredump kernel: Call Trace: [intlat_local_irq_enable+18/24] [__down+113/212] [__down_failed+8/12] [stext_lock+2135/3960] [proc_info_read+86/276] [sys_read+150/204] [system_call+62/80] 
Feb  3 17:57:10 coredump kernel: bash      S 00000000     0  9620     67  9642  (NOTLB)        
Feb  3 17:57:10 coredump kernel: Call Trace: [sys_wait4+901/948] [system_call+62/80] 
Feb  3 17:57:11 coredump kernel: gpm       S C1B7BF88  2672  9622      1        (NOTLB)          9611
Feb  3 17:57:11 coredump kernel: Call Trace: [schedule_timeout+118/152] [process_timeout+0/100] [sys_nanosleep+254/404] [system_call+62/80] 
Feb  3 17:57:11 coredump kernel: top       D C3F4D81C    16  9642   9620        (NOTLB)        
Feb  3 17:57:11 coredump kernel: Call Trace: [intlat_local_irq_enable+18/24] [__down+113/212] [__down_failed+8/12] [stext_lock+2135/3960] [proc_info_read+86/276] [sys_read+150/204] [system_call+62/80] 
Feb  3 17:57:11 coredump kernel: ps        D C3F4D81C     0  9648     68        (NOTLB)        
Feb  3 17:57:11 coredump kernel: Call Trace: [intlat_local_irq_enable+18/24] [__down+113/212] [__down_failed+8/12] [stext_lock+2135/3960] [proc_info_read+86/276] [sys_read+150/204] [system_call+62/80] 
Feb  3 17:57:11 coredump kernel: killall   D C3F4D81C     0  9651   9345        (NOTLB)        
Feb  3 17:57:11 coredump kernel: Call Trace: [__down+113/212] [__down_failed+8/12] [stext_lock+2135/3960] [proc_info_read+86/276] [sys_read+150/204] [system_call+62/80] 
Feb  3 17:57:11 coredump kernel: xterm     S 7FFFFFFF     0  9678     69  9680  (NOTLB)    9679
Feb  3 17:57:11 coredump kernel: Call Trace: [schedule_timeout+23/152] [do_select+413/476] [sys_select+842/1172] [system_call+62/80] 
Feb  3 17:57:11 coredump kernel: xterm     S 7FFFFFFF     8  9679     69  9681  (NOTLB)          9678
Feb  3 17:57:11 coredump kernel: Call Trace: [schedule_timeout+23/152] [do_select+413/476] [sys_select+842/1172] [system_call+62/80] 
Feb  3 17:57:11 coredump kernel: bash      S 7FFFFFFF     0  9680   9678        (NOTLB)        
Feb  3 17:57:11 coredump kernel: Call Trace: [schedule_timeout+23/152] [add_wait_queue+59/68] [read_chan+897/1844] [tty_read+176/208] [sys_read+150/204] [system_call+62/80] 
Feb  3 17:57:11 coredump kernel: bash      S 00000000     0  9681   9679  9719  (NOTLB)        
Feb  3 17:57:11 coredump kernel: Call Trace: [sys_wait4+901/948] [system_call+62/80] 
Feb  3 17:57:11 coredump kernel: tail      S C1C71F88     0  9719   9681        (NOTLB)        
Feb  3 17:57:11 coredump kernel: Call Trace: [schedule_timeout+118/152] [process_timeout+0/100] [sys_nanosleep+254/404] [system_call+62/80] 
Feb  3 17:57:46 coredump kernel: SysRq: Log level set to 8

--------------919FDCFF00446FE3C78B1B1D--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
