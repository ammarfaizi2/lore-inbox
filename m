Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131564AbRC3Uv2>; Fri, 30 Mar 2001 15:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131644AbRC3UvR>; Fri, 30 Mar 2001 15:51:17 -0500
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:39619 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S131564AbRC3UvD>; Fri, 30 Mar 2001 15:51:03 -0500
Date: Fri, 30 Mar 2001 21:50:17 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Herbert Rosmanith <herp@wildsau.idv-edu.uni-linz.ac.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem in drivers/block/Config.in
Message-ID: <20010330215017.E15175@redhat.com>
In-Reply-To: <200103302017.f2UKH8S07176@wildsau.idv-edu.uni-linz.ac.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="4Epv4kl9IRBfg3rk"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200103302017.f2UKH8S07176@wildsau.idv-edu.uni-linz.ac.at>; from herp@wildsau.idv-edu.uni-linz.ac.at on Fri, Mar 30, 2001 at 10:17:08PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4Epv4kl9IRBfg3rk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 30, 2001 at 10:17:08PM +0200, Herbert Rosmanith wrote:

> why not simply write:
>=20
> 	define_bool CONFIG_PARIDE_PARPORT $CONFIG_PARPORT
>=20
> instead?

Because it isn't that simple.  PARIDE works with parport, or without
parport, but if parport is a module then PARIDE must be configured as
modules too.

I'm planning on changing that in the next development cycle so that
PARIDE just depends on parport and that's it.

Tim.
*/

--4Epv4kl9IRBfg3rk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6xPGIONXnILZ4yVIRAlg2AJ9hre3I4UaO8oTtk2bpmDEIeFnpZQCeLemy
4zJvAKdbKRroUxSACoIsW+Q=
=qvDv
-----END PGP SIGNATURE-----

--4Epv4kl9IRBfg3rk--
