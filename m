Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVDGFjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVDGFjs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 01:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVDGFjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 01:39:48 -0400
Received: from 57.16.168.202.velocitynet.com.au ([202.168.16.57]:19329 "EHLO
	hope.sourcefrog.net") by vger.kernel.org with ESMTP id S261243AbVDGFjg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 01:39:36 -0400
Subject: Re: Kernel SCM saga..
From: Martin Pool <mbp@sourcefrog.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       David Lang <dlang@digitalinsight.com>
In-Reply-To: <Pine.LNX.4.62.0504061931560.10158@qynat.qvtvafvgr.pbz>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
	 <20050406193911.GA11659@stingr.stingr.net>
	 <pan.2005.04.07.01.40.20.998237@sourcefrog.net>
	 <20050407014727.GA17970@havoc.gtf.org>
	 <pan.2005.04.07.02.25.56.501269@sourcefrog.net>
	 <Pine.LNX.4.62.0504061931560.10158@qynat.qvtvafvgr.pbz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-PQJvh9r/3NQo6+OKiMMK"
Date: Thu, 07 Apr 2005 15:38:21 +1000
Message-Id: <1112852302.29544.75.camel@hope>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PQJvh9r/3NQo6+OKiMMK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-04-06 at 19:32 -0700, David Lang wrote:
> On Thu, 7 Apr 2005, Martin Pool wrote:
>=20
> > I haven't tested importing all 60,000+ changesets of the current bk tre=
e,
> > partly because I don't *have* all those changesets.  (Larry said
> > previously that someone (not me) tried to pull all of them using bkclie=
nt,
> > and he considered this abuse and blacklisted them.)
>=20
> pull the patches from the BK2CVS server. yes some patches are combined,=20
> but it will get you in the ballpark.

OK, I just tried that.  I know there are scripts to resynthesize
changesets from the CVS info but I skipped that for now and just pulled
each day's work into a separate bzr revision.  It's up to the end of
March and still running.

Importing the first snapshot (2004-01-01) took 41.77s user, 1:23.79
total.  Each subsequent day takes about 10s user, 30s elapsed to commit
into bzr.  The speeds are comparable to CVS or a bit faster, and may be
faster than other distributed systems. (This on a laptop with a 5400rpm
disk.)  Pulling out a complete copy of the tree as it was on a previous
date takes about 14 user, 60s elapsed.

I don't want to get too distracted by benchmarks now because there are
more urgent things to do and anyhow there is still lots of scope for
optimization.  I wouldn't be at all surprised if those times could be
more than halved.  I just wanted to show it is in (I hope) the right
ballpark.

--=20
Martin


--=-PQJvh9r/3NQo6+OKiMMK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCVMdNPGPKP6Cz6IsRAnclAKC0Se1IQUzGuSvUUlqTaimFrKWk2gCfT1+Y
W5Tc3VDcHHDCdJ3SbYQhmvg=
=Yw/C
-----END PGP SIGNATURE-----

--=-PQJvh9r/3NQo6+OKiMMK--
