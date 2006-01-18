Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030196AbWARIpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbWARIpj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 03:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030193AbWARIpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 03:45:39 -0500
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:12466 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1030196AbWARIpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 03:45:38 -0500
From: Ian Campbell <ijc@hellion.org.uk>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20060117190445.GA4298@infomag.infomag.iguana.be>
References: <1130921809.12578.179.camel@icampbell-debian>
	 <20051105101026.GA28438@flint.arm.linux.org.uk>
	 <1131358884.14696.57.camel@icampbell-debian>
	 <20060117190445.GA4298@infomag.infomag.iguana.be>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-A7bBulZa56/2hjxvBaDS"
Date: Wed, 18 Jan 2006 08:45:17 +0000
Message-Id: <1137573917.16338.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: ijc@hellion.org.uk
Subject: Re: [WATCHDOG] sa1100_wdt.c sparse cleanups
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on hopkins.hellion.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-A7bBulZa56/2hjxvBaDS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-01-17 at 20:04 +0100, Wim Van Sebroeck wrote:
> Hi Ian,
>=20
> > On Sat, 2005-11-05 at 10:10 +0000, Russell King wrote:
> >=20
> > > It's probably better to use a union with these, eg:
> >=20
> > The common idiom in the watchdog drivers seems to be to use separate
> > variables. I'll leave it up to Wim if he wants to change that.
> >=20
> > The following makes drivers/char/watchdog/sa1100_wdt.c sparse clean.
> >=20
> > Signed-off-by: Ian Campbell <icampbell@arcom.com>
>=20
> I seem to have missed this last e-mail (I was moving around that time...)=
.
> This is indeed how it's been done in other drivers. I just uploaded this =
"patch"
> into my -mm test tree. Within a week or two I'll move it to the final wat=
chdog tree.
>=20
> We should look to the struct watchdog part in more detail though.
> a union is an option, but probably not the only one :-)

Hi Wim,

Thanks for applying the patch.

BTW I've changed jobs since I sent it and I'm no longer working with ARM
hardware.

Ian.

--=20
Ian Campbell

Q:	Why do the police always travel in threes?
A:	One to do the reading, one to do the writing, and the other keeps
	an eye on the two intellectuals.

--=-A7bBulZa56/2hjxvBaDS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDzgAdM0+0qS9rzVkRAsM4AJ0cYGK3DvM5OzOsWk/usne2oYPOzQCg1zck
ld4k0B/OnTXgvsgqWCLQWZE=
=0mjH
-----END PGP SIGNATURE-----

--=-A7bBulZa56/2hjxvBaDS--

