Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310158AbSB1WYF>; Thu, 28 Feb 2002 17:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310174AbSB1WWB>; Thu, 28 Feb 2002 17:22:01 -0500
Received: from think.faceprint.com ([166.90.149.11]:53410 "EHLO
	think.faceprint.com") by vger.kernel.org with ESMTP
	id <S310168AbSB1WSv>; Thu, 28 Feb 2002 17:18:51 -0500
Date: Thu, 28 Feb 2002 17:18:48 -0500
To: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [OOPS] 2.5.5-dj2
Message-ID: <20020228221845.GA6682@faceprint.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
From: faceprint@faceprint.com (Nathan Walp)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

got this either unplugging and plugging my usb printer from the hub, or
turning it on and off (don't remember the exact timing). =20

---------------------------------------------------------------------

ksymoops 2.4.3 on i686 2.5.5-dj2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.5-dj2/ (default)
     -m /boot/System.map-2.5.5-dj2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol GPLONLY_idle_cpu not found in Sys=
tem.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol GPLONLY_vmalloc_to_page not found=
 in System.map.  Ignoring ksyms_base entry
Unable to handle kernel paging request at virtual address 081cd7a8
c02f0d2c
*pde =3D 13abc067
Oops: 0002
CPU:    0
EIP:    0010:[<c02f0d2c>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 00002000   ecx: 00002000   edx: bffff30c
esi: bfffd30c   edi: 081cd7a8   ebp: 00002000   esp: d3a81f3c
ds: 0018   es: 0018   ss: 0018
Stack: 00000000 00002000 df31f6c0 df31f6c8 df31f6c8 c028a127 081cd7a8 bfffd=
30c=20
       00002000 00000000 cdd02c40 ffffffea 00002000 00000282 00000000 00000=
000=20
       00000000 d3aced80 00000000 00000000 00000000 d3aced80 00000000 00000=
000=20
Call Trace: [<c028a127>] [<c013a3f6>] [<c0108a4f>]=20
Code: f3 aa 58 59 e9 e6 cb eb ff ba f2 ff ff ff e9 20 cc eb ff ba=20

>>EIP; c02f0d2c <proc_dodebug+189c/478c>   <=3D=3D=3D=3D=3D
Trace; c028a126 <usblp_write+206/280>
Trace; c013a3f6 <sys_write+96/120>
Trace; c0108a4e <syscall_call+6/a>
Code;  c02f0d2c <proc_dodebug+189c/478c>
00000000 <_EIP>:
Code;  c02f0d2c <proc_dodebug+189c/478c>   <=3D=3D=3D=3D=3D
   0:   f3 aa                     repz stos %al,%es:(%edi)   <=3D=3D=3D=3D=
=3D
Code;  c02f0d2e <proc_dodebug+189e/478c>
   2:   58                        pop    %eax
Code;  c02f0d2e <proc_dodebug+189e/478c>
   3:   59                        pop    %ecx
Code;  c02f0d30 <proc_dodebug+18a0/478c>
   4:   e9 e6 cb eb ff            jmp    ffebcbef <_EIP+0xffebcbef> c01ad91=
a <__generic_copy_from_user+3a/60>
Code;  c02f0d34 <proc_dodebug+18a4/478c>
   9:   ba f2 ff ff ff            mov    $0xfffffff2,%edx
Code;  c02f0d3a <proc_dodebug+18aa/478c>
   e:   e9 20 cc eb ff            jmp    ffebcc33 <_EIP+0xffebcc33> c01ad95=
e <__strncpy_from_user+1e/30>
Code;  c02f0d3e <proc_dodebug+18ae/478c>
  13:   ba 00 00 00 00            mov    $0x0,%edx

Unable to handle kernel paging request at virtual address 000500dc
c0277e2f
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0277e2f>]    Not tainted
EFLAGS: 00010202
eax: 00050010   ebx: df31f6c0   ecx: df31f6c8   edx: df31f734
esi: df31f6c8   edi: c039f800   ebp: 00000000   esp: dfc67f44
ds: 0018   es: 0018   ss: 0018
Stack: c028a8d8 df31f734 c039f7e0 df31f7c0 c0278c71 dc211e00 df31f6c0 00000=
100=20
       00000000 00000001 dfc3a400 00000000 dc211e00 c027b02e dfc3a5b0 00000=
000=20
       00000001 dfc3a400 dfc31a40 c027ad0d d074f340 00000000 dfc3a5b0 00000=
00a=20
Call Trace: [<c028a8d8>] [<c0278c71>] [<c027b02e>] [<c027ad0d>] [<c027b3b9>=
]=20
   [<c027b577>] [<c0107078>]=20
Code: 8b 80 cc 00 00 00 85 c0 74 17 8b 40 18 85 c0 74 10 52 8b 40=20

>>EIP; c0277e2e <usb_unlink_urb+e/40>   <=3D=3D=3D=3D=3D
Trace; c028a8d8 <usblp_disconnect+58/c4>
Trace; c0278c70 <usb_disconnect+90/160>
Trace; c027b02e <usb_hub_port_connect_change+4e/2c0>
Trace; c027ad0c <usb_hub_port_status+6c/80>
Trace; c027b3b8 <usb_hub_events+118/2a0>
Trace; c027b576 <usb_hub_thread+36/90>
Trace; c0107078 <kernel_thread+28/40>
Code;  c0277e2e <usb_unlink_urb+e/40>
00000000 <_EIP>:
Code;  c0277e2e <usb_unlink_urb+e/40>   <=3D=3D=3D=3D=3D
   0:   8b 80 cc 00 00 00         mov    0xcc(%eax),%eax   <=3D=3D=3D=3D=3D
Code;  c0277e34 <usb_unlink_urb+14/40>
   6:   85 c0                     test   %eax,%eax
Code;  c0277e36 <usb_unlink_urb+16/40>
   8:   74 17                     je     21 <_EIP+0x21> c0277e4e <usb_unlin=
k_urb+2e/40>
Code;  c0277e38 <usb_unlink_urb+18/40>
   a:   8b 40 18                  mov    0x18(%eax),%eax
Code;  c0277e3a <usb_unlink_urb+1a/40>
   d:   85 c0                     test   %eax,%eax
Code;  c0277e3c <usb_unlink_urb+1c/40>
   f:   74 10                     je     21 <_EIP+0x21> c0277e4e <usb_unlin=
k_urb+2e/40>
Code;  c0277e3e <usb_unlink_urb+1e/40>
  11:   52                        push   %edx
Code;  c0277e40 <usb_unlink_urb+20/40>
  12:   8b 40 00                  mov    0x0(%eax),%eax


3 warnings issued.  Results may not be reliable.

--=20
Nathan Walp             || faceprint@faceprint.com
GPG Fingerprint:        ||   http://faceprint.com/
5509 6EF3 928B 2363 9B2B  DA17 3E46 2CDC 492D DB7E


--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8fqzFPkYs3Ekt234RAjCwAJ9gFfCR20DRjQBEoLvAgWqjdY6HpwCfSHVO
rZmVZjDJ2U4H+QcXFkajmVE=
=2UbQ
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
