Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263472AbTLXItM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 03:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbTLXItL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 03:49:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12997 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263472AbTLXItJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 03:49:09 -0500
Date: Wed, 24 Dec 2003 09:49:03 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Dale Amon <amon@vnl.com>, linux-kernel@vger.kernel.org
Subject: Re: Question on LFS in Redhat
Message-ID: <20031224084903.GB20976@devserv.devel.redhat.com>
References: <20031223151042.GE9089@vnl.com> <1072193917.5262.1.camel@laptop.fenrus.com> <20031223235827.GK9089@vnl.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Content-Disposition: inline
In-Reply-To: <20031223235827.GK9089@vnl.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2003 at 11:58:27PM +0000, Dale Amon wrote:
> On Tue, Dec 23, 2003 at 04:38:38PM +0100, Arjan van de Ven wrote:
> > On Tue, 2003-12-23 at 16:10, Dale Amon wrote:
> > > If there are any Redhat folk around... could you tell
> > > me if you've included the LFS patches in your:
> > >=20
> > > 	2.4.16-9smp
> >=20
> > Red Hat never released a 2.4.16 kernel for production use.
>=20
> Hmmm, that's what is showing and the Raidzone guy here in
> the UK told me they are stock...=20

Raidzone does not ship a "stock" kernel but a kernel with a lot of changes
including changes to make their binary only modules possible (the legality
of this is left as an excercise to the reader).

You really shouldn't be running a 2.4.16 kernel (not without the latest
security patches for such a kernel from a distro) given the amount of secur=
ity issues
fixed since... and since I don't think any distro ever shipped 2.4.16 (some
shipped 2.4.17, a bunch shipped 2.4.18 but even RH doesn't do patches for
that 2.4.18 tree anymore since they have been obsoleted by 2.4.20 and newer
kernels).


> > However we also never released a 2.4 kernel with the large BLOCK patch.
> > All 2.4 kernels we shipped can do files > 2 Gb of course.
>=20
> But you wouldn't be able to handle file systems larger
> than 2TB then I presume?

correct.


--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/6VL+xULwo51rQBIRAs6UAJwJwUL3HGg2bfI/7kGo7VqBCm2+wACgkos3
G3zu+vdJnDad7Ga56uHAs1w=
=f0f7
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--
