Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269291AbTCDGzk>; Tue, 4 Mar 2003 01:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269292AbTCDGzk>; Tue, 4 Mar 2003 01:55:40 -0500
Received: from lmail.actcom.co.il ([192.114.47.13]:21672 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S269291AbTCDGzj>; Tue, 4 Mar 2003 01:55:39 -0500
Date: Tue, 4 Mar 2003 09:03:04 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add checkstack Makefile target
Message-ID: <20030304070304.GP4579@actcom.co.il>
References: <20030303211647.GA25205@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O7Os1+MGCLLi8F5z"
Content-Disposition: inline
In-Reply-To: <20030303211647.GA25205@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--O7Os1+MGCLLi8F5z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 03, 2003 at 10:16:47PM +0100, J?rn Engel wrote:
> On Thu, 20 February 2003 08:54:55 -0800, Linus Torvalds wrote:
> >=20
> > A sorted list of bad stack users (more than 256 bytes) in my default bu=
ild
> > follows. Anybody can create their own with something like
> >=20
> > 	objdump -d linux/vmlinux |
> > 		grep 'sub.*$0x...,.*esp' |
> > 		awk '{ print $9,$1 }' |
> > 		sort > bigstack
> >=20
> > and a script to look up the addresses.
>=20
> Since Linus didn't give us the script, I had to try it myself. The
> result is likely ugly and inefficient, but it works for i386 and ppc
> (actually crosscompiling for ppc).

Keith Owens has such a script, and even posted it here a time or
three. You can find it (and various other near scripts) at
http://www.kernelnewbies.org/scripts/. As for making a Makefile
target, nice idea, but probably 2.5 material.=20
--=20
Muli Ben-Yehuda
http://www.mulix.org


--O7Os1+MGCLLi8F5z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+ZE+nKRs727/VN8sRAihzAKCgBA09mde70PmVawBiT2zXuV46jgCffGl5
5LTttEh5ne3eAIkyP14pqeQ=
=9HK8
-----END PGP SIGNATURE-----

--O7Os1+MGCLLi8F5z--
