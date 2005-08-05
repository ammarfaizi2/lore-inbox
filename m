Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbVHEV51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbVHEV51 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 17:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263141AbVHEVzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 17:55:10 -0400
Received: from neveragain.de ([217.69.76.1]:37582 "EHLO hobbit.neveragain.de")
	by vger.kernel.org with ESMTP id S261798AbVHEVxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 17:53:47 -0400
Date: Fri, 5 Aug 2005 23:53:46 +0200
From: Martin Loschwitz <madkiss@madkiss.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: local DDOS? Kernel panic when accessing /proc/ioports
Message-ID: <20050805215346.GB25652@minerva.local.lan>
References: <20050805192628.GA24706@minerva.local.lan> <1123272188.8003.20.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Content-Disposition: inline
In-Reply-To: <1123272188.8003.20.camel@mindpipe>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender succeded SMTP AUTH authentication, not delayed by milter-greylist-1.4 (hobbit.neveragain.de [217.69.76.1]); Fri, 05 Aug 2005 23:53:45 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 05, 2005 at 04:03:07PM -0400, Lee Revell wrote:
> On Fri, 2005-08-05 at 21:26 +0200, Martin Loschwitz wrote:
> > Ooops and ksymoops-output is attached.
>=20
> Also, don't use ksymoops for 2.6, it's redundant at best and at worst
> actually removes information.  Check oops-tracing.txt, the docs have
> been updated.
>=20

Well, in this case, ksymoops output told me what I wanted to know -- the
thing explodes when reading /proc/ioports. I need to know why it does, if
the problem might be reproducible for others (that is the possible ddos
thing ...) and how to fix it ...

> Lee
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
  .''`.   Martin Loschwitz           Debian GNU/Linux developer
 : :'  :  madkiss@madkiss.org        madkiss@debian.org
 `. `'`   http://www.madkiss.org/    people.debian.org/~madkiss/
   `-     Use Debian GNU/Linux 3.0!  See http://www.debian.org/

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC89/qHPo+jNcUXjARAtIsAKCr8KzSHNP0m8bTcDUnBbqPBNpq8ACgsS7f
YdsVtCuKJ8f47ajbheeB12E=
=TLZr
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
