Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265118AbUAHPDP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 10:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265114AbUAHPC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 10:02:56 -0500
Received: from [200.55.45.199] ([200.55.45.199]:18338 "EHLO smtp.bensa.ar")
	by vger.kernel.org with ESMTP id S265100AbUAHPCn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 10:02:43 -0500
From: Norberto Bensa <nbensa@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Oops with 2.6.1-rc2-mm1
Date: Thu, 8 Jan 2004 12:00:03 -0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_2BX//9NOZtQ6Juv";
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200401081200.06009.nbensa@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_2BX//9NOZtQ6Juv
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

All right, this is one of my two or three "BSOD" since I use Linux :-)
Not sure if I did ksymoops right. I hope this is useful


$ /sbin/ksymoops
ksymoops 2.4.9 on i686 2.6.1-rc2-mm1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.1-rc2-mm1/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
/sbin/ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Reading Oops report from the terminal
Unable to handle kernel paging request at virtual address 193d2029
 printing eip:
c0152546
*pde =3D 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c0152546>]    Tainted: PF  VLI
EFLAGS: 00010202
eax: 00000000   ebx: d9fb0008   ecx: c0260a74   edx: c140f388
esi: 193d2025   edi: 00000000   ebp: 00000100   esp: da29def4
ds: 007b   es: 007b   ss: 0068
Process kdeinit (pid: 4298, threadinfo=3Dda29c000 task=3Dd9e18ce0)
Stack: d9893720 00000001 c0152951 da29df48 00000000 00000000 00000010 00000=
008
       000000b8 00000000 00000000 000000b8 da2de7ac da2de7a8 da2de7a4 da2de=
7b8
       da2de7b4 da2de7b0 7fffffff 00000008 00000000 c0152577 d9fb0000 00000=
000
Call Trace: [<c0152951>]  [<c0152577>]  [<c0152c93>]  [<c0227f0e>]
Code: d9 fb ff ff 90 8b 44 24 04 c7 00 77 25 15 c0 c7 40 08 00 00 00 00 c7 =
40=20
04 00 00 00 00 c3 56 53 8b 44 24 0c 8b 70 04 85 f6 74 2e <8b> 5e 04 83 eb 1=
c=20
8b 43 18 8d 53 04 e8 39 58 fc ff 8b 03 e8 d3
Badness in unblank_screen at drivers/char/vt.c:2793
Call Trace: [<c01ccfb6>]  [<c0114c9b>]  [<c010a87f>]  [<c0115233>] =20
[<c0115e0d>]  [<c0116afe>]  [<c0114f12>]  [<c02289e7>]  [<c0152546>] =20
[<c0152951>]  [<c0152577>]  [<c0152c93>]  [<c0227f0e>]
Unable to handle kernel paging request at virtual address 193d2029
c0152546
*pde =3D 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0152546>]    Tainted: PF  VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000000   ebx: d9fb0008   ecx: c0260a74   edx: c140f388
esi: 193d2025   edi: 00000000   ebp: 00000100   esp: da29def4
ds: 007b   es: 007b   ss: 0068
Stack: d9893720 00000001 c0152951 da29df48 00000000 00000000 00000010 00000=
008
       000000b8 00000000 00000000 000000b8 da2de7ac da2de7a8 da2de7a4 da2de=
7b8
       da2de7b4 da2de7b0 7fffffff 00000008 00000000 c0152577 d9fb0000 00000=
000
Call Trace: [<c0152951>]  [<c0152577>]  [<c0152c93>]  [<c0227f0e>]
Code: d9 fb ff ff 90 8b 44 24 04 c7 00 77 25 15 c0 c7 40 08 00 00 00 00 c7 =
40=20
04 00 00 00 00 c3 56 53 8b 44 24 0c 8b 70 04 85 f6 74 2e <8b> 5e 04 83 eb 1=
c=20
8b 43 18 8d 53 04 e8 39 58 fc ff 8b 03 e8 d3


>>EIP; c0152546 <poll_freewait+d/3e>   <=3D=3D=3D=3D=3D

>>ebx; d9fb0008 <_end+19d02c88/3fd4fc80>
>>ecx; c0260a74 <contig_page_data+114/398>
>>edx; c140f388 <_end+1162008/3fd4fc80>
>>esp; da29def4 <_end+19ff0b74/3fd4fc80>

Trace; c0152951 <do_select+27e/293>
Trace; c0152577 <__pollwait+0/9a>
Trace; c0152c93 <sys_select+315/45b>
Trace; c0227f0e <sysenter_past_esp+43/65>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c015251b <.text.lock.readdir+10/15>
00000000 <_EIP>:
Code;  c015251b <.text.lock.readdir+10/15>
   0:   d9 fb                     fsincos
Code;  c015251d <.text.lock.readdir+12/15>
   2:   ff                        (bad)
Code;  c015251e <.text.lock.readdir+13/15>
   3:   ff 90 8b 44 24 04         call   *0x424448b(%eax)
Code;  c0152524 <poll_initwait+4/19>
   9:   c7 00 77 25 15 c0         movl   $0xc0152577,(%eax)
Code;  c015252a <poll_initwait+a/19>
   f:   c7 40 08 00 00 00 00      movl   $0x0,0x8(%eax)
Code;  c0152531 <poll_initwait+11/19>
  16:   c7 40 04 00 00 00 00      movl   $0x0,0x4(%eax)
Code;  c0152538 <poll_initwait+18/19>
  1d:   c3                        ret
Code;  c0152539 <poll_freewait+0/3e>
  1e:   56                        push   %esi
Code;  c015253a <poll_freewait+1/3e>
  1f:   53                        push   %ebx
Code;  c015253b <poll_freewait+2/3e>
  20:   8b 44 24 0c               mov    0xc(%esp,1),%eax
Code;  c015253f <poll_freewait+6/3e>
  24:   8b 70 04                  mov    0x4(%eax),%esi
Code;  c0152542 <poll_freewait+9/3e>
  27:   85 f6                     test   %esi,%esi
Code;  c0152544 <poll_freewait+b/3e>
  29:   74 2e                     je     59 <_EIP+0x59>

This decode from eip onwards should be reliable

Code;  c0152546 <poll_freewait+d/3e>
00000000 <_EIP>:
Code;  c0152546 <poll_freewait+d/3e>   <=3D=3D=3D=3D=3D
   0:   8b 5e 04                  mov    0x4(%esi),%ebx   <=3D=3D=3D=3D=3D
Code;  c0152549 <poll_freewait+10/3e>
   3:   83 eb 1c                  sub    $0x1c,%ebx
Code;  c015254c <poll_freewait+13/3e>
   6:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  c015254f <poll_freewait+16/3e>
   9:   8d 53 04                  lea    0x4(%ebx),%edx
Code;  c0152552 <poll_freewait+19/3e>
   c:   e8 39 58 fc ff            call   fffc584a <_EIP+0xfffc584a>
Code;  c0152557 <poll_freewait+1e/3e>
  11:   8b 03                     mov    (%ebx),%eax
Code;  c0152559 <poll_freewait+20/3e>
  13:   e8                        .byte 0xe8
Code;  c015255a <poll_freewait+21/3e>
  14:   d3                        .byte 0xd3

Call Trace: [<c01ccfb6>]  [<c0114c9b>]  [<c010a87f>]  [<c0115233>] =20
[<c0115e0d>]  [<c0116afe>]  [<c0114f12>]  [<c02289e7>]  [<c0152546>] =20
[<c0152951>]  [<c0152577>]  [<c0152c93>]  [<c0227f0e>]

Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c01ccfb6 <unblank_screen+28/f2>
Trace; c0114c9b <bust_spinlocks+1f/46>
Trace; c010a87f <die+79/d2>
Trace; c0115233 <do_page_fault+321/462>
Trace; c0115e0d <recalc_task_prio+13e/14a>
Trace; c0116afe <schedule+424/4c2>
Trace; c0114f12 <do_page_fault+0/462>
Trace; c02289e7 <error_code+2f/38>
Trace; c0152546 <poll_freewait+d/3e>
Trace; c0152951 <do_select+27e/293>
Trace; c0152577 <__pollwait+0/9a>
Trace; c0152c93 <sys_select+315/45b>
Trace; c0227f0e <sysenter_past_esp+43/65>


2 warnings and 1 error issued.  Results may not be reliable.

=2D-=20
Linux 2.6.1-rc2-mm1 Pentium III (Coppermine) GenuineIntel GNU/Linux
 11:57:11 up 10 min,  1 user,  load average: 0.15, 0.20, 0.14

--Boundary-02=_2BX//9NOZtQ6Juv
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQA//XB1FXVF50lmS74RAvYuAJ9zAJbtL9nT/w8r7Tn0bbuxdCgQagCfVtBo
4i5bBAplWu2L20jcWupEjA4=
=f8OW
-----END PGP SIGNATURE-----

--Boundary-02=_2BX//9NOZtQ6Juv--

