Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbVBSBOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbVBSBOi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 20:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVBSBOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 20:14:38 -0500
Received: from ipp23-131.piekary.net ([80.48.23.131]:7147 "EHLO spock.one.pl")
	by vger.kernel.org with ESMTP id S261602AbVBSBOf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 20:14:35 -0500
Date: Sat, 19 Feb 2005 02:14:34 +0100
From: Michal Januszewski <spock@gentoo.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bootsplash for 2.6.11-rc4
Message-ID: <20050219011433.GA5954@spock.one.pl>
References: <20050218165254.GA1359@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <20050218165254.GA1359@elf.ucw.cz>
X-PGP-Key: http://dev.gentoo.org/~spock/spock.gpg
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 18, 2005 at 05:52:54PM +0100, Pavel Machek wrote:

Hi,

> Just in case someone is interested, this is bootsplash for 2.6.11-rc4,
> taken from suse kernel. I'll probably try to modify it to work with
> radeonfb.
>=20
> Any ideas why bootsplash needs to hack into vesafb? It only uses
> vesafb_ops to test against them before some kind of free...

It doesn't really need vesafb for anything. Back in the days of 2.6.7=20
I used to release a version of bootsplash that had the dep. on vesafb=20
removed. It worked fine with at least some other fb drivers.

You might also want to save yourself some work and try out an
alternative solution called fbsplash [1], which I designed after I got=20
tired of fixing bootsplash and which I actively maintain. Fbsplash=20
provides virtually the same functionality, and it has as much code as=20
possible moved into userspace (no more JPEG decoders in the kernel).

[1] http://dev.gentoo.org/~spock/projects/gensplash/current/
=20
Live long and prosper.
--=20
Michal 'Spock' Januszewski                        Gentoo Linux Developer
cell: +48504917690                         http://dev.gentoo.org/~spock/
JID: spock@im.gentoo.org               freenode: #gentoo-dev, #gentoo-pl


--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCFpL5aQ0HSaOUe+YRAlywAJ9doSKPYbptBUeQlPRMQwEmn2bteACfS6iP
SiXkKCiIIeHKW7c90Bb2Chs=
=u4Pm
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
