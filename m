Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264622AbSK0VMA>; Wed, 27 Nov 2002 16:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264798AbSK0VMA>; Wed, 27 Nov 2002 16:12:00 -0500
Received: from port326.ds1-brh.adsl.cybercity.dk ([217.157.160.207]:2644 "EHLO
	mail.jaquet.dk") by vger.kernel.org with ESMTP id <S264622AbSK0VL7>;
	Wed, 27 Nov 2002 16:11:59 -0500
Date: Wed, 27 Nov 2002 22:19:13 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: 2.5.49-mm2
Message-ID: <20021127221913.A9015@jaquet.dk>
References: <3DE48C4A.98979F0C@digeo.com> <20021127210153.A8411@jaquet.dk> <3DE526FC.3D78DB54@digeo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DE526FC.3D78DB54@digeo.com>; from akpm@digeo.com on Wed, Nov 27, 2002 at 12:11:40PM -0800
X-PGP-Key: http://www.jaquet.dk/rasmus/pubkey.asc
X-PGP-Fingerprint: 925A 8E4B 6D63 1C22 BFB9  29CF 9592 4049 9E9E 26CE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2002 at 12:11:40PM -0800, Andrew Morton wrote:
> > (I did not copy the rest but can reproduce at will.)
>=20
> Please do.  And tell how you're making it happen.

Hand copied. Sorry, but I am not able to get a ksymoops
running on my system to decode this so raw oops follows.=20
I have put the System.map at www.jaquet.dk/kernel/System.map-2.5.49-mm2.
I hope that helps some.


Printing eip:
 4008c90
*pde =3D 06e73067
*pte =3D 071c8065
Oops: 0007
CPU: 0
EIP: 0023:[<40008c90>] Not tained
EFLAGS: 00010202
EIP is at 0x40008c90
eax: 0000003d  ebx: 4001274c  ecx: 401c2600  edx: 400134f0
ds: 002b   es: 002b   ss: 002b

Process ntpd (pid: 220, threadinfo=3Dc6e64000 task=3Dc7a9a0c0)
 <0> Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing


> Does it go away if you turn off preemption?

It does.

Regards,
  Rasmus

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE95TbRlZJASZ6eJs4RAlSQAJwKD7wBar+f1hVfuBv/MA2YVNZDTACeOEuo
zVAYNoJlakLirz+yLdE0dQw=
=ovD/
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
