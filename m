Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262038AbSKMP2x>; Wed, 13 Nov 2002 10:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262046AbSKMP2x>; Wed, 13 Nov 2002 10:28:53 -0500
Received: from splat.lanl.gov ([128.165.17.254]:45210 "EHLO
	balance.radtt.lanl.gov") by vger.kernel.org with ESMTP
	id <S262038AbSKMP2w>; Wed, 13 Nov 2002 10:28:52 -0500
Date: Wed, 13 Nov 2002 08:35:42 -0700
From: Eric Weigle <ehw@lanl.gov>
To: Brian Jackson <brian-kernel-list@mdrx.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: md on shared storage
Message-ID: <20021113153542.GB31016@lanl.gov>
References: <20021113002529.7413.qmail@escalade.vistahp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline
In-Reply-To: <20021113002529.7413.qmail@escalade.vistahp.com>
User-Agent: Mutt/1.3.28i
X-Eric-Conspiracy: There is no conspiracy
X-Editor: Vim, http://www.vim.org
X-GnuPG-fingerprint: 112E F8CA 12A9 771E DB10  6514 D4B0 D758 59EA 9C4F
X-GnuPG-key: http://public.lanl.gov/ehw/ehw.gpg.key
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> ...
> I ask because I seem to be having some strange problems with an md device=
=20
> on shared storage(Qlogic FC controllers). The qlogic drivers spit out=20
> messages for about 20-60 lines then the machines lock up. So the drivers=
=20
> ...
If those messages look like "no handle slots, this should not happen" and
you're running a 2.4.x kernel there's a known problem with the qlogicfc
driver locking up the machine under high load. It's been fixed in 2.5,
but I don't think it's been back-ported yet.

So, aside from the _other_ problems induced by shared storage, this might
be biting you too. :)

See:
	http://www.uwsg.iu.edu/hypermail/linux/kernel/0209.0/0467.html


Thanks,
-Eric

--=20
------------------------------------------------
 Eric H. Weigle -- http://public.lanl.gov/ehw/=20
------------------------------------------------

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE90nFO1LDXWFnqnE8RAlrXAKDoewHnCHZrJXYwNc5TU372if2TwgCfdXz5
9rju0lEHxakEX9aVQqzph3s=
=qXCu
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
