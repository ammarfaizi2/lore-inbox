Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276380AbRJUUOw>; Sun, 21 Oct 2001 16:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276688AbRJUUOn>; Sun, 21 Oct 2001 16:14:43 -0400
Received: from cs6625129-123.austin.rr.com ([66.25.129.123]:18181 "HELO
	dragon.taral.net") by vger.kernel.org with SMTP id <S276380AbRJUUOZ>;
	Sun, 21 Oct 2001 16:14:25 -0400
Date: Sun, 21 Oct 2001 15:16:50 -0500
From: Taral <taral@taral.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MODULE_LICENSE and EXPORT_SYMBOL_GPL
Message-ID: <20011021151650.C13718@taral.net>
In-Reply-To: <20011019103041.D30774@taral.net> <E15vKR6-0006g5-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <E15vKR6-0006g5-00@the-village.bc.nu>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 21, 2001 at 04:22:47PM +0100, Alan Cox wrote:
> You are arguably obtaining services by deception, and possibly also
> violating a content management system.
>=20
> However the MODULE_LICENSE isn't aimed at people like that. In fact I've =
had
> totally positive responses from people who ship well known binary modules
> and understand why we want them to get bugs related to their code.
>=20
> The people bright enough to hack insmod generally are also bright enough =
to
> realise why its a bad idea.

I'm not arguing against MODULE_LICENSE. I'm arguing against
EXPORT_SYMBOL_GPL. I fully agree with the person who mentioned that
calling certain interfaces "restricted" and basing that restriction on
the licence of the interface user is an abuse of copyright.

More reasonable would be to have header files that looked like this:

#ifndef GPL_COMPATIBLE_LICENSE
#error This header file is restricted to GPL-compatible code only.
#endif

--=20
Taral <taral@taral.net>
This message is digitally signed. Please PGP encrypt mail to me.
"Any technology, no matter how primitive, is magic to those who don't
understand it." -- Florence Ambrose

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjvTLTIACgkQoQQF8xCPwJS1BACfREFjtnEn2+jfMZiW9fxsitdE
yiwAnRHSZ/N0yUOclriCNct7AmB2WgxH
=p6R3
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
