Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267320AbTALGwv>; Sun, 12 Jan 2003 01:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267321AbTALGwv>; Sun, 12 Jan 2003 01:52:51 -0500
Received: from adsl-67-121-154-100.dsl.pltn13.pacbell.net ([67.121.154.100]:6368
	"EHLO kanoe.ludicrus.net") by vger.kernel.org with ESMTP
	id <S267320AbTALGwt>; Sun, 12 Jan 2003 01:52:49 -0500
Date: Sat, 11 Jan 2003 23:01:24 -0800
To: rpjday@mindspring.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: some curiosities on the filesystems layout in kernel config
Message-ID: <20030112070124.GB18290@kanoe.ludicrus.net>
References: <Pine.LNX.4.44.0301120053420.21687-100000@dell> <200301120649.h0C6nULE005008@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JWEK1jqKZ6MHAcjA"
Content-Disposition: inline
In-Reply-To: <200301120649.h0C6nULE005008@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.3i
From: "Joshua M. Kwan" <joshk@ludicrus.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Never mind my patch in this case. I had just hit 'y' to send the email=20
when I read this! Obviously, I don't know quite enough about how the=20
kernel works.. I really did think ext3 depended on ext2, since ext3=20
was simply ext2 + a journal inode.

Oh well. Sorry for the wasted b/w

Regards
Josh

On Sun, Jan 12, 2003 at 01:49:29AM -0500, Valdis.Kletnieks@vt.edu=20
wrote:
> On Sun, 12 Jan 2003 01:00:40 EST, "Robert P. J. Day" <rpjday@mindspring.c=
om>  said:
>=20
> > 2) shouldn't ext3 depend on ext2?
>=20
> No, because somebody might want ext3 only, and have no intention or
> desire to mount a filesystem in ext2 mode.  Everything on this laptop
> is ext3...
>=20
> > 3) currently, since quotas are only supported for ext2, ext3 and
> >    reiserfs, shouldn't quotas depend on at least one of those
> >    being selected?
>=20
> Because if we did that, we'd be setting ourselves up for a mess when
> fs/xfs/xfs_qm.c eventually shows up - like it already has ;)
>=20
> Also, from my (possibly incorrect) reading of kernel/sys.c and
> fs/quota.c, there won't be a sys_quotactl() in the kernel.  As a
> result, if you have users who have 'quota -v' in their .login, things
> might get interesting.  So you might want a config where the quota
> system call is there, even if it doesn't do anything incredibly
> useful...
>=20
> --=20
> 				Valdis Kletnieks
> 				Computer Systems Senior Engineer
> 				Virginia Tech
>=20



--JWEK1jqKZ6MHAcjA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+IRLE6TRUxq22Mx4RAo31AJoDDxnRXnsKugbvBYNX54sYbwHsJQCfdGeh
isKzlPyjbMTw/AAtl9uTd3A=
=+vV8
-----END PGP SIGNATURE-----

--JWEK1jqKZ6MHAcjA--
