Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290361AbSBFJOE>; Wed, 6 Feb 2002 04:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290338AbSBFJN5>; Wed, 6 Feb 2002 04:13:57 -0500
Received: from smtpsrv0.isis.unc.edu ([152.2.1.139]:10400 "EHLO
	smtpsrv0.isis.unc.edu") by vger.kernel.org with ESMTP
	id <S289813AbSBFJNl>; Wed, 6 Feb 2002 04:13:41 -0500
Date: Wed, 6 Feb 2002 04:13:38 -0500
To: Shawn Starr <spstarr@sh0n.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18-pre8 + 2.4.17-pre8-ac3 + rmap12c + XFS Results
Message-ID: <20020206091338.GA670@opeth.ath.cx>
In-Reply-To: <Pine.LNX.4.40.0202060213380.395-100000@coredump.sh0n.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0202060213380.395-100000@coredump.sh0n.net>
User-Agent: Mutt/1.3.27i
From: Dan Chen <crimsun@email.unc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2002 at 02:17:28AM -0500, Shawn Starr wrote:
> I'm happy to say that rmap12c has huge preformance improvements over
> rmap11c with my Pentium 200Mhz w/64MB ram.
>=20
> Some of the differences:
>=20
> rmap11c: slow redrawing of mozilla, mouse hangs, system sluggishness.
>=20
> rmap12c: no slow redrawing UNLESS heavy I/O & swapping is occuring. System
                                    ^^^^^^^^^^^^^^^^^^^^
Would you try the ChangeSet 1.188, specifically the one for
fs/buffer.c@1.52?
http://linuxvm.bkbits.net:8088/vm-2.4/diffs/fs/buffer.c@1.52?nav=3Dindex.ht=
ml|ChangeSet@-2d|cset@1.188

I agree that rmap12c + the above fix has noticeable improvements over
the 11 series. I'll be pushing some numbers out later today.

--=20
Dan Chen                 crimsun@email.unc.edu
GPG key:   www.unc.edu/~crimsun/pubkey.gpg.asc

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8YPPCMwVVFhIHlU4RAvG9AJ0V6MUdE5yW1NCKHCdXfVBEExkwjwCfechC
4ITfd61UBh55i0D3LLRZfp0=
=dy6z
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
