Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313116AbSDSXQn>; Fri, 19 Apr 2002 19:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314337AbSDSXQm>; Fri, 19 Apr 2002 19:16:42 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:8891 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S313116AbSDSXQj>; Fri, 19 Apr 2002 19:16:39 -0400
Date: Sat, 20 Apr 2002 00:16:36 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Robin Johnson <robbat2@fermi.orbis-terrarum.net>
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
Subject: Re: Incremental Patch Building Script
Message-ID: <20020420001636.I16947@redhat.com>
In-Reply-To: <Pine.NEB.4.44.0204161404310.12986-100000@mimas.fachschaften.tu-muenchen.de> <Pine.LNX.4.43.0204160710290.12000-100000@fermi.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="fmvA4kSBHQVZhkR6"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fmvA4kSBHQVZhkR6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2002 at 07:11:46AM -0700, Robin Johnson wrote:

> On Tue, 16 Apr 2002, Adrian Bunk wrote:
> >
> > There's already interdiff from Tim Waugh's patchutils [1] that makes
> > incremental diffs between patches. And interdiff doesn't need the source
> > the patches are against (IOW: to make an incremental patch between two
> > kernel -pre patches you don't need any kernel sources). It's pretty
> > simple:
> >
> >   interdiff -z patch-2.4.19-pre6.gz patch-2.4.19-pre7.gz > mydiff
>=20
> I did try interdiff before writing this script, and it wasn't generating
> the right output.

I think that the problems Robin was seeing are resolved in
patchutils-0.2.12.

(The output was correct, but needlessly lengthy.)

Tim.
*/

--fmvA4kSBHQVZhkR6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8wKVTyaXy9qA00+cRAkYZAKCmh3oq7SGeVlhjIOEAGga5cyVFcgCghPhD
seCzb0nDEF1dXCH52JB3qpk=
=ZHmt
-----END PGP SIGNATURE-----

--fmvA4kSBHQVZhkR6--
