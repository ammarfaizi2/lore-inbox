Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267968AbRHFLIw>; Mon, 6 Aug 2001 07:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267972AbRHFLIm>; Mon, 6 Aug 2001 07:08:42 -0400
Received: from mail.2d3d.co.za ([196.14.185.200]:46231 "HELO mail.2d3d.co.za")
	by vger.kernel.org with SMTP id <S267968AbRHFLIj>;
	Mon, 6 Aug 2001 07:08:39 -0400
Date: Mon, 6 Aug 2001 13:09:24 +0200
From: Abraham vd Merwe <abraham@2d3d.co.za>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Felix von Leitner <leitner@fefe.de>
Subject: Re: kernel headers & userland
Message-ID: <20010806130924.A14167@crystal.2d3d.co.za>
Mail-Followup-To: Abraham vd Merwe <abraham@2d3d.co.za>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Felix von Leitner <leitner@fefe.de>
In-Reply-To: <20010806095638.A5638@crystal.2d3d.co.za> <m166c1wj66.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m166c1wj66.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Mon, Aug 06, 2001 at 04:56:49 -0600
Organization: 2d3D, Inc.
X-Operating-System: Debian GNU/Linux crystal 2.4.2 i686
X-GPG-Public-Key: http://oasis.blio.net/pgpkeys/keys/2d3d.gpg
X-Uptime: 1:05pm  up 12 days,  3:45,  6 users,  load average: 0.02, 0.02, 0.00
X-Edited-With-Muttmode: muttmail.sl - 2000-11-20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Eric!

> > Apparently Linus told Felix von Leitner (the author of dietlibc - a sma=
ll,
> > no nonsense glibc replacement C library) a while ago _not_ to include a=
ny
> > linux kernel headers in userland (i.e. the C library headers in this ca=
se).
> >=20
> > This imho is obviously wrong since there are definitely a need for incl=
uding
> > kernel headers on a linux platform.
>=20
> ???  Necessity no.  Are there practical benefits yes.
>=20
> The policy of the kernel developers in general is that if your apps
> includes kernel headers and it breaks, it is a kernel problem.
>=20
> As for ioctl it is a giant mess that needs to be taken out and shot.
>=20
> And yes there are places where even the mighty glibc is in the wrong.

Just acknowledging that it is a problem doesn't solve the problem though.
The question remains how you approach the kernel headers issue at the momen=
t?

My guess is the only way is by including the kernel headers for now and
change it one day when someone decides to clean up the mess.

--=20

Regards
 Abraham

Every absurdity has a champion who will defend it.

__________________________________________________________
 Abraham vd Merwe - 2d3D, Inc.

 Device Driver Development, Outsourcing, Embedded Systems

  Cell: +27 82 565 4451         Snailmail:
   Tel: +27 21 761 7549            Block C, Antree Park
   Fax: +27 21 761 7648            Doncaster Road
 Email: abraham@2d3d.co.za         Kenilworth, 7700
  Http: http://www.2d3d.com        South Africa


--wac7ysb48OaltWcw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7bnrkzNXhP0RCUqMRAo9DAJ4uG5iVVw8W+0woX0UTKcDjeH/9owCgkdM1
YyGheDP9/cIq4s5inA/P8Yk=
=Z7lB
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
