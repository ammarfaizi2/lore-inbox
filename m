Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbWGAWad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWGAWad (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 18:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWGAWad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 18:30:33 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:25517 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751192AbWGAWac (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 18:30:32 -0400
Date: Sat, 1 Jul 2006 20:17:02 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features
Message-ID: <20060701181702.GC8763@irc.pl>
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Theodore Ts'o <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <20060701170729.GB8763@irc.pl> <20060701174716.GC24570@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5G06lTa6Jq83wMTw"
Content-Disposition: inline
In-Reply-To: <20060701174716.GC24570@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5G06lTa6Jq83wMTw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 01, 2006 at 07:47:16PM +0200, Thomas Glanzmann wrote:
> Hello,
>=20
> > Checksums are not very useful for themselves. They are useful when we
> > have other copy of data (think raid mirroring) so data can be
> > reconstructed from working copy.
>=20
> it would be possible to identify data corruption.
>=20

  Yes, but what good is identification? We could only return I/O error.
Ability to fix corruption (like ZFS) is the real killer.

--=20
Tomasz Torcz            There exists no separation between gods and men:
zdzichu@irc.-nie.spam-.pl   one blends softly casual into the other.


--5G06lTa6Jq83wMTw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFEprweThhlKowQALQRAr2AAJ4q/mX7SGYDNATa9G3wzEWuPB0pHwCfVBLW
gsMCGvOwdQhLciKH8CFAdjE=
=s1BU
-----END PGP SIGNATURE-----

--5G06lTa6Jq83wMTw--
