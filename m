Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWGAXNB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWGAXNB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 19:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbWGAXNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 19:13:01 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:33211 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S932081AbWGAXM7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 19:12:59 -0400
Date: Sat, 1 Jul 2006 19:07:30 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features
Message-ID: <20060701170729.GB8763@irc.pl>
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Theodore Ts'o <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Content-Disposition: inline
In-Reply-To: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 01, 2006 at 06:33:01PM +0200, Thomas Glanzmann wrote:
> Hello,
> I would like to know which new features are planed to be incorported by
> ext4. So far I only read about supporting bigger filesystems to fit
> recent hardware developments. So are there any other big goals for ext4?
>=20
> What I personally would like to see most in ext4 are
>=20
>         * checksums for data

  Checksums are not very useful for themselves. They are useful when we
have other copy of data (think raid mirroring) so data can be
reconstructed from working copy.

>         * and snapshots on filesystem basis

  What's wrong with DM snapshots?

--=20
Tomasz Torcz            There exists no separation between gods and men:
zdzichu@irc.-nie.spam-.pl   one blends softly casual into the other.


--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFEpqvRThhlKowQALQRAujzAJ9Kz1DxbvIZ9WN4VVhYbVp2yT4kegCfXBwn
AnDRykhehW4Zp3RFDjO1w/o=
=WYaK
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
