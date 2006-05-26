Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751629AbWEZVkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbWEZVkn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 17:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbWEZVkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 17:40:42 -0400
Received: from junki.org ([194.154.83.175]:20139 "EHLO junki.org")
	by vger.kernel.org with ESMTP id S1751629AbWEZVkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 17:40:41 -0400
Subject: Re: Intercept write to disk
From: Mishael A Sibiryakov <death@junki.org>
To: Bernd Eckenfels <be-news06@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E1Fjjke-0000EV-00@calista.inka.de>
References: <E1Fjjke-0000EV-00@calista.inka.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-lXBJNeL6h/bxOa3qTu5k"
Date: Sat, 27 May 2006 01:40:11 +0400
Message-Id: <1148679612.2094.16.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.92.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lXBJNeL6h/bxOa3qTu5k
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-05-26 at 23:21 +0200, Bernd Eckenfels wrote:
> Mishael A Sibiryakov <death@junki.org> wrote:
> > Probably i have a stupid question but i can't find adequate solution fo=
r
> > it. I want to intercept write to real disk partition or entire disk
> > (except of swap partition of course). As i understood vfs and Co i thin=
k
> > that i need to work on level between fs driver and disk driver. But it'=
s
> > unclean for me. Please tell me is it possible and if possible then say
> > how or put me to some documentation.
>=20
> You can write a devmapper module, or maybe pre-load a shared user mode
> library.

Hm, i need a somthing transparent, this tool is for make image of entire
disk/partition on fly. Because tool is get some time for work i need to
store changes between start and end of the process for append it to
image. Probably i thinking in wrong way and i need a something else.

--=-lXBJNeL6h/bxOa3qTu5k
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEd3W7ltv4nqCvt/oRAsJ9AKDMWBBHdPzSkjOLW/DqFkucgU1s/ACePkJv
/A1jlXvnQR4qqK2BFdGnIvo=
=Hz4H
-----END PGP SIGNATURE-----

--=-lXBJNeL6h/bxOa3qTu5k--

