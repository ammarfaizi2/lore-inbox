Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbVDYHPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbVDYHPs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 03:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbVDYHPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 03:15:48 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:31648 "EHLO vagabond.light.src")
	by vger.kernel.org with ESMTP id S262529AbVDYHPg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 03:15:36 -0400
Date: Mon, 25 Apr 2005 09:14:48 +0200
From: Jan Hudec <bulb@ucw.cz>
To: Jamie Lokier <jamie@shareable.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Miklos Szeredi <miklos@szeredi.hu>, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050425071448.GB13975@vagabond>
References: <E1DPnOn-0000T0-00@localhost> <20050424201820.GA28428@infradead.org> <E1DPo3I-0000V0-00@localhost> <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk> <E1DPoCg-0000W0-00@localhost> <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk> <E1DPoRz-0000Y0-00@localhost> <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk> <20050424214339.GD9304@mail.shareable.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Content-Disposition: inline
In-Reply-To: <20050424214339.GD9304@mail.shareable.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 24, 2005 at 22:43:39 +0100, Jamie Lokier wrote:
> Al Viro wrote:
> > On Sun, Apr 24, 2005 at 11:15:35PM +0200, Miklos Szeredi wrote:
> > > No.  You can't set "mount environment" in scp.
> >=20
> > Of course you can.  It does execute the obvious set of rc files.
>=20
> It doesn't work for the specified use-scenario.  The reason is that
> there is no command or system call that can be executed from those rc
> files to join an existing namespace.
>=20
> He wants to do this:
>=20
>    1. From client, login to server and do a usermount on $HOME/private.
>=20
>    2. From client, login to server and read the files previously mounted.

Ok, that almost can be done. All that is needed from kernel is an
ability to mount bind from open directory handle instead of a path! The
rest is doable in userland.

---------------------------------------------------------------------------=
----
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCbJjoRel1vVwhjGURAm4cAJ96DvKBIM00qtyWoro3zI7Iq+Q85QCg6Rzh
8VxNLVl5v6BAQv1I5MVRKuo=
=P0IP
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
