Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272153AbTHRRvj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 13:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272215AbTHRRvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 13:51:39 -0400
Received: from fed1mtao03.cox.net ([68.6.19.242]:29895 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S272153AbTHRRvh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 13:51:37 -0400
Date: Mon, 18 Aug 2003 10:51:35 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Christoph Hellwig <hch@stop.crashing.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mark devfs obsolete
Message-ID: <20030818175135.GC848@ip68-0-152-218.tc.ph.cox.net>
References: <20030816114102.GA6026@lst.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <20030816114102.GA6026@lst.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 16, 2003 at 01:41:02PM +0200, Christoph Hellwig wrote:
> The person listed as maintainer hasn't touched it for alomost a year
> and after that only some odd fixes and my interface fixes went it.
>=20
> With udev we also have a proper replacement.
>=20
>=20
> --- 1.166/MAINTAINERS	Thu Aug 14 21:17:45 2003
> +++ edited/MAINTAINERS	Sat Aug 16 11:56:20 2003
> @@ -558,10 +558,7 @@
>  S:	Maintained
> =20
>  DEVICE FILESYSTEM
> -P:	Richard Gooch
> -M:	rgooch@atnf.csiro.au
> -L:	linux-kernel@vger.kernel.org
> -S:	Maintained
> +S:	Obsolete
> =20
>  DIGI INTL. EPCA DRIVER
>  P:	Digi International, Inc
> --- 1.28/fs/Kconfig	Thu Aug 14 02:20:32 2003
> +++ edited/fs/Kconfig	Sat Aug 16 12:03:57 2003
> @@ -762,7 +762,7 @@
>  	  programs depend on this, so everyone should say Y here.
> =20
>  config DEVFS_FS
> -	bool "/dev file system support (EXPERIMENTAL)"
> +	bool "/dev file system support (OBSOLETE)"
>  	depends on EXPERIMENTAL
>  	help
>  	  This is support for devfs, a virtual file system (like /proc) which
> @@ -780,6 +780,13 @@
>  	  Note that devfs no longer manages /dev/pts!  If you are using UNIX98
>  	  ptys, you will also need to enable (and mount) the /dev/pts
>  	  filesystem (CONFIG_DEVPTS_FS).
> +
> +	  Note that devfs has been obsoleted by udev,
> +	  <http://http://www.kernel.org/pub/linux/utils/kernel/hotplug/>.

Bogus URL here.

--=20
Tom Rini
http://gate.crashing.org/~trini/

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/QRIndZngf2G4WwMRAo1TAJ4p6mbYWOt55WbMTWZC4gWtlMRoeQCfYeMO
w7OA5vp6Cc7Wp5UYgYT06wA=
=L8MY
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
