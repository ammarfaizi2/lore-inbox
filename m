Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbVDMM5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVDMM5Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 08:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVDMM5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 08:57:24 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:17810 "EHLO vagabond.light.src")
	by vger.kernel.org with ESMTP id S261329AbVDMM5C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 08:57:02 -0400
Date: Wed, 13 Apr 2005 14:56:09 +0200
From: Jan Hudec <bulb@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: jamie@shareable.org, 7eggert@gmx.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
Message-ID: <20050413125609.GA9571@vagabond>
References: <3SbPN-3T4-19@gated-at.bofh.it> <E1DLHWZ-0001Bg-SU@be1.7eggert.dyndns.org> <20050412144529.GE10995@mail.shareable.org> <E1DLNAz-0001oI-00@dorka.pomaz.szeredi.hu> <20050412160409.GH10995@mail.shareable.org> <E1DLOI6-0001ws-00@dorka.pomaz.szeredi.hu> <20050412164401.GA14149@mail.shareable.org> <E1DLOfW-00020V-00@dorka.pomaz.szeredi.hu> <20050412171338.GA14633@mail.shareable.org> <E1DLQkL-0002DS-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <E1DLQkL-0002DS-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 12, 2005 at 21:08:25 +0200, Miklos Szeredi wrote:
> > There was a thread a few months ago where file-as-directory was
> > discussed extensively, after Namesys implemented it.  That's where the
> > conversation on detachable mount points originated AFAIR.  It will
> > probably happen at some point.
> >=20
> > A nice implemention of it in FUSE could push it along a bit :)
>=20
> Aren't there some assumptions in VFS that currently make this
> impossible?

I believe it's OK with VFS, but applications would be confused to death.
Well, there really is one issue -- dentries have exactly one parent, so
what do you do when opening a file with hardlinks as a directory? (In
fact IIRC that is what lead to all the funny talk about mountpoints,
since they don't have this limitation)

---------------------------------------------------------------------------=
----
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCXRbpRel1vVwhjGURAsi3AJ9USd++As69//zvLLBsM9IZNwkbBACg6YsH
rGRGEW5jvCgW3/ukGjsnLRM=
=jGU7
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
