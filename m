Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263893AbUGRMyC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbUGRMyC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 08:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263972AbUGRMyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 08:54:02 -0400
Received: from wblv-254-37.telkomadsl.co.za ([165.165.254.37]:45792 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S263893AbUGRMxx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 08:53:53 -0400
Subject: Re: Linux 2.6.8-rc2
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1090149153.3198.3.camel@paragon.slim>
References: <Pine.LNX.4.58.0407172237370.12598@ppc970.osdl.org>
	 <1090149153.3198.3.camel@paragon.slim>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-CeR2fzje0VelZIyi0sBN"
Message-Id: <1090155388.9380.37.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 18 Jul 2004 14:56:28 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CeR2fzje0VelZIyi0sBN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-07-18 at 13:12, Jurgen Kramer wrote:
> On Sun, 2004-07-18 at 07:41, Linus Torvalds wrote:
> > MTD updates, i2c updates and some USB updates, and a lot of small stuff
> > (sparse cleanups and fixes from Al etc).
> >=20
> > 		Linus
> >=20
> Just gave it a try. My EHCI controller is still failing (Asus P4C800-E
> i875p) as in the 2.6.7-mm series.
>=20
> <snip>
> ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
> ehci_hcd 0000:00:1d.7: EHCI Host Controller
> ehci_hcd 0000:00:1d.7: BIOS handoff failed (104, 1010001)
> ehci_hcd 0000:00:1d.7: can't reset
> ehci_hcd 0000:00:1d.7: init 0000:00:1d.7 fail, -95
> ehci_hcd: probe of 0000:00:1d.7 failed with error -95
> USB Universal Host Controller Interface driver v2.2
> <snip>
>=20
> Full dmesg output attached.
>=20

I have a P4C800-E (DLX) as well, but it is working fine.
The big differences I see is:
1) You have the 3Com network device where I have the E1000
   (I thought all P4C800-E have E1000, where the smaller ones,
    P4C800, P4C800-DLX have 3Com ??)
2) I use Interrupt Vectors, where you seem not to?

I am on bios 1016 (latest stable for P4C800-E DLX, while I
see there is a 1017 beta 002).

Not sure if you want my .config to compare?


Cheers,

--=20
Martin Schlemmer

--=-CeR2fzje0VelZIyi0sBN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA+nN8qburzKaJYLYRAiKIAJ4hGqOF1ARHrrP3kJmpECBBW9lnlACeLNBF
AU3PlBzhudfjOGgU9Ugwq/w=
=KpU+
-----END PGP SIGNATURE-----

--=-CeR2fzje0VelZIyi0sBN--

