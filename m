Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbWDJJbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWDJJbd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 05:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWDJJbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 05:31:33 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:63408 "EHLO smurf.noris.de")
	by vger.kernel.org with ESMTP id S1751087AbWDJJbc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 05:31:32 -0400
Date: Mon, 10 Apr 2006 11:31:19 +0200
To: Eric Sesterhenn <snakebyte@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] Overrun in
Message-ID: <20060410093119.GJ18658@smurf.noris.de>
References: <1144659666.15586.1.camel@alice>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B8ONY/mu/bqBak9m"
Content-Disposition: inline
In-Reply-To: <1144659666.15586.1.camel@alice>
User-Agent: Mutt/1.5.11
From: smurf@smurf.noris.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--B8ONY/mu/bqBak9m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Eric Sesterhenn:
> since the arrays are declared as in_urbs[N_IN_URB]
> and out_urbs[N_OUT_URB] both for loops, go one
> over the end of the array. This fixes coverity id #555
>=20
Ouch. Thanks.

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de

--B8ONY/mu/bqBak9m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEOiXn8+hUANcKr/kRAqrfAJ0dpLuMw6qRYitTNoBkugYg4KvPRwCggiN+
hJPjbS3rmZYT3OgtvsCAsiI=
=EEwM
-----END PGP SIGNATURE-----

--B8ONY/mu/bqBak9m--
