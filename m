Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133054AbRDRIVU>; Wed, 18 Apr 2001 04:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133055AbRDRIVK>; Wed, 18 Apr 2001 04:21:10 -0400
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:2861 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S133054AbRDRIVC>; Wed, 18 Apr 2001 04:21:02 -0400
Date: Wed, 18 Apr 2001 09:20:58 +0100
From: Tim Waugh <twaugh@redhat.com>
To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
Cc: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: Is printing broke on sparc ?
Message-ID: <20010418092058.H350@redhat.com>
In-Reply-To: <Pine.LNX.4.32.0104171707310.22166-100000@filesrv1.baby-dragons.com> <Pine.LNX.4.32.0104171720370.22166-100000@filesrv1.baby-dragons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="5UGlQXeG3ziZS81+"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.32.0104171720370.22166-100000@filesrv1.baby-dragons.com>; from babydr@baby-dragons.com on Tue, Apr 17, 2001 at 05:28:13PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5UGlQXeG3ziZS81+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2001 at 05:28:13PM -0700, Mr. James W. Laferriere wrote:

> 	Ok , There isn't a sysctl available to do that .  I am also a
> 	little worried about the 'none' in ths below .
>=20
> root@udragon:~# sysctl -A | grep -i parp
> dev.parport.parport0.devices.active =3D none

Don't be: unless the printer driver is actually using the port at the
instant that you look at the sysctl, it'll say none.  It's normal.
If you are printing at the time you look, keep checking sysctl and you
will see 'lp' there sometimes.

Tim.
*/

--5UGlQXeG3ziZS81+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD4DBQE63U5qONXnILZ4yVIRAohZAJj8l6gk1kL/89P83lspTEs00YMLAJ9QKphX
Ikc5tDagZ66POhB3jI2YHQ==
=IArI
-----END PGP SIGNATURE-----

--5UGlQXeG3ziZS81+--
