Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263276AbSJaQ6W>; Thu, 31 Oct 2002 11:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263241AbSJaQ6T>; Thu, 31 Oct 2002 11:58:19 -0500
Received: from relay.snowman.net ([63.80.4.38]:33029 "EHLO relay.snowman.net")
	by vger.kernel.org with ESMTP id <S263215AbSJaQ6P>;
	Thu, 31 Oct 2002 11:58:15 -0500
Date: Thu, 31 Oct 2002 12:04:36 -0500
From: Stephen Frost <sfrost@snowman.net>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Alexander Viro <viro@math.psu.edu>,
       Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: What's left over.
Message-ID: <20021031170435.GS15886@ns>
Mail-Followup-To: Oliver Xymoron <oxymoron@waste.org>,
	Alexander Viro <viro@math.psu.edu>,
	Linus Torvalds <torvalds@transmeta.com>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210301823120.1396-100000@home.transmeta.com> <Pine.GSO.4.21.0210302135150.13031-100000@weyl.math.psu.edu> <20021031163650.GC25906@waste.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UJL6Ehwkp4s1typS"
Content-Disposition: inline
In-Reply-To: <20021031163650.GC25906@waste.org>
User-Agent: Mutt/1.4i
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 11:58:56 up 88 days, 19:34, 12 users,  load average: 0.08, 0.07, 0.08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UJL6Ehwkp4s1typS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Oliver Xymoron (oxymoron@waste.org) wrote:
> On Wed, Oct 30, 2002 at 09:43:29PM -0500, Alexander Viro wrote:
> > Because People Are Stupid(tm).  Because it's cheaper to put "ACL suppor=
t: yes"
> > in the feature list under "Security" than to make sure than userland ca=
n cope
> > with anything more complex than  "Me Og.  Og see directory.  Directory =
Og's.
> > Nobody change it".  C.f. snake oil, P.T.Barnum and esp. LSM users
>=20
> It's nearly useless in a Unix-only context, true, however there's a rather
> serious impedance mismatch for serving files to Windows that this
> addresses. Emulating ACLs on the fly with groups to fit into the
> Windows model is mostly doable but ain't pretty.=20

It's only nearly useless if you have some desire as an admin to
constantly be creating groups and changing group lists for users.  This
is not a feature which is useful only when serving files to Windows
machines, not even nearly.  AFS, Solaris, Irix etc have support for ACLs
and have a great deal of people who use them.  The simple yet common
situation of one user who wants to give even just read access to
another specific user for a given file is a pain in the ass to deal with
given the current structure.

	Stephen

--UJL6Ehwkp4s1typS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9wWKjrzgMPqB3kigRAvf9AKCXKZ7bLf1zaFkV+j9/kgc3+aah3ACeMthi
dmHh2saMe6wcSc/3rAwhe4M=
=2B7r
-----END PGP SIGNATURE-----

--UJL6Ehwkp4s1typS--
