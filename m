Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317377AbSFLKLK>; Wed, 12 Jun 2002 06:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317681AbSFLKLJ>; Wed, 12 Jun 2002 06:11:09 -0400
Received: from spider.pl ([195.94.213.2]:41485 "HELO spider.pl")
	by vger.kernel.org with SMTP id <S317377AbSFLKLH>;
	Wed, 12 Jun 2002 06:11:07 -0400
Date: Wed, 12 Jun 2002 12:11:17 +0200
From: Maciej Polewczynski <m.polewczynski@spider.pl>
X-Mailer: The Bat! (v1.60h) Business
Reply-To: Maciej Polewczynski <m.polewczynski@spider.pl>
X-Priority: 3 (Normal)
Message-ID: <16810004502.20020612121117@spider.pl>
To: linux-kernel@vger.kernel.org
Subject: unable to handle kernel...
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello ,

I have Debian Potato with kernel 2.2.21. In high disc activity I have
in my logs: unable to handle... (see above). The system doesn's work
and I have to restart it (motherboard Asus A7M266-D, Athlon MP 1800,
1GB RAM, Adaptec AIC-7892 Ultra 160/m SCSI host adapter and IBM disc).
In a low disc activity system work properly. When i utar a big archive
(about 1GB) the system crasch. If you have any idea how to fix this
pleas send me a replay.

p.s.
...sory for my english


Maciej Polewczynski

Jun 11 19:11:53 www kernel: Unable to handle kernel NULL pointer
dereference at virtual address 0000
0020
Jun 11 19:11:53 www kernel: current->tss.cr3 = 00101000, %%cr3 =
00101000
Jun 11 19:11:53 www kernel: *pde = 00000000
Jun 11 19:11:53 www kernel: Oops: 0000
Jun 11 19:11:53 www kernel: CPU:    0
Jun 11 19:11:53 www kernel: EIP:    0010:[try_to_free_buffers+16/180]
Jun 11 19:11:53 www kernel: EFLAGS: 00010207
Jun 11 19:11:53 www kernel: eax: 01193bb4   ebx: c06b2110   ecx:
c025c950   edx: 00078000
Jun 11 19:11:53 www kernel: esi: 00000000   edi: db274ea0   ebp:
c06b2110   esp: fbfe5f4c
Jun 11 19:11:53 www kernel: ds: 0018   es: 0018   ss: 0018
Jun 11 19:11:53 www kernel: Process kswapd (pid: 4, process nr: 4,
stackpage=fbfe5000)
Jun 11 19:11:53 www kernel: Stack: fbfe4000 00000030 fbfff740 da9e1fe0
00000001 c011ba06 c06b2110 00
000030
Jun 11 19:11:53 www kernel:        00000030 c01304f6 00000008 00000005
00000030 fbfe4000 c010fbde fb
fe5fac
Jun 11 19:11:53 www kernel:        00000025 c01207cd 00000005 00000030
fbfe41cd ed638000 fbfe4000 c0
1f8b4e
Jun 11 19:11:53 www kernel: Call Trace: [shrink_mmap+258/352]
[shrink_dcache_memory+58/68] [schedule
+326/636] [try_to_free_pages+69/164] [tvecs+6958/13408]
[tvecs+6958/13408] [kswapd+106/160]
Jun 11 19:11:53 www kernel:        [kswapd+82/160]
[kernel_thread+31/56] [kernel_thread+40/56]
Jun 11 19:11:53 www kernel: Code: 83 7e 20 00 75 62 f6 46 18 46 75 5c
8b 76 14 39 fe 75 ed 90
Jun 11 19:11:53 www kernel: Unable to handle kernel NULL pointer
dereference at virtual address 0000
0014
Jun 11 19:11:53 www kernel: current->tss.cr3 = 194c7000, %%cr3 =
194c7000
Jun 11 19:11:53 www kernel: *pde = 00000000
Jun 11 19:11:53 www kernel: Oops: 0000
Jun 11 19:11:53 www kernel: CPU:    0
Jun 11 19:11:53 www kernel: EIP:    0010:[sync_page_buffers+36/92]
Jun 11 19:11:53 www kernel: EFLAGS: 00010203
Jun 11 19:11:53 www kernel: eax: 00000000   ebx: 00000000   ecx:
c025c950   edx: 00000000
Jun 11 19:11:53 www kernel: esi: db274d20   edi: 00000007   ebp:
c06b21b0   esp: da1dde0c
Jun 11 19:11:53 www kernel: ds: 0018   es: 0018   ss: 0018
Jun 11 19:11:53 www kernel: Process gzip (pid: 1235, process nr: 72,
stackpage=da1dd000)
Jun 11 19:11:53 www kernel: Stack: db274d20 c06b21b0 db274d80 db274d80
db274d80 00000000 db274d80 00
000023
Jun 11 19:11:53 www kernel:        00000202 c0126b81 c06b21b0 00000023
c06b2188 c0126b69 c06b21b0 00
00bfff
Jun 11 19:11:53 www kernel:        da1dc000 00000013 cec187e0 00000aac
00001000 c011ba06 c06b21b0 00
000013
Jun 11 19:11:53 www kernel: Call Trace: [try_to_free_buffers+137/180]
[try_to_free_buffers+113/180]
[shrink_mmap+258/352] [shrink_dcache_memory+58/68]
[try_to_free_pages+69/164] [common_interrupt+24/3
2] [scsi_old_done+1406/1420]
Jun 11 19:11:53 www kernel:        [__get_free_pages+152/680]
[do_generic_file_read+1035/1392] [__wa
ke_up+83/112] [generic_file_read+91/116] [file_read_actor+0/80]
[sys_read+178/208] [system_call+52/5
6]
Jun 11 19:11:53 www kernel: Code: 8b 5b 14 8b 42 18 a8 02 74 1e 0f ab
7a 18 19 c0 85 c0 74 14
Jun 11 19:12:05 www kernel: kmem_free: Bad obj addr (objp=db274900,
name=buffer_head)
Jun 11 19:12:06 www kernel: kmem_free: Bad obj addr (objp=db2748a0,
name=buffer_head)
Jun 11 19:12:06 www kernel: Unable to handle kernel NULL pointer
dereference at virtual address 0000
0000
Jun 11 19:12:06 www kernel: current->tss.cr3 = 38283000, %%cr3 =
38283000
Jun 11 19:12:06 www kernel: *pde = 00000000
Jun 11 19:12:06 www kernel: Oops: 0002
Jun 11 19:12:06 www kernel: CPU:    0
Jun 11 19:12:06 www kernel: EIP:    0010:[kmem_cache_free+320/360]
Jun 11 19:12:06 www kernel: EFLAGS: 00010286
Jun 11 19:12:06 www kernel: eax: 0000003d   ebx: db2748a0   ecx:
00000013   edx: 00000028
Jun 11 19:12:06 www kernel: esi: fbfff740   edi: 00000286   ebp:
c06b8678   esp: f8289dac
Jun 11 19:12:06 www kernel: ds: 0018   es: 0018   ss: 0018
Jun 11 19:12:06 www kernel: Process apache (pid: 711, process nr: 28,
stackpage=f8289000)
Jun 11 19:12:06 www kernel: Stack: db2748a0 c06b8678 f70cfc20 f45e5640
f45e56f0 c013e500 fb2af6f8 f8
289de8
Jun 11 19:12:06 www kernel:        c010f7e0 c012619a fbfff740 db2748a0
fbfff980 00000282 db2748a0 cd
af9220
Jun 11 19:12:06 www kernel:        fffffff9 00000001 db2748a0 db2748a0
00000286 c0126b39 db2748a0 da
06b95c
Jun 11 19:12:06 www kernel: Call Trace: [ext2_put_inode+16/24]
[wake_up_process+64/76] [put_unused_b
uffer_head+38/84] [try_to_free_buffers+65/180]
[try_to_free_buffers+56/180] [shrink_mmap+258/352] [s
hrink_dcache_memory+58/68]
Jun 11 19:12:06 www kernel:        [try_to_free_pages+69/164]
[__get_free_pages+152/680] [alloc_wait
+23/152] [do_select+93/512] [handle_mm_fault+291/328]
[sys_select+881/1176] [do_page_fault+263/992]
[common_interrupt+24/32]
Jun 11 19:12:06 www kernel:        [error_code+53/64]
[system_call+52/56]
Jun 11 19:12:06 www kernel: Code: c7 05 00 00 00 00 00 00 00 00 eb 12
83 c4 fc 56 53 68 5e 89
Jun 11 19:12:42 www kernel: Unable to handle kernel NULL pointer
dereference at virtual address 0000
0020
Jun 11 19:12:42 www kernel: current->tss.cr3 = 194c7000, %%cr3 =
194c7000
Jun 11 19:12:42 www kernel: *pde = 00000000
Jun 11 19:12:42 www kernel: Oops: 0000
Jun 11 19:12:42 www kernel: CPU:    0
Jun 11 19:12:42 www kernel: EIP:    0010:[try_to_free_buffers+16/180]
Jun 11 19:12:42 www kernel: EFLAGS: 00010207
Jun 11 19:12:42 www kernel: eax: 011a9ec8   ebx: c06b2110   ecx:
c025c950   edx: 00078000
Jun 11 19:12:42 www kernel: esi: 00000000   edi: db274ea0   ebp:
c06b2110   esp: fa041cbc
Jun 11 19:12:42 www kernel: ds: 0018   es: 0018   ss: 0018
Jun 11 19:12:42 www kernel: Process tar (pid: 1247, process nr: 72,
stackpage=fa041000)
Jun 11 19:12:42 www kernel: Stack: fa040000 00000005 00000805 00000000
00000293 c011ba06 c06b2110 00
000005
Jun 11 19:12:42 www kernel:        00000005 00000805 0000000e 00000005
00000005 fa040000 fbfff740 00
000005
Jun 11 19:12:42 www kernel:        da9f9000 c01207cd 00000005 00000005
c268dda0 c0125e2b fa040000 00
000000
Jun 11 19:12:42 www kernel: Call Trace: [shrink_mmap+258/352]
[try_to_free_pages+69/164] [balance_di
rty+19/44] [__get_free_pages+152/680] [grow_buffers+64/264]
[refill_freelist+16/68] [getblk+309/352]

Jun 11 19:12:42 www kernel:        [__brelse+19/68]
[ext2_alloc_block+116/376] [block_getblk+342/672
] [do_aic7xxx_isr+96/128] [ext2_getblk+146/172] [__brelse+19/68]
[ext2_file_write+1038/1468] [ext2_f
ile_write+550/1468]
Jun 11 19:12:42 www kernel:        [wake_up_process+64/76]
[__wake_up+83/112] [pipe_read+319/368] [p
ipe_read+303/368] [sys_write+212/260] [system_call+52/56]
Jun 11 19:12:42 www kernel: Code: 83 7e 20 00 75 62 f6 46 18 46 75 5c
8b 76 14 39 fe 75 ed 90
Jun 11 19:12:48 www kernel: Kernel panic: VFS: LRU block list
corrupted


