Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312384AbSCUQmc>; Thu, 21 Mar 2002 11:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312388AbSCUQmY>; Thu, 21 Mar 2002 11:42:24 -0500
Received: from 12-216-36-250.client.mchsi.com ([12.216.36.250]:16796 "EHLO
	united.lan.codewhore.org") by vger.kernel.org with ESMTP
	id <S312384AbSCUQmP>; Thu, 21 Mar 2002 11:42:15 -0500
Date: Thu, 21 Mar 2002 11:40:11 -0500
From: David Brown <dave@codewhore.org>
To: Amol Kumar Lad <amolk@ishoni.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Porting from vxworks to linux
Message-ID: <20020321114011.A27340@codewhore.org>
In-Reply-To: <7CFD7CA8510CD6118F950002A519EA3001067C7A@leonoid.in.ishoni.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi:

I haven't actually played with it, but the 'MM Shared Memory Library' at
http://www.engelschall.com/sw/mm/ looks like a starting point.

According to the manual:
 "The MM library is a 2-layer abstraction library which simplifies the
  usage of shared memory between forked (and this way strongly related)
  processes under Unix platforms. On the first layer it hides all platform
  dependent implementation details (allocation and locking) when dealing
  with shared memory segments and on the second layer it provides a
  high-level malloc(3)-style API for a convenient and well known way to
  work with data-structures inside those shared memory segments."

BSD-style license and all that good stuff.

Regards,
- Dave
  dave@codewhore.org


On Thu, Mar 21, 2002 at 04:09:51PM +0530, Amol Kumar Lad wrote:
> Hi ,
>   Sorry for posting this to wrong list. But you can help me out.
>=20
> I am porting some code from Vxworks to Linux (application level, not
> kernel).=20
> THe problem is , in Vxworks as there is a single address space so a 'mall=
oc'
> done by one process is visible to other process also, i.e. all the global
> data is shared in Vxworks across processes.
>=20
> This is not true in linux, as every process has its own address space.=20
> What could be done so that I can use same 'malloc' like interface and have
> all my 'global data'
> shared across process.=20
>=20
> I can understand that i have to use shared memory for this. Is there any
> library available
> that provides me a 'malloc' type interface for shared memory.
>=20
> All processes are unrelated processes ( fork -> exec)
>=20
> Thanks
> Amol
>=20
> -- please CC me..
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjyaDOsACgkQcHEtmM/AAybJsQCgl5KSJCQROIebyYh8VQmhvU7B
WykAn3+NgU64in9te/BjdFQNqO2AYeoD
=3+1T
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
