Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262991AbVAFSNB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262991AbVAFSNB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 13:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262982AbVAFSJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 13:09:42 -0500
Received: from vds-320151.amen-pro.com ([62.193.204.86]:25302 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S262932AbVAFSFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 13:05:15 -0500
Subject: Re: [PATCH] Enhanced Trusted Path Execution (TPE) Linux
	Security	Module
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Felipe Alfaro Solana <lkml@mac.com>
Cc: narahimi@us.ibm.com, Chris Wright <chrisw@osdl.org>,
       linux-kernel@vger.kernel.org, linux-security-module@wirex.com
In-Reply-To: <EA341136-600C-11D9-892F-000D9352858E@mac.com>
References: <1104979908.8060.34.camel@localhost.localdomain>
	 <20050105212629.K469@build.pdx.osdl.net>
	 <1105023040.4028.36.camel@localhost.localdomain>
	 <EA341136-600C-11D9-892F-000D9352858E@mac.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-cLmWxhN8Qwq/qZKjwugs"
Date: Thu, 06 Jan 2005 19:04:36 +0100
Message-Id: <1105034676.4028.77.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cLmWxhN8Qwq/qZKjwugs
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Felipe,

El jue, 06-01-2005 a las 19:00 +0100, Felipe Alfaro Solana escribi=F3:
> On 6 Jan 2005, at 15:50, Lorenzo Hern=E1ndez Garc=EDa-Hierro wrote:
>=20
> >> The two biggest issues are 1) it's trivial to bypass:
> >> $ /lib/ld.so /untrusted/path/to/program
> >> and 2) that there's no (visible/vocal) user base calling for the=20
> >> feature.
> >
> > About the point 1), yesterday i wrote just a simple regression test
> > (that can be found at the same place as the patch) and of course it
> > bypasses, this is an old commented problem, Stephen suggested the use=20
> > of
> > the mmap and mprotect hooks, so, i will have a look at them but i'm not
> > sure on how to (really) prevent the dirty,old trick.
> > About 2), just give it a chance, maybe it's useful and my work is not
> > completely nonsense.
>=20
> Well, I'm not a visible/vocal user base, but I do really like this TPE=20
> LSM module.

Thanks :)
I hope you will like much more the revision i'm coding right now.
Tonight, my queue is a bit overloaded, i need to fix some things in the
SELinux 2.4 backport, but i hope i will finish it today as it doesn't
require a lot of time.

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org> [1024D/6F2B2DEC]
[2048g/9AE91A22] Hardened Debian head developer & project manager

--=-cLmWxhN8Qwq/qZKjwugs
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBB3X20DcEopW8rLewRAihjAKCcd0JxaeKaDb0qjKowEIGAFJMuewCdG9sW
SViht1XrQ8r01cLe6IVDku0=
=birp
-----END PGP SIGNATURE-----

--=-cLmWxhN8Qwq/qZKjwugs--

