Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965609AbWKDVBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965609AbWKDVBO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 16:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965687AbWKDVBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 16:01:14 -0500
Received: from lug-owl.de ([195.71.106.12]:30682 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S965609AbWKDVBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 16:01:13 -0500
Date: Sat, 4 Nov 2006 22:01:11 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Albert Cahalan <acahalan@gmail.com>
Cc: kangur@polcom.net, mikulas@artax.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
Message-ID: <20061104210111.GB21485@lug-owl.de>
Mail-Followup-To: Albert Cahalan <acahalan@gmail.com>,
	kangur@polcom.net, mikulas@artax.karlin.mff.cuni.cz,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.63.0611022346450.14187@alpha.polcom.net> <787b0d920611041159y6171ec25u92716777ce9bea4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline
In-Reply-To: <787b0d920611041159y6171ec25u92716777ce9bea4a@mail.gmail.com>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-11-04 14:59:53 -0500, Albert Cahalan <acahalan@gmail.com> wrot=
e:
> Grzegorz Kulewski writes:
> > On Thu, 2 Nov 2006, Mikulas Patocka wrote:
> > > As my PhD thesis, I am designing and writing a filesystem,
> > > and it's now in a state that it can be released. You can
> > > download it from http://artax.karlin.mff.cuni.cz/~mikulas/spadfs/
> >
> > "Disk that can atomically write one sector (512 bytes) so that
> > the sector contains either old or new content in case of crash."
>=20
> New drives will soon use 4096-byte sectors. This is a better
> match for the normal (non-VAX!) page size and reduces overhead.

Well... VAXen use physical PTEs for 512 byte pages, Linux uses 8
consecutive pages to simulate 4K pages.

On top of that, some of today's machines have configurable page sizes.
Besides that, 512 byte sectors are quite a clever thing: Drives
probably can write a number of consecutive sectors, so if you want to
send a page, just send eight sectors.

> BTW, a person with disk recovery experience told me that drives
> will sometimes reorder the sectors. Sector 42 becomes sector 7732,
> sector 880880 becomes sector 12345, etc. The very best filesystems
> can handle with without data loss. (for example, ZFS) Merely great
> filesystems will at least recognize that the data has been trashed.

Uh? This should be transparent to the host computer, so logical sector
numbers won't change.

MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
Signature of:                http://catb.org/~esr/faqs/smart-questions.html
the second  :

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD4DBQFFTP+XHb1edYOZ4bsRAm/sAJ9XWGumJ+Jw0xNW78LwOfENneZ5XgCY1OUa
ZRrxpYKYOBUNRm0BocCAZQ==
=rBhj
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--
