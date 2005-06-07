Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbVFGTtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbVFGTtA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 15:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbVFGTtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 15:49:00 -0400
Received: from the-penguin.otak.com ([65.37.126.18]:48076 "EHLO
	the-penguin.otak.com") by vger.kernel.org with ESMTP
	id S261880AbVFGTsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 15:48:55 -0400
Date: Tue, 7 Jun 2005 12:48:52 -0700
From: Lawrence Walton <lawrence@the-penguin.otak.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: oops 2.6.11 and 2.6.12-rc6
Message-ID: <20050607194852.GA3638@the-penguin.otak.com>
References: <20050607182329.GA3950@the-penguin.otak.com> <1118172809.956.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
In-Reply-To: <1118172809.956.6.camel@localhost.localdomain>
X-Operating-System: Linux 2.6.12-rc5-mm1 on an i686
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Alexander Nyberg [alexn@telia.com] wrote:
> tis 2005-06-07 klockan 11:23 -0700 skrev Lawrence Walton:
> > Hello!
> >=20
> > I have a production server that has not booted any kernel I've tried se=
nse
> > 2.6.10.
> > I captured this oops by *hand* this morning when trying to boot 2.6.12-=
rc6.
> >=20
> > I've included the decoded oops, lspci -vvv, .config and ver_linux infor=
mation.
> >=20
> > Unlike most cases this is a prodution machine and I have limited time t=
o test patches. :(
> >=20
>=20
> Unfortunately the oops text you sent cannot be used for debugging.
> Please send the oops that 2.6.12-rc6 produces to the list (ksymoops is
> not necessary on 2.6.x kernels and should not be used!).=20
> Depending on how early the oops happens you can definately use
> Documentation/serial-console.txt and maybe the somewhat simpler
> Documentation/networking/netconsole.txt
>=20
> Please send the non-ksymoopsed oops you wrote off the screen when
> booting 2.6.12-rc6
>=20
> Thanks
>=20
Here is the bare oops.


Unable to handle kernel paging request at virtual address=20
8bb85fc4
 printing eip:
de15829 1
*pde =3D 00000000
Oops: 0002 [#1]
Modules linked in:
CPU:	0
Eip:	0060:[<de158291>]	not tainted VLI
EFLAGS: 00010286	(2.6.11)
eip is at 0xde158291
eax: c18e37fc ebx: c1921eb8 ecx: c18e05c0 edx: c18e05c0
esi: c1921eb8 edi: c1921ebc ebp: c1921e74 esp: c1921629
ds: 007b es: 007b ss: 0068=20
Process Swapper (pid: 1, threadinfo=3Dc1920000 task=3Dc18f2a20)
Stack: 00000292 00000283 0c000000 0d000000 0e000000 0f000000 10000000 11000=
000
       12000000 13000000 14000000 150000000 160000000 17000000 180000000 19=
000000
       1a000000 1b000000 1c000000 1d0000000 1e0000000 1f000000 200000000 21=
000000
call trace:
Code: 00 00 20 3c 9c 08 79 00 00 00 2c 22 9c 08 90 21 9c 08 c0 cb 14 08 a8 =
21 9c
08 b4 21 9cd 08 cc 21 9c 08 c0 cb 14 08 e4 21 9c 08 d8 <21> 9c 08 08 22 9c =
08 c0
21 9c 08 f0 21 0c 08 fc 21 9c 08 e4 c6
<0> Kernel panic - not syncing: Attempted to kill intit!

--=20
*--* Mail: lawrence@otak.com
*--* Voice: 425.739.4247
*--* Fax: 425.827.9577
*--* HTTP://the-penguin.otak.com/~lawrence
--------------------------------------
- - - - - - O t a k  i n c . - - - - -=20



--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCpfoksgPkFxgrWYkRAhKrAJ93/ioTk/VC/iGt6SxMEXqOdOi1AgCfaQKX
HONVk5Rgkkbb4dlL/NOm6uA=
=BOCa
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
