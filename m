Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130533AbRCIPe4>; Fri, 9 Mar 2001 10:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130534AbRCIPeq>; Fri, 9 Mar 2001 10:34:46 -0500
Received: from sgpd.it.as.ex.state.ut.us ([168.179.242.14]:17419 "EHLO
	sgpd.state.ut.us") by vger.kernel.org with ESMTP id <S130533AbRCIPeb>;
	Fri, 9 Mar 2001 10:34:31 -0500
Message-ID: <3AA8F9F6.718EC29F@infowest.com>
Date: Fri, 09 Mar 2001 08:42:46 -0700
From: Sherman Stebbins <policesa@infowest.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was told that you might be able to tell me what is going wrong.

I am running RH 7 with  Apache/1.3.12  and  Samba Version 2.0.7

Thanks Sherm

The system crashes while the CPU is doing hardly anything and crashes
often.
Here are the logs.

Mar  8 21:01:01 hcpds kernel: Unable to handle kernel paging request at
virtual address d3dcafbf
Mar  8 21:01:01 hcpds kernel: current->tss.cr3 = 00480000, %cr3 =
00480000
Mar  8 21:01:01 hcpds kernel: *pde = 00000000
Mar  8 21:01:01 hcpds kernel: Oops: 0000
Mar  8 21:01:01 hcpds kernel: CPU:    0
Mar  8 21:01:01 hcpds kernel: EIP:    0010:[<d3dcafbf>]
Mar  8 21:01:01 hcpds kernel: EFLAGS: 00010292
Mar  8 21:01:01 hcpds kernel: eax: c2ef63e0   ebx: c2ef63e0   ecx:
c2ef63e0   edx: c2fd9650
Mar  8 21:01:01 hcpds kernel: esi: 00000000   edi: c2b0fdc0   ebp:
c2ef62e0   esp: c0069b1c
Mar  8 21:01:01 hcpds kernel: ds: 0018   es: 0018   ss: 0018
Mar  8 21:01:01 hcpds kernel: Process bash (pid: 2991, process nr: 43,
stackpage=c0069000)
Mar  8 21:01:01 hcpds kernel: Stack: c2ef62e0 00000001 c2b0fdc0 c0068000
c29cba00 c2ef62e0 00000001 c2d9e5d8
Mar  8 21:01:01 hcpds kernel:        c012ca58 c29cba00 c2ef62e0 00000001
c29cba00 c29cba00 c2697f92 c012cbef
Mar  8 21:01:01 hcpds kernel:        c2ef62e0 c29cba00 00000001 00000013
c2697f82 00000001 c23fc040 c2697f85
Mar  8 21:01:01 hcpds kernel: Call Trace: [do_follow_link+76/132]
[lookup_dentry+351/488] [open_namei+102/848] [cprt+1421/20000]
[load_elf_binary+793/3480] [load_elf_binary+945/3480]
[do_no_page+81/196]
Mar  8 21:01:01 hcpds kernel:        [do_no_page+183/196]
[handle_mm_fault+197/324] [do_generic_file_read+1496/1508]
[cprt+1396/20000] [read_exec+194/316] [read_exec+303/316]
[search_binary_handler+71/288] [do_load_script+486/508]
Mar  8 21:01:01 hcpds kernel:        [sys_mremap+352/884]
[copy_strings+380/448] [load_script+15/20]
[search_binary_handler+71/288] [do_execve+383/480] [do_execve+417/480]
[sys_execve+47/88] [system_call+52/56]
Mar  8 21:01:01 hcpds kernel: Code: <1>Unable to handle kernel paging
request at virtual address d3dcafbf
Mar  8 21:01:01 hcpds kernel: current->tss.cr3 = 00480000, %cr3 =
00480000
Mar  8 21:01:01 hcpds kernel: *pde = 00000000
Mar  8 21:01:01 hcpds kernel: Oops: 0000
Mar  8 21:01:01 hcpds kernel: CPU:    0
Mar  8 21:01:01 hcpds kernel: EIP:    0010:[show_registers+653/704]
Mar  8 21:01:01 hcpds kernel: EFLAGS: 00010046
Mar  8 21:01:01 hcpds kernel: eax: 00000000   ebx: 00000000   ecx:
d3dcafbf   edx: c2a2a000
Mar  8 21:01:01 hcpds kernel: esi: 0000002b   edi: c006a000   ebp:
c3800000   esp: c0069a5c
Mar  8 21:01:01 hcpds kernel: ds: 0018   es: 0018   ss: 0018
Mar  8 21:01:01 hcpds kernel: Process bash (pid: 2991, process nr: 43,
stackpage=c0069000)
Mar  8 21:01:01 hcpds kernel: Stack: d3dcafbf c2ef62e0 c02490ae 00000000
c2b0fdc0 c2ef62e0 c2ef63e0 c2ef63e0
Mar  8 21:01:01 hcpds kernel:        c2ef63e0 c2fd9650 d3dcafbf 00010292
d3dcafc0 c4000000 c010a470 c0069ae0
Mar  8 21:01:01 hcpds kernel:        c01d9227 c01dab4e 00000000 00000000
c010f560 c01dab4e c0069ae0 00000000
Mar  8 21:01:01 hcpds kernel: Call Trace: [<c4000000>] [die+48/56]
[error_table+2631/9344] [error_table+9070/9344] [do_page_fault+708/944]
[error_table+9070/9344] [error_code+45/56]
Mar  8 21:01:01 hcpds kernel:        [ext2_follow_link+93/120]
[do_follow_link+76/132] [lookup_dentry+351/488] [open_namei+102/848]
[cprt+1421/20000] [load_elf_binary+793/3480] [load_elf_binary+945/3480]
[do_no_page+81/196]
Mar  8 21:01:01 hcpds kernel:        [do_no_page+183/196]
[handle_mm_fault+197/324] [do_generic_file_read+1496/1508]
[cprt+1396/20000] [read_exec+194/316] [read_exec+303/316]
[search_binary_handler+71/288] [do_load_script+486/508]
Mar  8 21:01:01 hcpds kernel:        [sys_mremap+352/884]
[copy_strings+380/448] [load_script+15/20]
[search_binary_handler+71/288] [do_execve+383/480] [do_execve+417/480]
[sys_execve+47/88] [system_call+52/56]
Mar  8 21:01:01 hcpds kernel: Code: 8a 04 0b 89 44 24 38 50 68 1f 92 1d
c0 e8 9d 9c 00 00 83 c4
Mar  9 08:21:51 hcpds syslogd 1.3-3: restart.


