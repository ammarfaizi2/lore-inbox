Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267949AbRGVKRA>; Sun, 22 Jul 2001 06:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267950AbRGVKQk>; Sun, 22 Jul 2001 06:16:40 -0400
Received: from gent-smtp1.xs4all.be ([195.144.67.21]:10765 "EHLO gent-smtp1")
	by vger.kernel.org with ESMTP id <S267949AbRGVKQb>;
	Sun, 22 Jul 2001 06:16:31 -0400
Date: Sun, 22 Jul 2001 12:15:20 +0200
From: Filip Van Raemdonck <filipvr@xs4all.be>
To: linux-kernel@vger.kernel.org
Cc: Alexander Griesser <tuxx@aon.at>, Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Another 2.4.7 build failure
Message-ID: <20010722121520.A719@lucretia.debian.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Alexander Griesser <tuxx@aon.at>,
	Jeff Garzik <jgarzik@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <3B59FE8B.CEB83605@mandrakesoft.com>
User-Agent: Mutt/1.3.18i
X-Marks-The-Spot: xxxxxxxxxx
X-GPG-Fingerprint: 1024D/8E950E00 CAC1 0932 B6B9 8768 40DB  C6AA 1239 F709 8E95 0E00
X-Machine-info: Linux lucretia 2.4.6 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 21, 2001 at 06:13:31PM -0400, Jeff Garzik wrote:
> Alexander Griesser wrote:
> >=20
> > On Sat, Jul 21, 2001 at 10:28:26PM +0200, you wrote:
> > > Building fails for me with following error:
> > > ll_rw_blk.c:25: linux/completion.h: No such file or directory
> >=20
> > Maybe a bad patch?
> > $TOPDIR/include/linux/completion.h exists, at least on my platform :)
>=20
> sounds like someone forgot a 'cvs add' or similar...

There seems to be more to this than just the missing header. Note that there
are also errors about missing struct members (for structures that are
apparently known, so supposedly defined elsewhere than that missing header).

Regards,

Filip

--=20
Steal this tagline.  I did.

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7Wqe3Ejn3CY6VDgARAvIAAJ0YzdoYaoHwCuUU9WsWnxaUD3HSFwCg7LNM
sDndrSbgYc4M/3hJq6XT9Bo=
=of8d
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
