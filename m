Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbWB1KFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbWB1KFy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 05:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbWB1KFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 05:05:53 -0500
Received: from mail.gmx.de ([213.165.64.20]:56196 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751004AbWB1KFw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 05:05:52 -0500
X-Authenticated: #2308221
Date: Tue, 28 Feb 2006 11:05:48 +0100
From: Christian Trefzer <ctrefzer@gmx.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christian Trefzer <ctrefzer@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: libata PATA patch for 2.6.16-rc5
Message-ID: <20060228100548.GA19574@zeus.uziel.local>
References: <1141054370.3089.0.camel@localhost.localdomain> <20060228003039.GA13335@zeus.uziel.local> <1141120189.3089.47.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <1141120189.3089.47.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 28, 2006 at 09:49:49AM +0000, Alan Cox wrote:
>=20
> Thanks for the report. The PDC20268 and 2027x are driven by Albert Lee's
> Promise driver which should end up in the main tree soon, probably
> before my PATA bits.=20
>=20

That's weird, pata_pdc2027x.c is in the -rc5 tree, or at least after
applying your -ide1 patch, but the references in Kconfig and Makefile
are missing. Is this intentional? I'll try and scribble something up,
diff is about to follow.

Thanks for the pointer!

Chris

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iQIVAwUBRAQgfF2m8MprmeOlAQIYGQ/9EnvUVVEFX9dUo3EckLq82n+f5KUAz3vZ
lNZFFxUYIb62aJYd7TRRxNBvm8HBASR6UWKMuoR0ubCEo3OvvwhDmLK29o6j0/vb
2ayKWcDTrjZDa+DlbvKrO1AUBtE98Ija6zmw+OVftN8e0Gp0k3x5zhQiCUpWeTb0
H5mD1o3GcH7e0Bw8EDQyXQ7SXd7D44enorG3KlJ8RmyHv1o6klvydJl2EFeM+XM3
IbpcHrwA0LdAsn9ZokVQOwR7GE//Qb7imLba7wPSz6RCwOnWQgrHU2UvxbiJjo0l
d+IXzi9ixADcvjFMr7wBcE5mNU/2AQeGvFFXyw/7FbGvDfmfm94x5SSm9S0VJaKd
PLedmCCqkdwLaHF8W/UJeQQSpu82xaADdh04x9w+0uaKI146Ee+3y/WOg3sV6619
FhSddC3cIz9e2SfeKDP4S+hcHvuHPJq0sfV/DV8Wlh1Lff8yVFkfBeaW0RRG153C
2ommkk5EUimv+mX5qdaZqkJDiA74M9HbeaSnZh6CrQUXbNuBKgpuRpWf8IRbX9zG
VRnJe0egvz/QcX0xcKFZoOz9VwzZJ5GLz+GuHuYBSDS2nTt0R/X+lo06iOZcU+hc
4Zi8J438kw5EvTI0LovOtD5SFZqsi9amvHQUtYt8E/GgDHB5xgnS9MzR9vksLVQe
uIh8r9XK0YQ=
=BrcA
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--

