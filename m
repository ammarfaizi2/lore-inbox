Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262294AbVDYHLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbVDYHLt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 03:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262536AbVDYHLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 03:11:49 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:29088 "EHLO vagabond.light.src")
	by vger.kernel.org with ESMTP id S262294AbVDYHLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 03:11:43 -0400
Date: Mon, 25 Apr 2005 09:10:47 +0200
From: Jan Hudec <bulb@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: viro@parcelfarce.linux.theplanet.co.uk, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050425071047.GA13975@vagabond>
References: <E1DPnOn-0000T0-00@localhost> <20050424201820.GA28428@infradead.org> <E1DPo3I-0000V0-00@localhost> <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk> <E1DPoCg-0000W0-00@localhost> <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk> <E1DPoRz-0000Y0-00@localhost> <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk> <E1DPofK-0000Yu-00@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <E1DPofK-0000Yu-00@localhost>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 24, 2005 at 23:29:22 +0200, Miklos Szeredi wrote:
> > On Sun, Apr 24, 2005 at 11:15:35PM +0200, Miklos Szeredi wrote:
> > > No.  You can't set "mount environment" in scp.
> >=20
> > Of course you can.  It does execute the obvious set of rc files.
>=20
> Don't think so.  ftp server and sftp server sure as hell don't.

Sftp sure *DOES*. It is invoked by shell, which is not run as login one,
but even non-login shell sources an rc file.

> > > Otherwise your analogy is nice, but misses a few points.  The usage of
> > > mounts that we are talking about is much more dynamic than usage of
> > > environment variables.
> >=20
> > What the hell are you smoking and just how are you using shell?
>=20
> Maybe differently from you :).  It's not that often that I have to
> tweak environment variables.  They are usually set by scripts.
>=20
> However if you write me a script that reads my mind as to which server
> I want to mount with sshfs at which time, I give you all my respect.

I can't write a script that reads your mind. But I sure can write
a script that finds out what you mounted in the other shells (with help
of a little wrapper around the mount command).

---------------------------------------------------------------------------=
----
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCbJf3Rel1vVwhjGURAqWKAJ442/zXSBR99Mgs25QBtl1erSh5mgCeI3sg
dQSaRlVOweYNS+U9h+CDdVM=
=IZIr
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
