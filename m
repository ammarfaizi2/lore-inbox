Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263490AbTD0IBk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 04:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263845AbTD0IBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 04:01:40 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:20198 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S263490AbTD0IBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 04:01:39 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Andrew Morton <akpm@digeo.com>
Subject: Oop in 2.5.68-mm2 apply_alternatives
Date: Sun, 27 Apr 2003 10:13:41 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_6E5q+9wST8ftGbJ";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200304271013.47047.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_6E5q+9wST8ftGbJ
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

I get following (hand copied) Oops at init when booting 2.5.68-mm2. As the=
=20
last message diplayed is "Setting up network device eth0" I think the reaso=
n=20
is loading the module 8130too or any of its dependencies. (My .config is no=
t=20
attached, but if missed I'll send it to you).

   Thomas Schlichter

P.S.: Even if the keyboard works at this stage and for example=20
<SHIFT><Scroll-Lock> works, the SysReq doesn't. But the support for it shou=
ld=20
have been compiled in...

Unable to handle kernel paging request at virtual address c040e93c
  printing eip:
c040e93c
*pde =3D 00103027
Oops: 0000[#1]
VPU: 0
EIP: 0060:[<c040e93c>] Not tainted VLI
EFLAGS: 00010282
EIP is at apply_alternatives+0x0/0xb0

~~Register values not written down~~

Process modprobe (pid: 199, threadinfo=3Dcf34000 task=3Dc13386e0)
Stack: c011fa04 d491e540 d491e558 000003c0 00000000 d491ff80 d490918e cf34b=
f98

~~The other Stack values not written down~~
--Boundary-02=_6E5q+9wST8ftGbJ
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+q5E6YAiN+WRIZzQRArQnAKCOEaAGQLI1kmISaYAfZGIdJYZkDACfZWHP
zzjlQ+917vupSyZO77HemjQ=
=8xs6
-----END PGP SIGNATURE-----

--Boundary-02=_6E5q+9wST8ftGbJ--

