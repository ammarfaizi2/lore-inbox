Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261910AbVCANYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbVCANYE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 08:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbVCANWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 08:22:14 -0500
Received: from ipp23-131.piekary.net ([80.48.23.131]:16348 "EHLO spock.one.pl")
	by vger.kernel.org with ESMTP id S261900AbVCANVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 08:21:41 -0500
Date: Tue, 1 Mar 2005 14:09:10 +0100
From: Michal Januszewski <spock@gentoo.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Arjan van de Ven <arjan@infradead.org>, aj@suse.de,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Bootsplash for 2.6.11-rc4
Message-ID: <20050301130910.GD14278@spock.one.pl>
References: <20050218165254.GA1359@elf.ucw.cz> <20050219011433.GA5954@spock.one.pl> <20050219230326.GB13135@kroah.com> <20050219232519.GC1372@elf.ucw.cz> <20050220132600.GA19700@spock.one.pl> <20050227165420.GD1441@elf.ucw.cz> <1109532700.15362.42.camel@laptopd505.fenrus.org> <20050227194123.GX1441@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mJm6k4Vb/yFcL9ZU"
Content-Disposition: inline
In-Reply-To: <20050227194123.GX1441@elf.ucw.cz>
X-PGP-Key: http://dev.gentoo.org/~spock/spock.gpg
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mJm6k4Vb/yFcL9ZU
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 27, 2005 at 08:41:23PM +0100, Pavel Machek wrote:

Hi,

> [aj added to the list].
>=20
> Andreas, who is the person to talk about this? I like redhat's
> solution the best. Pass "quiet", perhaps replace penguin with some big
> picture including penguin and chameleon or something, and do the
> interesting work in userspace...
>=20
> That's the best solution, technically... Perhaps it is even acceptable
> politically?

And that's exactly how it will be done in fbsplash, as soon as I move
the rest of the 'silent'-handling code to the userspace. Fbsplash will=20
call a userspace helper as soon as fbcon is initialized. The helper can=20
be used put the console into KD_GRAPHICS mode and paint a full-screen=20
picture to cover any text messages. Progress bars and other fancy stuff=20
will be handled after init, by 100% userspace code (it's done that way=20
even with the current version of fbsplash).

Live long and prosper.
--=20
Michal 'Spock' Januszewski                        Gentoo Linux Developer
cell: +48504917690                         http://dev.gentoo.org/~spock/
JID: spock@im.gentoo.org               freenode: #gentoo-dev, #gentoo-pl


--mJm6k4Vb/yFcL9ZU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCJGl2aQ0HSaOUe+YRAg7EAKCl5th3eSISyAv6SJNhVFDo326vKgCfRgcF
gBZrAkslRjsvSekkoeP6SPw=
=lpjJ
-----END PGP SIGNATURE-----

--mJm6k4Vb/yFcL9ZU--
