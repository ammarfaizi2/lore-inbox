Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965012AbWFNP0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbWFNP0V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 11:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbWFNP0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 11:26:20 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:20692 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S965010AbWFNP0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 11:26:19 -0400
Date: Wed, 14 Jun 2006 17:26:06 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Daniel Phillips <phillips@google.com>, bidulock@openss7.org,
       Stephen Hemminger <shemminger@osdl.org>,
       Sridhar Samudrala <sri@us.ibm.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 1/2] in-kernel sockets API
Message-ID: <20060614152606.GB29312@sunbeam.de.gnumonks.org>
References: <1150156562.19929.32.camel@w-sridhar2.beaverton.ibm.com> <20060613140716.6af45bec@localhost.localdomain> <20060613052215.B27858@openss7.org> <448F2A49.5020809@google.com> <20060614133022.GU11863@sunbeam.de.gnumonks.org> <20060614142903.GI11542@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
Content-Disposition: inline
In-Reply-To: <20060614142903.GI11542@harddisk-recovery.com>
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 14, 2006 at 04:29:04PM +0200, Erik Mouw wrote:
> On Wed, Jun 14, 2006 at 03:30:22PM +0200, Harald Welte wrote:
> > On Tue, Jun 13, 2006 at 02:12:41PM -0700, Daniel Phillips wrote:
> > =20
> > > This has the makings of a nice stable internal kernel api.  Why do we=
 want
> > > to provide this nice stable internal api to proprietary modules?
> >=20
> > because there is IMHO legally nothing we can do about it anyway.  Use of
> > an industry-standard API that is provided in multiple operating system
> > is one of the clearest idnication of some program _not_ being a
> > derivative work.
>=20
> IMHO there is no industry-standard API for in-kernel use of sockets.
> There is however one for user space.

it doesn't matter in what space you are.  If the API really is similar
enough, then any piece of code (no matter where it was originally
intended to run) will be able to work with any such socket API.

The whole point of this is: Where is the derivation of an existing work?
I can write a program against some BSD socket api somewhere, and I can
easily make it use the proposed in-kernel sockets API.  No derivation of
anything that is inside the kernel and GPL licensed.

> (IANAL, etc)

Neither am I, but I'm constantly dealing with legal questions related to
the GPL while running gpl-violations.org.

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
We all know Linux is great...it does infinite loops in 5 seconds. -- Linus

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEkCqOXaXGVTD0i/8RAhMhAJ41CdPR23ZpDwcXE9rfawmgR7gmXwCfdNGa
WyULyg2u040CL7LKxQLkMBI=
=pDwl
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--
