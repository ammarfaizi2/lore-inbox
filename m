Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbTIZByR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 21:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbTIZByR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 21:54:17 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:9080 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262328AbTIZByP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 21:54:15 -0400
Subject: [panic] 2.4.18 in schedule - Alpha CPU
From: Stephen Torri <storri@sbcglobal.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-EADjpWyNgES+oyga4ucd"
Message-Id: <1064541251.25019.1.camel@base>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 25 Sep 2003 20:54:11 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-EADjpWyNgES+oyga4ucd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Panic occurred when trying to run the program 'xine'. The kernel is
2.4.18 for a Alpha PC164 system.

Reading Oops report from the terminal
pc=3D[<fffffc000031fca0>]
Using defaults from ksymoops -t elf64-alpha -a alpha
ra=3D[<fffffc000031fc94>]
ps=3D0007
v0=3D000000000000001b
t0=3Dfffffc000057c770
t1=3D0000000000000001
t2=3D000000000036a488
t3=3Dfffffc00035d0000
t4=3D0000000000000000
t5=3D0000000000000065
t6=3D0000000000000a00
t7=3Dfffffc00031f4000
a0=3D0000000000000007
a1=3D0000000000000001
a2=3D0000000000000001
a3=3D0000000000000000
a4=3D0000000000000a00
a5=3D0000000000000001
t8=3D000000000000001f
t9=3D0000000000000000
t10=3Dfffffc8608926a00
t11=3D0000000000000000
pv=3Dfffffc00003200e0
at=3D0000000000000000
gp=3Dfffffc00005c1320
sp=3Dfffffc00031f3f98
Trace: ffffc00005c1320 fffffc000031f014
Code: a63ddbc0 a77da938 6b5b51b3 27ba002a 23bd168c 00000081 <a43d9640>
47e80406


>>PC;  fffffc000031fca0 <schedule+60/4a0>   <=3D=3D=3D=3D=3D

Code;  fffffc000031fc88 <schedule+48/4a0>
0000000000000000 <_PC>:
Code;  fffffc000031fc88 <schedule+48/4a0>
   0:   c0 db 3d a6       ldq  a1,-9280(gp)
Code;  fffffc000031fc8c <schedule+4c/4a0>
   4:   38 a9 7d a7       ldq  t12,-22216(gp)
Code;  fffffc000031fc90 <schedule+50/4a0>
   8:   b3 51 5b 6b       jsr  ra,(t12),46d8 <_PC+0x46d8>
fffffc0000324360 <printk+0/280>
Code;  fffffc000031fc94 <schedule+54/4a0>
   c:   2a 00 ba 27       ldah gp,42(ra)
Code;  fffffc000031fc98 <schedule+58/4a0>
  10:   8c 16 bd 23       lda  gp,5772(gp)
Code;  fffffc000031fc9c <schedule+5c/4a0>
  14:   81 00 00 00       call_pal     0x81
Code;  fffffc000031fca0 <schedule+60/4a0>   <=3D=3D=3D=3D=3D
  18:   40 96 3d a4       ldq  t0,-27072(gp)   <=3D=3D=3D=3D=3D
Code;  fffffc000031fca4 <schedule+64/4a0>
  1c:   06 04 e8 47       mov  t7,t5

Stephen
--=20
Stephen Torri
GPG Key: http://www.cs.wustl.edu/~storri/storri.asc

--=-EADjpWyNgES+oyga4ucd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/c5xDmXRzpT81NcgRAsIpAJ4+2CwRZEgw7wU0EmTv0+OHkACcXgCgg9rx
ks1MrLUiUILieWTsX9yvdb0=
=C8ex
-----END PGP SIGNATURE-----

--=-EADjpWyNgES+oyga4ucd--

