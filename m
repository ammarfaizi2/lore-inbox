Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbUKVQaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbUKVQaZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 11:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUKVQ1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 11:27:50 -0500
Received: from zlynx.org ([199.45.143.209]:62726 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S261279AbUKVPfA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 10:35:00 -0500
Subject: Re: file as a directory
From: Zan Lynx <zlynx@acm.org>
To: Martin Waitz <tali@admingilde.org>
Cc: Amit Gud <amitgud1@gmail.com>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
In-Reply-To: <20041122143720.GL19738@admingilde.org>
References: <2c59f00304112205546349e88e@mail.gmail.com>
	 <20041122143720.GL19738@admingilde.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+dYzRREl91J3/0Umo86J"
Date: Mon, 22 Nov 2004 08:34:02 -0700
Message-Id: <1101137642.15949.4.camel@titania.zlynx.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+dYzRREl91J3/0Umo86J
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-11-22 at 15:37 +0100, Martin Waitz wrote:
> hoi :)
>=20
> On Mon, Nov 22, 2004 at 07:24:36PM +0530, Amit Gud wrote:
> >  A straight forward question. Wouldn't adding a "file as a directory"
> > mechanism more logical in VFS itself, rather than having each fs (like
> > reiser4) to implement it seperately?
>=20
> wouldn't it be better if such things would be implemented in a library?
> use gnome-vfs, or try to get a vfs layer into libc.
> That way you can even support different and old kernels and all
> filesystems.
>=20
> The kernel already provides all methods that are neccessary to do that.
> So there is no need to implement it in the kernel.

There are already several things in filesystems that don't strictly
belong inside the kernel.  A filesystem could be implemented quite well
as a user-space daemon that sat on top of the block device and
communicated via sockets or shared memory just like an X server.

So, the argument that because it could be implemented in userspace that
it should be implemented in userspace is not automatically true.
--=20
Zan Lynx <zlynx@acm.org>

--=-+dYzRREl91J3/0Umo86J
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBogbqG8fHaOLTWwgRAhlsAJ9ZA2v3vVJS2gD5HfJYV7uCcfIHbgCfYR5C
VwU8Rz7He2DT57tODuarLX8=
=iqux
-----END PGP SIGNATURE-----

--=-+dYzRREl91J3/0Umo86J--

