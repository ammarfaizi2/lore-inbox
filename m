Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289167AbSBMXkl>; Wed, 13 Feb 2002 18:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289166AbSBMXkc>; Wed, 13 Feb 2002 18:40:32 -0500
Received: from web13509.mail.yahoo.com ([216.136.173.13]:12437 "HELO
	web13509.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S289167AbSBMXkZ>; Wed, 13 Feb 2002 18:40:25 -0500
Message-ID: <20020213234024.58688.qmail@web13509.mail.yahoo.com>
Date: Wed, 13 Feb 2002 15:40:24 -0800 (PST)
From: Shamu <shamu112@yahoo.com>
Subject: kswapd ?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux shamu 2.4.17 #1 Fri Dec 21 18:57:30 CST 2001
i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11f
mount                  2.11g
modutils               2.4.10
e2fsprogs              1.23
PPP                    2.4.1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         ipt_MASQUERADE ipt_TOS
ipt_REJECT ipt_LOG ipt_limit ipt_state w83781d bt869
i2c-proc i2c-voodoo3 i2c-algo-bit i2c-viapro i2c-core
serial 8139too iptable_mangle iptable_filter
ip_conntrack_ftp iptable_nat ip_conntrack ip_tables
nls_iso8859-1 nls_cp437 vfat fat es1370 soundcore
usb-uhci usbcore

Feb 13 10:04:56 shamu kernel: Unable to handle kernel
NULL pointer dereference at virtual address 00000004
Feb 13 10:04:56 shamu kernel:  printing eip:
Feb 13 10:04:56 shamu kernel: c01315d4
Feb 13 10:04:56 shamu kernel: *pde = 00000000
Feb 13 10:04:56 shamu kernel: Oops: 0002
Feb 13 10:04:56 shamu kernel: CPU:    0
Feb 13 10:04:56 shamu kernel: EIP:   
0010:[__remove_from_queues+20/48]    Not tainted
Feb 13 10:04:56 shamu kernel: EIP:   
0010:[<c01315d4>]    Not tainted
Feb 13 10:04:56 shamu kernel: EFLAGS: 00010246
Feb 13 10:04:56 shamu kernel: eax: 00000000   ebx:
c39e2ec0   ecx: c39e2ec0   edx: 00000004
Feb 13 10:04:56 shamu kernel: esi: c39e2ec0   edi:
c39e2ec0   ebp: c11ce000   esp: c7fb1f00
Feb 13 10:04:56 shamu kernel: ds: 0018   es: 0018  
ss: 0018
Feb 13 10:04:56 shamu kernel: Process kswapd (pid: 5,
stackpage=c7fb1000)
Feb 13 10:04:56 shamu kernel: Stack: c0133be2 c39e2ec0
c7fb0000 00000217 c1040000 c0203380 00000000 c11ce000 
Feb 13 10:04:56 shamu kernel:        0000001d 0000025c
c01297c4 c11ce000 000001d0 c0141d86 c7fb0000 0000003c 
Feb 13 10:04:56 shamu kernel:        000001d0 c0203368
c0145648 c7feb0c0 c7feb2f0 00000000 00000020 000001d0 
Feb 13 10:04:56 shamu kernel: Call Trace:
[try_to_free_buffers+114/256] [shrink_cache+500/752]
[prune_icache+198/208] [shrink
_dqcache_memory+40/48] [shrink_caches+80/144] 
Feb 13 10:04:56 shamu kernel: Call Trace: [<c0133be2>]
[<c01297c4>] [<c0141d86>] [<c0145648>] [<c01299f0>] 
Feb 13 10:04:56 shamu kernel:   
[try_to_free_pages+60/96]
[kswapd_balance_pgdat+81/160] [kswapd_balance+38/80]
[kswapd+161/2
08] [kswapd+0/208] [stext+0/48] 
Feb 13 10:04:56 shamu kernel:    [<c0129a6c>]
[<c0129b21>] [<c0129b96>] [<c0129cf1>] [<c0129c50>]
[<c0105000>] 
Feb 13 10:04:56 shamu kernel:    [kernel_thread+38/48]
[kswapd+0/208] 
Feb 13 10:04:56 shamu kernel:    [<c0105746>]
[<c0129c50>] 
Feb 13 10:04:56 shamu kernel: 
Feb 13 10:04:56 shamu kernel: Code: 89 02 c7 41 30 00
00 00 00 89 4c 24 04 e9 7a ff ff ff 8d 76 

__________________________________________________
Do You Yahoo!?
Send FREE Valentine eCards with Yahoo! Greetings!
http://greetings.yahoo.com
