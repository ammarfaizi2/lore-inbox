Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278269AbRKNWOp>; Wed, 14 Nov 2001 17:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278275AbRKNWOf>; Wed, 14 Nov 2001 17:14:35 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:30675 "EHLO
	mailout04.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S278269AbRKNWOX>; Wed, 14 Nov 2001 17:14:23 -0500
Date: Mon, 12 Nov 2001 21:19:33 +0100
From: Norbert Tretkowski <nobse@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: error compiling 2.4.14
Message-ID: <20011112201933.GA801@rollcage.bzimage.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0111122053270.25006-100000@achilles.dreef.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111122053270.25006-100000@achilles.dreef.net>
User-Agent: Mutt/1.3.23.1i
Mail-Copies-To: never
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Erik Verhulp wrote:
> drivers/block/block.o(.text+0x889d): undefined reference to
> `deactivate_page'
> drivers/block/block.o(.text+0x88e9): undefined reference to
> `deactivate_page'
> make: *** [vmlinux] Error 1

Take a look in the archive of this list. Remove the two lines with
'deactivate_page' in drivers/block/loop.c.

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE78C7Ur/RnCw96jQERAoPSAKCz8AbbqMlIp0kESiYm/O/x+FMEWACgp0Em
cgZhz2dbRn90qL70hV5gpEM=
=zbtv
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
