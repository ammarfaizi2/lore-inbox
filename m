Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbVAXNtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbVAXNtS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 08:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVAXNtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 08:49:18 -0500
Received: from pegase1.c-s.fr ([194.2.40.7]:49145 "EHLO pegase1.c-s.fr")
	by vger.kernel.org with ESMTP id S261487AbVAXNrQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 08:47:16 -0500
Message-ID: <41F4FBCF.9060004@c-s.fr>
Date: Mon, 24 Jan 2005 14:44:47 +0100
From: "GUILLON Gabriel" <gabriel.guillon@c-s.fr>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Ooops!
Content-Type: multipart/mixed;
 boundary="------------070903030003060903040308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070903030003060903040308
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

I send that Oops after rebooting.
Ooopses were found in kernel.log

Hope it'll help :)

-- 
Gabriel Guillon

--------------070903030003060903040308
Content-Type: text/plain;
 name="plop"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="plop"

ksymoops 2.4.9 on i686 2.6.10.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.10/ (default)
     -m /boot/System.map-2.6.10 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Jan 24 12:45:01 moustache kernel: Unable to handle kernel paging request at virtual address ccb1b320
Jan 24 12:45:01 moustache kernel: c0163b41
Jan 24 12:45:01 moustache kernel: *pde = 011ba067
Jan 24 12:45:01 moustache kernel: Oops: 0000 [#1]
Jan 24 12:45:01 moustache kernel: CPU:    0
Jan 24 12:45:01 moustache kernel: EIP:    0060:[__posix_lock_file+113/1600]    Not tainted VLI
Jan 24 12:45:01 moustache kernel: EFLAGS: 00010202   (2.6.10) 
Jan 24 12:45:01 moustache kernel: eax: ccb1b320   ebx: c03929e0   ecx: 000003a7   edx: c034402a
Jan 24 12:45:01 moustache kernel: esi: cbfe4800   edi: c6bfb960   ebp: 00000000   esp: c8cb1f18
Jan 24 12:45:01 moustache kernel: ds: 007b   es: 007b   ss: 0068
Jan 24 12:45:01 moustache kernel: Stack: c6bfb960 00000020 c5c3af34 c034402a 00000000 c6bfb960 cbfe4800 00000395 
Jan 24 12:45:01 moustache kernel:        c01679a7 c6bfb960 cbfe4800 c8cb1f4c 00000000 0000000f 00000000 0000000e 
Jan 24 12:45:01 moustache kernel:        00000000 00000000 c46d66a0 c8cb1fac 00000400 c0149fe8 c46d66a0 b7fe7000 
Jan 24 12:45:01 moustache kernel: Call Trace:
Jan 24 12:45:01 moustache kernel: Code: 74 24 04 89 3c 24 89 44 24 08 e8 6b 43 00 00 89 3c 24 b9 20 00 00 00 89 4c 24 04 e8 aa 45 00 00 8b 46 14 ba 2a 40 34 c0 8b 40 20 <8b> 00 89 54 24 08 89 3c 24 89 44 24 04 e8 0d 42 00 00 8b 46 14 
Using defaults from ksymoops -t elf32-i386 -a i386


>>eax; ccb1b320 <pg0+c681320/3fb64400>
>>ebx; c03929e0 <snd_ac97_ad198x_spdif_source+20/40>
>>edx; c034402a <tcp_collapse+9a/370>
>>esi; cbfe4800 <pg0+bb4a800/3fb64400>
>>edi; c6bfb960 <pg0+6761960/3fb64400>
>>esp; c8cb1f18 <pg0+8817f18/3fb64400>

Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
   0:   74 24                     je     26 <_EIP+0x26>
Code;  ffffffd7 <__kernel_rt_sigreturn+1b97/????>
   2:   04 89                     add    $0x89,%al
Code;  ffffffd9 <__kernel_rt_sigreturn+1b99/????>
   4:   3c 24                     cmp    $0x24,%al
Code;  ffffffdb <__kernel_rt_sigreturn+1b9b/????>
   6:   89 44 24 08               mov    %eax,0x8(%esp)
Code;  ffffffdf <__kernel_rt_sigreturn+1b9f/????>
   a:   e8 6b 43 00 00            call   437a <_EIP+0x437a>
Code;  ffffffe4 <__kernel_rt_sigreturn+1ba4/????>
   f:   89 3c 24                  mov    %edi,(%esp)
Code;  ffffffe7 <__kernel_rt_sigreturn+1ba7/????>
  12:   b9 20 00 00 00            mov    $0x20,%ecx
Code;  ffffffec <__kernel_rt_sigreturn+1bac/????>
  17:   89 4c 24 04               mov    %ecx,0x4(%esp)
Code;  fffffff0 <__kernel_rt_sigreturn+1bb0/????>
  1b:   e8 aa 45 00 00            call   45ca <_EIP+0x45ca>
Code;  fffffff5 <__kernel_rt_sigreturn+1bb5/????>
  20:   8b 46 14                  mov    0x14(%esi),%eax
Code;  fffffff8 <__kernel_rt_sigreturn+1bb8/????>
  23:   ba 2a 40 34 c0            mov    $0xc034402a,%edx
Code;  fffffffd <__kernel_rt_sigreturn+1bbd/????>
  28:   8b 40 20                  mov    0x20(%eax),%eax
Code;  00000000 Before first symbol
  2b:   8b 00                     mov    (%eax),%eax
Code;  00000002 Before first symbol
  2d:   89 54 24 08               mov    %edx,0x8(%esp)
Code;  00000006 Before first symbol
  31:   89 3c 24                  mov    %edi,(%esp)
Code;  00000009 Before first symbol
  34:   89 44 24 04               mov    %eax,0x4(%esp)
Code;  0000000d Before first symbol
  38:   e8 0d 42 00 00            call   424a <_EIP+0x424a>
Code;  00000012 Before first symbol
  3d:   8b 46 14                  mov    0x14(%esi),%eax

Jan 24 12:45:02 moustache kernel:  <1>Unable to handle kernel paging request at virtual address ccb1b320
Jan 24 12:45:02 moustache kernel: c0163b41
Jan 24 12:45:02 moustache kernel: *pde = 011ba067
Jan 24 12:45:02 moustache kernel: Oops: 0000 [#2]
Jan 24 12:45:02 moustache kernel: CPU:    0
Jan 24 12:45:02 moustache kernel: EIP:    0060:[__posix_lock_file+113/1600]    Not tainted VLI
Jan 24 12:45:02 moustache kernel: EFLAGS: 00010202   (2.6.10) 
Jan 24 12:45:02 moustache kernel: eax: ccb1b320   ebx: c03929e0   ecx: 000003a7   edx: c034402a
Jan 24 12:45:02 moustache kernel: esi: cbfe4800   edi: c6bfb960   ebp: 00000000   esp: c8cb1f18
Jan 24 12:45:02 moustache kernel: ds: 007b   es: 007b   ss: 0068
Jan 24 12:45:02 moustache kernel: Stack: c6bfb960 00000020 c5c3af34 c034402a 00000000 c6bfb960 cbfe4800 00000395 
Jan 24 12:45:02 moustache kernel:        c01679a7 c6bfb960 cbfe4800 c8cb1f4c 00000000 0000000f 00000000 0000000e 
Jan 24 12:45:02 moustache kernel:        00000000 00000000 c23972e0 c8cb1fac 00000400 c0149fe8 c23972e0 b7fe7000 
Jan 24 12:45:02 moustache kernel: Call Trace:
Jan 24 12:45:02 moustache kernel: Code: 74 24 04 89 3c 24 89 44 24 08 e8 6b 43 00 00 89 3c 24 b9 20 00 00 00 89 4c 24 04 e8 aa 45 00 00 8b 46 14 ba 2a 40 34 c0 8b 40 20 <8b> 00 89 54 24 08 89 3c 24 89 44 24 04 e8 0d 42 00 00 8b 46 14 


>>eax; ccb1b320 <pg0+c681320/3fb64400>
>>ebx; c03929e0 <snd_ac97_ad198x_spdif_source+20/40>
>>edx; c034402a <tcp_collapse+9a/370>
>>esi; cbfe4800 <pg0+bb4a800/3fb64400>
>>edi; c6bfb960 <pg0+6761960/3fb64400>
>>esp; c8cb1f18 <pg0+8817f18/3fb64400>

Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
   0:   74 24                     je     26 <_EIP+0x26>
Code;  ffffffd7 <__kernel_rt_sigreturn+1b97/????>
   2:   04 89                     add    $0x89,%al
Code;  ffffffd9 <__kernel_rt_sigreturn+1b99/????>
   4:   3c 24                     cmp    $0x24,%al
Code;  ffffffdb <__kernel_rt_sigreturn+1b9b/????>
   6:   89 44 24 08               mov    %eax,0x8(%esp)
Code;  ffffffdf <__kernel_rt_sigreturn+1b9f/????>
   a:   e8 6b 43 00 00            call   437a <_EIP+0x437a>
Code;  ffffffe4 <__kernel_rt_sigreturn+1ba4/????>
   f:   89 3c 24                  mov    %edi,(%esp)
Code;  ffffffe7 <__kernel_rt_sigreturn+1ba7/????>
  12:   b9 20 00 00 00            mov    $0x20,%ecx
Code;  ffffffec <__kernel_rt_sigreturn+1bac/????>
  17:   89 4c 24 04               mov    %ecx,0x4(%esp)
Code;  fffffff0 <__kernel_rt_sigreturn+1bb0/????>
  1b:   e8 aa 45 00 00            call   45ca <_EIP+0x45ca>
Code;  fffffff5 <__kernel_rt_sigreturn+1bb5/????>
  20:   8b 46 14                  mov    0x14(%esi),%eax
Code;  fffffff8 <__kernel_rt_sigreturn+1bb8/????>
  23:   ba 2a 40 34 c0            mov    $0xc034402a,%edx
Code;  fffffffd <__kernel_rt_sigreturn+1bbd/????>
  28:   8b 40 20                  mov    0x20(%eax),%eax
Code;  00000000 Before first symbol
  2b:   8b 00                     mov    (%eax),%eax
Code;  00000002 Before first symbol
  2d:   89 54 24 08               mov    %edx,0x8(%esp)
Code;  00000006 Before first symbol
  31:   89 3c 24                  mov    %edi,(%esp)
Code;  00000009 Before first symbol
  34:   89 44 24 04               mov    %eax,0x4(%esp)
Code;  0000000d Before first symbol
  38:   e8 0d 42 00 00            call   424a <_EIP+0x424a>
Code;  00000012 Before first symbol
  3d:   8b 46 14                  mov    0x14(%esi),%eax

Jan 24 12:45:09 moustache kernel: Unable to handle kernel paging request at virtual address ccb1b320
Jan 24 12:45:09 moustache kernel: c0163b41
Jan 24 12:45:09 moustache kernel: *pde = 011ba067
Jan 24 12:45:09 moustache kernel: Oops: 0000 [#3]
Jan 24 12:45:09 moustache kernel: CPU:    0
Jan 24 12:45:09 moustache kernel: EIP:    0060:[__posix_lock_file+113/1600]    Not tainted VLI
Jan 24 12:45:09 moustache kernel: EFLAGS: 00010202   (2.6.10) 
Jan 24 12:45:09 moustache kernel: eax: ccb1b320   ebx: c03929e0   ecx: 000003a7   edx: c034402a
Jan 24 12:45:09 moustache kernel: esi: cbfe4800   edi: c79f90a0   ebp: 00000000   esp: c8cb1f18
Jan 24 12:45:09 moustache kernel: ds: 007b   es: 007b   ss: 0068
Jan 24 12:45:09 moustache kernel: Stack: c79f90a0 00000020 c5c3af34 c034402a 00000000 c79f90a0 cbfe4800 00000395 
Jan 24 12:45:09 moustache kernel:        c01679a7 c79f90a0 cbfe4800 c8cb1f4c 00000000 0000000f 00000000 0000000e 
Jan 24 12:45:09 moustache kernel:        00000000 00000000 cb7bc1a0 c8cb1fac 00000400 c0149fe8 cb7bc1a0 b7fe8000 
Jan 24 12:45:09 moustache kernel: Call Trace:
Jan 24 12:45:09 moustache kernel: Code: 74 24 04 89 3c 24 89 44 24 08 e8 6b 43 00 00 89 3c 24 b9 20 00 00 00 89 4c 24 04 e8 aa 45 00 00 8b 46 14 ba 2a 40 34 c0 8b 40 20 <8b> 00 89 54 24 08 89 3c 24 89 44 24 04 e8 0d 42 00 00 8b 46 14 


>>eax; ccb1b320 <pg0+c681320/3fb64400>
>>ebx; c03929e0 <snd_ac97_ad198x_spdif_source+20/40>
>>edx; c034402a <tcp_collapse+9a/370>
>>esi; cbfe4800 <pg0+bb4a800/3fb64400>
>>edi; c79f90a0 <pg0+755f0a0/3fb64400>
>>esp; c8cb1f18 <pg0+8817f18/3fb64400>

Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
   0:   74 24                     je     26 <_EIP+0x26>
Code;  ffffffd7 <__kernel_rt_sigreturn+1b97/????>
   2:   04 89                     add    $0x89,%al
Code;  ffffffd9 <__kernel_rt_sigreturn+1b99/????>
   4:   3c 24                     cmp    $0x24,%al
Code;  ffffffdb <__kernel_rt_sigreturn+1b9b/????>
   6:   89 44 24 08               mov    %eax,0x8(%esp)
Code;  ffffffdf <__kernel_rt_sigreturn+1b9f/????>
   a:   e8 6b 43 00 00            call   437a <_EIP+0x437a>
Code;  ffffffe4 <__kernel_rt_sigreturn+1ba4/????>
   f:   89 3c 24                  mov    %edi,(%esp)
Code;  ffffffe7 <__kernel_rt_sigreturn+1ba7/????>
  12:   b9 20 00 00 00            mov    $0x20,%ecx
Code;  ffffffec <__kernel_rt_sigreturn+1bac/????>
  17:   89 4c 24 04               mov    %ecx,0x4(%esp)
Code;  fffffff0 <__kernel_rt_sigreturn+1bb0/????>
  1b:   e8 aa 45 00 00            call   45ca <_EIP+0x45ca>
Code;  fffffff5 <__kernel_rt_sigreturn+1bb5/????>
  20:   8b 46 14                  mov    0x14(%esi),%eax
Code;  fffffff8 <__kernel_rt_sigreturn+1bb8/????>
  23:   ba 2a 40 34 c0            mov    $0xc034402a,%edx
Code;  fffffffd <__kernel_rt_sigreturn+1bbd/????>
  28:   8b 40 20                  mov    0x20(%eax),%eax
Code;  00000000 Before first symbol
  2b:   8b 00                     mov    (%eax),%eax
Code;  00000002 Before first symbol
  2d:   89 54 24 08               mov    %edx,0x8(%esp)
Code;  00000006 Before first symbol
  31:   89 3c 24                  mov    %edi,(%esp)
Code;  00000009 Before first symbol
  34:   89 44 24 04               mov    %eax,0x4(%esp)
Code;  0000000d Before first symbol
  38:   e8 0d 42 00 00            call   424a <_EIP+0x424a>
Code;  00000012 Before first symbol
  3d:   8b 46 14                  mov    0x14(%esi),%eax

Jan 24 12:45:09 moustache kernel:  <1>Unable to handle kernel paging request at virtual address ccb1b320
Jan 24 12:45:09 moustache kernel: c0163b41
Jan 24 12:45:09 moustache kernel: *pde = 011ba067
Jan 24 12:45:09 moustache kernel: Oops: 0000 [#4]
Jan 24 12:45:09 moustache kernel: CPU:    0
Jan 24 12:45:09 moustache kernel: EIP:    0060:[__posix_lock_file+113/1600]    Not tainted VLI
Jan 24 12:45:09 moustache kernel: EFLAGS: 00010202   (2.6.10) 
Jan 24 12:45:09 moustache kernel: eax: ccb1b320   ebx: c03929e0   ecx: 000003a7   edx: c034402a
Jan 24 12:45:09 moustache kernel: esi: cbfe4800   edi: c851a9a0   ebp: 00000000   esp: c1a31f18
Jan 24 12:45:09 moustache kernel: ds: 007b   es: 007b   ss: 0068
Jan 24 12:45:09 moustache kernel: Stack: c851a9a0 00000020 c5c3af34 c034402a 00000000 c851a9a0 cbfe4800 00000395 
Jan 24 12:45:09 moustache kernel:        c01679a7 c851a9a0 cbfe4800 c1a31f4c 00000000 0000000f 00000000 0000000e 
Jan 24 12:45:09 moustache kernel:        00000000 00000000 c46d66a0 c1a31fac 00000400 c0149fe8 c46d66a0 b7fe8000 
Jan 24 12:45:09 moustache kernel: Call Trace:
Jan 24 12:45:09 moustache kernel: Code: 74 24 04 89 3c 24 89 44 24 08 e8 6b 43 00 00 89 3c 24 b9 20 00 00 00 89 4c 24 04 e8 aa 45 00 00 8b 46 14 ba 2a 40 34 c0 8b 40 20 <8b> 00 89 54 24 08 89 3c 24 89 44 24 04 e8 0d 42 00 00 8b 46 14 


>>eax; ccb1b320 <pg0+c681320/3fb64400>
>>ebx; c03929e0 <snd_ac97_ad198x_spdif_source+20/40>
>>edx; c034402a <tcp_collapse+9a/370>
>>esi; cbfe4800 <pg0+bb4a800/3fb64400>
>>edi; c851a9a0 <pg0+80809a0/3fb64400>
>>esp; c1a31f18 <pg0+1597f18/3fb64400>

Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
   0:   74 24                     je     26 <_EIP+0x26>
Code;  ffffffd7 <__kernel_rt_sigreturn+1b97/????>
   2:   04 89                     add    $0x89,%al
Code;  ffffffd9 <__kernel_rt_sigreturn+1b99/????>
   4:   3c 24                     cmp    $0x24,%al
Code;  ffffffdb <__kernel_rt_sigreturn+1b9b/????>
   6:   89 44 24 08               mov    %eax,0x8(%esp)
Code;  ffffffdf <__kernel_rt_sigreturn+1b9f/????>
   a:   e8 6b 43 00 00            call   437a <_EIP+0x437a>
Code;  ffffffe4 <__kernel_rt_sigreturn+1ba4/????>
   f:   89 3c 24                  mov    %edi,(%esp)
Code;  ffffffe7 <__kernel_rt_sigreturn+1ba7/????>
  12:   b9 20 00 00 00            mov    $0x20,%ecx
Code;  ffffffec <__kernel_rt_sigreturn+1bac/????>
  17:   89 4c 24 04               mov    %ecx,0x4(%esp)
Code;  fffffff0 <__kernel_rt_sigreturn+1bb0/????>
  1b:   e8 aa 45 00 00            call   45ca <_EIP+0x45ca>
Code;  fffffff5 <__kernel_rt_sigreturn+1bb5/????>
  20:   8b 46 14                  mov    0x14(%esi),%eax
Code;  fffffff8 <__kernel_rt_sigreturn+1bb8/????>
  23:   ba 2a 40 34 c0            mov    $0xc034402a,%edx
Code;  fffffffd <__kernel_rt_sigreturn+1bbd/????>
  28:   8b 40 20                  mov    0x20(%eax),%eax
Code;  00000000 Before first symbol
  2b:   8b 00                     mov    (%eax),%eax
Code;  00000002 Before first symbol
  2d:   89 54 24 08               mov    %edx,0x8(%esp)
Code;  00000006 Before first symbol
  31:   89 3c 24                  mov    %edi,(%esp)
Code;  00000009 Before first symbol
  34:   89 44 24 04               mov    %eax,0x4(%esp)
Code;  0000000d Before first symbol
  38:   e8 0d 42 00 00            call   424a <_EIP+0x424a>
Code;  00000012 Before first symbol
  3d:   8b 46 14                  mov    0x14(%esi),%eax

Jan 24 12:45:16 moustache kernel: Unable to handle kernel paging request at virtual address ccb1b320
Jan 24 12:45:16 moustache kernel: c0163b41
Jan 24 12:45:16 moustache kernel: *pde = 011ba067
Jan 24 12:45:16 moustache kernel: Oops: 0000 [#5]
Jan 24 12:45:16 moustache kernel: CPU:    0
Jan 24 12:45:16 moustache kernel: EIP:    0060:[__posix_lock_file+113/1600]    Not tainted VLI
Jan 24 12:45:16 moustache kernel: EFLAGS: 00010202   (2.6.10) 
Jan 24 12:45:16 moustache kernel: eax: ccb1b320   ebx: c03929e0   ecx: 000003a7   edx: c034402a
Jan 24 12:45:16 moustache kernel: esi: cbfe4800   edi: c79f90a0   ebp: 00000000   esp: c8cb1f18
Jan 24 12:45:16 moustache kernel: ds: 007b   es: 007b   ss: 0068
Jan 24 12:45:16 moustache kernel: Stack: c79f90a0 00000020 c5c3af34 c034402a 00000000 c79f90a0 cbfe4800 00000395 
Jan 24 12:45:16 moustache kernel:        c01679a7 c79f90a0 cbfe4800 c8cb1f4c 00000000 0000000f 00000000 0000000e 
Jan 24 12:45:16 moustache kernel:        00000000 00000000 c5034ce0 c8cb1fac 00000400 c0149fe8 c5034ce0 b7fe8000 
Jan 24 12:45:16 moustache kernel: Call Trace:
Jan 24 12:45:16 moustache kernel: Code: 74 24 04 89 3c 24 89 44 24 08 e8 6b 43 00 00 89 3c 24 b9 20 00 00 00 89 4c 24 04 e8 aa 45 00 00 8b 46 14 ba 2a 40 34 c0 8b 40 20 <8b> 00 89 54 24 08 89 3c 24 89 44 24 04 e8 0d 42 00 00 8b 46 14 


>>eax; ccb1b320 <pg0+c681320/3fb64400>
>>ebx; c03929e0 <snd_ac97_ad198x_spdif_source+20/40>
>>edx; c034402a <tcp_collapse+9a/370>
>>esi; cbfe4800 <pg0+bb4a800/3fb64400>
>>edi; c79f90a0 <pg0+755f0a0/3fb64400>
>>esp; c8cb1f18 <pg0+8817f18/3fb64400>

Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
   0:   74 24                     je     26 <_EIP+0x26>
Code;  ffffffd7 <__kernel_rt_sigreturn+1b97/????>
   2:   04 89                     add    $0x89,%al
Code;  ffffffd9 <__kernel_rt_sigreturn+1b99/????>
   4:   3c 24                     cmp    $0x24,%al
Code;  ffffffdb <__kernel_rt_sigreturn+1b9b/????>
   6:   89 44 24 08               mov    %eax,0x8(%esp)
Code;  ffffffdf <__kernel_rt_sigreturn+1b9f/????>
   a:   e8 6b 43 00 00            call   437a <_EIP+0x437a>
Code;  ffffffe4 <__kernel_rt_sigreturn+1ba4/????>
   f:   89 3c 24                  mov    %edi,(%esp)
Code;  ffffffe7 <__kernel_rt_sigreturn+1ba7/????>
  12:   b9 20 00 00 00            mov    $0x20,%ecx
Code;  ffffffec <__kernel_rt_sigreturn+1bac/????>
  17:   89 4c 24 04               mov    %ecx,0x4(%esp)
Code;  fffffff0 <__kernel_rt_sigreturn+1bb0/????>
  1b:   e8 aa 45 00 00            call   45ca <_EIP+0x45ca>
Code;  fffffff5 <__kernel_rt_sigreturn+1bb5/????>
  20:   8b 46 14                  mov    0x14(%esi),%eax
Code;  fffffff8 <__kernel_rt_sigreturn+1bb8/????>
  23:   ba 2a 40 34 c0            mov    $0xc034402a,%edx
Code;  fffffffd <__kernel_rt_sigreturn+1bbd/????>
  28:   8b 40 20                  mov    0x20(%eax),%eax
Code;  00000000 Before first symbol
  2b:   8b 00                     mov    (%eax),%eax
Code;  00000002 Before first symbol
  2d:   89 54 24 08               mov    %edx,0x8(%esp)
Code;  00000006 Before first symbol
  31:   89 3c 24                  mov    %edi,(%esp)
Code;  00000009 Before first symbol
  34:   89 44 24 04               mov    %eax,0x4(%esp)
Code;  0000000d Before first symbol
  38:   e8 0d 42 00 00            call   424a <_EIP+0x424a>
Code;  00000012 Before first symbol
  3d:   8b 46 14                  mov    0x14(%esi),%eax

Jan 24 12:45:16 moustache kernel:  <1>Unable to handle kernel paging request at virtual address ccb1b320
Jan 24 12:45:16 moustache kernel: c0163b41
Jan 24 12:45:16 moustache kernel: *pde = 011ba067
Jan 24 12:45:16 moustache kernel: Oops: 0000 [#6]
Jan 24 12:45:16 moustache kernel: CPU:    0
Jan 24 12:45:16 moustache kernel: EIP:    0060:[__posix_lock_file+113/1600]    Not tainted VLI
Jan 24 12:45:16 moustache kernel: EFLAGS: 00010202   (2.6.10) 
Jan 24 12:45:16 moustache kernel: eax: ccb1b320   ebx: c03929e0   ecx: 000003a7   edx: c034402a
Jan 24 12:45:16 moustache kernel: esi: cbfe4800   edi: c79f90a0   ebp: 00000000   esp: c0fadf18
Jan 24 12:45:16 moustache kernel: ds: 007b   es: 007b   ss: 0068
Jan 24 12:45:16 moustache kernel: Stack: c79f90a0 00000020 c5c3af34 c034402a 00000000 c79f90a0 cbfe4800 00000395 
Jan 24 12:45:16 moustache kernel:        c01679a7 c79f90a0 cbfe4800 c0fadf4c 00000000 0000000f 00000000 0000000e 
Jan 24 12:45:16 moustache kernel:        00000000 00000000 c1efba60 c0fadfac 00000400 c0149fe8 c1efba60 b7fe8000 
Jan 24 12:45:16 moustache kernel: Call Trace:
Jan 24 12:45:16 moustache kernel: Code: 74 24 04 89 3c 24 89 44 24 08 e8 6b 43 00 00 89 3c 24 b9 20 00 00 00 89 4c 24 04 e8 aa 45 00 00 8b 46 14 ba 2a 40 34 c0 8b 40 20 <8b> 00 89 54 24 08 89 3c 24 89 44 24 04 e8 0d 42 00 00 8b 46 14 


>>eax; ccb1b320 <pg0+c681320/3fb64400>
>>ebx; c03929e0 <snd_ac97_ad198x_spdif_source+20/40>
>>edx; c034402a <tcp_collapse+9a/370>
>>esi; cbfe4800 <pg0+bb4a800/3fb64400>
>>edi; c79f90a0 <pg0+755f0a0/3fb64400>
>>esp; c0fadf18 <pg0+b13f18/3fb64400>

Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
   0:   74 24                     je     26 <_EIP+0x26>
Code;  ffffffd7 <__kernel_rt_sigreturn+1b97/????>
   2:   04 89                     add    $0x89,%al
Code;  ffffffd9 <__kernel_rt_sigreturn+1b99/????>
   4:   3c 24                     cmp    $0x24,%al
Code;  ffffffdb <__kernel_rt_sigreturn+1b9b/????>
   6:   89 44 24 08               mov    %eax,0x8(%esp)
Code;  ffffffdf <__kernel_rt_sigreturn+1b9f/????>
   a:   e8 6b 43 00 00            call   437a <_EIP+0x437a>
Code;  ffffffe4 <__kernel_rt_sigreturn+1ba4/????>
   f:   89 3c 24                  mov    %edi,(%esp)
Code;  ffffffe7 <__kernel_rt_sigreturn+1ba7/????>
  12:   b9 20 00 00 00            mov    $0x20,%ecx
Code;  ffffffec <__kernel_rt_sigreturn+1bac/????>
  17:   89 4c 24 04               mov    %ecx,0x4(%esp)
Code;  fffffff0 <__kernel_rt_sigreturn+1bb0/????>
  1b:   e8 aa 45 00 00            call   45ca <_EIP+0x45ca>
Code;  fffffff5 <__kernel_rt_sigreturn+1bb5/????>
  20:   8b 46 14                  mov    0x14(%esi),%eax
Code;  fffffff8 <__kernel_rt_sigreturn+1bb8/????>
  23:   ba 2a 40 34 c0            mov    $0xc034402a,%edx
Code;  fffffffd <__kernel_rt_sigreturn+1bbd/????>
  28:   8b 40 20                  mov    0x20(%eax),%eax
Code;  00000000 Before first symbol
  2b:   8b 00                     mov    (%eax),%eax
Code;  00000002 Before first symbol
  2d:   89 54 24 08               mov    %edx,0x8(%esp)
Code;  00000006 Before first symbol
  31:   89 3c 24                  mov    %edi,(%esp)
Code;  00000009 Before first symbol
  34:   89 44 24 04               mov    %eax,0x4(%esp)
Code;  0000000d Before first symbol
  38:   e8 0d 42 00 00            call   424a <_EIP+0x424a>
Code;  00000012 Before first symbol
  3d:   8b 46 14                  mov    0x14(%esi),%eax

Jan 24 12:45:54 moustache kernel: Unable to handle kernel paging request at virtual address ccb1b320
Jan 24 12:45:54 moustache kernel: c0163b41
Jan 24 12:45:54 moustache kernel: *pde = 011ba067
Jan 24 12:45:54 moustache kernel: Oops: 0000 [#7]
Jan 24 12:45:54 moustache kernel: CPU:    0
Jan 24 12:45:54 moustache kernel: EIP:    0060:[__posix_lock_file+113/1600]    Not tainted VLI
Jan 24 12:45:54 moustache kernel: EFLAGS: 00010202   (2.6.10) 
Jan 24 12:45:54 moustache kernel: eax: ccb1b320   ebx: c03929e0   ecx: 000003a7   edx: c034402a
Jan 24 12:45:54 moustache kernel: esi: cbfe4800   edi: c79f9260   ebp: 00000000   esp: c6dcff18
Jan 24 12:45:54 moustache kernel: ds: 007b   es: 007b   ss: 0068
Jan 24 12:45:54 moustache kernel: Stack: c79f9260 00000020 c5c3af34 c034402a 00000000 c79f9260 cbfe4800 00000395 
Jan 24 12:45:54 moustache kernel:        c01679a7 c79f9260 cbfe4800 c6dcff4c 00000000 0000000f 00000000 0000000e 
Jan 24 12:45:54 moustache kernel:        00000000 00000000 c1efba60 c6dcffac 00000400 c0149fe8 c1efba60 b7fe8000 
Jan 24 12:45:54 moustache kernel: Call Trace:
Jan 24 12:45:54 moustache kernel: Code: 74 24 04 89 3c 24 89 44 24 08 e8 6b 43 00 00 89 3c 24 b9 20 00 00 00 89 4c 24 04 e8 aa 45 00 00 8b 46 14 ba 2a 40 34 c0 8b 40 20 <8b> 00 89 54 24 08 89 3c 24 89 44 24 04 e8 0d 42 00 00 8b 46 14 


>>eax; ccb1b320 <pg0+c681320/3fb64400>
>>ebx; c03929e0 <snd_ac97_ad198x_spdif_source+20/40>
>>edx; c034402a <tcp_collapse+9a/370>
>>esi; cbfe4800 <pg0+bb4a800/3fb64400>
>>edi; c79f9260 <pg0+755f260/3fb64400>
>>esp; c6dcff18 <pg0+6935f18/3fb64400>

Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
   0:   74 24                     je     26 <_EIP+0x26>
Code;  ffffffd7 <__kernel_rt_sigreturn+1b97/????>
   2:   04 89                     add    $0x89,%al
Code;  ffffffd9 <__kernel_rt_sigreturn+1b99/????>
   4:   3c 24                     cmp    $0x24,%al
Code;  ffffffdb <__kernel_rt_sigreturn+1b9b/????>
   6:   89 44 24 08               mov    %eax,0x8(%esp)
Code;  ffffffdf <__kernel_rt_sigreturn+1b9f/????>
   a:   e8 6b 43 00 00            call   437a <_EIP+0x437a>
Code;  ffffffe4 <__kernel_rt_sigreturn+1ba4/????>
   f:   89 3c 24                  mov    %edi,(%esp)
Code;  ffffffe7 <__kernel_rt_sigreturn+1ba7/????>
  12:   b9 20 00 00 00            mov    $0x20,%ecx
Code;  ffffffec <__kernel_rt_sigreturn+1bac/????>
  17:   89 4c 24 04               mov    %ecx,0x4(%esp)
Code;  fffffff0 <__kernel_rt_sigreturn+1bb0/????>
  1b:   e8 aa 45 00 00            call   45ca <_EIP+0x45ca>
Code;  fffffff5 <__kernel_rt_sigreturn+1bb5/????>
  20:   8b 46 14                  mov    0x14(%esi),%eax
Code;  fffffff8 <__kernel_rt_sigreturn+1bb8/????>
  23:   ba 2a 40 34 c0            mov    $0xc034402a,%edx
Code;  fffffffd <__kernel_rt_sigreturn+1bbd/????>
  28:   8b 40 20                  mov    0x20(%eax),%eax
Code;  00000000 Before first symbol
  2b:   8b 00                     mov    (%eax),%eax
Code;  00000002 Before first symbol
  2d:   89 54 24 08               mov    %edx,0x8(%esp)
Code;  00000006 Before first symbol
  31:   89 3c 24                  mov    %edi,(%esp)
Code;  00000009 Before first symbol
  34:   89 44 24 04               mov    %eax,0x4(%esp)
Code;  0000000d Before first symbol
  38:   e8 0d 42 00 00            call   424a <_EIP+0x424a>
Code;  00000012 Before first symbol
  3d:   8b 46 14                  mov    0x14(%esi),%eax

Jan 24 12:45:54 moustache kernel:  <1>Unable to handle kernel paging request at virtual address ccb1b320
Jan 24 12:45:54 moustache kernel: c0163b41
Jan 24 12:45:54 moustache kernel: *pde = 011ba067
Jan 24 12:45:54 moustache kernel: Oops: 0000 [#8]
Jan 24 12:45:54 moustache kernel: CPU:    0
Jan 24 12:45:54 moustache kernel: EIP:    0060:[__posix_lock_file+113/1600]    Not tainted VLI
Jan 24 12:45:54 moustache kernel: EFLAGS: 00010202   (2.6.10) 
Jan 24 12:45:54 moustache kernel: eax: ccb1b320   ebx: c03929e0   ecx: 000003a7   edx: c034402a
Jan 24 12:45:54 moustache kernel: esi: cbfe4800   edi: c851a9a0   ebp: 00000000   esp: c1e2df18
Jan 24 12:45:54 moustache kernel: ds: 007b   es: 007b   ss: 0068
Jan 24 12:45:54 moustache kernel: Stack: c851a9a0 00000020 c5c3af34 c034402a 00000000 c851a9a0 cbfe4800 00000395 
Jan 24 12:45:54 moustache kernel:        c01679a7 c851a9a0 cbfe4800 c1e2df4c 00000000 0000000f 00000000 0000000e 
Jan 24 12:45:54 moustache kernel:        00000000 00000000 c3bc3c40 c1e2dfac 00000400 c0149fe8 c3bc3c40 b7fe8000 
Jan 24 12:45:54 moustache kernel: Call Trace:
Jan 24 12:45:54 moustache kernel: Code: 74 24 04 89 3c 24 89 44 24 08 e8 6b 43 00 00 89 3c 24 b9 20 00 00 00 89 4c 24 04 e8 aa 45 00 00 8b 46 14 ba 2a 40 34 c0 8b 40 20 <8b> 00 89 54 24 08 89 3c 24 89 44 24 04 e8 0d 42 00 00 8b 46 14 


>>eax; ccb1b320 <pg0+c681320/3fb64400>
>>ebx; c03929e0 <snd_ac97_ad198x_spdif_source+20/40>
>>edx; c034402a <tcp_collapse+9a/370>
>>esi; cbfe4800 <pg0+bb4a800/3fb64400>
>>edi; c851a9a0 <pg0+80809a0/3fb64400>
>>esp; c1e2df18 <pg0+1993f18/3fb64400>

Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
   0:   74 24                     je     26 <_EIP+0x26>
Code;  ffffffd7 <__kernel_rt_sigreturn+1b97/????>
   2:   04 89                     add    $0x89,%al
Code;  ffffffd9 <__kernel_rt_sigreturn+1b99/????>
   4:   3c 24                     cmp    $0x24,%al
Code;  ffffffdb <__kernel_rt_sigreturn+1b9b/????>
   6:   89 44 24 08               mov    %eax,0x8(%esp)
Code;  ffffffdf <__kernel_rt_sigreturn+1b9f/????>
   a:   e8 6b 43 00 00            call   437a <_EIP+0x437a>
Code;  ffffffe4 <__kernel_rt_sigreturn+1ba4/????>
   f:   89 3c 24                  mov    %edi,(%esp)
Code;  ffffffe7 <__kernel_rt_sigreturn+1ba7/????>
  12:   b9 20 00 00 00            mov    $0x20,%ecx
Code;  ffffffec <__kernel_rt_sigreturn+1bac/????>
  17:   89 4c 24 04               mov    %ecx,0x4(%esp)
Code;  fffffff0 <__kernel_rt_sigreturn+1bb0/????>
  1b:   e8 aa 45 00 00            call   45ca <_EIP+0x45ca>
Code;  fffffff5 <__kernel_rt_sigreturn+1bb5/????>
  20:   8b 46 14                  mov    0x14(%esi),%eax
Code;  fffffff8 <__kernel_rt_sigreturn+1bb8/????>
  23:   ba 2a 40 34 c0            mov    $0xc034402a,%edx
Code;  fffffffd <__kernel_rt_sigreturn+1bbd/????>
  28:   8b 40 20                  mov    0x20(%eax),%eax
Code;  00000000 Before first symbol
  2b:   8b 00                     mov    (%eax),%eax
Code;  00000002 Before first symbol
  2d:   89 54 24 08               mov    %edx,0x8(%esp)
Code;  00000006 Before first symbol
  31:   89 3c 24                  mov    %edi,(%esp)
Code;  00000009 Before first symbol
  34:   89 44 24 04               mov    %eax,0x4(%esp)
Code;  0000000d Before first symbol
  38:   e8 0d 42 00 00            call   424a <_EIP+0x424a>
Code;  00000012 Before first symbol
  3d:   8b 46 14                  mov    0x14(%esi),%eax

Jan 24 12:45:59 moustache kernel: Unable to handle kernel paging request at virtual address ccb1b320
Jan 24 12:45:59 moustache kernel: c0163b41
Jan 24 12:45:59 moustache kernel: *pde = 011ba067
Jan 24 12:45:59 moustache kernel: Oops: 0000 [#9]
Jan 24 12:45:59 moustache kernel: CPU:    0
Jan 24 12:45:59 moustache kernel: EIP:    0060:[__posix_lock_file+113/1600]    Not tainted VLI
Jan 24 12:45:59 moustache kernel: EFLAGS: 00010202   (2.6.10) 
Jan 24 12:45:59 moustache kernel: eax: ccb1b320   ebx: c03929e0   ecx: 000003a7   edx: c034402a
Jan 24 12:45:59 moustache kernel: esi: cbfe4800   edi: c79f90a0   ebp: 00000000   esp: c6dcff18
Jan 24 12:45:59 moustache kernel: ds: 007b   es: 007b   ss: 0068
Jan 24 12:45:59 moustache kernel: Stack: c79f90a0 00000020 c5c3af34 c034402a 00000000 c79f90a0 cbfe4800 00000395 
Jan 24 12:45:59 moustache kernel:        c01679a7 c79f90a0 cbfe4800 c6dcff4c 00000000 0000000f 00000000 0000000e 
Jan 24 12:45:59 moustache kernel:        00000000 00000000 c004cf60 c6dcffac 00000400 c0149fe8 c004cf60 b7fe8000 
Jan 24 12:45:59 moustache kernel: Call Trace:
Jan 24 12:45:59 moustache kernel: Code: 74 24 04 89 3c 24 89 44 24 08 e8 6b 43 00 00 89 3c 24 b9 20 00 00 00 89 4c 24 04 e8 aa 45 00 00 8b 46 14 ba 2a 40 34 c0 8b 40 20 <8b> 00 89 54 24 08 89 3c 24 89 44 24 04 e8 0d 42 00 00 8b 46 14 


>>eax; ccb1b320 <pg0+c681320/3fb64400>
>>ebx; c03929e0 <snd_ac97_ad198x_spdif_source+20/40>
>>edx; c034402a <tcp_collapse+9a/370>
>>esi; cbfe4800 <pg0+bb4a800/3fb64400>
>>edi; c79f90a0 <pg0+755f0a0/3fb64400>
>>esp; c6dcff18 <pg0+6935f18/3fb64400>

Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
   0:   74 24                     je     26 <_EIP+0x26>
Code;  ffffffd7 <__kernel_rt_sigreturn+1b97/????>
   2:   04 89                     add    $0x89,%al
Code;  ffffffd9 <__kernel_rt_sigreturn+1b99/????>
   4:   3c 24                     cmp    $0x24,%al
Code;  ffffffdb <__kernel_rt_sigreturn+1b9b/????>
   6:   89 44 24 08               mov    %eax,0x8(%esp)
Code;  ffffffdf <__kernel_rt_sigreturn+1b9f/????>
   a:   e8 6b 43 00 00            call   437a <_EIP+0x437a>
Code;  ffffffe4 <__kernel_rt_sigreturn+1ba4/????>
   f:   89 3c 24                  mov    %edi,(%esp)
Code;  ffffffe7 <__kernel_rt_sigreturn+1ba7/????>
  12:   b9 20 00 00 00            mov    $0x20,%ecx
Code;  ffffffec <__kernel_rt_sigreturn+1bac/????>
  17:   89 4c 24 04               mov    %ecx,0x4(%esp)
Code;  fffffff0 <__kernel_rt_sigreturn+1bb0/????>
  1b:   e8 aa 45 00 00            call   45ca <_EIP+0x45ca>
Code;  fffffff5 <__kernel_rt_sigreturn+1bb5/????>
  20:   8b 46 14                  mov    0x14(%esi),%eax
Code;  fffffff8 <__kernel_rt_sigreturn+1bb8/????>
  23:   ba 2a 40 34 c0            mov    $0xc034402a,%edx
Code;  fffffffd <__kernel_rt_sigreturn+1bbd/????>
  28:   8b 40 20                  mov    0x20(%eax),%eax
Code;  00000000 Before first symbol
  2b:   8b 00                     mov    (%eax),%eax
Code;  00000002 Before first symbol
  2d:   89 54 24 08               mov    %edx,0x8(%esp)
Code;  00000006 Before first symbol
  31:   89 3c 24                  mov    %edi,(%esp)
Code;  00000009 Before first symbol
  34:   89 44 24 04               mov    %eax,0x4(%esp)
Code;  0000000d Before first symbol
  38:   e8 0d 42 00 00            call   424a <_EIP+0x424a>
Code;  00000012 Before first symbol
  3d:   8b 46 14                  mov    0x14(%esi),%eax

Jan 24 12:45:59 moustache kernel:  <1>Unable to handle kernel paging request at virtual address ccb1b320
Jan 24 12:45:59 moustache kernel: c0163b41
Jan 24 12:45:59 moustache kernel: *pde = 011ba067
Jan 24 12:45:59 moustache kernel: Oops: 0000 [#10]
Jan 24 12:45:59 moustache kernel: CPU:    0
Jan 24 12:45:59 moustache kernel: EIP:    0060:[__posix_lock_file+113/1600]    Not tainted VLI
Jan 24 12:45:59 moustache kernel: EFLAGS: 00010202   (2.6.10) 
Jan 24 12:45:59 moustache kernel: eax: ccb1b320   ebx: c03929e0   ecx: 000003a7   edx: c034402a
Jan 24 12:45:59 moustache kernel: esi: cbfe4800   edi: c79f90a0   ebp: 00000000   esp: c1e2bf18
Jan 24 12:45:59 moustache kernel: ds: 007b   es: 007b   ss: 0068
Jan 24 12:45:59 moustache kernel: Stack: c79f90a0 00000020 c5c3af34 c034402a 00000000 c79f90a0 cbfe4800 00000395 
Jan 24 12:45:59 moustache kernel:        c01679a7 c79f90a0 cbfe4800 c1e2bf4c 00000000 0000000f 00000000 0000000e 
Jan 24 12:45:59 moustache kernel:        00000000 00000000 c980bb00 c1e2bfac 00000400 c0149fe8 c980bb00 b7fe8000 
Jan 24 12:45:59 moustache kernel: Call Trace:
Jan 24 12:45:59 moustache kernel: Code: 74 24 04 89 3c 24 89 44 24 08 e8 6b 43 00 00 89 3c 24 b9 20 00 00 00 89 4c 24 04 e8 aa 45 00 00 8b 46 14 ba 2a 40 34 c0 8b 40 20 <8b> 00 89 54 24 08 89 3c 24 89 44 24 04 e8 0d 42 00 00 8b 46 14 


>>eax; ccb1b320 <pg0+c681320/3fb64400>
>>ebx; c03929e0 <snd_ac97_ad198x_spdif_source+20/40>
>>edx; c034402a <tcp_collapse+9a/370>
>>esi; cbfe4800 <pg0+bb4a800/3fb64400>
>>edi; c79f90a0 <pg0+755f0a0/3fb64400>
>>esp; c1e2bf18 <pg0+1991f18/3fb64400>

Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
   0:   74 24                     je     26 <_EIP+0x26>
Code;  ffffffd7 <__kernel_rt_sigreturn+1b97/????>
   2:   04 89                     add    $0x89,%al
Code;  ffffffd9 <__kernel_rt_sigreturn+1b99/????>
   4:   3c 24                     cmp    $0x24,%al
Code;  ffffffdb <__kernel_rt_sigreturn+1b9b/????>
   6:   89 44 24 08               mov    %eax,0x8(%esp)
Code;  ffffffdf <__kernel_rt_sigreturn+1b9f/????>
   a:   e8 6b 43 00 00            call   437a <_EIP+0x437a>
Code;  ffffffe4 <__kernel_rt_sigreturn+1ba4/????>
   f:   89 3c 24                  mov    %edi,(%esp)
Code;  ffffffe7 <__kernel_rt_sigreturn+1ba7/????>
  12:   b9 20 00 00 00            mov    $0x20,%ecx
Code;  ffffffec <__kernel_rt_sigreturn+1bac/????>
  17:   89 4c 24 04               mov    %ecx,0x4(%esp)
Code;  fffffff0 <__kernel_rt_sigreturn+1bb0/????>
  1b:   e8 aa 45 00 00            call   45ca <_EIP+0x45ca>
Code;  fffffff5 <__kernel_rt_sigreturn+1bb5/????>
  20:   8b 46 14                  mov    0x14(%esi),%eax
Code;  fffffff8 <__kernel_rt_sigreturn+1bb8/????>
  23:   ba 2a 40 34 c0            mov    $0xc034402a,%edx
Code;  fffffffd <__kernel_rt_sigreturn+1bbd/????>
  28:   8b 40 20                  mov    0x20(%eax),%eax
Code;  00000000 Before first symbol
  2b:   8b 00                     mov    (%eax),%eax
Code;  00000002 Before first symbol
  2d:   89 54 24 08               mov    %edx,0x8(%esp)
Code;  00000006 Before first symbol
  31:   89 3c 24                  mov    %edi,(%esp)
Code;  00000009 Before first symbol
  34:   89 44 24 04               mov    %eax,0x4(%esp)
Code;  0000000d Before first symbol
  38:   e8 0d 42 00 00            call   424a <_EIP+0x424a>
Code;  00000012 Before first symbol
  3d:   8b 46 14                  mov    0x14(%esi),%eax

Jan 24 12:46:06 moustache kernel: Unable to handle kernel paging request at virtual address ccb1b320
Jan 24 12:46:06 moustache kernel: c0163b41
Jan 24 12:46:06 moustache kernel: *pde = 011ba067
Jan 24 12:46:06 moustache kernel: Oops: 0000 [#11]
Jan 24 12:46:06 moustache kernel: CPU:    0
Jan 24 12:46:06 moustache kernel: EIP:    0060:[__posix_lock_file+113/1600]    Not tainted VLI
Jan 24 12:46:06 moustache kernel: EFLAGS: 00010202   (2.6.10) 
Jan 24 12:46:06 moustache kernel: eax: ccb1b320   ebx: c03929e0   ecx: 000003a7   edx: c034402a
Jan 24 12:46:06 moustache kernel: esi: cbfe4800   edi: c79f9260   ebp: 00000000   esp: c1e2bf18
Jan 24 12:46:06 moustache kernel: ds: 007b   es: 007b   ss: 0068
Jan 24 12:46:06 moustache kernel: Stack: c79f9260 00000020 c5c3af34 c034402a 00000000 c79f9260 cbfe4800 00000395 
Jan 24 12:46:06 moustache kernel:        c01679a7 c79f9260 cbfe4800 c1e2bf4c 00000000 0000000f 00000000 0000000e 
Jan 24 12:46:06 moustache kernel:        00000000 00000000 c5034ce0 c1e2bfac 00000400 c0149fe8 c5034ce0 b7fe8000 
Jan 24 12:46:06 moustache kernel: Call Trace:
Jan 24 12:46:06 moustache kernel: Code: 74 24 04 89 3c 24 89 44 24 08 e8 6b 43 00 00 89 3c 24 b9 20 00 00 00 89 4c 24 04 e8 aa 45 00 00 8b 46 14 ba 2a 40 34 c0 8b 40 20 <8b> 00 89 54 24 08 89 3c 24 89 44 24 04 e8 0d 42 00 00 8b 46 14 


>>eax; ccb1b320 <pg0+c681320/3fb64400>
>>ebx; c03929e0 <snd_ac97_ad198x_spdif_source+20/40>
>>edx; c034402a <tcp_collapse+9a/370>
>>esi; cbfe4800 <pg0+bb4a800/3fb64400>
>>edi; c79f9260 <pg0+755f260/3fb64400>
>>esp; c1e2bf18 <pg0+1991f18/3fb64400>

Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
   0:   74 24                     je     26 <_EIP+0x26>
Code;  ffffffd7 <__kernel_rt_sigreturn+1b97/????>
   2:   04 89                     add    $0x89,%al
Code;  ffffffd9 <__kernel_rt_sigreturn+1b99/????>
   4:   3c 24                     cmp    $0x24,%al
Code;  ffffffdb <__kernel_rt_sigreturn+1b9b/????>
   6:   89 44 24 08               mov    %eax,0x8(%esp)
Code;  ffffffdf <__kernel_rt_sigreturn+1b9f/????>
   a:   e8 6b 43 00 00            call   437a <_EIP+0x437a>
Code;  ffffffe4 <__kernel_rt_sigreturn+1ba4/????>
   f:   89 3c 24                  mov    %edi,(%esp)
Code;  ffffffe7 <__kernel_rt_sigreturn+1ba7/????>
  12:   b9 20 00 00 00            mov    $0x20,%ecx
Code;  ffffffec <__kernel_rt_sigreturn+1bac/????>
  17:   89 4c 24 04               mov    %ecx,0x4(%esp)
Code;  fffffff0 <__kernel_rt_sigreturn+1bb0/????>
  1b:   e8 aa 45 00 00            call   45ca <_EIP+0x45ca>
Code;  fffffff5 <__kernel_rt_sigreturn+1bb5/????>
  20:   8b 46 14                  mov    0x14(%esi),%eax
Code;  fffffff8 <__kernel_rt_sigreturn+1bb8/????>
  23:   ba 2a 40 34 c0            mov    $0xc034402a,%edx
Code;  fffffffd <__kernel_rt_sigreturn+1bbd/????>
  28:   8b 40 20                  mov    0x20(%eax),%eax
Code;  00000000 Before first symbol
  2b:   8b 00                     mov    (%eax),%eax
Code;  00000002 Before first symbol
  2d:   89 54 24 08               mov    %edx,0x8(%esp)
Code;  00000006 Before first symbol
  31:   89 3c 24                  mov    %edi,(%esp)
Code;  00000009 Before first symbol
  34:   89 44 24 04               mov    %eax,0x4(%esp)
Code;  0000000d Before first symbol
  38:   e8 0d 42 00 00            call   424a <_EIP+0x424a>
Code;  00000012 Before first symbol
  3d:   8b 46 14                  mov    0x14(%esi),%eax

Jan 24 12:46:06 moustache kernel:  <1>Unable to handle kernel paging request at virtual address ccb1b320
Jan 24 12:46:06 moustache kernel: c0163b41
Jan 24 12:46:06 moustache kernel: *pde = 011ba067
Jan 24 12:46:06 moustache kernel: Oops: 0000 [#12]
Jan 24 12:46:06 moustache kernel: CPU:    0
Jan 24 12:46:06 moustache kernel: EIP:    0060:[__posix_lock_file+113/1600]    Not tainted VLI
Jan 24 12:46:06 moustache kernel: EFLAGS: 00010202   (2.6.10) 
Jan 24 12:46:06 moustache kernel: eax: ccb1b320   ebx: c03929e0   ecx: 000003a7   edx: c034402a
Jan 24 12:46:06 moustache kernel: esi: cbfe4800   edi: c851a9a0   ebp: 00000000   esp: c1e2df18
Jan 24 12:46:06 moustache kernel: ds: 007b   es: 007b   ss: 0068
Jan 24 12:46:06 moustache kernel: Stack: c851a9a0 00000020 c5c3af34 c034402a 00000000 c851a9a0 cbfe4800 00000395 
Jan 24 12:46:06 moustache kernel:        c01679a7 c851a9a0 cbfe4800 c1e2df4c 00000000 0000000f 00000000 0000000e 
Jan 24 12:46:06 moustache kernel:        00000000 00000000 cad969c0 c1e2dfac 00000400 c0149fe8 cad969c0 b7fe8000 
Jan 24 12:46:06 moustache kernel: Call Trace:
Jan 24 12:46:06 moustache kernel: Code: 74 24 04 89 3c 24 89 44 24 08 e8 6b 43 00 00 89 3c 24 b9 20 00 00 00 89 4c 24 04 e8 aa 45 00 00 8b 46 14 ba 2a 40 34 c0 8b 40 20 <8b> 00 89 54 24 08 89 3c 24 89 44 24 04 e8 0d 42 00 00 8b 46 14 


>>eax; ccb1b320 <pg0+c681320/3fb64400>
>>ebx; c03929e0 <snd_ac97_ad198x_spdif_source+20/40>
>>edx; c034402a <tcp_collapse+9a/370>
>>esi; cbfe4800 <pg0+bb4a800/3fb64400>
>>edi; c851a9a0 <pg0+80809a0/3fb64400>
>>esp; c1e2df18 <pg0+1993f18/3fb64400>

Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
   0:   74 24                     je     26 <_EIP+0x26>
Code;  ffffffd7 <__kernel_rt_sigreturn+1b97/????>
   2:   04 89                     add    $0x89,%al
Code;  ffffffd9 <__kernel_rt_sigreturn+1b99/????>
   4:   3c 24                     cmp    $0x24,%al
Code;  ffffffdb <__kernel_rt_sigreturn+1b9b/????>
   6:   89 44 24 08               mov    %eax,0x8(%esp)
Code;  ffffffdf <__kernel_rt_sigreturn+1b9f/????>
   a:   e8 6b 43 00 00            call   437a <_EIP+0x437a>
Code;  ffffffe4 <__kernel_rt_sigreturn+1ba4/????>
   f:   89 3c 24                  mov    %edi,(%esp)
Code;  ffffffe7 <__kernel_rt_sigreturn+1ba7/????>
  12:   b9 20 00 00 00            mov    $0x20,%ecx
Code;  ffffffec <__kernel_rt_sigreturn+1bac/????>
  17:   89 4c 24 04               mov    %ecx,0x4(%esp)
Code;  fffffff0 <__kernel_rt_sigreturn+1bb0/????>
  1b:   e8 aa 45 00 00            call   45ca <_EIP+0x45ca>
Code;  fffffff5 <__kernel_rt_sigreturn+1bb5/????>
  20:   8b 46 14                  mov    0x14(%esi),%eax
Code;  fffffff8 <__kernel_rt_sigreturn+1bb8/????>
  23:   ba 2a 40 34 c0            mov    $0xc034402a,%edx
Code;  fffffffd <__kernel_rt_sigreturn+1bbd/????>
  28:   8b 40 20                  mov    0x20(%eax),%eax
Code;  00000000 Before first symbol
  2b:   8b 00                     mov    (%eax),%eax
Code;  00000002 Before first symbol
  2d:   89 54 24 08               mov    %edx,0x8(%esp)
Code;  00000006 Before first symbol
  31:   89 3c 24                  mov    %edi,(%esp)
Code;  00000009 Before first symbol
  34:   89 44 24 04               mov    %eax,0x4(%esp)
Code;  0000000d Before first symbol
  38:   e8 0d 42 00 00            call   424a <_EIP+0x424a>
Code;  00000012 Before first symbol
  3d:   8b 46 14                  mov    0x14(%esi),%eax

Jan 24 12:46:13 moustache kernel: Unable to handle kernel paging request at virtual address ccb1b320
Jan 24 12:46:13 moustache kernel: c0163b41
Jan 24 12:46:13 moustache kernel: *pde = 011ba067
Jan 24 12:46:13 moustache kernel: Oops: 0000 [#13]
Jan 24 12:46:13 moustache kernel: CPU:    0
Jan 24 12:46:13 moustache kernel: EIP:    0060:[__posix_lock_file+113/1600]    Not tainted VLI
Jan 24 12:46:13 moustache kernel: EFLAGS: 00010202   (2.6.10) 
Jan 24 12:46:13 moustache kernel: eax: ccb1b320   ebx: c03929e0   ecx: 000003a7   edx: c034402a
Jan 24 12:46:13 moustache kernel: esi: cbfe4800   edi: c79f90a0   ebp: 00000000   esp: c1e2bf18
Jan 24 12:46:13 moustache kernel: ds: 007b   es: 007b   ss: 0068
Jan 24 12:46:13 moustache kernel: Stack: c79f90a0 00000020 c5c3af34 c034402a 00000000 c79f90a0 cbfe4800 00000395 
Jan 24 12:46:13 moustache kernel:        c01679a7 c79f90a0 cbfe4800 c1e2bf4c 00000000 0000000f 00000000 0000000e 
Jan 24 12:46:13 moustache kernel:        00000000 00000000 cb7bc1a0 c1e2bfac 00000400 c0149fe8 cb7bc1a0 b7fe8000 
Jan 24 12:46:13 moustache kernel: Call Trace:
Jan 24 12:46:13 moustache kernel: Code: 74 24 04 89 3c 24 89 44 24 08 e8 6b 43 00 00 89 3c 24 b9 20 00 00 00 89 4c 24 04 e8 aa 45 00 00 8b 46 14 ba 2a 40 34 c0 8b 40 20 <8b> 00 89 54 24 08 89 3c 24 89 44 24 04 e8 0d 42 00 00 8b 46 14 


>>eax; ccb1b320 <pg0+c681320/3fb64400>
>>ebx; c03929e0 <snd_ac97_ad198x_spdif_source+20/40>
>>edx; c034402a <tcp_collapse+9a/370>
>>esi; cbfe4800 <pg0+bb4a800/3fb64400>
>>edi; c79f90a0 <pg0+755f0a0/3fb64400>
>>esp; c1e2bf18 <pg0+1991f18/3fb64400>

Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
   0:   74 24                     je     26 <_EIP+0x26>
Code;  ffffffd7 <__kernel_rt_sigreturn+1b97/????>
   2:   04 89                     add    $0x89,%al
Code;  ffffffd9 <__kernel_rt_sigreturn+1b99/????>
   4:   3c 24                     cmp    $0x24,%al
Code;  ffffffdb <__kernel_rt_sigreturn+1b9b/????>
   6:   89 44 24 08               mov    %eax,0x8(%esp)
Code;  ffffffdf <__kernel_rt_sigreturn+1b9f/????>
   a:   e8 6b 43 00 00            call   437a <_EIP+0x437a>
Code;  ffffffe4 <__kernel_rt_sigreturn+1ba4/????>
   f:   89 3c 24                  mov    %edi,(%esp)
Code;  ffffffe7 <__kernel_rt_sigreturn+1ba7/????>
  12:   b9 20 00 00 00            mov    $0x20,%ecx
Code;  ffffffec <__kernel_rt_sigreturn+1bac/????>
  17:   89 4c 24 04               mov    %ecx,0x4(%esp)
Code;  fffffff0 <__kernel_rt_sigreturn+1bb0/????>
  1b:   e8 aa 45 00 00            call   45ca <_EIP+0x45ca>
Code;  fffffff5 <__kernel_rt_sigreturn+1bb5/????>
  20:   8b 46 14                  mov    0x14(%esi),%eax
Code;  fffffff8 <__kernel_rt_sigreturn+1bb8/????>
  23:   ba 2a 40 34 c0            mov    $0xc034402a,%edx
Code;  fffffffd <__kernel_rt_sigreturn+1bbd/????>
  28:   8b 40 20                  mov    0x20(%eax),%eax
Code;  00000000 Before first symbol
  2b:   8b 00                     mov    (%eax),%eax
Code;  00000002 Before first symbol
  2d:   89 54 24 08               mov    %edx,0x8(%esp)
Code;  00000006 Before first symbol
  31:   89 3c 24                  mov    %edi,(%esp)
Code;  00000009 Before first symbol
  34:   89 44 24 04               mov    %eax,0x4(%esp)
Code;  0000000d Before first symbol
  38:   e8 0d 42 00 00            call   424a <_EIP+0x424a>
Code;  00000012 Before first symbol
  3d:   8b 46 14                  mov    0x14(%esi),%eax

Jan 24 12:46:13 moustache kernel:  <1>Unable to handle kernel paging request at virtual address ccb1b320
Jan 24 12:46:13 moustache kernel: c0163b41
Jan 24 12:46:13 moustache kernel: *pde = 011ba067
Jan 24 12:46:13 moustache kernel: Oops: 0000 [#14]
Jan 24 12:46:13 moustache kernel: CPU:    0
Jan 24 12:46:13 moustache kernel: EIP:    0060:[__posix_lock_file+113/1600]    Not tainted VLI
Jan 24 12:46:13 moustache kernel: EFLAGS: 00010202   (2.6.10) 
Jan 24 12:46:13 moustache kernel: eax: ccb1b320   ebx: c03929e0   ecx: 000003a7   edx: c034402a
Jan 24 12:46:13 moustache kernel: esi: cbfe4800   edi: c79f90a0   ebp: 00000000   esp: c6dcff18
Jan 24 12:46:13 moustache kernel: ds: 007b   es: 007b   ss: 0068
Jan 24 12:46:13 moustache kernel: Stack: c79f90a0 00000020 c5c3af34 c034402a 00000000 c79f90a0 cbfe4800 00000395 
Jan 24 12:46:13 moustache kernel:        c01679a7 c79f90a0 cbfe4800 c6dcff4c 00000000 0000000f 00000000 0000000e 
Jan 24 12:46:13 moustache kernel:        00000000 00000000 c3bc39c0 c6dcffac 00000400 c0149fe8 c3bc39c0 b7fe8000 
Jan 24 12:46:13 moustache kernel: Call Trace:
Jan 24 12:46:13 moustache kernel: Code: 74 24 04 89 3c 24 89 44 24 08 e8 6b 43 00 00 89 3c 24 b9 20 00 00 00 89 4c 24 04 e8 aa 45 00 00 8b 46 14 ba 2a 40 34 c0 8b 40 20 <8b> 00 89 54 24 08 89 3c 24 89 44 24 04 e8 0d 42 00 00 8b 46 14 


>>eax; ccb1b320 <pg0+c681320/3fb64400>
>>ebx; c03929e0 <snd_ac97_ad198x_spdif_source+20/40>
>>edx; c034402a <tcp_collapse+9a/370>
>>esi; cbfe4800 <pg0+bb4a800/3fb64400>
>>edi; c79f90a0 <pg0+755f0a0/3fb64400>
>>esp; c6dcff18 <pg0+6935f18/3fb64400>

Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
   0:   74 24                     je     26 <_EIP+0x26>
Code;  ffffffd7 <__kernel_rt_sigreturn+1b97/????>
   2:   04 89                     add    $0x89,%al
Code;  ffffffd9 <__kernel_rt_sigreturn+1b99/????>
   4:   3c 24                     cmp    $0x24,%al
Code;  ffffffdb <__kernel_rt_sigreturn+1b9b/????>
   6:   89 44 24 08               mov    %eax,0x8(%esp)
Code;  ffffffdf <__kernel_rt_sigreturn+1b9f/????>
   a:   e8 6b 43 00 00            call   437a <_EIP+0x437a>
Code;  ffffffe4 <__kernel_rt_sigreturn+1ba4/????>
   f:   89 3c 24                  mov    %edi,(%esp)
Code;  ffffffe7 <__kernel_rt_sigreturn+1ba7/????>
  12:   b9 20 00 00 00            mov    $0x20,%ecx
Code;  ffffffec <__kernel_rt_sigreturn+1bac/????>
  17:   89 4c 24 04               mov    %ecx,0x4(%esp)
Code;  fffffff0 <__kernel_rt_sigreturn+1bb0/????>
  1b:   e8 aa 45 00 00            call   45ca <_EIP+0x45ca>
Code;  fffffff5 <__kernel_rt_sigreturn+1bb5/????>
  20:   8b 46 14                  mov    0x14(%esi),%eax
Code;  fffffff8 <__kernel_rt_sigreturn+1bb8/????>
  23:   ba 2a 40 34 c0            mov    $0xc034402a,%edx
Code;  fffffffd <__kernel_rt_sigreturn+1bbd/????>
  28:   8b 40 20                  mov    0x20(%eax),%eax
Code;  00000000 Before first symbol
  2b:   8b 00                     mov    (%eax),%eax
Code;  00000002 Before first symbol
  2d:   89 54 24 08               mov    %edx,0x8(%esp)
Code;  00000006 Before first symbol
  31:   89 3c 24                  mov    %edi,(%esp)
Code;  00000009 Before first symbol
  34:   89 44 24 04               mov    %eax,0x4(%esp)
Code;  0000000d Before first symbol
  38:   e8 0d 42 00 00            call   424a <_EIP+0x424a>
Code;  00000012 Before first symbol
  3d:   8b 46 14                  mov    0x14(%esi),%eax

Jan 24 12:46:32 moustache kernel: Unable to handle kernel paging request at virtual address ccb1b320
Jan 24 12:46:32 moustache kernel: c0163b41
Jan 24 12:46:32 moustache kernel: *pde = 011ba067
Jan 24 12:46:32 moustache kernel: Oops: 0000 [#15]
Jan 24 12:46:32 moustache kernel: CPU:    0
Jan 24 12:46:32 moustache kernel: EIP:    0060:[__posix_lock_file+113/1600]    Not tainted VLI
Jan 24 12:46:32 moustache kernel: EFLAGS: 00010202   (2.6.10) 
Jan 24 12:46:32 moustache kernel: eax: ccb1b320   ebx: c03929e0   ecx: 000003a7   edx: c034402a
Jan 24 12:46:32 moustache kernel: esi: cbfe4800   edi: c79f9260   ebp: 00000000   esp: c060bf18
Jan 24 12:46:32 moustache kernel: ds: 007b   es: 007b   ss: 0068
Jan 24 12:46:32 moustache kernel: Stack: c79f9260 00000020 c5c3af34 c034402a 00000000 c79f9260 cbfe4800 00000395 
Jan 24 12:46:32 moustache kernel:        c01679a7 c79f9260 cbfe4800 c060bf4c 00000000 0000000f 00000000 0000000e 
Jan 24 12:46:32 moustache kernel:        00000000 00000000 c3bc3c40 c060bfac 00000400 c0149fe8 c3bc3c40 b7fe8000 
Jan 24 12:46:32 moustache kernel: Call Trace:
Jan 24 12:46:32 moustache kernel: Code: 74 24 04 89 3c 24 89 44 24 08 e8 6b 43 00 00 89 3c 24 b9 20 00 00 00 89 4c 24 04 e8 aa 45 00 00 8b 46 14 ba 2a 40 34 c0 8b 40 20 <8b> 00 89 54 24 08 89 3c 24 89 44 24 04 e8 0d 42 00 00 8b 46 14 


>>eax; ccb1b320 <pg0+c681320/3fb64400>
>>ebx; c03929e0 <snd_ac97_ad198x_spdif_source+20/40>
>>edx; c034402a <tcp_collapse+9a/370>
>>esi; cbfe4800 <pg0+bb4a800/3fb64400>
>>edi; c79f9260 <pg0+755f260/3fb64400>
>>esp; c060bf18 <pg0+171f18/3fb64400>

Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
   0:   74 24                     je     26 <_EIP+0x26>
Code;  ffffffd7 <__kernel_rt_sigreturn+1b97/????>
   2:   04 89                     add    $0x89,%al
Code;  ffffffd9 <__kernel_rt_sigreturn+1b99/????>
   4:   3c 24                     cmp    $0x24,%al
Code;  ffffffdb <__kernel_rt_sigreturn+1b9b/????>
   6:   89 44 24 08               mov    %eax,0x8(%esp)
Code;  ffffffdf <__kernel_rt_sigreturn+1b9f/????>
   a:   e8 6b 43 00 00            call   437a <_EIP+0x437a>
Code;  ffffffe4 <__kernel_rt_sigreturn+1ba4/????>
   f:   89 3c 24                  mov    %edi,(%esp)
Code;  ffffffe7 <__kernel_rt_sigreturn+1ba7/????>
  12:   b9 20 00 00 00            mov    $0x20,%ecx
Code;  ffffffec <__kernel_rt_sigreturn+1bac/????>
  17:   89 4c 24 04               mov    %ecx,0x4(%esp)
Code;  fffffff0 <__kernel_rt_sigreturn+1bb0/????>
  1b:   e8 aa 45 00 00            call   45ca <_EIP+0x45ca>
Code;  fffffff5 <__kernel_rt_sigreturn+1bb5/????>
  20:   8b 46 14                  mov    0x14(%esi),%eax
Code;  fffffff8 <__kernel_rt_sigreturn+1bb8/????>
  23:   ba 2a 40 34 c0            mov    $0xc034402a,%edx
Code;  fffffffd <__kernel_rt_sigreturn+1bbd/????>
  28:   8b 40 20                  mov    0x20(%eax),%eax
Code;  00000000 Before first symbol
  2b:   8b 00                     mov    (%eax),%eax
Code;  00000002 Before first symbol
  2d:   89 54 24 08               mov    %edx,0x8(%esp)
Code;  00000006 Before first symbol
  31:   89 3c 24                  mov    %edi,(%esp)
Code;  00000009 Before first symbol
  34:   89 44 24 04               mov    %eax,0x4(%esp)
Code;  0000000d Before first symbol
  38:   e8 0d 42 00 00            call   424a <_EIP+0x424a>
Code;  00000012 Before first symbol
  3d:   8b 46 14                  mov    0x14(%esi),%eax

Jan 24 12:46:32 moustache kernel:  <1>Unable to handle kernel paging request at virtual address ccb1b320
Jan 24 12:46:32 moustache kernel: c0163b41
Jan 24 12:46:32 moustache kernel: *pde = 011ba067
Jan 24 12:46:32 moustache kernel: Oops: 0000 [#16]
Jan 24 12:46:32 moustache kernel: CPU:    0
Jan 24 12:46:32 moustache kernel: EIP:    0060:[__posix_lock_file+113/1600]    Not tainted VLI
Jan 24 12:46:32 moustache kernel: EFLAGS: 00010202   (2.6.10) 
Jan 24 12:46:32 moustache kernel: eax: ccb1b320   ebx: c03929e0   ecx: 000003a7   edx: c034402a
Jan 24 12:46:32 moustache kernel: esi: cbfe4800   edi: c851a960   ebp: 00000000   esp: c060bf18
Jan 24 12:46:32 moustache kernel: ds: 007b   es: 007b   ss: 0068
Jan 24 12:46:32 moustache kernel: Stack: c851a960 00000020 c5c3af34 c034402a 00000000 c851a960 cbfe4800 00000395 
Jan 24 12:46:32 moustache kernel:        c01679a7 c851a960 cbfe4800 c060bf4c 00000000 0000000f 00000000 0000000e 
Jan 24 12:46:32 moustache kernel:        00000000 00000000 c3bc3c40 c060bfac 00000400 c0149fe8 c3bc3c40 b7fe8000 
Jan 24 12:46:32 moustache kernel: Call Trace:
Jan 24 12:46:32 moustache kernel: Code: 74 24 04 89 3c 24 89 44 24 08 e8 6b 43 00 00 89 3c 24 b9 20 00 00 00 89 4c 24 04 e8 aa 45 00 00 8b 46 14 ba 2a 40 34 c0 8b 40 20 <8b> 00 89 54 24 08 89 3c 24 89 44 24 04 e8 0d 42 00 00 8b 46 14 


>>eax; ccb1b320 <pg0+c681320/3fb64400>
>>ebx; c03929e0 <snd_ac97_ad198x_spdif_source+20/40>
>>edx; c034402a <tcp_collapse+9a/370>
>>esi; cbfe4800 <pg0+bb4a800/3fb64400>
>>edi; c851a960 <pg0+8080960/3fb64400>
>>esp; c060bf18 <pg0+171f18/3fb64400>

Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
   0:   74 24                     je     26 <_EIP+0x26>
Code;  ffffffd7 <__kernel_rt_sigreturn+1b97/????>
   2:   04 89                     add    $0x89,%al
Code;  ffffffd9 <__kernel_rt_sigreturn+1b99/????>
   4:   3c 24                     cmp    $0x24,%al
Code;  ffffffdb <__kernel_rt_sigreturn+1b9b/????>
   6:   89 44 24 08               mov    %eax,0x8(%esp)
Code;  ffffffdf <__kernel_rt_sigreturn+1b9f/????>
   a:   e8 6b 43 00 00            call   437a <_EIP+0x437a>
Code;  ffffffe4 <__kernel_rt_sigreturn+1ba4/????>
   f:   89 3c 24                  mov    %edi,(%esp)
Code;  ffffffe7 <__kernel_rt_sigreturn+1ba7/????>
  12:   b9 20 00 00 00            mov    $0x20,%ecx
Code;  ffffffec <__kernel_rt_sigreturn+1bac/????>
  17:   89 4c 24 04               mov    %ecx,0x4(%esp)
Code;  fffffff0 <__kernel_rt_sigreturn+1bb0/????>
  1b:   e8 aa 45 00 00            call   45ca <_EIP+0x45ca>
Code;  fffffff5 <__kernel_rt_sigreturn+1bb5/????>
  20:   8b 46 14                  mov    0x14(%esi),%eax
Code;  fffffff8 <__kernel_rt_sigreturn+1bb8/????>
  23:   ba 2a 40 34 c0            mov    $0xc034402a,%edx
Code;  fffffffd <__kernel_rt_sigreturn+1bbd/????>
  28:   8b 40 20                  mov    0x20(%eax),%eax
Code;  00000000 Before first symbol
  2b:   8b 00                     mov    (%eax),%eax
Code;  00000002 Before first symbol
  2d:   89 54 24 08               mov    %edx,0x8(%esp)
Code;  00000006 Before first symbol
  31:   89 3c 24                  mov    %edi,(%esp)
Code;  00000009 Before first symbol
  34:   89 44 24 04               mov    %eax,0x4(%esp)
Code;  0000000d Before first symbol
  38:   e8 0d 42 00 00            call   424a <_EIP+0x424a>
Code;  00000012 Before first symbol
  3d:   8b 46 14                  mov    0x14(%esi),%eax

Jan 24 12:46:47 moustache kernel: Unable to handle kernel paging request at virtual address ccb1b320
Jan 24 12:46:47 moustache kernel: c0163b41
Jan 24 12:46:47 moustache kernel: *pde = 011ba067
Jan 24 12:46:47 moustache kernel: Oops: 0000 [#17]
Jan 24 12:46:47 moustache kernel: CPU:    0
Jan 24 12:46:47 moustache kernel: EIP:    0060:[__posix_lock_file+113/1600]    Not tainted VLI
Jan 24 12:46:47 moustache kernel: EFLAGS: 00010202   (2.6.10) 
Jan 24 12:46:47 moustache kernel: eax: ccb1b320   ebx: c03929e0   ecx: 000003a7   edx: c034402a
Jan 24 12:46:47 moustache kernel: esi: cbfe4800   edi: c79f9460   ebp: 00000000   esp: c0c79f18
Jan 24 12:46:47 moustache kernel: ds: 007b   es: 007b   ss: 0068
Jan 24 12:46:47 moustache kernel: Stack: c79f9460 00000020 c5c3af34 c034402a 00000000 c79f9460 cbfe4800 00000395 
Jan 24 12:46:47 moustache kernel:        c01679a7 c79f9460 cbfe4800 c0c79f4c 00000000 0000000f 00000000 0000000e 
Jan 24 12:46:47 moustache kernel:        00000000 00000000 c1efba60 c0c79fac 00000400 c0149fe8 c1efba60 b7fe8000 
Jan 24 12:46:47 moustache kernel: Call Trace:
Jan 24 12:46:47 moustache kernel: Code: 74 24 04 89 3c 24 89 44 24 08 e8 6b 43 00 00 89 3c 24 b9 20 00 00 00 89 4c 24 04 e8 aa 45 00 00 8b 46 14 ba 2a 40 34 c0 8b 40 20 <8b> 00 89 54 24 08 89 3c 24 89 44 24 04 e8 0d 42 00 00 8b 46 14 


>>eax; ccb1b320 <pg0+c681320/3fb64400>
>>ebx; c03929e0 <snd_ac97_ad198x_spdif_source+20/40>
>>edx; c034402a <tcp_collapse+9a/370>
>>esi; cbfe4800 <pg0+bb4a800/3fb64400>
>>edi; c79f9460 <pg0+755f460/3fb64400>
>>esp; c0c79f18 <pg0+7dff18/3fb64400>

Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
   0:   74 24                     je     26 <_EIP+0x26>
Code;  ffffffd7 <__kernel_rt_sigreturn+1b97/????>
   2:   04 89                     add    $0x89,%al
Code;  ffffffd9 <__kernel_rt_sigreturn+1b99/????>
   4:   3c 24                     cmp    $0x24,%al
Code;  ffffffdb <__kernel_rt_sigreturn+1b9b/????>
   6:   89 44 24 08               mov    %eax,0x8(%esp)
Code;  ffffffdf <__kernel_rt_sigreturn+1b9f/????>
   a:   e8 6b 43 00 00            call   437a <_EIP+0x437a>
Code;  ffffffe4 <__kernel_rt_sigreturn+1ba4/????>
   f:   89 3c 24                  mov    %edi,(%esp)
Code;  ffffffe7 <__kernel_rt_sigreturn+1ba7/????>
  12:   b9 20 00 00 00            mov    $0x20,%ecx
Code;  ffffffec <__kernel_rt_sigreturn+1bac/????>
  17:   89 4c 24 04               mov    %ecx,0x4(%esp)
Code;  fffffff0 <__kernel_rt_sigreturn+1bb0/????>
  1b:   e8 aa 45 00 00            call   45ca <_EIP+0x45ca>
Code;  fffffff5 <__kernel_rt_sigreturn+1bb5/????>
  20:   8b 46 14                  mov    0x14(%esi),%eax
Code;  fffffff8 <__kernel_rt_sigreturn+1bb8/????>
  23:   ba 2a 40 34 c0            mov    $0xc034402a,%edx
Code;  fffffffd <__kernel_rt_sigreturn+1bbd/????>
  28:   8b 40 20                  mov    0x20(%eax),%eax
Code;  00000000 Before first symbol
  2b:   8b 00                     mov    (%eax),%eax
Code;  00000002 Before first symbol
  2d:   89 54 24 08               mov    %edx,0x8(%esp)
Code;  00000006 Before first symbol
  31:   89 3c 24                  mov    %edi,(%esp)
Code;  00000009 Before first symbol
  34:   89 44 24 04               mov    %eax,0x4(%esp)
Code;  0000000d Before first symbol
  38:   e8 0d 42 00 00            call   424a <_EIP+0x424a>
Code;  00000012 Before first symbol
  3d:   8b 46 14                  mov    0x14(%esi),%eax

Jan 24 12:46:47 moustache kernel:  <1>Unable to handle kernel paging request at virtual address ccb1b320
Jan 24 12:46:47 moustache kernel: c0163b41
Jan 24 12:46:47 moustache kernel: *pde = 011ba067
Jan 24 12:46:47 moustache kernel: Oops: 0000 [#18]
Jan 24 12:46:47 moustache kernel: CPU:    0
Jan 24 12:46:47 moustache kernel: EIP:    0060:[__posix_lock_file+113/1600]    Not tainted VLI
Jan 24 12:46:47 moustache kernel: EFLAGS: 00010202   (2.6.10) 
Jan 24 12:46:47 moustache kernel: eax: ccb1b320   ebx: c03929e0   ecx: 000003a7   edx: c034402a
Jan 24 12:46:47 moustache kernel: esi: cbfe4800   edi: c79f9460   ebp: 00000000   esp: c1e2bf18
Jan 24 12:46:47 moustache kernel: ds: 007b   es: 007b   ss: 0068
Jan 24 12:46:47 moustache kernel: Stack: c79f9460 00000020 c5c3af34 c034402a 00000000 c79f9460 cbfe4800 00000395 
Jan 24 12:46:47 moustache kernel:        c01679a7 c79f9460 cbfe4800 c1e2bf4c 00000000 0000000f 00000000 0000000e 
Jan 24 12:46:47 moustache kernel:        00000000 00000000 c5e89060 c1e2bfac 00000400 c0149fe8 c5e89060 b7fe8000 
Jan 24 12:46:47 moustache kernel: Call Trace:
Jan 24 12:46:47 moustache kernel: Code: 74 24 04 89 3c 24 89 44 24 08 e8 6b 43 00 00 89 3c 24 b9 20 00 00 00 89 4c 24 04 e8 aa 45 00 00 8b 46 14 ba 2a 40 34 c0 8b 40 20 <8b> 00 89 54 24 08 89 3c 24 89 44 24 04 e8 0d 42 00 00 8b 46 14 


>>eax; ccb1b320 <pg0+c681320/3fb64400>
>>ebx; c03929e0 <snd_ac97_ad198x_spdif_source+20/40>
>>edx; c034402a <tcp_collapse+9a/370>
>>esi; cbfe4800 <pg0+bb4a800/3fb64400>
>>edi; c79f9460 <pg0+755f460/3fb64400>
>>esp; c1e2bf18 <pg0+1991f18/3fb64400>

Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
   0:   74 24                     je     26 <_EIP+0x26>
Code;  ffffffd7 <__kernel_rt_sigreturn+1b97/????>
   2:   04 89                     add    $0x89,%al
Code;  ffffffd9 <__kernel_rt_sigreturn+1b99/????>
   4:   3c 24                     cmp    $0x24,%al
Code;  ffffffdb <__kernel_rt_sigreturn+1b9b/????>
   6:   89 44 24 08               mov    %eax,0x8(%esp)
Code;  ffffffdf <__kernel_rt_sigreturn+1b9f/????>
   a:   e8 6b 43 00 00            call   437a <_EIP+0x437a>
Code;  ffffffe4 <__kernel_rt_sigreturn+1ba4/????>
   f:   89 3c 24                  mov    %edi,(%esp)
Code;  ffffffe7 <__kernel_rt_sigreturn+1ba7/????>
  12:   b9 20 00 00 00            mov    $0x20,%ecx
Code;  ffffffec <__kernel_rt_sigreturn+1bac/????>
  17:   89 4c 24 04               mov    %ecx,0x4(%esp)
Code;  fffffff0 <__kernel_rt_sigreturn+1bb0/????>
  1b:   e8 aa 45 00 00            call   45ca <_EIP+0x45ca>
Code;  fffffff5 <__kernel_rt_sigreturn+1bb5/????>
  20:   8b 46 14                  mov    0x14(%esi),%eax
Code;  fffffff8 <__kernel_rt_sigreturn+1bb8/????>
  23:   ba 2a 40 34 c0            mov    $0xc034402a,%edx
Code;  fffffffd <__kernel_rt_sigreturn+1bbd/????>
  28:   8b 40 20                  mov    0x20(%eax),%eax
Code;  00000000 Before first symbol
  2b:   8b 00                     mov    (%eax),%eax
Code;  00000002 Before first symbol
  2d:   89 54 24 08               mov    %edx,0x8(%esp)
Code;  00000006 Before first symbol
  31:   89 3c 24                  mov    %edi,(%esp)
Code;  00000009 Before first symbol
  34:   89 44 24 04               mov    %eax,0x4(%esp)
Code;  0000000d Before first symbol
  38:   e8 0d 42 00 00            call   424a <_EIP+0x424a>
Code;  00000012 Before first symbol
  3d:   8b 46 14                  mov    0x14(%esi),%eax

Jan 24 12:48:21 moustache kernel: Unable to handle kernel paging request at virtual address ccb1b320
Jan 24 12:48:21 moustache kernel: c0163b41
Jan 24 12:48:21 moustache kernel: *pde = 011ba067
Jan 24 12:48:21 moustache kernel: Oops: 0000 [#19]
Jan 24 12:48:21 moustache kernel: CPU:    0
Jan 24 12:48:21 moustache kernel: EIP:    0060:[__posix_lock_file+113/1600]    Not tainted VLI
Jan 24 12:48:21 moustache kernel: EFLAGS: 00010202   (2.6.10) 
Jan 24 12:48:21 moustache kernel: eax: ccb1b320   ebx: c03929e0   ecx: 000003a7   edx: c034402a
Jan 24 12:48:21 moustache kernel: esi: cbfe4800   edi: c79f9260   ebp: 00000000   esp: c8acbf18
Jan 24 12:48:21 moustache kernel: ds: 007b   es: 007b   ss: 0068
Jan 24 12:48:21 moustache kernel: Stack: c79f9260 00000020 c5c3af34 c034402a 00000000 c79f9260 cbfe4800 00000395 
Jan 24 12:48:21 moustache kernel:        c01679a7 c79f9260 cbfe4800 c8acbf4c 00000000 0000000f 00000000 0000000e 
Jan 24 12:48:21 moustache kernel:        00000000 00000000 c004c740 c8acbfac 00000400 c0149fe8 c004c740 b7fe8000 
Jan 24 12:48:21 moustache kernel: Call Trace:
Jan 24 12:48:21 moustache kernel: Code: 74 24 04 89 3c 24 89 44 24 08 e8 6b 43 00 00 89 3c 24 b9 20 00 00 00 89 4c 24 04 e8 aa 45 00 00 8b 46 14 ba 2a 40 34 c0 8b 40 20 <8b> 00 89 54 24 08 89 3c 24 89 44 24 04 e8 0d 42 00 00 8b 46 14 


>>eax; ccb1b320 <pg0+c681320/3fb64400>
>>ebx; c03929e0 <snd_ac97_ad198x_spdif_source+20/40>
>>edx; c034402a <tcp_collapse+9a/370>
>>esi; cbfe4800 <pg0+bb4a800/3fb64400>
>>edi; c79f9260 <pg0+755f260/3fb64400>
>>esp; c8acbf18 <pg0+8631f18/3fb64400>

Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
   0:   74 24                     je     26 <_EIP+0x26>
Code;  ffffffd7 <__kernel_rt_sigreturn+1b97/????>
   2:   04 89                     add    $0x89,%al
Code;  ffffffd9 <__kernel_rt_sigreturn+1b99/????>
   4:   3c 24                     cmp    $0x24,%al
Code;  ffffffdb <__kernel_rt_sigreturn+1b9b/????>
   6:   89 44 24 08               mov    %eax,0x8(%esp)
Code;  ffffffdf <__kernel_rt_sigreturn+1b9f/????>
   a:   e8 6b 43 00 00            call   437a <_EIP+0x437a>
Code;  ffffffe4 <__kernel_rt_sigreturn+1ba4/????>
   f:   89 3c 24                  mov    %edi,(%esp)
Code;  ffffffe7 <__kernel_rt_sigreturn+1ba7/????>
  12:   b9 20 00 00 00            mov    $0x20,%ecx
Code;  ffffffec <__kernel_rt_sigreturn+1bac/????>
  17:   89 4c 24 04               mov    %ecx,0x4(%esp)
Code;  fffffff0 <__kernel_rt_sigreturn+1bb0/????>
  1b:   e8 aa 45 00 00            call   45ca <_EIP+0x45ca>
Code;  fffffff5 <__kernel_rt_sigreturn+1bb5/????>
  20:   8b 46 14                  mov    0x14(%esi),%eax
Code;  fffffff8 <__kernel_rt_sigreturn+1bb8/????>
  23:   ba 2a 40 34 c0            mov    $0xc034402a,%edx
Code;  fffffffd <__kernel_rt_sigreturn+1bbd/????>
  28:   8b 40 20                  mov    0x20(%eax),%eax
Code;  00000000 Before first symbol
  2b:   8b 00                     mov    (%eax),%eax
Code;  00000002 Before first symbol
  2d:   89 54 24 08               mov    %edx,0x8(%esp)
Code;  00000006 Before first symbol
  31:   89 3c 24                  mov    %edi,(%esp)
Code;  00000009 Before first symbol
  34:   89 44 24 04               mov    %eax,0x4(%esp)
Code;  0000000d Before first symbol
  38:   e8 0d 42 00 00            call   424a <_EIP+0x424a>
Code;  00000012 Before first symbol
  3d:   8b 46 14                  mov    0x14(%esi),%eax

Jan 24 12:48:21 moustache kernel:  <1>Unable to handle kernel paging request at virtual address ccb1b320
Jan 24 12:48:21 moustache kernel: c0163b41
Jan 24 12:48:21 moustache kernel: *pde = 011ba067
Jan 24 12:48:21 moustache kernel: Oops: 0000 [#20]
Jan 24 12:48:21 moustache kernel: CPU:    0
Jan 24 12:48:21 moustache kernel: EIP:    0060:[__posix_lock_file+113/1600]    Not tainted VLI
Jan 24 12:48:21 moustache kernel: EFLAGS: 00010202   (2.6.10) 
Jan 24 12:48:21 moustache kernel: eax: ccb1b320   ebx: c03929e0   ecx: 000003a7   edx: c034402a
Jan 24 12:48:21 moustache kernel: esi: cbfe4800   edi: c851a960   ebp: 00000000   esp: c0789f18
Jan 24 12:48:21 moustache kernel: ds: 007b   es: 007b   ss: 0068
Jan 24 12:48:21 moustache kernel: Stack: c851a960 00000020 c5c3af34 c034402a 00000000 c851a960 cbfe4800 00000395 
Jan 24 12:48:21 moustache kernel:        c01679a7 c851a960 cbfe4800 c0789f4c 00000000 0000000f 00000000 0000000e 
Jan 24 12:48:21 moustache kernel:        00000000 00000000 c23972e0 c0789fac 00000400 c0149fe8 c23972e0 b7fe8000 
Jan 24 12:48:21 moustache kernel: Call Trace:
Jan 24 12:48:21 moustache kernel: Code: 74 24 04 89 3c 24 89 44 24 08 e8 6b 43 00 00 89 3c 24 b9 20 00 00 00 89 4c 24 04 e8 aa 45 00 00 8b 46 14 ba 2a 40 34 c0 8b 40 20 <8b> 00 89 54 24 08 89 3c 24 89 44 24 04 e8 0d 42 00 00 8b 46 14 


>>eax; ccb1b320 <pg0+c681320/3fb64400>
>>ebx; c03929e0 <snd_ac97_ad198x_spdif_source+20/40>
>>edx; c034402a <tcp_collapse+9a/370>
>>esi; cbfe4800 <pg0+bb4a800/3fb64400>
>>edi; c851a960 <pg0+8080960/3fb64400>
>>esp; c0789f18 <pg0+2eff18/3fb64400>

Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
   0:   74 24                     je     26 <_EIP+0x26>
Code;  ffffffd7 <__kernel_rt_sigreturn+1b97/????>
   2:   04 89                     add    $0x89,%al
Code;  ffffffd9 <__kernel_rt_sigreturn+1b99/????>
   4:   3c 24                     cmp    $0x24,%al
Code;  ffffffdb <__kernel_rt_sigreturn+1b9b/????>
   6:   89 44 24 08               mov    %eax,0x8(%esp)
Code;  ffffffdf <__kernel_rt_sigreturn+1b9f/????>
   a:   e8 6b 43 00 00            call   437a <_EIP+0x437a>
Code;  ffffffe4 <__kernel_rt_sigreturn+1ba4/????>
   f:   89 3c 24                  mov    %edi,(%esp)
Code;  ffffffe7 <__kernel_rt_sigreturn+1ba7/????>
  12:   b9 20 00 00 00            mov    $0x20,%ecx
Code;  ffffffec <__kernel_rt_sigreturn+1bac/????>
  17:   89 4c 24 04               mov    %ecx,0x4(%esp)
Code;  fffffff0 <__kernel_rt_sigreturn+1bb0/????>
  1b:   e8 aa 45 00 00            call   45ca <_EIP+0x45ca>
Code;  fffffff5 <__kernel_rt_sigreturn+1bb5/????>
  20:   8b 46 14                  mov    0x14(%esi),%eax
Code;  fffffff8 <__kernel_rt_sigreturn+1bb8/????>
  23:   ba 2a 40 34 c0            mov    $0xc034402a,%edx
Code;  fffffffd <__kernel_rt_sigreturn+1bbd/????>
  28:   8b 40 20                  mov    0x20(%eax),%eax
Code;  00000000 Before first symbol
  2b:   8b 00                     mov    (%eax),%eax
Code;  00000002 Before first symbol
  2d:   89 54 24 08               mov    %edx,0x8(%esp)
Code;  00000006 Before first symbol
  31:   89 3c 24                  mov    %edi,(%esp)
Code;  00000009 Before first symbol
  34:   89 44 24 04               mov    %eax,0x4(%esp)
Code;  0000000d Before first symbol
  38:   e8 0d 42 00 00            call   424a <_EIP+0x424a>
Code;  00000012 Before first symbol
  3d:   8b 46 14                  mov    0x14(%esi),%eax

Jan 24 14:20:20 moustache kernel: Unable to handle kernel paging request at virtual address ccb1b2a8
Jan 24 14:20:20 moustache kernel: c01501a3
Jan 24 14:20:20 moustache kernel: *pde = 011ba067
Jan 24 14:20:20 moustache kernel: Oops: 0000 [#21]
Jan 24 14:20:20 moustache kernel: CPU:    0
Jan 24 14:20:20 moustache kernel: EIP:    0060:[buffer_io_error+35/80]    Not tainted VLI
Jan 24 14:20:20 moustache kernel: EFLAGS: 00010216   (2.6.10) 
Jan 24 14:20:20 moustache kernel: eax: ccb1b280   ebx: c0dd4800   ecx: 00000000   edx: cbcdf000
Jan 24 14:20:20 moustache kernel: esi: 00000000   edi: bffffaa4   ebp: c9ce0000   esp: c9ce1f9c
Jan 24 14:20:20 moustache kernel: ds: 007b   es: 007b   ss: 0068
Jan 24 14:20:20 moustache kernel: Stack: cbcdf000 c0150162 00000001 0804c4c0 c014b694 00000000 00000001 c014b6ef 
Jan 24 14:20:20 moustache kernel:        00000001 c0102ed3 00000001 ffffffe0 00000002 0804c4c0 bffffaa4 bffff8c8 
Jan 24 14:20:20 moustache kernel:        00000024 0000007b 0000007b 00000024 b7f7d777 00000073 00000246 bffff60c 
Jan 24 14:20:20 moustache kernel: Call Trace:
Jan 24 14:20:20 moustache kernel: Code: 14 ff 0d 9c 21 39 c0 0f 88 b2 0a 00 00 8b 1d 94 21 39 c0 81 fb 94 21 39 c0 74 4e 8d b6 00 00 00 00 8d bc 27 00 00 00 00 8b 43 24 <8b> 40 28 85 c0 0f 85 92 00 00 00 8b 1b 81 fb 94 21 39 c0 75 e8 


>>eax; ccb1b280 <pg0+c681280/3fb64400>
>>ebx; c0dd4800 <pg0+93a800/3fb64400>
>>edx; cbcdf000 <pg0+b845000/3fb64400>
>>ebp; c9ce0000 <pg0+9846000/3fb64400>
>>esp; c9ce1f9c <pg0+9847f9c/3fb64400>

Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
00000000 <_EIP>:
Code;  ffffffd5 <__kernel_rt_sigreturn+1b95/????>
   0:   14 ff                     adc    $0xff,%al
Code;  ffffffd7 <__kernel_rt_sigreturn+1b97/????>
   2:   0d 9c 21 39 c0            or     $0xc039219c,%eax
Code;  ffffffdc <__kernel_rt_sigreturn+1b9c/????>
   7:   0f 88 b2 0a 00 00         js     abf <_EIP+0xabf>
Code;  ffffffe2 <__kernel_rt_sigreturn+1ba2/????>
   d:   8b 1d 94 21 39 c0         mov    0xc0392194,%ebx
Code;  ffffffe8 <__kernel_rt_sigreturn+1ba8/????>
  13:   81 fb 94 21 39 c0         cmp    $0xc0392194,%ebx
Code;  ffffffee <__kernel_rt_sigreturn+1bae/????>
  19:   74 4e                     je     69 <_EIP+0x69>
Code;  fffffff0 <__kernel_rt_sigreturn+1bb0/????>
  1b:   8d b6 00 00 00 00         lea    0x0(%esi),%esi
Code;  fffffff6 <__kernel_rt_sigreturn+1bb6/????>
  21:   8d bc 27 00 00 00 00      lea    0x0(%edi),%edi
Code;  fffffffd <__kernel_rt_sigreturn+1bbd/????>
  28:   8b 43 24                  mov    0x24(%ebx),%eax
Code;  00000000 Before first symbol
  2b:   8b 40 28                  mov    0x28(%eax),%eax
Code;  00000003 Before first symbol
  2e:   85 c0                     test   %eax,%eax
Code;  00000005 Before first symbol
  30:   0f 85 92 00 00 00         jne    c8 <_EIP+0xc8>
Code;  0000000b Before first symbol
  36:   8b 1b                     mov    (%ebx),%ebx
Code;  0000000d Before first symbol
  38:   81 fb 94 21 39 c0         cmp    $0xc0392194,%ebx
Code;  00000013 Before first symbol
  3e:   75 e8                     jne    28 <_EIP+0x28>


1 warning and 1 error issued.  Results may not be reliable.

--------------070903030003060903040308--
