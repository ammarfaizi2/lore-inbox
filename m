Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312887AbSDBS35>; Tue, 2 Apr 2002 13:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312883AbSDBS3u>; Tue, 2 Apr 2002 13:29:50 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:64405 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S312887AbSDBS3k>; Tue, 2 Apr 2002 13:29:40 -0500
Message-ID: <3CA9E851.3010606@t-online.de>
Date: Tue, 02 Apr 2002 19:20:17 +0200
From: Robert.Hannebauer@t-online.de (Robert Hannebauer)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:0.9.9) Gecko/20020313
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: oops in 2.4.19-pre5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i'm got this while running seti. No other special load.

bye
   Robert

---- /var/log/messages ----

Apr 2 18:35:45 sonne kernel: Unable to handle kernel paging request at 
virtual address 01000054
Apr 2 18:35:45 sonne kernel: printing eip:
Apr 2 18:35:45 sonne kernel: c01282d7
Apr 2 18:35:45 sonne kernel: *pde = 00000000
Apr 2 18:35:45 sonne kernel: Oops: 0000
Apr 2 18:35:45 sonne kernel: CPU: 0
Apr 2 18:35:45 sonne kernel: EIP: 0010:[__find_lock_page_helper+23/96] 
Not tainted
Apr 2 18:35:45 sonne kernel: EFLAGS: 00210202
Apr 2 18:35:45 sonne kernel: eax: cc7f5330 ebx: 0100004c ecx: c114004c 
edx: 00060528
Apr 2 18:35:45 sonne kernel: esi: 00060528 edi: cc7f5330 ebp: c114004c 
esp: c82a3f38
Apr 2 18:35:45 sonne kernel: ds: 0018 es: 0018 ss: 0018
Apr 2 18:35:45 sonne kernel: Process kmix (pid: 1550, stackpage=c82a3000)
Apr 2 18:35:45 sonne kernel: Stack: 0000002c c82a3f94 00060528 cff41ca0 
c0128333 c012a781 cc7f5330 00060528
Apr 2 18:35:45 sonne kernel: cff41ca0 00000000 cdc295c0 ffffffea 
0000002e cc7f52e8 00001000 00000000
Apr 2 18:35:45 sonne kernel: 0000002c fffffff4 00000002 60528000 
00000000 cc7f5280 cc7f5330 00000000
Apr 2 18:35:45 sonne kernel: Call Trace: [__find_lock_page+19/32] 
[generic_file_write+993/1792] [sys_write+150/240] [system_call+51/56]
Apr 2 18:35:45 sonne kernel:
Apr 2 18:35:45 sonne kernel: Code: 39 7b 08 75 f4 39 73 0c 75 ef 85 db 
74 32 ff 43 14 31 c0 0f
Apr 2 18:38:04 sonne kernel: kernel BUG at page_alloc.c:227!
Apr 2 18:38:04 sonne kernel: invalid operand: 0000
Apr 2 18:38:04 sonne kernel: CPU: 0
Apr 2 18:38:04 sonne kernel: EIP: 0010:[rmqueue+112/544] Not tainted
Apr 2 18:38:04 sonne kernel: EFLAGS: 00010086
Apr 2 18:38:04 sonne kernel: eax: 0000fff0 ebx: c12416f8 ecx: 00001000 
edx: e8bb0085
Apr 2 18:38:04 sonne kernel: esi: c12416f8 edi: 00000000 ebp: c027aa74 
esp: c3e23e50
Apr 2 18:38:04 sonne kernel: ds: 0018 es: 0018 ss: 0018
Apr 2 18:38:04 sonne kernel: Process setiathome (pid: 1638, 
stackpage=c3e23000)
Apr 2 18:38:04 sonne kernel: Stack: c027ac00 000001ff cbf5bc80 00000000 
00000001 0000bcdf 00000286 c027aa8c
Apr 2 18:38:04 sonne kernel: 00000000 c027aa74 c012ed53 000001d2 
cbf5bc80 cbf5bc80 c820b1c0 c027aa74
Apr 2 18:38:04 sonne kernel: c027abfc 000001d2 c02251e6 c012eb56 
00104025 c0125d14 41010000 cbf5bc80
Apr 2 18:38:04 sonne kernel: Call Trace: [__alloc_pages+51/368] 
[mmx_clear_page+38/48] [_alloc_pages+22/32] [do_anonymous_page+52/224] 
[do_no_page+47/368]
Apr 2 18:38:04 sonne kernel: [handle_mm_fault+82/176] 
[do_page_fault+355/1172] [do_page_fault+0/1172] [old_mmap+237/304] 
[error_code+52/60]
Apr 2 18:38:04 sonne kernel:
Apr 2 18:38:04 sonne kernel: Code: 0f 0b e3 00 06 60 23 c0 8b 53 04 8b 
03 89 50 04 89 02 8b 54
Apr 2 18:45:00 sonne kernel: kernel BUG at page_alloc.c:227!
Apr 2 18:45:00 sonne kernel: invalid operand: 0000
Apr 2 18:45:00 sonne kernel: CPU: 0
Apr 2 18:45:00 sonne kernel: EIP: 0010:[rmqueue+112/544] Not tainted
Apr 2 18:45:00 sonne kernel: EFLAGS: 00010086
Apr 2 18:45:00 sonne kernel: eax: 0000fff0 ebx: c12416f8 ecx: 00001000 
edx: e8bb0085
Apr 2 18:45:00 sonne kernel: esi: c12416f8 edi: 00000000 ebp: c027aa74 
esp: c3cb1e78
Apr 2 18:45:00 sonne kernel: ds: 0018 es: 0018 ss: 0018
Apr 2 18:45:00 sonne kernel: Process cron (pid: 1662, stackpage=c3cb1000)
Apr 2 18:45:00 sonne kernel: Stack: c027ac00 000001ff 0ed74065 00000000 
7271706f 00002e4e 00000296 c027aa8c
Apr 2 18:45:00 sonne kernel: 00000000 c027aa74 c012ed53 000001d2 
00000000 0ed74065 c8323520 c027aa74
Apr 2 18:45:00 sonne kernel: c027abfc 000001d2 c128d00c c012eb56 
c128d00c c01258af 40148fe8 cbf5bc80
Apr 2 18:45:00 sonne kernel: Call Trace: [__alloc_pages+51/368] 
[_alloc_pages+22/32] [do_wp_page+143/512] [handle_mm_fault+122/176] 
[do_page_fault+355/1172]
Apr 2 18:45:00 sonne kernel: [do_page_fault+0/1172] 
[copy_thread+136/160] [sys_fcntl64+128/144] [error_code+52/60]
Apr 2 18:45:00 sonne kernel:
Apr 2 18:45:00 sonne kernel: Code: 0f 0b e3 00 06 60 23 c0 8b 53 04 8b 
03 89 50 04 89 02 8b 54
Apr 2 18:45:00 sonne kernel: kernel BUG at page_alloc.c:227!
Apr 2 18:45:00 sonne kernel: invalid operand: 0000
Apr 2 18:45:00 sonne kernel: CPU: 0
Apr 2 18:45:00 sonne kernel: EIP: 0010:[rmqueue+112/544] Not tainted
Apr 2 18:45:00 sonne kernel: EFLAGS: 00010086
Apr 2 18:45:00 sonne kernel: eax: 0000fff0 ebx: c12416f8 ecx: 00001000 
edx: e8bb0085
Apr 2 18:45:00 sonne kernel: esi: c12416f8 edi: 00000000 ebp: c027aa74 
esp: c3e4de44
Apr 2 18:45:00 sonne kernel: ds: 0018 es: 0018 ss: 0018
Apr 2 18:45:00 sonne kernel: Process cron (pid: 1663, stackpage=c3e4d000)
Apr 2 18:45:00 sonne kernel: Stack: c027ac00 000001ff 0c051b94 00000000 
16066574 00000000 00000282 c027aa8c
Apr 2 18:45:00 sonne kernel: 00000000 c027aa74 c012ed53 000001d2 
00000000 0c051b94 0002a100 c027aa74
Apr 2 18:45:00 sonne kernel: c027abfc 000001d2 c012f3b1 c012eb56 
00000000 c012f3ca 00000000 00000001
Apr 2 18:45:00 sonne kernel: Call Trace: [__alloc_pages+51/368] 
[read_swap_cache_async+65/160] [_alloc_pages+22/32] 
[read_swap_cache_async+90/160] [swapin_readahead+64/80]
Apr 2 18:45:00 sonne kernel: [do_swap_page+38/224] 
[handle_mm_fault+98/176] [do_page_fault+355/1172] [do_page_fault+0/1172] 
[dentry_open+225/400] [filp_open+82/96]
Apr 2 18:45:00 sonne kernel: [sys_fcntl64+128/144] [error_code+52/60]
Apr 2 18:45:00 sonne kernel:
Apr 2 18:45:00 sonne kernel: Code: 0f 0b e3 00 06 60 23 c0 8b 53 04 8b 
03 89 50 04 89 02 8b 54
Apr 2 18:51:37 sonne kernel: kernel BUG at page_alloc.c:227!
Apr 2 18:51:37 sonne kernel: invalid operand: 0000
Apr 2 18:51:37 sonne kernel: CPU: 0
Apr 2 18:51:37 sonne kernel: EIP: 0010:[rmqueue+112/544] Not tainted
Apr 2 18:51:37 sonne kernel: EFLAGS: 00010086
Apr 2 18:51:37 sonne kernel: eax: 0000fff0 ebx: c12416f8 ecx: 00001000 
edx: e8bb0085
Apr 2 18:51:37 sonne kernel: esi: c12416f8 edi: 00000000 ebp: c027aa74 
esp: c263be50
Apr 2 18:51:37 sonne kernel: ds: 0018 es: 0018 ss: 0018
Apr 2 18:51:37 sonne kernel: Process setiathome (pid: 1664, 
stackpage=c263b000)
Apr 2 18:51:37 sonne kernel: Stack: c027ac00 000001ff cbf5bd40 00000000 
c01bfc36 0000a4dc 00000286 c027aa8c
Apr 2 18:51:37 sonne kernel: 00000000 c027aa74 c012ed53 000001d2 
cbf5bd40 cbf5bd40 c829a340 c027aa74
Apr 2 18:51:37 sonne kernel: c027abfc 000001d2 c02251e6 c012eb56 
00104025 c0125d14 4029f000 cbf5bd40
Apr 2 18:51:37 sonne kernel: Call Trace: [do_rw_disk+742/1344] 
[__alloc_pages+51/368] [mmx_clear_page+38/48] [_alloc_pages+22/32] 
[do_anonymous_page+52/224]
Apr 2 18:51:37 sonne kernel: [do_no_page+47/368] 
[handle_mm_fault+82/176] [do_page_fault+355/1172] [do_page_fault+0/1172] 
[send_sig+27/32] [it_real_fn+64/80]
Apr 2 18:51:37 sonne kernel: [timer_bh+546/608] [tqueue_bh+22/32] 
[bh_action+26/80] [schedule+710/752] [error_code+52/60]
Apr 2 18:51:37 sonne kernel:
Apr 2 18:51:37 sonne kernel: Code: 0f 0b e3 00 06 60 23 c0 8b 53 04 8b 
03 89 50 04 89 02 8b 54
Apr 2 18:52:04 sonne kernel: kernel BUG at page_alloc.c:227!
Apr 2 18:52:04 sonne kernel: invalid operand: 0000
Apr 2 18:52:04 sonne kernel: CPU: 0
Apr 2 18:52:04 sonne kernel: EIP: 0010:[rmqueue+112/544] Not tainted
Apr 2 18:52:04 sonne kernel: EFLAGS: 00013086
Apr 2 18:52:04 sonne kernel: eax: 0000fff0 ebx: c12416f8 ecx: 00001000 
edx: e8bb0085
Apr 2 18:52:04 sonne kernel: esi: c12416f8 edi: 00000000 ebp: c027aa74 
esp: ce8a5e50
Apr 2 18:52:04 sonne kernel: ds: 0018 es: 0018 ss: 0018
Apr 2 18:52:04 sonne kernel: Process X (pid: 880, stackpage=ce8a5000)
Apr 2 18:52:04 sonne kernel: Stack: c027ac00 000001ff cfee2a40 00000000 
c8f25280 00001f8b 00003286 c027aa8c
Apr 2 18:52:04 sonne kernel: 00000000 c027aa74 c012ed53 000001d2 
cfee2a40 cfee2a40 c8920cc0 c027aa74
Apr 2 18:52:04 sonne kernel: c027abfc 000001d2 c02251e6 c012eb56 
00104025 c0125d14 45ad4000 cfee2a40
Apr 2 18:52:04 sonne kernel: Call Trace: [__alloc_pages+51/368] 
[mmx_clear_page+38/48] [_alloc_pages+22/32] [do_anonymous_page+52/224] 
[do_no_page+47/368]
Apr 2 18:52:04 sonne kernel: [handle_mm_fault+82/176] 
[do_page_fault+355/1172] [do_page_fault+0/1172] [kill_fasync+22/26] 
[update_wall_time+11/64] [timer_bh+36/608]
Apr 2 18:52:04 sonne kernel: [do_timer+63/112] [timer_interrupt+118/256] 
[bh_action+26/80] [tasklet_hi_action+70/112] [do_softirq+90/176] 
[do_IRQ+157/176]
Apr 2 18:52:04 sonne kernel: [error_code+52/60]
Apr 2 18:52:04 sonne kernel:
Apr 2 18:52:04 sonne kernel: Code: 0f 0b e3 00 06 60 23 c0 8b 53 04 8b 
03 89 50 04 89 02 8b 54
Apr 2 18:52:05 sonne kdm[851]: Server for display :0 terminated unexpectedly
Apr 2 18:52:05 sonne PAM-unix2[915]: session finished for user robert, 
service xdm
Apr 2 18:52:07 sonne kernel: kernel BUG at page_alloc.c:227!
Apr 2 18:52:07 sonne kernel: invalid operand: 0000
Apr 2 18:52:07 sonne kernel: CPU: 0
Apr 2 18:52:07 sonne kernel: EIP: 0010:[rmqueue+112/544] Not tainted
Apr 2 18:52:07 sonne kernel: EFLAGS: 00013086
Apr 2 18:52:07 sonne kernel: eax: 0000fff0 ebx: c12416f8 ecx: 00001000 
edx: e8bb0085
Apr 2 18:52:07 sonne kernel: esi: c12416f8 edi: 00000000 ebp: c027aa74 
esp: cd36be1c
Apr 2 18:52:07 sonne kernel: ds: 0018 es: 0018 ss: 0018
Apr 2 18:52:07 sonne kernel: Process xkbcomp (pid: 1674, stackpage=cd36b000)
Apr 2 18:52:07 sonne kernel: Stack: c027ac00 000001ff 0000000e 00000000 
00001000 cdcb08c0 00003292 c027aa8c
Apr 2 18:52:07 sonne kernel: 00000000 c027aa74 c012ed53 000001d2 
ca4463f0 0000000e cff54bc4 c027aa74
Apr 2 18:52:07 sonne kernel: c027abfc 000001d2 c0156600 c012eb56 
0000000e c0127f8a 0000000e 00000001
Apr 2 18:52:07 sonne kernel: Call Trace: [__alloc_pages+51/368] 
[ext2_get_block+0/752] [_alloc_pages+22/32] [page_cache_read+106/192] 
[read_cluster_nonblocking+41/64]

--- kysmoops ----

ksymoops 2.4.2 on i686 2.4.19-pre5. Options used
-V (default)
-k /proc/ksyms (default)
-l /proc/modules (default)
-o /lib/modules/2.4.19-pre5/ (default)
-m /boot/System.map-2.4.19-pre5 (default)

Warning: You did not tell me where to find symbol information. I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc. ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol GPLONLY_vmalloc_to_page not 
found in System.map. Ignoring ksyms_base entry
Apr 2 18:35:45 sonne kernel: Unable to handle kernel paging request at 
virtual address 01000054
Apr 2 18:35:45 sonne kernel: c01282d7
Apr 2 18:35:45 sonne kernel: *pde = 00000000
Apr 2 18:35:45 sonne kernel: Oops: 0000
Apr 2 18:35:45 sonne kernel: CPU: 0
Apr 2 18:35:45 sonne kernel: EIP: 0010:[__find_lock_page_helper+23/96] 
Not tainted
Apr 2 18:35:45 sonne kernel: EFLAGS: 00210202
Apr 2 18:35:45 sonne kernel: eax: cc7f5330 ebx: 0100004c ecx: c114004c 
edx: 00060528
Apr 2 18:35:45 sonne kernel: esi: 00060528 edi: cc7f5330 ebp: c114004c 
esp: c82a3f38
Apr 2 18:35:45 sonne kernel: ds: 0018 es: 0018 ss: 0018
Apr 2 18:35:45 sonne kernel: Process kmix (pid: 1550, stackpage=c82a3000)
Apr 2 18:35:45 sonne kernel: Stack: 0000002c c82a3f94 00060528 cff41ca0 
c0128333 c012a781 cc7f5330 00060528
Apr 2 18:35:45 sonne kernel: cff41ca0 00000000 cdc295c0 ffffffea 
0000002e cc7f52e8 00001000 00000000
Apr 2 18:35:45 sonne kernel: 0000002c fffffff4 00000002 60528000 
00000000 cc7f5280 cc7f5330 00000000
Apr 2 18:35:45 sonne kernel: Call Trace: [__find_lock_page+19/32] 
[generic_file_write+993/1792] [sys_write+150/240] [system_call+51/56]
Apr 2 18:35:45 sonne kernel: Code: 39 7b 08 75 f4 39 73 0c 75 ef 85 db 
74 32 ff 43 14 31 c0 0f
Using defaults from ksymoops -t elf32-i386 -a i386

Code; 00000000 Before first symbol
00000000 <_EIP>:
Code; 00000000 Before first symbol
0: 39 7b 08 cmp %edi,0x8(%ebx)
Code; 00000002 Before first symbol
3: 75 f4 jne fffffff9 <_EIP+0xfffffff9> fffffff8 <END_OF_CODE+2b68b07a/????>
Code; 00000004 Before first symbol
5: 39 73 0c cmp %esi,0xc(%ebx)
Code; 00000008 Before first symbol
8: 75 ef jne fffffff9 <_EIP+0xfffffff9> fffffff8 <END_OF_CODE+2b68b07a/????>
Code; 0000000a Before first symbol
a: 85 db test %ebx,%ebx
Code; 0000000c Before first symbol
c: 74 32 je 40 <_EIP+0x40> 00000040 Before first symbol
Code; 0000000e Before first symbol
e: ff 43 14 incl 0x14(%ebx)
Code; 00000010 Before first symbol
11: 31 c0 xor %eax,%eax
Code; 00000012 Before first symbol
13: 0f 00 00 sldt (%eax)

Apr 2 18:38:04 sonne kernel: kernel BUG at page_alloc.c:227!
Apr 2 18:38:04 sonne kernel: invalid operand: 0000
Apr 2 18:38:04 sonne kernel: CPU: 0
Apr 2 18:38:04 sonne kernel: EIP: 0010:[rmqueue+112/544] Not tainted
Apr 2 18:38:04 sonne kernel: EFLAGS: 00010086
Apr 2 18:38:04 sonne kernel: eax: 0000fff0 ebx: c12416f8 ecx: 00001000 
edx: e8bb0085
Apr 2 18:38:04 sonne kernel: esi: c12416f8 edi: 00000000 ebp: c027aa74 
esp: c3e23e50
Apr 2 18:38:04 sonne kernel: ds: 0018 es: 0018 ss: 0018
Apr 2 18:38:04 sonne kernel: Process setiathome (pid: 1638, 
stackpage=c3e23000)
Apr 2 18:38:04 sonne kernel: Stack: c027ac00 000001ff cbf5bc80 00000000 
00000001 0000bcdf 00000286 c027aa8c
Apr 2 18:38:04 sonne kernel: 00000000 c027aa74 c012ed53 000001d2 
cbf5bc80 cbf5bc80 c820b1c0 c027aa74
Apr 2 18:38:04 sonne kernel: c027abfc 000001d2 c02251e6 c012eb56 
00104025 c0125d14 41010000 cbf5bc80
Apr 2 18:38:04 sonne kernel: Call Trace: [__alloc_pages+51/368] 
[mmx_clear_page+38/48] [_alloc_pages+22/32] [do_anonymous_page+52/224] 
[do_no_page+47/368]
Apr 2 18:38:04 sonne kernel: Code: 0f 0b e3 00 06 60 23 c0 8b 53 04 8b 
03 89 50 04 89 02 8b 54

Code; 00000000 Before first symbol
00000000 <_EIP>:
Code; 00000000 Before first symbol
0: 0f 0b ud2a
Code; 00000002 Before first symbol
2: e3 00 jecxz 4 <_EIP+0x4> 00000004 Before first symbol
Code; 00000004 Before first symbol
4: 06 push %es
Code; 00000004 Before first symbol
5: 60 pusha
Code; 00000006 Before first symbol
6: 23 c0 and %eax,%eax
Code; 00000008 Before first symbol
8: 8b 53 04 mov 0x4(%ebx),%edx
Code; 0000000a Before first symbol
b: 8b 03 mov (%ebx),%eax
Code; 0000000c Before first symbol
d: 89 50 04 mov %edx,0x4(%eax)
Code; 00000010 Before first symbol
10: 89 02 mov %eax,(%edx)
Code; 00000012 Before first symbol
12: 8b 54 00 00 mov 0x0(%eax,%eax,1),%edx

Apr 2 18:45:00 sonne kernel: kernel BUG at page_alloc.c:227!
Apr 2 18:45:00 sonne kernel: invalid operand: 0000
Apr 2 18:45:00 sonne kernel: CPU: 0
Apr 2 18:45:00 sonne kernel: EIP: 0010:[rmqueue+112/544] Not tainted
Apr 2 18:45:00 sonne kernel: EFLAGS: 00010086
Apr 2 18:45:00 sonne kernel: eax: 0000fff0 ebx: c12416f8 ecx: 00001000 
edx: e8bb0085
Apr 2 18:45:00 sonne kernel: esi: c12416f8 edi: 00000000 ebp: c027aa74 
esp: c3cb1e78
Apr 2 18:45:00 sonne kernel: ds: 0018 es: 0018 ss: 0018
Apr 2 18:45:00 sonne kernel: Process cron (pid: 1662, stackpage=c3cb1000)
Apr 2 18:45:00 sonne kernel: Stack: c027ac00 000001ff 0ed74065 00000000 
7271706f 00002e4e 00000296 c027aa8c
Apr 2 18:45:00 sonne kernel: 00000000 c027aa74 c012ed53 000001d2 
00000000 0ed74065 c8323520 c027aa74
Apr 2 18:45:00 sonne kernel: c027abfc 000001d2 c128d00c c012eb56 
c128d00c c01258af 40148fe8 cbf5bc80
Apr 2 18:45:00 sonne kernel: Call Trace: [__alloc_pages+51/368] 
[_alloc_pages+22/32] [do_wp_page+143/512] [handle_mm_fault+122/176] 
[do_page_fault+355/1172]
Apr 2 18:45:00 sonne kernel: Code: 0f 0b e3 00 06 60 23 c0 8b 53 04 8b 
03 89 50 04 89 02 8b 54

Code; 00000000 Before first symbol
00000000 <_EIP>:
Code; 00000000 Before first symbol
0: 0f 0b ud2a
Code; 00000002 Before first symbol
2: e3 00 jecxz 4 <_EIP+0x4> 00000004 Before first symbol
Code; 00000004 Before first symbol
4: 06 push %es
Code; 00000004 Before first symbol
5: 60 pusha
Code; 00000006 Before first symbol
6: 23 c0 and %eax,%eax
Code; 00000008 Before first symbol
8: 8b 53 04 mov 0x4(%ebx),%edx
Code; 0000000a Before first symbol
b: 8b 03 mov (%ebx),%eax
Code; 0000000c Before first symbol
d: 89 50 04 mov %edx,0x4(%eax)
Code; 00000010 Before first symbol
10: 89 02 mov %eax,(%edx)
Code; 00000012 Before first symbol
12: 8b 54 00 00 mov 0x0(%eax,%eax,1),%edx

Apr 2 18:45:00 sonne kernel: kernel BUG at page_alloc.c:227!
Apr 2 18:45:00 sonne kernel: invalid operand: 0000
Apr 2 18:45:00 sonne kernel: CPU: 0
Apr 2 18:45:00 sonne kernel: EIP: 0010:[rmqueue+112/544] Not tainted
Apr 2 18:45:00 sonne kernel: EFLAGS: 00010086
Apr 2 18:45:00 sonne kernel: eax: 0000fff0 ebx: c12416f8 ecx: 00001000 
edx: e8bb0085
Apr 2 18:45:00 sonne kernel: esi: c12416f8 edi: 00000000 ebp: c027aa74 
esp: c3e4de44
Apr 2 18:45:00 sonne kernel: ds: 0018 es: 0018 ss: 0018
Apr 2 18:45:00 sonne kernel: Process cron (pid: 1663, stackpage=c3e4d000)
Apr 2 18:45:00 sonne kernel: Stack: c027ac00 000001ff 0c051b94 00000000 
16066574 00000000 00000282 c027aa8c
Apr 2 18:45:00 sonne kernel: 00000000 c027aa74 c012ed53 000001d2 
00000000 0c051b94 0002a100 c027aa74
Apr 2 18:45:00 sonne kernel: c027abfc 000001d2 c012f3b1 c012eb56 
00000000 c012f3ca 00000000 00000001
Apr 2 18:45:00 sonne kernel: Call Trace: [__alloc_pages+51/368] 
[read_swap_cache_async+65/160] [_alloc_pages+22/32] 
[read_swap_cache_async+90/160] [swapin_readahead+64/80]
Apr 2 18:45:00 sonne kernel: Code: 0f 0b e3 00 06 60 23 c0 8b 53 04 8b 
03 89 50 04 89 02 8b 54

Code; 00000000 Before first symbol
00000000 <_EIP>:
Code; 00000000 Before first symbol
0: 0f 0b ud2a
Code; 00000002 Before first symbol
2: e3 00 jecxz 4 <_EIP+0x4> 00000004 Before first symbol
Code; 00000004 Before first symbol
4: 06 push %es
Code; 00000004 Before first symbol
5: 60 pusha
Code; 00000006 Before first symbol
6: 23 c0 and %eax,%eax
Code; 00000008 Before first symbol
8: 8b 53 04 mov 0x4(%ebx),%edx
Code; 0000000a Before first symbol
b: 8b 03 mov (%ebx),%eax
Code; 0000000c Before first symbol
d: 89 50 04 mov %edx,0x4(%eax)
Code; 00000010 Before first symbol
10: 89 02 mov %eax,(%edx)
Code; 00000012 Before first symbol
12: 8b 54 00 00 mov 0x0(%eax,%eax,1),%edx

Apr 2 18:51:37 sonne kernel: kernel BUG at page_alloc.c:227!
Apr 2 18:51:37 sonne kernel: invalid operand: 0000
Apr 2 18:51:37 sonne kernel: CPU: 0
Apr 2 18:51:37 sonne kernel: EIP: 0010:[rmqueue+112/544] Not tainted
Apr 2 18:51:37 sonne kernel: EFLAGS: 00010086
Apr 2 18:51:37 sonne kernel: eax: 0000fff0 ebx: c12416f8 ecx: 00001000 
edx: e8bb0085
Apr 2 18:51:37 sonne kernel: esi: c12416f8 edi: 00000000 ebp: c027aa74 
esp: c263be50
Apr 2 18:51:37 sonne kernel: ds: 0018 es: 0018 ss: 0018
Apr 2 18:51:37 sonne kernel: Process setiathome (pid: 1664, 
stackpage=c263b000)
Apr 2 18:51:37 sonne kernel: Stack: c027ac00 000001ff cbf5bd40 00000000 
c01bfc36 0000a4dc 00000286 c027aa8c
Apr 2 18:51:37 sonne kernel: 00000000 c027aa74 c012ed53 000001d2 
cbf5bd40 cbf5bd40 c829a340 c027aa74
Apr 2 18:51:37 sonne kernel: c027abfc 000001d2 c02251e6 c012eb56 
00104025 c0125d14 4029f000 cbf5bd40
Apr 2 18:51:37 sonne kernel: Call Trace: [do_rw_disk+742/1344] 
[__alloc_pages+51/368] [mmx_clear_page+38/48] [_alloc_pages+22/32] 
[do_anonymous_page+52/224]
Apr 2 18:51:37 sonne kernel: Code: 0f 0b e3 00 06 60 23 c0 8b 53 04 8b 
03 89 50 04 89 02 8b 54

Code; 00000000 Before first symbol
00000000 <_EIP>:
Code; 00000000 Before first symbol
0: 0f 0b ud2a
Code; 00000002 Before first symbol
2: e3 00 jecxz 4 <_EIP+0x4> 00000004 Before first symbol
Code; 00000004 Before first symbol
4: 06 push %es
Code; 00000004 Before first symbol
5: 60 pusha
Code; 00000006 Before first symbol
6: 23 c0 and %eax,%eax
Code; 00000008 Before first symbol
8: 8b 53 04 mov 0x4(%ebx),%edx
Code; 0000000a Before first symbol
b: 8b 03 mov (%ebx),%eax
Code; 0000000c Before first symbol
d: 89 50 04 mov %edx,0x4(%eax)
Code; 00000010 Before first symbol
10: 89 02 mov %eax,(%edx)
Code; 00000012 Before first symbol
12: 8b 54 00 00 mov 0x0(%eax,%eax,1),%edx

Apr 2 18:52:04 sonne kernel: kernel BUG at page_alloc.c:227!
Apr 2 18:52:04 sonne kernel: invalid operand: 0000
Apr 2 18:52:04 sonne kernel: CPU: 0
Apr 2 18:52:04 sonne kernel: EIP: 0010:[rmqueue+112/544] Not tainted
Apr 2 18:52:04 sonne kernel: EFLAGS: 00013086
Apr 2 18:52:04 sonne kernel: eax: 0000fff0 ebx: c12416f8 ecx: 00001000 
edx: e8bb0085
Apr 2 18:52:04 sonne kernel: esi: c12416f8 edi: 00000000 ebp: c027aa74 
esp: ce8a5e50
Apr 2 18:52:04 sonne kernel: ds: 0018 es: 0018 ss: 0018
Apr 2 18:52:04 sonne kernel: Process X (pid: 880, stackpage=ce8a5000)
Apr 2 18:52:04 sonne kernel: Stack: c027ac00 000001ff cfee2a40 00000000 
c8f25280 00001f8b 00003286 c027aa8c
Apr 2 18:52:04 sonne kernel: 00000000 c027aa74 c012ed53 000001d2 
cfee2a40 cfee2a40 c8920cc0 c027aa74
Apr 2 18:52:04 sonne kernel: c027abfc 000001d2 c02251e6 c012eb56 
00104025 c0125d14 45ad4000 cfee2a40
Apr 2 18:52:04 sonne kernel: Call Trace: [__alloc_pages+51/368] 
[mmx_clear_page+38/48] [_alloc_pages+22/32] [do_anonymous_page+52/224] 
[do_no_page+47/368]
Apr 2 18:52:04 sonne kernel: Code: 0f 0b e3 00 06 60 23 c0 8b 53 04 8b 
03 89 50 04 89 02 8b 54

Code; 00000000 Before first symbol
00000000 <_EIP>:
Code; 00000000 Before first symbol
0: 0f 0b ud2a
Code; 00000002 Before first symbol
2: e3 00 jecxz 4 <_EIP+0x4> 00000004 Before first symbol
Code; 00000004 Before first symbol
4: 06 push %es
Code; 00000004 Before first symbol
5: 60 pusha
Code; 00000006 Before first symbol
6: 23 c0 and %eax,%eax
Code; 00000008 Before first symbol
8: 8b 53 04 mov 0x4(%ebx),%edx
Code; 0000000a Before first symbol
b: 8b 03 mov (%ebx),%eax
Code; 0000000c Before first symbol
d: 89 50 04 mov %edx,0x4(%eax)
Code; 00000010 Before first symbol
10: 89 02 mov %eax,(%edx)
Code; 00000012 Before first symbol
12: 8b 54 00 00 mov 0x0(%eax,%eax,1),%edx

Apr 2 18:52:07 sonne kernel: kernel BUG at page_alloc.c:227!
Apr 2 18:52:07 sonne kernel: invalid operand: 0000
Apr 2 18:52:07 sonne kernel: CPU: 0
Apr 2 18:52:07 sonne kernel: EIP: 0010:[rmqueue+112/544] Not tainted
Apr 2 18:52:07 sonne kernel: EFLAGS: 00013086
Apr 2 18:52:07 sonne kernel: eax: 0000fff0 ebx: c12416f8 ecx: 00001000 
edx: e8bb0085
Apr 2 18:52:07 sonne kernel: esi: c12416f8 edi: 00000000 ebp: c027aa74 
esp: cd36be1c
Apr 2 18:52:07 sonne kernel: ds: 0018 es: 0018 ss: 0018
Apr 2 18:52:07 sonne kernel: Process xkbcomp (pid: 1674, stackpage=cd36b000)
Apr 2 18:52:07 sonne kernel: Stack: c027ac00 000001ff 0000000e 00000000 
00001000 cdcb08c0 00003292 c027aa8c
Apr 2 18:52:07 sonne kernel: 00000000 c027aa74 c012ed53 000001d2 
ca4463f0 0000000e cff54bc4 c027aa74
Apr 2 18:52:07 sonne kernel: c027abfc 000001d2 c0156600 c012eb56 
0000000e c0127f8a 0000000e 00000001
Apr 2 18:52:07 sonne kernel: Call Trace: [__alloc_pages+51/368] 
[ext2_get_block+0/752] [_alloc_pages+22/32] [page_cache_read+106/192] 
[read_cluster_nonblocking+41/64]

2 warnings issued. Results may not be reliable.


