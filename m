Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130656AbRCLUzE>; Mon, 12 Mar 2001 15:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130657AbRCLUyz>; Mon, 12 Mar 2001 15:54:55 -0500
Received: from mx2.magma.ca ([206.191.0.250]:18427 "EHLO mx2.magma.ca")
	by vger.kernel.org with ESMTP id <S130656AbRCLUyg>;
	Mon, 12 Mar 2001 15:54:36 -0500
Date: Mon, 12 Mar 2001 15:54:08 -0500
From: Martin Hicks <mort@bork.org>
To: mulix <mulix@actcom.co.il>, linux-kernel@vger.kernel.org
Subject: Re: 2.4 and PPPoE problem
Message-ID: <20010312155408.A10163@plato.bork.org>
In-Reply-To: <20010312145749.A8645@plato.bork.org> <Pine.LNX.4.10.10103122203230.2273-100000@alhambra.merseine.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.10.10103122203230.2273-100000@alhambra.merseine.nu>; from mulix@actcom.co.il on Mon, Mar 12, 2001 at 10:06:15PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Yes...my MTU on ppp0 was to high.  Thanks.

mh

On Mon, Mar 12, 2001 at 10:06:15PM +0200, mulix wrote:
> hi,=20
>=20
> you might want to check your mtu and mru values on both the external
> interface (i assume you are using an ADSL modem, from your usage of
> PPPoE, so that will be eth0) and the internal interface (ppp0). the mtu
> and mru values on the internal interface should be a bit less than those
> on the external interface, to work around modem bugs.=20
>=20
> here in israel, an MTU value of 1500 for the external interface and 1452
> for the internal (1452) seems to work fine and solve a problem which
> sounds exactly like yours.=20
>=20
> On Mon, 12 Mar 2001, Martin Hicks wrote:
>=20
> > The machine connects fine and allows network traffic to pass
> > through the link.
> >=20
> > However, certain websites seem to choke.
> > (notable ones are www.chapters.ca and www.hp.com)
> >=20
> > Using Lynx or Netscape I get the same results, a few bytes of
> > traffic are received and then nothing (eventually the connection
> > times out). =20
>=20
> --=20
> mulix
> http://www.advogato.com/person/mulix
>=20
> linux/reboot.h: #define LINUX_REBOOT_MAGIC1 0xfee1dead
>=20

--=20
Martin Hicks   || mort@bork.org   =20
Use PGP/GnuPG  || DSS PGP Key: 0x4C7F2BEE =20
Beer: So much more than just a breakfast drink.

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6rTdw0ZUZrUx/K+4RAikBAKDJGpkWqE6EUvXWZb5B29/PtIH34gCfd1A+
2LAR5Xhr6W0J4wjCB7jS5nc=
=kTPJ
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
