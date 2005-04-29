Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262496AbVD2LzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbVD2LzZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 07:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbVD2LzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 07:55:25 -0400
Received: from keetweej.xs4all.nl ([213.84.46.114]:63436 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S262496AbVD2LzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 07:55:12 -0400
Date: Fri, 29 Apr 2005 13:55:10 +0200
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Davy Durham <pubaddr2@davyandbeth.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 issue..
Message-ID: <20050429115509.GM8774@vanheusden.com>
References: <4270FA5B.5060609@davyandbeth.com>
	<20050428200908.GB6669@thunk.org>
	<20050428205536.GA2297@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7ZMy3ZKywLyoHonN"
Content-Disposition: inline
In-Reply-To: <20050428205536.GA2297@csclub.uwaterloo.ca>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Thu Apr 28 19:51:31 CEST 2005
X-MSMail-Priority: High
User-Agent: Mutt/1.5.9i
From: folkert@vanheusden.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7ZMy3ZKywLyoHonN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > What messages were displayed by e2fsck?  What version of the kernel
> > are you running?
> > No, I haven't heard of any such problems with ext2/3 filesystems.
> > This is the first time that someone was reported a specific problem
> > with the # of blocks used accounting.  There is the standard "file
> > held open so the number of blocks used is greater than blocks reported
> > by du", but that won't cause df to display negative numbers.
> I think I have seen this once or twice in the past.  A reboot always
> made it go away and it didn't seem to come back.  fsck never showed
> anything so I assumed it was just the kernel having lost its mind about
> the state of the FS.

"me too"
kernel 2.6.11
a reboot fixed it. fsck did not bother to check the filesystem. ext3


Folkert van Heusden

--=20
Auto te koop, zie: http://www.vanheusden.com/daihatsu.php
Op zoek naar een IT of Finance baan? Mail me voor de mogelijkheden.
--------------------------------------------------------------------
 UNIX admin? Then give MultiTail (http://vanheusden.com/multitail/)=20
 a try, it brings monitoring logfiles to a different level! See    =20
 http://vanheusden.com/multitail/features.html for a feature-list. =20
--------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE
Get your PGP/GPG key signed at www.biglumber.com!

--7ZMy3ZKywLyoHonN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iIMEARECAEMFAkJyIJw8Gmh0dHA6Ly93d3cudmFuaGV1c2Rlbi5jb20vZGF0YS1z
aWduaW5nLXdpdGgtcGdwLXBvbGljeS5odG1sAAoJEDAZDowfKNiuZc0AoI6ZWlQD
d5w9v1Q1omy7V7pn4EJ0AJwMwfaSC2YaUw6kWs1k87fksq7T1w==
=90Jb
-----END PGP SIGNATURE-----

--7ZMy3ZKywLyoHonN--
