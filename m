Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbUCDF02 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 00:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbUCDF02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 00:26:28 -0500
Received: from [196.25.168.8] ([196.25.168.8]:15596 "EHLO lbsd.net")
	by vger.kernel.org with ESMTP id S261370AbUCDF00 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 00:26:26 -0500
Date: Thu, 4 Mar 2004 07:25:26 +0200
From: Nigel Kukard <nkukard@lbsd.net>
To: Chris Wright <chrisw@osdl.org>
Cc: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.3] Sysfs breakage - tun.ko
Message-ID: <20040304052526.GT21950@lbsd.net>
References: <4043938C.9090504@lbsd.net> <40439B03.4000505@backtobasicsmgmt.com> <20040302060251.GG21950@lbsd.net> <20040302182834.R22989@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7Ha3rcGc4ZVRbLT1"
Content-Disposition: inline
In-Reply-To: <20040302182834.R22989@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
X-PHP-Key: http://www.lbsd.net/~nkukard/keys/gpg_public.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7Ha3rcGc4ZVRbLT1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks bud!

Hopefully it'll get included in 2.6.4  ;)

On Tue, Mar 02, 2004 at 06:28:34PM -0800, Chris Wright wrote:
> * Nigel Kukard (nkukard@lbsd.net) wrote:
> >=20
> > Nothing said solves the problem, the problem has got nothing to do with
> > devfs (only for compat reasons), the problem is that "net/tun" breaks
> > sysfs.
>=20
> Yes, why does this not work?  Keeps devfs legacy name, works fine with
> udev, and makes proper dir in sysfs.
>=20
> thanks,
> -chris
>=20
> =3D=3D=3D=3D=3D drivers/net/tun.c 1.29 vs edited =3D=3D=3D=3D=3D
> --- 1.29/drivers/net/tun.c	Sat Jan 10 16:09:09 2004
> +++ edited/drivers/net/tun.c	Tue Mar  2 12:05:30 2004
> @@ -602,7 +602,8 @@
> =20
>  static struct miscdevice tun_miscdev =3D {
>  	.minor =3D TUN_MINOR,
> -	.name =3D "net/tun",
> +	.name =3D "tun",
> +	.devfs_name =3D "net/tun",
>  	.fops =3D &tun_fops
>  };
> =20

--7Ha3rcGc4ZVRbLT1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFARr3GKoUGSidwLE4RAqkvAJ9Ja6ftN2hVFYhEBr7EM0Mor4MyBQCfbCD8
p5Aan1W03bVj/qbp407EJ7Y=
=vDE9
-----END PGP SIGNATURE-----

--7Ha3rcGc4ZVRbLT1--
