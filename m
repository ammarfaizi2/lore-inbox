Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286241AbRLJMWn>; Mon, 10 Dec 2001 07:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286244AbRLJMWb>; Mon, 10 Dec 2001 07:22:31 -0500
Received: from eos.dobrich.net ([217.79.68.4]:14342 "EHLO eos.dobrich.net")
	by vger.kernel.org with ESMTP id <S286241AbRLJMW1>;
	Mon, 10 Dec 2001 07:22:27 -0500
Date: Mon, 10 Dec 2001 14:21:59 +0200 (EET)
From: Admin <root@eos.dobrich.net>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: kernel: Unable to handle kernel paging request
Message-ID: <Pine.LNX.4.10.10112101411530.2642-100000@eos.dobrich.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Full description of the report:
Dec 10 02:02:30 shtajga kernel: Unable to handle kernel paging request at
virtual address 0000c7df
Dec 10 02:02:30 shtajga kernel: current->tss.cr3 = 09b2c000, %%cr3 =
09b2c000
Dec 10 02:02:30 shtajga kernel: *pde = 00000000
Dec 10 02:02:30 shtajga kernel: Oops: 0000
Dec 10 02:02:30 shtajga kernel: CPU:    0
Dec 10 02:02:30 shtajga kernel: EIP:    0010:[redo_fd_request+366/964]
Dec 10 02:02:30 shtajga kernel: EFLAGS: 00010002
Dec 10 02:02:30 shtajga kernel: eax: 00000000   ebx: 0000c79b   ecx:
c0219556   edx: 00000001
Dec 10 02:02:30 shtajga kernel: esi: 00000000   edi: 00000000   ebp:
000001a8   esp: c9d1dedc
Dec 10 02:02:30 shtajga kernel: ds: 0018   es: 0018   ss: 0018
Dec 10 02:02:30 shtajga kernel: Process ipchains (pid: 10735, process nr:
67, stackpage=c9d1d000)
Dec 10 02:02:30 shtajga kernel: Stack: 00000238 c9d1c000 00000001 c0248a40
00000000 00000000 cffbf680 c011b9aa 
Dec 10 02:02:30 shtajga kernel:        c9d1c000 c01a8303 ca034238 c7230500
0000c79b 00000246 c6f6ff00 00000400 
Dec 10 02:02:30 shtajga kernel:        ca034000 00000400 00000000 000003e9
00000238 00000246 c6f6ff00 ffffffea 
Dec 10 02:02:30 shtajga kernel: Call Trace: [do_no_page+54/212]
[redo_fd_request+695/964] [mem_read+25/328] [get_task+11/88]
[sys_read+178/208] [error_code+53/64] [system
_call+52/56] 
Dec 10 02:02:30 shtajga kernel: Code: 8b 4c 18 44 01 4c 24 18 8b 4c 18 48
11 4c 24 1c 03 74 18 4c 

Kernel version:
Linux version 2.2.19 (root@shtajga) (gcc version 2.95.4 20010319 (Debian
prerelease)) #3 Fri Oct 26 16:50:45 EEST 2001

Software:
Linux shtajga 2.2.19 #3 Fri Oct 26 16:50:45 EEST 2001 i686 unknown
Gnu C                  2.95.4
Gnu make               3.78.1
binutils               2.11.90.0.7
util-linux             2.10f
modutils               2.3.11
e2fsprogs              1.18
reiserfsprogs          3.x.0j
PPP                    2.3.11
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.6
Net-tools              1.54
Kbd                    0.96
Sh-utils               2.0
Modules Loaded         

Processor information:
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 548.545
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 3
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat pse36 psn mmx fxsr xmm
bogomips        : 1094.45

Modules: None

SCSI: None

Memory information:
        total:    used:    free:  shared: buffers:  cached:
Mem:  263589888 256901120  6688768 104308736 79421440 64991232
Swap: 268877824        0 268877824
MemTotal:    257412 kB
MemFree:       6532 kB
MemShared:   101864 kB
Buffers:      77560 kB
Cached:       63468 kB
SwapTotal:   262576 kB
SwapFree:    262576 kB

