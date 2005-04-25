Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262597AbVDYLrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262597AbVDYLrJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 07:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262600AbVDYLrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 07:47:09 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:45474 "EHLO vagabond.light.src")
	by vger.kernel.org with ESMTP id S262597AbVDYLqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 07:46:42 -0400
Date: Mon, 25 Apr 2005 13:45:50 +0200
From: Jan Hudec <bulb@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: viro@parcelfarce.linux.theplanet.co.uk, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050425114550.GA25885@vagabond>
References: <20050424201820.GA28428@infradead.org> <E1DPo3I-0000V0-00@localhost> <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk> <E1DPoCg-0000W0-00@localhost> <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk> <E1DPoRz-0000Y0-00@localhost> <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk> <E1DPofK-0000Yu-00@localhost> <20050425071047.GA13975@vagabond> <E1DQ0Mc-0007B5-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <E1DQ0Mc-0007B5-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 25, 2005 at 11:58:50 +0200, Miklos Szeredi wrote:
> > > However if you write me a script that reads my mind as to which server
> > > I want to mount with sshfs at which time, I give you all my respect.
> >=20
> > I can't write a script that reads your mind. But I sure can write
> > a script that finds out what you mounted in the other shells (with help
> > of a little wrapper around the mount command).
>=20
> How do you bind mount it from a different namespace?  You _do_ need
> bind mount, since a new mount might require password input, etc...

Yes, I would need one thing from kernel. That one thing would be to
mount bind a directory handle, instead of path.

And if you wonder how I get the handle, that's what SCM_RIGHTS message
of unix-domain sockets is for.

---------------------------------------------------------------------------=
----
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCbNhuRel1vVwhjGURAhFnAJ9t73kcnjcUVf5osTJNRtCWASnviACgxUjz
MyxR53CrArhVzOOLbJiT11o=
=ACcW
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
