Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWGCUza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWGCUza (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 16:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWGCUza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 16:55:30 -0400
Received: from nsm.pl ([195.34.211.229]:53783 "EHLO nsm.pl")
	by vger.kernel.org with ESMTP id S932115AbWGCUz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 16:55:29 -0400
Date: Mon, 3 Jul 2006 22:55:23 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features
Message-ID: <20060703205523.GA17122@irc.pl>
Mail-Followup-To: Helge Hafting <helgehaf@aitel.hist.no>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Theodore Ts'o <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <20060701170729.GB8763@irc.pl> <20060701174716.GC24570@cip.informatik.uni-erlangen.de> <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <20060703202219.GA9707@aitel.hist.no>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 03, 2006 at 10:22:19PM +0200, Helge Hafting wrote:
> On Sat, Jul 01, 2006 at 08:17:02PM +0200, Tomasz Torcz wrote:
> > On Sat, Jul 01, 2006 at 07:47:16PM +0200, Thomas Glanzmann wrote:
> > > Hello,
> > >=20
> > > > Checksums are not very useful for themselves. They are useful when =
we
> > > > have other copy of data (think raid mirroring) so data can be
> > > > reconstructed from working copy.
> > >=20
> > > it would be possible to identify data corruption.
> > >=20
> >=20
> >   Yes, but what good is identification? We could only return I/O error.
> > Ability to fix corruption (like ZFS) is the real killer.
>=20
> Isn't that what we have RAID-1/5/6 for? =20

  ZFS was already called ,,blatant layering violation''. ;)
Yes,that what RAID is for. And if we want checksums in filesystem,
that's the best way to utilise them.

--=20
Tomasz Torcz                 Morality must always be based on practicality.
zdzichu@irc.-nie.spam-.pl                -- Baron Vladimir Harkonnen


--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFEqYQ7ThhlKowQALQRAgzIAKCWdKQrjl0ftWw2zfbEmQ6OBDNg6QCfaA6o
JOPPcoyrHSj7/b/ixFJMAeQ=
=SdSI
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
