Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbVBWV61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVBWV61 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 16:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbVBWV44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 16:56:56 -0500
Received: from hostmaster.org ([212.186.110.32]:59613 "EHLO hostmaster.org")
	by vger.kernel.org with ESMTP id S261629AbVBWVzv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 16:55:51 -0500
Subject: tun/tap(bochs) on AMD64
From: Thomas Zehetbauer <thomasz@hostmaster.org>
To: linux-kernel@vger.kernel.org, discuss@x86-64.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-q37hyykiZdgFfB8/F8lP"
Date: Wed, 23 Feb 2005 22:54:48 +0100
Message-Id: <1109195688.4387.28.camel@hostmaster.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-q37hyykiZdgFfB8/F8lP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I am trying to get bochs to use tun/tap on x86_64, strace reveals the
following problem:

open("/dev/net/tun", O_RDWR)            =3D 7
ioctl(7, TUNSETIFF, 0x7fffffffe6c0)     =3D -1 EINVAL (Invalid argument)

I wonder if this a tun/tap or a bochs problem. Any clues?

Tom

--=20
  T h o m a s   Z e h e t b a u e r   ( TZ251 )
  PGP encrypted mail preferred - KeyID 96FFCB89
      finger thomasz@hostmaster.org for key

Linux is like a Wigwam..  No Windows, no Gates, and Apache inside.




--=-q37hyykiZdgFfB8/F8lP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iQEVAwUAQhz7qGD1OYqW/8uJAQLuRgf6AtKxE47Eq8oKkA6jrFUO8GdlQovpXOL4
U74Cr99S0pVm7wdIuu1pZIAF5UP7ZqDrmHgNjnEZAFo1fzABkJh6DhxYwN8v4dTn
aTglc8HBJtXtO7mh8b01bZSe7hfvDZKDnp6edwcFujHEwLqGuY7C1v68HKYUxQ9V
eFShwdUgMYzj+E/gfROabPPKkwSp4MPSsKnhNSVlRc5YvgG38WnjjP9IRCAKQMOB
DVDaczONKQ1i0NcrFYSbWz0eveBMsT8RjtB/0WReQHePKVJ3t8gPj+ZkLr5nbwte
lkt5X9EPjkfiLfv3bSl33DaUgBL2xiTkJlNgaYPNK+YYvJOROXRZFA==
=YOkr
-----END PGP SIGNATURE-----

--=-q37hyykiZdgFfB8/F8lP--

