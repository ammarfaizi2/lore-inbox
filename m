Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275137AbRIYRvu>; Tue, 25 Sep 2001 13:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275138AbRIYRvj>; Tue, 25 Sep 2001 13:51:39 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:4778 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S275137AbRIYRvW>; Tue, 25 Sep 2001 13:51:22 -0400
Date: Tue, 25 Sep 2001 12:51:44 -0500
From: Bob McElrath <mcelrath@draal.physics.wisc.edu>
To: linux-kernel@vger.kernel.org
Subject: O_DIRECT as a mount option?
Message-ID: <20010925125144.D14612@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x4pBfXISqBoDm8sr"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--x4pBfXISqBoDm8sr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

With O_DIRECT (buffer cache bypass open() flag) now in the mainstream
kernel, I wonder if people would be opposed to making a "direct" mount
option, which would open all files on the filesystem with the O_DIRECT
flag, just as there exists a "sync" mount option to perform filesystem
transactions synchronously.

This would allow you to=20
    mount -o direct,sync /dev/hdb1 /mnt/video
And would be useful for things like streaming video applications,
allowing the advantages of O_DIRECT without rewriting every application
you want to use.

Cheers,
-- Bob

Bob McElrath (rsmcelrath@students.wisc.edu)=20
Univ. of Wisconsin at Madison, Department of Physics

--x4pBfXISqBoDm8sr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjuwxDAACgkQjwioWRGe9K1ppgCgoeiPyEfl7nmxuxR2XBQztnRO
/W0Anil6Pl44Hur5S6rnWRuUBvVs6OH5
=eRZ9
-----END PGP SIGNATURE-----

--x4pBfXISqBoDm8sr--
