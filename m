Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753839AbWKFVqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753839AbWKFVqX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 16:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753785AbWKFVqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 16:46:23 -0500
Received: from mail.isohunt.com ([69.64.61.20]:60856 "EHLO mail.isohunt.com")
	by vger.kernel.org with ESMTP id S1753839AbWKFVqW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 16:46:22 -0500
X-Spam-Check-By: mail.isohunt.com
Date: Mon, 6 Nov 2006 13:46:27 -0800
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: "Robin H. Johnson" <robbat2@gentoo.org>, linux-kernel@vger.kernel.org
Subject: Re: [x86_64] soft lockup with sunrpc/nfsd (also DWARF2 unwinder stuck)
Message-ID: <20061106214627.GS15897@curie-int.orbis-terrarum.net>
References: <20061106044752.GP15897@curie-int.orbis-terrarum.net> <1162819898.14238.1.camel@twins>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VdnGiXwuH6t1Tqzo"
Content-Disposition: inline
In-Reply-To: <1162819898.14238.1.camel@twins>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VdnGiXwuH6t1Tqzo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2006 at 02:31:38PM +0100, Peter Zijlstra wrote:
> On Sun, 2006-11-05 at 20:47 -0800, Robin H. Johnson wrote:
> > The -git head as of today (2.6.19-rc4-git9) has a bug with SunRPC by th=
e looks
> > of it.=20
>=20
> Does:
>   http://lkml.org/lkml/2006/10/29/43
> fix it?

Yup, that seems to solve the lockup, thanks.

--=20
Robin Hugh Johnson
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--VdnGiXwuH6t1Tqzo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFFT60zPpIsIjIzwiwRAnkuAJ0WP3IzuUOvrhYlQTSn2FMGaPC76ACdEEuf
+LA6BVfFW24BhkfCvRuUscM=
=Lbdu
-----END PGP SIGNATURE-----

--VdnGiXwuH6t1Tqzo--
