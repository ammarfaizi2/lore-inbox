Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262883AbTE0JHp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 05:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262884AbTE0JHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 05:07:45 -0400
Received: from 62.231.64.189 ([62.231.64.189]:31625 "EHLO mail.transfond.ro")
	by vger.kernel.org with ESMTP id S262883AbTE0JHj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 05:07:39 -0400
Subject: Proxy hangs out ...what could it be??? (newbie)
From: Gabi Craciun <gcraciun@transfond.ro>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-JcMydgCmJfQDkXcabaMK"
Organization: 
Message-Id: <1054027469.3030.6.camel@sun.rdd.tfd.ro>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 May 2003 12:24:30 +0300
X-OriginalArrivalTime: 27 May 2003 09:24:43.0328 (UTC) FILETIME=[CE844C00:01C32431]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JcMydgCmJfQDkXcabaMK
Content-Type: multipart/mixed; boundary="=-5bHe3UPMurZze40TIoEB"


--=-5bHe3UPMurZze40TIoEB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello!

I'm running squid on RH 7.3 machine. sometimes, i think when a certain
amount of /var/spool/squid is occupied, it hang.....any ideas?

--=-5bHe3UPMurZze40TIoEB
Content-Disposition: attachment; filename="ksymoops result"
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name="ksymoops result"; charset=UTF-8

proxy:~# ksymoops < the_oops.txt
ksymoops 2.4.4 on i686 2.4.18-3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-3/ (default)
     -m /boot/System.map-2.4.18-3 (default)
=20
Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.
=20
Error (expand_objects): cannot stat(/lib/ext3.o) for ext3
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/jbd.o) for jbd
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/ft.o) for ft
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/sd_mod.o) for sd_mod
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/scsi_mod.o) for scsi_mod
ksymoops: No such file or directory
/usr/bin/find: /lib/modules/2.4.18-3/build: No such file or directory
Error (pclose_local): find_objects pclose failed 0x100
Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base say=
s c01bd130, System.map says c015abe0.  Ignoring ksyms_base entry
Warning (map_ksym_to_module): cannot match loaded module ext3 to a unique m=
odule object.  Trace may not be reliable.
May 25 07:00:01 proxy kernel: Unable to handle kernel NULL pointer derefere=
nce at virtual address 00000004
May 25 07:00:01 proxy kernel: c014c084
May 25 07:00:01 proxy kernel: *pde =3D 00000000
May 25 07:00:01 proxy kernel: Oops: 0002
May 25 07:00:01 proxy kernel: CPU:    0
May 25 07:00:01 proxy kernel: EIP:    0010:[<c014c084>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
May 25 07:00:01 proxy kernel: EFLAGS: 00010246
May 25 07:00:01 proxy kernel: eax: 00000000   ebx: c85a5a38   ecx: c826ab00=
   edx: c1727f80
May 25 07:00:01 proxy kernel: esi: c85a5a40   edi: c1727f80   ebp: c1726000=
   esp: c1727f60
May 25 07:00:01 proxy kernel: ds: 0018   es: 0018   ss: 0018
May 25 07:00:01 proxy kernel: Process kswapd (pid: 4, stackpage=3Dc1727000)
May 25 07:00:01 proxy kernel: Stack: c6a48708 c6a48700 c02c5550 00001df8 c0=
14c393 c1727f80 c1726000 00002961
May 25 07:00:01 proxy kernel:        c85a5a40 c97720e8 000001d0 0000066d 00=
000000 00000000 c014c3d0 00002160
May 25 07:00:01 proxy kernel:        c0130c26 00000001 000001d0 c170f130 00=
0001d0 000001d0 c1726000 00000000
May 25 07:00:01 proxy kernel: Call Trace: [<c014c393>] prune_icache [kernel=
] 0x123
May 25 07:00:01 proxy kernel: [<c014c3d0>] shrink_icache_memory [kernel] 0x=
20
May 25 07:00:01 proxy kernel: [<c0130c26>] do_try_to_free_pages [kernel] 0x=
26
May 25 07:00:01 proxy kernel: [<c0130f11>] kswapd [kernel] 0x101
May 25 07:00:01 proxy kernel: [<c0105000>] stext [kernel] 0x0
May 25 07:00:01 proxy kernel: [<c0107136>] kernel_thread [kernel] 0x26
May 25 07:00:01 proxy kernel: [<c0130e10>] kswapd [kernel] 0x0
May 25 07:00:01 proxy kernel: Code: 89 50 04 89 02 8b 83 cc 00 00 00 85 c0 =
74 13 6a 00 8d 86 ac
=20
>>EIP; c014c084 <dispose_list+34/80>   <=3D=3D=3D=3D=3D
Trace; c014c393 <prune_icache+123/140>
Trace; c014c3d0 <shrink_icache_memory+20/30>
Trace; c0130c26 <do_try_to_free_pages+26/180>
Trace; c0130f11 <kswapd+101/2d0>
Trace; c0105000 <_stext+0/0>
Trace; c0107136 <kernel_thread+26/30>
Trace; c0130e10 <kswapd+0/2d0>
Code;  c014c084 <dispose_list+34/80>
00000000 <_EIP>:
Code;  c014c084 <dispose_list+34/80>   <=3D=3D=3D=3D=3D
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=3D=3D=3D=3D=3D
Code;  c014c087 <dispose_list+37/80>
   3:   89 02                     mov    %eax,(%edx)
Code;  c014c089 <dispose_list+39/80>
   5:   8b 83 cc 00 00 00         mov    0xcc(%ebx),%eax
Code;  c014c08f <dispose_list+3f/80>
   b:   85 c0                     test   %eax,%eax
Code;  c014c091 <dispose_list+41/80>
   d:   74 13                     je     22 <_EIP+0x22> c014c0a6 <dispose_l=
ist+56/80>
Code;  c014c093 <dispose_list+43/80>
   f:   6a 00                     push   $0x0
Code;  c014c095 <dispose_list+45/80>
  11:   8d 86 ac 00 00 00         lea    0xac(%esi),%eax
=20
=20
3 warnings and 6 errors issued.  Results may not be reliable.

--=-5bHe3UPMurZze40TIoEB--

--=-JcMydgCmJfQDkXcabaMK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+0y7NoxBSpqmyrBURAsfRAJ42MZRyvTO+mUPPdf2W94nXnty7CwCfeQ0w
ZbQYHHQ+y8pBOI6pTZHRIaA=
=22+a
-----END PGP SIGNATURE-----

--=-JcMydgCmJfQDkXcabaMK--

