Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267839AbUIZR0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267839AbUIZR0b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 13:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267840AbUIZR0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 13:26:31 -0400
Received: from pauli.thundrix.ch ([213.239.201.101]:28648 "EHLO
	pauli.thundrix.ch") by vger.kernel.org with ESMTP id S267839AbUIZR00
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 13:26:26 -0400
Date: Sun, 26 Sep 2004 19:24:29 +0200
From: Tonnerre <tonnerre@thundrix.ch>
To: Olivier Galibert <galibert@pobox.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: __initcall macros and C token pasting
Message-ID: <20040926172429.GA15441@thundrix.ch>
References: <9e47339104092510574c908525@mail.gmail.com> <20040925183234.GU23987@parcelfarce.linux.theplanet.co.uk> <9e473391040925121774e7e1e1@mail.gmail.com> <20040926172104.GA44528@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <20040926172104.GA44528@dspnet.fr.eu.org>
X-GPG-KeyID: 0x8BE1C38D
X-GPG-Fingerprint: 1AB0 9AD6 D0C8 B9D5 C5C9  9C2A FF86 CBEE 8BE1 C38D
X-GPG-KeyURL: http://users.thundrix.ch/~tonnerre/tonnerre.asc
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

On Sun, Sep 26, 2004 at 07:21:04PM +0200, Olivier Galibert wrote:
> > One response is to build a stable API for the core.
>=20
> This has absolutely zero chance to happen, as the evolution of the
> kernel has proven time and again.  The internal APIs of the kernel
> aren't stable, however much we'd like them to be, because the best way
> to do something at time t isn't the best way to do it at time t+1.
> The best that is done is to try to change the drivers at the time the
> core changes, and that only happens if the source of the drivers is
> there along with the rest of the kernel.

That'd be true if fact were fiction and TV reality.

Actually, lots  of drivers  that *are* in  the kernel are  pretty much
broken.

And I don't  think putting more drivers into  the mainline kernel will
fix this problem.

The  only thing that  will is  doing stable  and development  trees in
different places. We ceased to do that, and *it's* *no* *good*.

			    Tonnerre

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.2 (GNU/Linux)

iD8DBQFBVvtM/4bL7ovhw40RAie4AKCDVHKgJuLXMDmgBHkceKAGWDq6gACcDzEP
+v3jAn7KcxYTnPH+pCylth8=
=b6IL
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
