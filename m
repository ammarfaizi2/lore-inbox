Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbVCGIOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbVCGIOi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 03:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbVCGIOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 03:14:37 -0500
Received: from faye.voxel.net ([69.9.164.210]:43460 "EHLO faye.voxel.net")
	by vger.kernel.org with ESMTP id S261679AbVCGIOX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 03:14:23 -0500
Subject: Re: [RFQ] Rules for accepting patches into the linux-releases tree
From: Andres Salomon <dilinger@voxel.net>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050306235027.268da803.pj@sgi.com>
References: <20050304222146.GA1686@kroah.com>
	 <20050305104305.GB7671@pclin040.win.tue.nl>
	 <pan.2005.03.06.17.10.41.114607@voxel.net>
	 <20050306235027.268da803.pj@sgi.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-M5moWGaLEOAKX7TSOi2y"
Date: Mon, 07 Mar 2005 03:14:23 -0500
Message-Id: <1110183263.7581.16.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-M5moWGaLEOAKX7TSOi2y
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2005-03-06 at 23:50 -0800, Paul Jackson wrote:
> Andres wrote:
> > An obvious fix is an obvious fix.
>=20
> Perhaps in theory.  But in practice, any fix bears some risk.
>=20

Of course; no one's arguing that (things that depend on broken behavior,
corner cases, etc).  In practice, however; an obvious fix is still an
obvious fix.  :)

What I mean is, if there's an unknown (ie, due to hardware behavior,
user input, etc), and it's not adding sanity checking or somehow
ensuring that the data it's dealing with is of a certain form, then it's
not really an obvious fix.

Of course, part of the problem is that "obvious" is subjective.  I know
what *I* consider obvious; someone who works for a hardware company, and
has access to hardware, specifications, and errata would have different
criteria for what they consider obvious.  Here's where that
signed-off-by-5-people thing comes into play.


> They have nothing against "obvious" fixes.  But unless additional
> criteria are also met, such fixes are for someone else to apply.
>=20

That's fine; I agree w/ the additional criteria of "it must be a build,
oops, hang, or race fix". =20

> > >>  - It can not contain any "trivial" fixes in it (spelling changes,
> > >>    whitespace cleanups, etc.)
> >=20
> > This and the "it must fix a problem" are basically saying the same thin=
g.
>=20
> Not at all.  Let me put it this way.
>=20
> If a change that fixes a problem is included in a patch with another
> change that makes trivial changes (typo fix, say), the patch will
> be rejected.
>=20

That's fine as well; that's covered by the "it must only fix one thing"
rule, which I also agree w/.  The "no trivial fixes" thing is still
redundant; a) a patch must contain only one fix, and b) a patch may only
fix a build error, oops, hang, or race.


> The statement:
>=20
>     "It must fix a problem and it must _not_ contain anything else,
>      such as 'trivial' fixes."
>=20
> is _obviously_ not the same as:
>=20
>     "It must fix a problem."
>=20
> (Notice how quickly even the obvious becomes unobvious ...;).
>=20


--=20
Andres Salomon <dilinger@voxel.net>

--=-M5moWGaLEOAKX7TSOi2y
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCLA1e78o9R9NraMQRAna2AJ92nbyOjneL4WSoL83I5fDhYS3UwQCeOmsr
l40DYj2VhFa7jQgdDXpVbQ8=
=u9K9
-----END PGP SIGNATURE-----

--=-M5moWGaLEOAKX7TSOi2y--

