Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263562AbTJVUkh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 16:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263570AbTJVUkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 16:40:37 -0400
Received: from platypus.jpl.nasa.gov ([128.149.23.35]:10150 "EHLO
	platypus.jpl.nasa.gov") by vger.kernel.org with ESMTP
	id S263562AbTJVUkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 16:40:21 -0400
From: Katherine Nakazono <katherine.nakazono@jpl.nasa.gov>
Organization: Jet Propulsion Laboratory
To: linux-kernel@vger.kernel.org
Subject: Need help interpreting Kernel oops
Date: Wed, 22 Oct 2003 13:39:23 -0700
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_NPE6RD9VA4MNO30VYZ1K"
Message-Id: <200310221339.23671.katherine.nakazono@jpl.nasa.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_NPE6RD9VA4MNO30VYZ1K
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

To whom it may concern,

I'm trying to resolve an intermittent problem and so far the log only has=
=20
these oops.  If it is a problem with the kernel, then it may be something=
=20
easy to fix.  If not, it may be a hardware problem.

Thanks in advance.

Katherine
--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Opinions expressed herein are my own and do not represent the opinion or
policy of JPL or any other organization or individual.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Katherine Nakazono                      katherine.nakazono@jpl.nasa.gov
System Administrator                    Phone: (818) 354-3565
Navigation and Mission Design Section   Fax:  (818) 393-6388
Jet Propulsion Laboratory               Pgr: 1-800-759-8888 PIN#2125009
4800 Oak Grove Drive    M/S 301-276     Pasadena, CA 91109-8001
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--------------Boundary-00=_NPE6RD9VA4MNO30VYZ1K
Content-Type: text/plain;
  charset="us-ascii";
  name="palantir.ksymoops"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="palantir.ksymoops"

[root@palantir /adm]# /usr/bin/ksymoops < palantir.oops
ksymoops 2.4.9 on i686 2.4.9-21.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.9-21/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_system_map stat /usr/src/linux/System.map fail=
ed
/usr/bin/ksymoops: No such file or directory
Oct 20 21:00:39 palantir kernel: Unable to handle kernel paging request a=
t virtual address c8a284e8
Oct 20 21:00:39 palantir kernel: c01271d8
Oct 20 21:00:39 palantir kernel: *pde =3D 088001e3
Oct 20 21:00:39 palantir kernel: Oops: 0000
Oct 20 21:00:39 palantir kernel: EIP: =C2=A0 =C2=A00010:[exit_mmap+136/28=
8] =C2=A0 =C2=A0Not tainted
Oct 20 21:00:39 palantir kernel: EIP: =C2=A0 =C2=A00010:[<c01271d8>] =C2=A0=
 =C2=A0Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Oct 20 21:00:39 palantir kernel: EFLAGS: 00010246
Oct 20 21:00:39 palantir kernel: eax: c8a284e0 =C2=A0 ebx: c51a48a0 =C2=A0=
 ecx: c51a4000 =C2=A0 edx: c51a48a0
Warning (Oops_set_regs): garbage '=C2=A0 ebx: c51a48a0 =C2=A0 ecx: c51a40=
00 =C2=A0 edx: c51a48a0' at end of register line ignored
Oct 20 21:00:39 palantir kernel: esi: 0000c000 =C2=A0 edi: d5f90c80 =C2=A0=
 ebp: 4084e000 =C2=A0 esp: c6f69eac
Warning (Oops_set_regs): garbage '=C2=A0 edi: d5f90c80 =C2=A0 ebp: 4084e0=
00 =C2=A0 esp: c6f69eac' at end of register line ignored
Oct 20 21:00:39 palantir kernel: ds: 0018 =C2=A0 es: 0018 =C2=A0 ss: 0018
Oct 20 21:00:39 palantir kernel: Process nethack (pid: 8402, stackpage=3D=
c6f69000)
Oct 20 21:00:39 palantir kernel: Stack: c51a4460 0000000b c011fc9d c1c863=
d0 00000020 d5f90c80 c6f68000 0000000b
Oct 20 21:00:39 palantir kernel: Call Trace: [send_signal+45/240] send_si=
gnal [kernel] 0x2d
Oct 20 21:00:39 palantir kernel: Call Trace: [<c011fc9d>] send_signal [ke=
rnel] 0x2d
Oct 20 21:00:39 palantir kernel: [<c01163f4>] mmput [kernel] 0x54
Oct 20 21:00:39 palantir kernel: [<c011a443>] do_exit [kernel] 0xb3
Oct 20 21:00:39 palantir kernel: [<c011f9fd>] dequeue_signal [kernel] 0x6=
d
Oct 20 21:00:39 palantir kernel: [<c0106de4>] do_signal [kernel] 0x234
Oct 20 21:00:39 palantir kernel: [<c01bbc18>] sock_read [kernel] 0x88
Oct 20 21:00:39 palantir kernel: [<c0144902>] sys_select [kernel] 0x472
Oct 20 21:00:39 palantir kernel: [<c01bbeae>] sock_ioctl [kernel] 0x1e
Oct 20 21:00:39 palantir kernel: [<c0143a13>] sys_ioctl [kernel] 0x223
Oct 20 21:00:39 palantir kernel: [<c0114480>] do_page_fault [kernel] 0x0
Oct 20 21:00:39 palantir kernel: [<c0106f7c>] signal_return [kernel] 0x14
Oct 20 21:00:39 palantir kernel: Code: 8b 40 08 74 06 ff 80 18 01 00 00 8=
b 53 24 85 d2 74 09 8b 43


>>EIP; c01271d8 <do_brk+278/6d0>   <=3D=3D=3D=3D=3D

>>eax; c8a284e0 <___strtok+86c63cc/204dfeec>

Trace; c011fc9d <dequeue_signal+30d/430>
Trace; c01163f4 <remove_wait_queue+284/900>
Trace; c011a443 <exit_mm+343/480>
Trace; c011f9fd <dequeue_signal+6d/430>
Trace; c0106de4 <sys_sigaltstack+c64/2130>
Trace; c01bbc18 <sock_recvmsg+148/680>
Trace; c0144902 <sys_select+472/600>
Trace; c01bbeae <sock_recvmsg+3de/680>
Trace; c0143a13 <sys_ioctl+223/230>
Trace; c0114480 <do_BUG+d0/780>
Trace; c0106f7c <sys_sigaltstack+dfc/2130>

Code;  c01271d8 <do_brk+278/6d0>
00000000 <_EIP>:
Code;  c01271d8 <do_brk+278/6d0>   <=3D=3D=3D=3D=3D
   0:   8b 40 08                  mov    0x8(%eax),%eax   <=3D=3D=3D=3D=3D
Code;  c01271db <do_brk+27b/6d0>
   3:   74 06                     je     b <_EIP+0xb> c01271e3 <do_brk+28=
3/6d0>
Code;  c01271dd <do_brk+27d/6d0>
   5:   ff 80 18 01 00 00         incl   0x118(%eax)
Code;  c01271e3 <do_brk+283/6d0>
   b:   8b 53 24                  mov    0x24(%ebx),%edx
Code;  c01271e6 <do_brk+286/6d0>
   e:   85 d2                     test   %edx,%edx
Code;  c01271e8 <do_brk+288/6d0>
  10:   74 09                     je     1b <_EIP+0x1b> c01271f3 <do_brk+=
293/6d0>
Code;  c01271ea <do_brk+28a/6d0>
  12:   8b 43 00                  mov    0x0(%ebx),%eax

Oct 20 21:00:39 palantir kernel: =C2=A0<1>Unable to handle kernel paging =
request at virtual address c905a004
Oct 20 21:00:39 palantir kernel: c012d2b3
Oct 20 21:00:39 palantir kernel: *pde =3D 090001e3
Oct 20 21:00:39 palantir kernel: Oops: 0002
Oct 20 21:00:39 palantir kernel: EIP: =C2=A0 =C2=A00010:[kmem_cache_free+=
115/176] =C2=A0 =C2=A0Not tainted
Oct 20 21:00:39 palantir kernel: EIP: =C2=A0 =C2=A00010:[<c012d2b3>] =C2=A0=
 =C2=A0Not tainted
Oct 20 21:00:39 palantir kernel: EFLAGS: 00010046
Oct 20 21:00:39 palantir kernel: eax: c905a000 =C2=A0 ebx: 00000007 =C2=A0=
 ecx: dcc62000 =C2=A0 edx: c1c861a8
Warning (Oops_set_regs): garbage '=C2=A0 ebx: 00000007 =C2=A0 ecx: dcc620=
00 =C2=A0 edx: c1c861a8' at end of register line ignored
Oct 20 21:00:39 palantir kernel: esi: c1c861a0 =C2=A0 edi: 00000286 =C2=A0=
 ebp: 00000c40 =C2=A0 esp: c6f69cb4
Warning (Oops_set_regs): garbage '=C2=A0 edi: 00000286 =C2=A0 ebp: 00000c=
40 =C2=A0 esp: c6f69cb4' at end of register line ignored
Oct 20 21:00:39 palantir kernel: ds: 0018 =C2=A0 es: 0018 =C2=A0 ss: 0018
Oct 20 21:00:39 palantir kernel: Process nethack (pid: 8402, stackpage=3D=
c6f69000)
Oct 20 21:00:39 palantir kernel: Stack: c01fa29a dcc62c80 00000000 dcc62c=
80 c2a8fd20 c014881a c1c861a0 dcc62c80
Oct 20 21:00:39 palantir kernel: Call Trace: [unix_release_sock+202/464] =
unix_release_sock [kernel] 0xca
Oct 20 21:00:39 palantir kernel: Call Trace: [<c01fa29a>] unix_release_so=
ck [kernel] 0xca
Oct 20 21:00:39 palantir kernel: [<c014881a>] destroy_inode [kernel] 0x2a
Oct 20 21:00:39 palantir kernel: [<c014a002>] iput_free [kernel] 0x1c2
Oct 20 21:00:39 palantir kernel: [<c01fa5bf>] unix_release [kernel] 0x1f
Oct 20 21:00:39 palantir kernel: [<c01477c6>] dput [kernel] 0xf6
Oct 20 21:00:39 palantir kernel: [<c0137224>] fput [kernel] 0x74
Oct 20 21:00:39 palantir kernel: [<c0136233>] filp_close [kernel] 0x53
Oct 20 21:00:39 palantir kernel: [<c0119e5c>] put_files_struct [kernel] 0=
x4c
Oct 20 21:00:39 palantir kernel: [<c011a461>] do_exit [kernel] 0xd1
Oct 20 21:00:39 palantir kernel: [<c022d63e>] .rodata.str1.1 [kernel] 0x1=
b39
Oct 20 21:00:40 palantir kernel: [<c011439e>] bust_spinlocks [kernel] 0x3=
e
Oct 20 21:00:40 palantir kernel: [<c0230ec0>] .rodata.str1.1 [kernel] 0x5=
3bb
Oct 20 21:00:40 palantir kernel: [<c0107497>] die [kernel] 0x47
Oct 20 21:00:40 palantir kernel: [<c023166d>] .rodata.str1.1 [kernel] 0x5=
b68
Oct 20 21:00:40 palantir kernel: [<c022c0f2>] .rodata.str1.1 [kernel] 0x5=
ed
Oct 20 21:00:40 palantir kernel: [<c022d63e>] .rodata.str1.1 [kernel] 0x1=
b39
Oct 20 21:00:40 palantir kernel: [<c01271d8>] exit_mmap [kernel] 0x88
Oct 20 21:00:40 palantir kernel: [<c0216780>] IRQ0x0f_interrupt [kernel] =
0x4400
Oct 20 21:00:40 palantir kernel: [<c01147f7>] do_page_fault [kernel] 0x37=
7
Oct 20 21:00:40 palantir kernel: [<c0130a25>] free_page_and_swap_cache [k=
ernel] 0xc5
Oct 20 21:00:40 palantir kernel: [<c01fb8d8>] unix_stream_sendmsg [kernel=
] 0x228
Oct 20 21:00:40 palantir kernel: [<c01249b6>] zap_page_range [kernel] 0x1=
e6
Oct 20 21:00:40 palantir kernel: [<c0114480>] do_page_fault [kernel] 0x0
Oct 20 21:00:40 palantir kernel: [<c0107038>] error_code [kernel] 0x38
Oct 20 21:00:40 palantir kernel: [<c01271d8>] exit_mmap [kernel] 0x88
Oct 20 21:00:40 palantir kernel: [<c011fc9d>] send_signal [kernel] 0x2d
Oct 20 21:00:40 palantir kernel: [<c01163f4>] mmput [kernel] 0x54
Oct 20 21:00:40 palantir kernel: [<c011a443>] do_exit [kernel] 0xb3
Oct 20 21:00:40 palantir kernel: [<c011f9fd>] dequeue_signal [kernel] 0x6=
d
Oct 20 21:00:40 palantir kernel: [<c0106de4>] do_signal [kernel] 0x234
Oct 20 21:00:40 palantir kernel: [<c01bbc18>] sock_read [kernel] 0x88
Oct 20 21:00:40 palantir kernel: [<c0144902>] sys_select [kernel] 0x472
Oct 20 21:00:40 palantir kernel: [<c01bbeae>] sock_ioctl [kernel] 0x1e
Oct 20 21:00:40 palantir kernel: [<c0143a13>] sys_ioctl [kernel] 0x223
Oct 20 21:00:40 palantir kernel: [<c0114480>] do_page_fault [kernel] 0x0
Oct 20 21:00:40 palantir kernel: [<c0106f7c>] signal_return [kernel] 0x14
Oct 20 21:00:40 palantir kernel: Code: 89 48 04 89 01 89 51 04 89 4e 08 e=
b 28 8b 51 04 8b 01 89 50


>>EIP; c012d2b3 <kmem_cache_free+73/b0>   <=3D=3D=3D=3D=3D

>>eax; c905a000 <___strtok+8cf7eec/204dfeec>
>>esi; c1c861a0 <___strtok+192408c/204dfeec>

Trace; c01fa29a <ip_rt_ioctl+70ba/9cc0>
Trace; c014881a <flush_dentry_attributes+ba/1b0>
Trace; c014a002 <iput+3a2/3b0>
Trace; c01fa5bf <ip_rt_ioctl+73df/9cc0>
Trace; c01477c6 <dput+f6/160>
Trace; c0137224 <fput+74/d0>
Trace; c0136233 <filp_close+53/60>
Trace; c0119e5c <try_inc_mod_count+140c/1490>
Trace; c011a461 <exit_mm+361/480>
Trace; c022d63e <fb_con+1dd1e/a00c0>
Trace; c011439e <__verify_write+18e/1a0>
Trace; c0230ec0 <fb_con+215a0/a00c0>
Trace; c0107497 <sys_sigaltstack+1317/2130>
Trace; c023166d <fb_con+21d4d/a00c0>
Trace; c022c0f2 <fb_con+1c7d2/a00c0>
Trace; c022d63e <fb_con+1dd1e/a00c0>
Trace; c01271d8 <do_brk+278/6d0>
Trace; c0216780 <fb_con+6e60/a00c0>
Trace; c01147f7 <do_BUG+447/780>
Trace; c0130a25 <nr_free_pages+655/2020>
Trace; c01fb8d8 <ip_rt_ioctl+86f8/9cc0>
Trace; c01249b6 <pm_find+ab6/c20>
Trace; c0114480 <do_BUG+d0/780>
Trace; c0107038 <sys_sigaltstack+eb8/2130>
Trace; c01271d8 <do_brk+278/6d0>
Trace; c011fc9d <dequeue_signal+30d/430>
Trace; c01163f4 <remove_wait_queue+284/900>
Trace; c011a443 <exit_mm+343/480>
Trace; c011f9fd <dequeue_signal+6d/430>
Trace; c0106de4 <sys_sigaltstack+c64/2130>
Trace; c01bbc18 <sock_recvmsg+148/680>
Trace; c0144902 <sys_select+472/600>
Trace; c01bbeae <sock_recvmsg+3de/680>
Trace; c0143a13 <sys_ioctl+223/230>
Trace; c0114480 <do_BUG+d0/780>
Trace; c0106f7c <sys_sigaltstack+dfc/2130>

Code;  c012d2b3 <kmem_cache_free+73/b0>
00000000 <_EIP>:
Code;  c012d2b3 <kmem_cache_free+73/b0>   <=3D=3D=3D=3D=3D
   0:   89 48 04                  mov    %ecx,0x4(%eax)   <=3D=3D=3D=3D=3D
Code;  c012d2b6 <kmem_cache_free+76/b0>
   3:   89 01                     mov    %eax,(%ecx)
Code;  c012d2b8 <kmem_cache_free+78/b0>
   5:   89 51 04                  mov    %edx,0x4(%ecx)
Code;  c012d2bb <kmem_cache_free+7b/b0>
   8:   89 4e 08                  mov    %ecx,0x8(%esi)
Code;  c012d2be <kmem_cache_free+7e/b0>
   b:   eb 28                     jmp    35 <_EIP+0x35> c012d2e8 <kmem_ca=
che_free+a8/b0>
Code;  c012d2c0 <kmem_cache_free+80/b0>
   d:   8b 51 04                  mov    0x4(%ecx),%edx
Code;  c012d2c3 <kmem_cache_free+83/b0>
  10:   8b 01                     mov    (%ecx),%eax
Code;  c012d2c5 <kmem_cache_free+85/b0>
  12:   89 50 00                  mov    %edx,0x0(%eax)

Oct 20 21:18:17 palantir kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Oct 20 21:18:17 palantir kernel: cs: IO port probe 0x0100-0x04ff: excludi=
ng 0x3b8-0x3df 0x4d0-0x4d7
Oct 20 21:18:17 palantir kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Oct 20 21:18:56 palantir kernel: ac97_codec: AC97 Audio codec, id: 0x4352=
:0x5914 (Cirrus Logic CS4297A rev B)
Oct 20 21:47:39 palantir kernel: kernel BUG at page_alloc.c:93!
Oct 20 21:47:39 palantir kernel: invalid operand: 0000
Oct 20 21:47:39 palantir kernel: EIP: =C2=A0 =C2=A00010:[__free_pages_ok+=
157/864] =C2=A0 =C2=A0Not tainted
Oct 20 21:47:39 palantir kernel: EIP: =C2=A0 =C2=A00010:[<c012f9cd>] =C2=A0=
 =C2=A0Not tainted
Oct 20 21:47:39 palantir kernel: EFLAGS: 00010286
Oct 20 21:47:39 palantir kernel: eax: 0000001f =C2=A0 ebx: c18199b0 =C2=A0=
 ecx: 00000001 =C2=A0 edx: 00001a51
Warning (Oops_set_regs): garbage '=C2=A0 ebx: c18199b0 =C2=A0 ecx: 000000=
01 =C2=A0 edx: 00001a51' at end of register line ignored
Oct 20 21:47:39 palantir kernel: esi: 00000000 =C2=A0 edi: 00000000 =C2=A0=
 ebp: 00000000 =C2=A0 esp: c7cabef4
Warning (Oops_set_regs): garbage '=C2=A0 edi: 00000000 =C2=A0 ebp: 000000=
00 =C2=A0 esp: c7cabef4' at end of register line ignored
Oct 20 21:47:39 palantir kernel: ds: 0018 =C2=A0 es: 0018 =C2=A0 ss: 0018
Oct 20 21:47:39 palantir kernel: Process ntpd (pid: 360, stackpage=3Dc7ca=
b000)
Oct 20 21:47:39 palantir kernel: Stack: c022dda1 0000005d 00000000 c7cabf=
30 c0114df7 c7caa550 c7cabfc4 de7e8008
Oct 20 21:47:39 palantir kernel: Call Trace: [IRQ0x0f_interrupt+113185/13=
8400] .rodata.str1.1 [kernel] 0x229c
Oct 20 21:47:39 palantir kernel: Call Trace: [<c022dda1>] .rodata.str1.1 =
[kernel] 0x229c
Oct 20 21:47:39 palantir kernel: [<c0114df7>] schedule_timeout [kernel] 0=
x17
Oct 20 21:47:39 palantir kernel: [<c01440a4>] poll_freewait [kernel] 0x44
Oct 20 21:47:39 palantir kernel: [<c0144446>] do_select [kernel] 0x226
Oct 20 21:47:39 palantir kernel: [<c01447c9>] sys_select [kernel] 0x339
Oct 20 21:47:39 palantir kernel: [<c0106f3b>] system_call [kernel] 0x33
Oct 20 21:47:39 palantir kernel: Code: 0f 0b 58 5a 8b 43 18 83 e0 40 74 1=
0 6a 5f 68 a1 dd 22 c0 e8


>>EIP; c012f9cd <deactivate_page+204d/2690>   <=3D=3D=3D=3D=3D

Trace; c022dda1 <fb_con+1e481/a00c0>
Trace; c0114df7 <schedule_timeout+17/c0>
Trace; c01440a4 <poll_freewait+44/50>
Trace; c0144446 <__pollwait+396/3e0>
Trace; c01447c9 <sys_select+339/600>
Trace; c0106f3b <sys_sigaltstack+dbb/2130>

Code;  c012f9cd <deactivate_page+204d/2690>
00000000 <_EIP>:
Code;  c012f9cd <deactivate_page+204d/2690>   <=3D=3D=3D=3D=3D
   0:   0f 0b                     ud2a      <=3D=3D=3D=3D=3D
Code;  c012f9cf <deactivate_page+204f/2690>
   2:   58                        pop    %eax
Code;  c012f9d0 <deactivate_page+2050/2690>
   3:   5a                        pop    %edx
Code;  c012f9d1 <deactivate_page+2051/2690>
   4:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  c012f9d4 <deactivate_page+2054/2690>
   7:   83 e0 40                  and    $0x40,%eax
Code;  c012f9d7 <deactivate_page+2057/2690>
   a:   74 10                     je     1c <_EIP+0x1c> c012f9e9 <deactiv=
ate_page+2069/2690>
Code;  c012f9d9 <deactivate_page+2059/2690>
   c:   6a 5f                     push   $0x5f
Code;  c012f9db <deactivate_page+205b/2690>
   e:   68 a1 dd 22 c0            push   $0xc022dda1
Code;  c012f9e0 <deactivate_page+2060/2690>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18> c012f9e5 <deactiv=
ate_page+2065/2690>


7 warnings and 1 error issued.  Results may not be reliable.


--------------Boundary-00=_NPE6RD9VA4MNO30VYZ1K--
