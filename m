Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318767AbSHLSTd>; Mon, 12 Aug 2002 14:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318768AbSHLSTd>; Mon, 12 Aug 2002 14:19:33 -0400
Received: from winch-as1-42.win.ORG ([204.184.50.138]:33412 "EHLO
	SpacedOut.fries.net") by vger.kernel.org with ESMTP
	id <S318767AbSHLSTc>; Mon, 12 Aug 2002 14:19:32 -0400
Date: Mon, 12 Aug 2002 13:25:58 -0500
From: David Fries <dfries@mail.win.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: via vp3 udma corruption
Message-ID: <20020812182558.GB677@spacedout.fries.net>
References: <20020811210826.GA684@spacedout.fries.net> <20020812170232.GC15249@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Content-Disposition: inline
In-Reply-To: <20020812170232.GC15249@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I ran oldconfig, but I probably just said, 'USB I have all the drivers
I need, NO', but thanks, I figured out that option when I read the USB
mailing list.

Are there alternate ways of getting data to the /dev/usb/mice type
devices CONFIG_INPUT_MOUSEDEV?  (Major 13, Minor 63), or shouldn't an
open to that device fail with no device if CONFIG_USB_HIDINPUT isn't
enabled?

On Mon, Aug 12, 2002 at 10:02:33AM -0700, Greg KH wrote:
> On Sun, Aug 11, 2002 at 04:08:26PM -0500, David Fries wrote:
> >=20
> > I did most of my testing with 2.4.17 since my USB mouse doesn't work
> > with 2.4.19 but does with 2.4.17.
>=20
> Make sure CONFIG_USB_HIDINPUT is enabled.  You _did_ run=20
> 'make oldconfig' with your old 2.4.17 .config file, right?
>=20
> thanks,
>=20
> greg k-h

--=20
David Fries <dfries@mail.win.org>
http://fries.net/~david/pgp.txt

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj1X/bYACgkQAI852cse6PB7GACeOLqVnDLlFyjMyGWBzBSpJbwD
U6YAmgJyvasP4YZy/6GkOChVk8Tt0vt5
=RPNv
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
