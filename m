Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278338AbRJSI04>; Fri, 19 Oct 2001 04:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278339AbRJSI0r>; Fri, 19 Oct 2001 04:26:47 -0400
Received: from rhlx01.fht-esslingen.de ([134.108.34.10]:33622 "HELO
	rhlx01.fht-esslingen.de") by vger.kernel.org with SMTP
	id <S278338AbRJSI0j>; Fri, 19 Oct 2001 04:26:39 -0400
Subject: Re: MODULE_LICENSE and EXPORT_SYMBOL_GPL
From: Nils Philippsen <nils@wombat.dialup.fht-esslingen.de>
To: linux-kernel@vger.kernel.org
In-Reply-To: <8B8fdgcmw-B@khms.westfalen.de>
In-Reply-To: <8658.1003375433@kao2.melbourne.sgi.com> 
	<8B8fdgcmw-B@khms.westfalen.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-+go/pOZiuaT/6Ne82qqc"
X-Mailer: Evolution/0.15.99 (Preview Release)
Date: 19 Oct 2001 10:26:21 +0200
Message-Id: <1003479981.2793.29.camel@wombat>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+go/pOZiuaT/6Ne82qqc
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 2001-10-19 at 09:16, Kai Henningsen wrote:
> kaos@ocs.com.au (Keith Owens)  wrote on 18.10.01 in <8658.1003375433@kao2=
.melbourne.sgi.com>:
>=20
> > EXPORT_SYMBOL_GPL() allows for new interfaces to be marked as only
> > available to modules with a GPL compatible license.  This is
> > independent of the kernel tainting, but obviously takes advantage of
> > MODULE_LICENSE() strings.
>=20
> Incidentally, an argument can be made that using EXPORT_SYMBOL_GPL =20
> actually renders your code incompatible with the GPL, insofar as it =20
> violates the "additional restriction" clause. Which doesn't matter as lon=
g =20
> as it's *only* your code (author can always do different things), but =20
> *does* matter if you add *other* people's GPL code (such as the rest of =20
> the kernel), because it's *their* GPL that you're breaking ...

[IANAL]

Not the least -- there is no such thing as code "(in)compatible with the
GPL" -- you can alter (or write) GPLed code to do (or don't do) anything
you want when it comes to the GPL. The additional restrictions provision
in the GPL you talk about means restrictions in licensing, not technical
ones. For what it's worth I could alter the glibc to not work when used
by a process called "acroread" or "vmware" or whatever (not that that
would make sense) and still be in full compliance with the GPL as long
as I adhere to the GPL when distributing it.

Nils
--=20
 Nils Philippsen / Berliner Stra=DFe 39 / D-71229 Leonberg //
+49.7152.209647
nils@wombat.dialup.fht-esslingen.de / nils@redhat.de /
nils@fht-esslingen.de
        Ever noticed that common sense isn't really all that common?

--=-+go/pOZiuaT/6Ne82qqc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA7z+OtR9ibZWlRMBERAtMjAJ9IhvlDlZ2AAdAnCwO/XlcmAvW63QCdEj1h
n22w+sG7WhIykiMegd2hRus=
=PsnI
-----END PGP SIGNATURE-----

--=-+go/pOZiuaT/6Ne82qqc--

