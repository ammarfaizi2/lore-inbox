Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbVEBEFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVEBEFS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 00:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbVEBEFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 00:05:18 -0400
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:15750 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S261507AbVEBEFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 00:05:09 -0400
Date: Sun, 1 May 2005 21:05:05 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: Support multiply-LUN devices in ub
Message-ID: <20050502040505.GA6914@one-eyed-alien.net>
Mail-Followup-To: Pete Zaitcev <zaitcev@redhat.com>, greg@kroah.com,
	linux-kernel@vger.kernel.org
References: <20050501160540.5b2f4e61.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <20050501160540.5b2f4e61.zaitcev@redhat.com>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2005 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 01, 2005 at 04:05:40PM -0700, Pete Zaitcev wrote:
> @@ -49,7 +48,14 @@
>  #define US_SC_SCSI	0x06		/* Transparent */
> =20
>  /*
> + * This many LUNs per USB device.
> + * Every one of them takes a host, see UB_MAX_HOSTS.
>   */
> +#define UB_MAX_LUNS   4
> +
> +/*
> + */
> +

Why only 4 LUNs?

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

G:   Baaap booop BAHHHP.
Mir: 9600 Baud?
Mik: No, no!  9600 goes baap booop, not booop bahhhp!
					-- Greg, Miranda and Mike
User Friendly, 12/31/1998

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCdabxHL9iwnUZqnkRAiowAKCl/Aqk7BQm7PsngiNgHASzheTSsQCgkfs7
xGv2vB50VRQnBvFsqpcepqI=
=MTEN
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
