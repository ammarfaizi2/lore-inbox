Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262899AbVF3PiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262899AbVF3PiM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 11:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262901AbVF3PiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 11:38:11 -0400
Received: from nysv.org ([213.157.66.145]:45273 "EHLO nysv.org")
	by vger.kernel.org with ESMTP id S262899AbVF3Ph7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 11:37:59 -0400
Date: Thu, 30 Jun 2005 18:37:38 +0300
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Douglas McNaught <doug@mcnaught.org>, Hubert Chan <hubert@uhoreg.ca>,
       Kyle Moffett <mrmacman_g4@mac.com>, David Masover <ninja@slaphack.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
Message-ID: <20050630153738.GU11013@nysv.org>
References: <20050629135820.GJ11013@nysv.org> <200506291719.j5THJCSg011438@laptop11.inf.utfsm.cl> <20050630095926.GN11013@nysv.org> <17091.60930.633968.822210@gargle.gargle.HOWL> <20050630142107.GQ11013@nysv.org> <17092.3415.28856.827179@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/Z3Qj54wC++taHdq"
Content-Disposition: inline
In-Reply-To: <17092.3415.28856.827179@gargle.gargle.HOWL>
User-Agent: Mutt/1.5.9i
From: mjt@nysv.org (Markus  =?ISO-8859-1?Q?=20T=F6rnqvist?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/Z3Qj54wC++taHdq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 30, 2005 at 07:18:47PM +0400, Nikita Danilov wrote:

>Sorry, I don't see your point. Again: if you think that user level
>developers are unlikely to agree to the common framework, what
>difference it makes whether this framework is defined at the kernel or
>library boundary? Applications would have to be changed to conform to
>the common API either way.

I see it as a heavier incentive to do it by a framework that's in
the kernel.

>If you can force application developers to conform to the LSB why you
>cannot do the same with the library level interface?

If I want to access metadata with bash, do I patch bash to support
both Gnome's and KDE's solutions? Was there one of XFCE too?
And FooBarXyzzyWM that'll want to do it's own VFS next year?

I'd also guess that the upstream guys would much rather have
patches for their progs that conform to the kernel than some
obscure neighbor userspace system.

Sure looks like having this in the kernel makes it easiest; there's
just one common denominator to patch for.

This doesn't even invalidate the userland VFSs of the other guys,
they're still needed for systems whose kernels don't have a
metadata facility.

--=20
mjt


--/Z3Qj54wC++taHdq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCxBHCIqNMpVm8OhwRApbMAKCQQN/xEG7W1/znVBUkdaOSALsP8wCdETVb
S4Pqxjw9SMMfqVXp7mh8zMk=
=Ti36
-----END PGP SIGNATURE-----

--/Z3Qj54wC++taHdq--
