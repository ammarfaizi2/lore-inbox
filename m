Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129105AbQJ0R23>; Fri, 27 Oct 2000 13:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130072AbQJ0R2U>; Fri, 27 Oct 2000 13:28:20 -0400
Received: from ziggy.one-eyed-alien.net ([216.51.112.145]:1804 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S129105AbQJ0R2E>; Fri, 27 Oct 2000 13:28:04 -0400
Date: Fri, 27 Oct 2000 10:26:45 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Weis <djweis@sjdjweis.com>, linux-kernel@vger.kernel.org
Subject: Re: GPL Question
Message-ID: <20001027102645.B28279@one-eyed-alien.net>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	David Weis <djweis@sjdjweis.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10010271130550.23907-100000@catbert.desm.plconline.com> <E13pDC5-0004g7-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <E13pDC5-0004g7-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Oct 27, 2000 at 06:21:27PM +0100
Organization: One Eyed Alien Networks
X-Copyright: (C) 2000 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2000 at 06:21:27PM +0100, Alan Cox wrote:
> > On Fri, 27 Oct 2000, Jason Wohlgemuth wrote:
> >=20
> > > Now, if a module is loaded that registers a set of functions that hav=
e=20
> > > increased functionality compared to the original functions, if that=
=20
> > > modules is not based off GPL'd code, must the source code of that mod=
ule=20
> > > be released under the GPL?
> >=20
> > It would probably follow GPL, but it's pretty slimy. I won't buy it.
>=20
> It depends primarily if the module depends on the code which is GPL. Its =
all
> a rather unclear area.=20

Legally, I think this is probably unclear.  But, I have my own, personal
standard I use for this.

The question in my mind is one of "can it stand alone".  In the example
originally mentioned, the new module (let's call it the alpha module)
registers function calls with the old module (let's call it beta).

Now, the question in my mind is this:  Is alpha a replacement for beta? It
certainly sounds like it.  But it depends of what/how many functions are
being overridden.  Are there other functions from beta which are used by
alpha (either as above alpha or below it)?  What are these replacement
functions trying to do?  If you're using an allready existing abstraction
layer, then you're probably okay... but if you're really inventing a new
abstraction layer, then you're probably not okay.

I guess what I'm saying is this: It all comes down to intent for me.  Yeah,
that's a lousy standard to use, especially in a courtroom.  But that's what
I really care about in the end.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

We can customize our colonels.
					-- Tux
User Friendly, 12/1/1998

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE5+brVz64nssGU+ykRArtNAKDfsDEF/S7BpCson6/0fSrHsc4QAACePQrC
NrjFbaNCgio7x6wnIE4yPsY=
=PxRL
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
