Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288980AbSCCUnO>; Sun, 3 Mar 2002 15:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289025AbSCCUnE>; Sun, 3 Mar 2002 15:43:04 -0500
Received: from mailhost.teleline.es ([195.235.113.141]:55320 "EHLO
	tsmtp1.mail.isp") by vger.kernel.org with ESMTP id <S288980AbSCCUmd>;
	Sun, 3 Mar 2002 15:42:33 -0500
Date: Sun, 3 Mar 2002 21:41:35 +0100
From: Diego Calleja <DiegoCG@teleline.es>
To: linux-kernel@vger.kernel.org
Cc: andrea@suse.de
Subject: 2.4.19-pre1-aa1 problems
Message-Id: <20020303214135.7fb8f07c.DiegoCG@teleline.es>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. I have 4 outputs from a 2.4.19-pre1-aa1 kernel. The first, happened while donwloading a file with X && a screensaver
The rest happened while displaying a mpeg video with xine, the three at the same time.

ksymoops 2.4.3 on i686 2.4.19pre1aa1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19pre1/ (default)
     -m /boot/System.map-2.4.19pre1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Mar  3 20:39:17 localhost kernel: Unable to handle kernel paging request at virtual address 04740010
Mar  3 20:39:17 localhost kernel: c01a078a
Mar  3 20:39:17 localhost kernel: *pde = 00000000
Mar  3 20:39:17 localhost kernel: Oops: 0000
Mar  3 20:39:17 localhost kernel: CPU:    0
Mar  3 20:39:17 localhost kernel: EIP:    0010:[sock_poll+30/40]    Tainted: P
Mar  3 20:39:17 localhost kernel: EFLAGS: 00210286
Mar  3 20:39:17 localhost kernel: eax: 0473fff4   ebx: c0bc0e40   ecx: 00000000   edx: c0de0ea0
Mar  3 20:39:17 localhost kernel: esi: c0bc0e40   edi: 00000000   ebp: c0d17f70   esp: c0d17f28
Mar  3 20:39:17 localhost kernel: ds: 0018   es: 0018   ss: 0018
Mar  3 20:39:17 localhost kernel: Process XFree86 (pid: 313, stackpage=c0d17000)
Mar  3 20:39:17 localhost kernel: Stack: c0bc0e40 c0de0ea0 00000000 00000000 c013aec6 c0bc0e40 00000000 00000100
Mar  3 20:39:17 localhost kernel:        00000020 c19e7a40 00000145 00000002 c0d16000 7fffffff 00000001 00000000
Mar  3 20:39:17 localhost kernel:        00000000 c0ba3000 00000000 c013b31c 00000013 c0d17fa8 c0d17fa4 c0d16000
Mar  3 20:39:17 localhost kernel: Call Trace: [do_select+226/476] [sys_select+820/1156] [system_call+51/64]
Mar  3 20:39:17 localhost kernel: Code: 8b 40 1c ff d0 83 c4 0c 5b c3 53 8b 5c 24 08 8b 43 08 8b 54
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 40 1c                  mov    0x1c(%eax),%eax
Code;  00000002 Before first symbol
   3:   ff d0                     call   *%eax
Code;  00000004 Before first symbol
   5:   83 c4 0c                  add    $0xc,%esp
Code;  00000008 Before first symbol
   8:   5b                        pop    %ebx
Code;  00000008 Before first symbol
   9:   c3                        ret    
Code;  0000000a Before first symbol
   a:   53                        push   %ebx
Code;  0000000a Before first symbol
   b:   8b 5c 24 08               mov    0x8(%esp,1),%ebx
Code;  0000000e Before first symbol
   f:   8b 43 08                  mov    0x8(%ebx),%eax
Code;  00000012 Before first symbol
  12:   8b 54 00 00               mov    0x0(%eax,%eax,1),%edx


1 warning issued.  Results may not be reliable.

----------------------------------------------------------

ksymoops 2.4.3 on i686 2.4.19pre1aa1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19pre1/ (default)
     -m /boot/System.map-2.4.19pre1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Mar  3 21:00:29 localhost kernel: Unable to handle kernel paging request at virtual address 74a0047a
Mar  3 21:00:29 localhost kernel: c012e4d5
Mar  3 21:00:29 localhost kernel: *pde = 00000000
Mar  3 21:00:29 localhost kernel: Oops: 0000
Mar  3 21:00:29 localhost kernel: CPU:    0
Mar  3 21:00:29 localhost kernel: EIP:    0010:[sys_write+65/224]    Tainted: P
Mar  3 21:00:29 localhost kernel: EFLAGS: 00210202
Mar  3 21:00:29 localhost kernel: eax: 74a00452   ebx: 00000000   ecx: 00000000   edx: c0bf9280
Mar  3 21:00:29 localhost kernel: esi: c18ec660   edi: fffffff7   ebp: 00000034   esp: c0af1fb0
Mar  3 21:00:29 localhost kernel: ds: 0018   es: 0018   ss: 0018
Mar  3 21:00:29 localhost kernel: Process xine (pid: 619, stackpage=c0af1000)
Mar  3 21:00:29 localhost kernel: Stack: c0af0000 00000034 080dc910 bebff898 c0106b83 00000003 080dc910 00000034
Mar  3 21:00:29 localhost kernel:        00000034 080dc910 bebff898 00000004 0000002b 0000002b 00000004 4028b534
Mar  3 21:00:29 localhost kernel:        00000023 00200287 bebff858 0000002b
Mar  3 21:00:29 localhost kernel: Call Trace: [system_call+51/64]
Mar  3 21:00:29 localhost kernel: Code: f6 40 28 40 74 25 66 8b 42 32 25 08 04 00 00 66 3d 00 04 75
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   f6 40 28 40               testb  $0x40,0x28(%eax)
Code;  00000004 Before first symbol
   4:   74 25                     je     2b <_EIP+0x2b> 0000002a Before first symbol
Code;  00000006 Before first symbol
   6:   66 8b 42 32               mov    0x32(%edx),%ax
Code;  0000000a Before first symbol
   a:   25 08 04 00 00            and    $0x408,%eax
Code;  0000000e Before first symbol
   f:   66 3d 00 04               cmp    $0x400,%ax
Code;  00000012 Before first symbol
  13:   75 00                     jne    15 <_EIP+0x15> 00000014 Before first symbol

----------------------------------------------------------

1 warning issued.  Results may not be reliable.
ksymoops 2.4.3 on i686 2.4.19pre1aa1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19pre1/ (default)
     -m /boot/System.map-2.4.19pre1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Mar  3 21:00:29 localhost kernel:  <1>Unable to handle kernel paging request at virtual address 1b0b315c
Mar  3 21:00:29 localhost kernel: c01a078a
Mar  3 21:00:29 localhost kernel: *pde = 00000000
Mar  3 21:00:29 localhost kernel: Oops: 0000
Mar  3 21:00:29 localhost kernel: CPU:    0
Mar  3 21:00:29 localhost kernel: EIP:    0010:[sock_poll+30/40]    Tainted: P
Mar  3 21:00:29 localhost kernel: EFLAGS: 00210286
Mar  3 21:00:29 localhost kernel: eax: 1b0b3140   ebx: c18ec660   ecx: 00000000   edx: c0bf93a0
Mar  3 21:00:29 localhost kernel: esi: c18ec660   edi: 00000000   ebp: c16fdf70   esp: c16fdf28
Mar  3 21:00:29 localhost kernel: ds: 0018   es: 0018   ss: 0018
Mar  3 21:00:29 localhost kernel: Process xine (pid: 464, stackpage=c16fd000)
Mar  3 21:00:29 localhost kernel: Stack: c18ec660 c0bf93a0 00000000 00000000 c013aec6 c18ec660 00000000 00000004
Mar  3 21:00:29 localhost kernel:        00000004 c10b0eb8 00000145 00000008 c16fc000 7fffffff 00000003 00000000
Mar  3 21:00:29 localhost kernel:        00000000 c15c5000 00000000 c013b31c 00000004 c16fdfa8 c16fdfa4 c16fc000
Mar  3 21:00:29 localhost kernel: Call Trace: [do_select+226/476] [sys_select+820/1156] [system_call+51/64]
Mar  3 21:00:29 localhost kernel: Code: 8b 40 1c ff d0 83 c4 0c 5b c3 53 8b 5c 24 08 8b 43 08 8b 54
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 40 1c                  mov    0x1c(%eax),%eax
Code;  00000002 Before first symbol
   3:   ff d0                     call   *%eax
Code;  00000004 Before first symbol
   5:   83 c4 0c                  add    $0xc,%esp
Code;  00000008 Before first symbol
   8:   5b                        pop    %ebx
Code;  00000008 Before first symbol
   9:   c3                        ret    
Code;  0000000a Before first symbol
   a:   53                        push   %ebx
Code;  0000000a Before first symbol
   b:   8b 5c 24 08               mov    0x8(%esp,1),%ebx
Code;  0000000e Before first symbol
   f:   8b 43 08                  mov    0x8(%ebx),%eax
Code;  00000012 Before first symbol
  12:   8b 54 00 00               mov    0x0(%eax,%eax,1),%edx


1 warning issued.  Results may not be reliable.

----------------------------------------------------------


ksymoops 2.4.3 on i686 2.4.19pre1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19pre1/ (default)
     -m /boot/System.map-2.4.19pre1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Mar  3 21:00:29 localhost kernel:  <1>Unable to handle kernel paging request at virtual address 26b246c3
Mar  3 21:00:29 localhost kernel: c013dad1
Mar  3 21:00:29 localhost kernel: *pde = 00000000
Mar  3 21:00:29 localhost kernel: Oops: 0000
Mar  3 21:00:29 localhost kernel: CPU:    0
Mar  3 21:00:29 localhost kernel: EIP:    0010:[locks_remove_posix+49/312]    Tainted: P
Mar  3 21:00:29 localhost kernel: EFLAGS: 00010286
Mar  3 21:00:29 localhost kernel: eax: 26b24697   ebx: c18ec660   ecx: 26b24697   edx: c0bf9328
Mar  3 21:00:29 localhost kernel: esi: c0e9a000   edi: c0bf9328   ebp: c0e96da0   esp: c0e9be98
Mar  3 21:00:29 localhost kernel: ds: 0018   es: 0018   ss: 0018
Mar  3 21:00:29 localhost kernel: Process xine (pid: 474, stackpage=c0e9b000)
Mar  3 21:00:29 localhost kernel: Stack: c18ec660 00000000 c0e96da0 00000001 c012e065 c18ec660 c0e96da0 00000000
Mar  3 21:00:29 localhost kernel:        c18ec660 00000000 0000003f 00000003 c0115ab8 c18ec660 c0e96da0 c1cf8820
Mar  3 21:00:29 localhost kernel:        c0e9a000 0000000b c0e9bfc4 c0e96ec0 c011608f c0e96da0 0000000b 0000000b
Mar  3 21:00:29 localhost kernel: Call Trace: [filp_close+85/100] [put_files_struct+84/188] [do_exit+199/492] [do_signal+559/660] 
Mar  3 21:00:29 localhost kernel: Code: f6 40 2c 01 0f 84 ec 00 00 00 39 68 14 0f 85 e3 00 00 00 8b
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   f6 40 2c 01               testb  $0x1,0x2c(%eax)
Code;  00000004 Before first symbol
   4:   0f 84 ec 00 00 00         je     f6 <_EIP+0xf6> 000000f6 Before first symbol
Code;  0000000a Before first symbol
   a:   39 68 14                  cmp    %ebp,0x14(%eax)
Code;  0000000c Before first symbol
   d:   0f 85 e3 00 00 00         jne    f6 <_EIP+0xf6> 000000f6 Before first symbol
Code;  00000012 Before first symbol
  13:   8b 00                     mov    (%eax),%eax


1 warning issued.  Results may not be reliable.
