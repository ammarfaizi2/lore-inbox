Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267282AbTAGDaj>; Mon, 6 Jan 2003 22:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267284AbTAGDaj>; Mon, 6 Jan 2003 22:30:39 -0500
Received: from spider.morgul.net ([18.24.4.35]:21519 "EHLO spider.morgul.net")
	by vger.kernel.org with ESMTP id <S267282AbTAGDag>;
	Mon, 6 Jan 2003 22:30:36 -0500
Date: Mon, 6 Jan 2003 22:39:14 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: ext3 related oops in 2.4.{18,20} on sparc
Message-ID: <20030107033914.GE25227@morgul.net>
References: <20030107033647.GD25227@morgul.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jfWagoTHmfL/c8Ax"
Content-Disposition: inline
In-Reply-To: <20030107033647.GD25227@morgul.net>
User-Agent: Mutt/1.3.28i
From: "Noah L. Meyerhans" <frodo@morgul.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jfWagoTHmfL/c8Ax
Content-Type: multipart/mixed; boundary="WcQ7DTTOeW3GIUV5"
Content-Disposition: inline


--WcQ7DTTOeW3GIUV5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ahh!  I forgot to attach the oops!  It is attached here.  Sorry!

noah

--=20
 _______________________________________________________
| Web: http://web.morgul.net/~frodo/
| PGP Public Key: http://web.morgul.net/~frodo/mail.html=20

--WcQ7DTTOeW3GIUV5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.decoded"
Content-Transfer-Encoding: quoted-printable

ksymoops 2.4.5 on sparc64 2.4.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m /boot/System.map-2.4.20 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod f=
ile?
Jan  6 22:16:02 mantis kernel: Unable to handle kernel NULL pointer derefer=
ence
Jan  6 22:16:02 mantis kernel: tsk->{mm,active_mm}->context =3D 00000000000=
00534
Jan  6 22:16:02 mantis kernel: tsk->{mm,active_mm}->pgd =3D fffff800207c0000
Jan  6 22:16:02 mantis kernel:               \|/ ____ \|/
Jan  6 22:16:02 mantis kernel:               "@'/ .. \`@"
Jan  6 22:16:02 mantis kernel:               /_| \__/ |_\
Jan  6 22:16:02 mantis kernel:                  \__U_/
Jan  6 22:16:02 mantis kernel: rsync(320): Oops
Jan  6 22:16:02 mantis kernel: TSTATE: 0000004411009605 TPC: 000000000048c9=
3c TNPC: 000000000048c940 Y: 00000000    Not tainted
Using defaults from ksymoops -t elf32-sparc -a sparc
Jan  6 22:16:02 mantis kernel: g0: fffff800022d9760 g1: 000000000048c760 g2=
: 0000000000000002 g3: 0000000000000000
Jan  6 22:16:02 mantis kernel: g4: fffff80000000000 g5: 0000000000000002 g6=
: fffff80002494000 g7: 0000000000000002
Jan  6 22:16:02 mantis kernel: o0: fffff80002494000 o1: 0000000000000000 o2=
: 0000000000ff0000 o3: 000000000000ff00
Jan  6 22:16:02 mantis kernel: o4: 0000000000000001 o5: 0000000000000001 sp=
: fffff800024972d1 ret_pc: 000000000048c920
Jan  6 22:16:02 mantis kernel: l0: fffff8000206cc20 l1: fffff800019b0060 l2=
: 00000000006b0800 l3: fffff800101f103c
Jan  6 22:16:02 mantis kernel: l4: 0000000000000010 l5: 0000000000000000 l6=
: 0000000000000000 l7: 0000000000000000
Jan  6 22:16:02 mantis kernel: i0: fffffffffffffff3 i1: fffff8000206cc20 i2=
: 000000000060cdb8 i3: 000000000048c900
Jan  6 22:16:02 mantis kernel: i4: 0000000000000048 i5: 00000000700e9428 i6=
: fffff800024973a1 i7: 0000000000469a6c
Jan  6 22:16:02 mantis kernel: Caller[0000000000469a6c]
Jan  6 22:16:02 mantis kernel: Caller[0000000000469d50]
Jan  6 22:16:02 mantis kernel: Caller[000000000045cb3c]
Jan  6 22:16:02 mantis kernel: Caller[000000000042ba30]
Jan  6 22:16:02 mantis kernel: Caller[00000000004107f4]
Jan  6 22:16:02 mantis kernel: Caller[0000000070136090]
Jan  6 22:16:02 mantis kernel: Instruction DUMP: 94102000  15003fc0  d25fa7=
e7 <d6024000> 1300003f  a12ae018  92126300  920ac009  940ac00a=20


>>PC;  0048c93c <ext3_lookup+3c/c0>   <=3D=3D=3D=3D=3D

>>g0; fffff800022d9760 <END_OF_CODE+fffff80001bed820/????>
>>g1; 0048c760 <ext3_find_entry+1a0/340>
>>g4; fffff80000000000 <END_OF_CODE+fffff7ffff9140c0/????>
>>g6; fffff80002494000 <END_OF_CODE+fffff80001da80c0/????>
>>o0; fffff80002494000 <END_OF_CODE+fffff80001da80c0/????>
>>o2; 00ff0000 <END_OF_CODE+9040c0/????>
>>o3; 0000ff00 Before first symbol
>>sp; fffff800024972d1 <END_OF_CODE+fffff80001dab391/????>
>>ret_pc; 0048c920 <ext3_lookup+20/c0>
>>l0; fffff8000206cc20 <END_OF_CODE+fffff80001980ce0/????>
>>l1; fffff800019b0060 <END_OF_CODE+fffff800012c4120/????>
>>l2; 006b0800 <cdev_hashtable+3c8/400>
>>l3; fffff800101f103c <END_OF_CODE+fffff8000fb050fc/????>
>>i0; fffffffffffffff3 <END_OF_CODE+ffffffffff9140b3/????>
>>i1; fffff8000206cc20 <END_OF_CODE+fffff80001980ce0/????>
>>i2; 0060cdb8 <ext3_dir_inode_operations+0/a0>
>>i3; 0048c900 <ext3_lookup+0/c0>
>>i5; 700e9428 <END_OF_CODE+6f9fd4e8/????>
>>i6; fffff800024973a1 <END_OF_CODE+fffff80001dab461/????>
>>i7; 00469a6c <lookup_hash+8c/c0>

Trace; 00469a6c <lookup_hash+8c/c0>
Trace; 00469d50 <open_namei+b0/640>
Trace; 0045cb3c <filp_open+3c/80>
Trace; 0042ba30 <sparc32_open+50/100>
Trace; 004107f4 <linux_sparc_syscall32+34/40>
Trace; 70136090 <END_OF_CODE+6fa4a150/????>

Code;  0048c930 <ext3_lookup+30/c0>
00000000 <_PC>:
Code;  0048c930 <ext3_lookup+30/c0>
   0:   94 10 20 00       clr  %o2
Code;  0048c934 <ext3_lookup+34/c0>
   4:   15 00 3f c0       sethi  %hi(0xff0000), %o2
Code;  0048c938 <ext3_lookup+38/c0>
   8:   d2 5f a7 e7       unknown
Code;  0048c93c <ext3_lookup+3c/c0>   <=3D=3D=3D=3D=3D
   c:   d6 02 40 00       ld  [ %o1 ], %o3   <=3D=3D=3D=3D=3D
Code;  0048c940 <ext3_lookup+40/c0>
  10:   13 00 00 3f       sethi  %hi(0xfc00), %o1
Code;  0048c944 <ext3_lookup+44/c0>
  14:   a1 2a e0 18       sll  %o3, 0x18, %l0
Code;  0048c948 <ext3_lookup+48/c0>
  18:   92 12 63 00       or  %o1, 0x300, %o1
Code;  0048c94c <ext3_lookup+4c/c0>
  1c:   92 0a c0 09       and  %o3, %o1, %o1
Code;  0048c950 <ext3_lookup+50/c0>
  20:   94 0a c0 0a       and  %o3, %o2, %o2


2 warnings issued.  Results may not be reliable.

--WcQ7DTTOeW3GIUV5--

--jfWagoTHmfL/c8Ax
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+GkviYrVLjBFATsMRAo/KAJ9hlH1NYvXEFfUNGWTiYXn8rlJ67ACcDaB2
+LTcKDMCstnj2LltIfgEPmM=
=0GHL
-----END PGP SIGNATURE-----

--jfWagoTHmfL/c8Ax--
