Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266445AbUHBKNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266445AbUHBKNh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 06:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266434AbUHBKNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 06:13:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48603 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266425AbUHBKL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 06:11:26 -0400
Date: Mon, 2 Aug 2004 12:10:37 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in register_chrdev, what did I do?
Message-ID: <20040802101037.GA14477@devserv.devel.redhat.com>
References: <yw1xwu0i1vcp.fsf@kth.se> <yw1xllgxg9v4.fsf@kth.se> <1091439574.2826.3.camel@laptop.fenrus.com> <yw1xd629g8bc.fsf@kth.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <yw1xd629g8bc.fsf@kth.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 02, 2004 at 12:09:43PM +0200, M=E5ns Rullg=E5rd wrote:
> Arjan van de Ven <arjanv@redhat.com> writes:
>=20
> >> OTOH, wouldn't it be a good idea to refuse loading modules not
> >> matching the running kernel?
> >
> > we do that already... provided you use the kbuild infrastructure instead
> > of a broken self-made makefile hack....
>=20
> I used "make -C /lib/modules/`uname -r` SUBDIRS=3D$PWD modules".  Is
> that not correct?  The breakage was my fault, though.

that is correct

>=20
> The problem I see is that a modules contain information about certain
> compiler flags used, e.g. -mregparm, but insmod still attempts to load
> them even they do not match the kernel.  This is independent of what
> build system you used.

that is odd, which modutils is that ? Afaik insmod is supposed to just
refuse (and I've seen it do that as well)

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBDhMcxULwo51rQBIRApEKAJ42AHslo7LfWwrdfaCLncvw5coPpwCeI32a
wVdLqGK9jvCIldfUROtqvGU=
=xHII
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
