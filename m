Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbTLUL3r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 06:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262747AbTLUL3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 06:29:47 -0500
Received: from neveragain.de ([217.69.76.1]:31625 "EHLO hobbit.neveragain.de")
	by vger.kernel.org with ESMTP id S262740AbTLUL3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 06:29:44 -0500
Date: Sun, 21 Dec 2003 12:29:34 +0100
From: Martin Loschwitz <madkiss@madkiss.org>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>, linux-kernel@vger.kernel.org
Subject: Re: 3ware driver broken with 2.4.22/23 ?
Message-ID: <20031221112933.GA5758@minerva.local.lan>
References: <20031221112113.GE916@mail.muni.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <20031221112113.GE916@mail.muni.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 21, 2003 at 12:21:13PM +0100, Lukas Hejtmanek wrote:
> Hello,
>=20
> I have 3ware Escalade 8500-8 card with 8 SATA WD 250GB drives. I set up H=
W RAID5
> configuration over all drives.
> I'm using kernel 2.4.23 vanilla with XFS patch. RAID5 partition is format=
ed to
> XFS.
> System is single hyper threaded P4 Xeon 2.8GHz with 1GB of RAM. There is =
Intel
> 1000/PRO ethernet card. Motherboard is MSI E7501 Master-LS.
>=20
> If I do:
> iozone -Ra -g 20G -e -n 10485760=20
> on the XFS partition then it freezes after certain time (but always the s=
ame
> amount if I run it again few times).
>=20
> Server responds only to ping and sysrq. No process can be run and already
> running process top freezes as well. After about 8 hours it is still free=
zed.
> If I connect monitor to the server when it freezes then monitor indicates=
 - no
> signal.
>=20
> I use configuration with SMP without HIGHMEM. However it happens without =
SMP as
> well. (Driver: 1.02.00.036)
>=20
> With kernel 2.6.0 it seems to be ok. (Driver: 1.02.00.037)
>=20
> Can firmware upgrade help? Or there is an issue with something other not =
related
> to 3ware card?
>=20
Well, it happens from time to time that the card refuses to work with an
actual driver as actual drivers sometimes make use of functions introduced
in firmware upgrades. Upgrading the firmware should be the first thing to
try. Chances are it works well even with 2.4 afterwards.

> --=20
> Luk=E1? Hejtm=E1nek
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
  .''`.   Martin Loschwitz           Debian GNU/Linux developer
 : :'  :  madkiss@madkiss.org        madkiss@debian.org
 `. `'`   http://www.madkiss.org/    people.debian.org/~madkiss/
   `-     Use Debian GNU/Linux 3.0!  See http://www.debian.org/

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/5YQdHPo+jNcUXjARAiuLAKCYiNOsF6tNZ0+0Y8UkZUZquspxKACeK2lE
0LWVAh6hZnf1wBaht1ZLJUU=
=Niwu
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
