Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262598AbVCVKBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbVCVKBn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 05:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262599AbVCVKBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 05:01:43 -0500
Received: from relay.rost.ru ([80.254.111.11]:40146 "EHLO relay.rost.ru")
	by vger.kernel.org with ESMTP id S262598AbVCVKBU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 05:01:20 -0500
Date: Tue, 22 Mar 2005 13:01:14 +0300
From: Andrey Panin <pazke@donpac.ru>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Kenan Esau <kenan.esau@conan.de>, harald.hoyer@redhat.de,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [rfc/rft] Fujitsu B-Series Lifebook PS/2 TouchScreen driver
Message-ID: <20050322100114.GI2810@pazke>
Mail-Followup-To: Dmitry Torokhov <dtor_core@ameritech.net>,
	Kenan Esau <kenan.esau@conan.de>, harald.hoyer@redhat.de,
	linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
	Vojtech Pavlik <vojtech@suse.cz>
References: <20050217194217.GA2458@ucw.cz> <d120d500050321065261ee815c@mail.gmail.com> <1111419068.8079.15.camel@localhost> <200503220213.46375.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8JPrznbw0YAQ/KXy"
Content-Disposition: inline
In-Reply-To: <200503220213.46375.dtor_core@ameritech.net>
X-Uname: Linux 2.6.11-pazke i686
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8JPrznbw0YAQ/KXy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 081, 03 22, 2005 at 02:13:45AM -0500, Dmitry Torokhov wrote:
> On Monday 21 March 2005 10:31, Kenan Esau wrote:
> > Am Montag, den 21.03.2005, 09:52 -0500 schrieb Dmitry Torokhov:
> > >=20
> > > There are couple of things that I an concerned with:
> > >=20
> > > 1. I don't like that it overrides meaning of max_proto parameter to be
> > > exactly the protocol specified.=20
> >=20
> > Yeah -- I agree. I also don't like that double-meaning. That was the
> > reason why I originally proposed the use of a new parameter...
> >=20
>=20
> Ok, I have some patches to lifebook that I would like to included (if
> they work):
>=20
> 1. lifebook-dmi-x86-only - do not compile in DMI detection on anything
>    but x86.

On !x86 machines DMI functions will be optimized away and so you'll save on=
ly
few bytes in .init.data section. IMHO it's not worth additional ugly #ifdef=
's.

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--8JPrznbw0YAQ/KXy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCP+zqby9O0+A2ZecRAlArAJ9lWC4R3kFASxSDCEp+pzCkdY+siACgxZx7
CKE+aXmHGOYOjSNwO7Fx/gY=
=1sWd
-----END PGP SIGNATURE-----

--8JPrznbw0YAQ/KXy--
