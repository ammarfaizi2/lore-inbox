Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266886AbSKOWkt>; Fri, 15 Nov 2002 17:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266888AbSKOWkt>; Fri, 15 Nov 2002 17:40:49 -0500
Received: from [216.38.156.94] ([216.38.156.94]:5905 "EHLO mail.networkfab.com")
	by vger.kernel.org with ESMTP id <S266886AbSKOWkr>;
	Fri, 15 Nov 2002 17:40:47 -0500
Subject: Re: lan based kgdb
From: Dmitri <dmitri@users.sourceforge.net>
To: Stelian Pop <stelian.pop@fr.alcove.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021115222430.GA1877@tahoe.alcove-fr>
References: <3DD5591E.A3D0506D@efi.com> <334960000.1037397999@flay>
	<ar3op8$f20$1@penguin.transmeta.com> 
	<20021115222430.GA1877@tahoe.alcove-fr>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-x78MtniSiMbt864hy/ls"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 15 Nov 2002 14:47:35 -0800
Message-Id: <1037400456.1565.38.camel@usb.networkfab.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-x78MtniSiMbt864hy/ls
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2002-11-15 at 14:24, Stelian Pop wrote:

> Using USB instead of the serial line or the network card would be
> the best IMHO, because:
>=20
> 	* many machines have network cards, but all machines have USB
> 	  (and it's gonna stay this way for some time)
> 	 =20
> 	* the USB stack seems simpler than the net stack +=20
> 	  (eventualy) pcmcia + network card driver.
>=20
> Maybe the 'simpler' USB protocols (usbkbd and usbmouse) could be
> used for this, I don't know...

USB hardware and protocols are master-slave, meaning that you can not
connect another computer to this one directly. What USB *device* would
you want to see connected?

Of course, a USB-Serial adapter would work, and you can connect any
serial terminal, but then we are back to using serial ports; it's just
you will need a different driver for that.

Dmitri


--=-x78MtniSiMbt864hy/ls
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA91XmHiqqasvm69/IRAhi3AJ4jYhv/xHapX0Y7SlbB9aRiL6NaogCeNbj4
CBEUpLkP+kKw39pRTl530o4=
=pu7H
-----END PGP SIGNATURE-----

--=-x78MtniSiMbt864hy/ls--

