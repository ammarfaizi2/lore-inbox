Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbTJNWuW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 18:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbTJNWuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 18:50:21 -0400
Received: from mail.tamiweb.com ([194.12.244.146]:4992 "EHLO mail.tamiweb.com")
	by vger.kernel.org with ESMTP id S262063AbTJNWuQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 18:50:16 -0400
Subject: apache oops 2.4.22
From: Kostadin Karaivanov <larry@tamiweb.com>
Reply-To: larry@tamiweb.com
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-SvH7gT6lJHqKn45TD72N"
Organization: tamiweb
Message-Id: <1066171858.1868.4.camel@laptop.minfin.bg>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 15 Oct 2003 01:50:59 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SvH7gT6lJHqKn45TD72N
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I find this in my logs.
Two apache servers on different ports, one of them unusable....
The only starnge thing about machine is that iptables is modular
and I use modules-init-tools-0.9.14 over original module utils as of
Slackware 9.1

Oct 14 23:26:21 hosting kernel:  printing eip:
Oct 14 23:26:21 hosting kernel: c026d9e2
Oct 14 23:26:21 hosting kernel: *pde =3D 00000000
Oct 14 23:26:21 hosting kernel: Oops: 0002
Oct 14 23:26:21 hosting kernel: iptable_filter
Oct 14 23:26:21 hosting kernel: CPU:    0
Oct 14 23:26:21 hosting kernel: EIP:    0010:[<c026d9e2>]    Not tainted
Oct 14 23:26:21 hosting kernel: EFLAGS: 00010246
Oct 14 23:26:21 hosting kernel: eax: 0000003f   ebx: 03865000   ecx:
f74f6000 edx: 00000140
Oct 14 23:26:21 hosting kernel: esi: f4097394   edi: c13a9310   ebp:
00000000 esp: f74f7e58
Oct 14 23:26:21 hosting kernel: ds: 0018   es: 0018   ss: 0018
Oct 14 23:26:21 hosting kernel: Process httpd (pid: 161,
stackpage=3Df74f7000)
Oct 14 23:26:21 hosting kernel: Stack: c13a9310 c013469d 03865000
f7438234 00000cf5 f7d123d4 00000000 f750b6a0
Oct 14 23:26:21 hosting kernel:        f74382a0 f7438234 f7438180
00000001 f79a06c0 f73e2308 c0134ad5 f7438180
Oct 14 23:26:21 hosting kernel:        00000cf5 f74f7ea4 00000001
00000000 f7555840 c0126be9 f7555840 434c2000
Oct 14 23:26:21 hosting kernel: Call Trace: [<c013469d>]  [<c0134ad5>]=20
[<c0126be9>]  [<c0126550>]  [<c0126dc7>]  [<c0148bd3>]  [<c0113e5e>]=20
[<c01204fd>]  [<c011c902>]  [<c011c816>]  [<c010a4fe>]  [<c0113d00>]=20
[<c0108f70>]
Oct 14 23:26:21 hosting kernel: Code: 0f e7 03 0f e7 43 08 0f e7 43 10
0f e7 43 18 0f e7 43 20 0f



--=-SvH7gT6lJHqKn45TD72N
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/jH3Sinq4IVRzHg8RAo3UAJ49PyXPnTgm69poKiFsBkYU2U5YcwCfRbvP
2nFYRXpsvfqub3i8GFcft8g=
=boTe
-----END PGP SIGNATURE-----

--=-SvH7gT6lJHqKn45TD72N--

