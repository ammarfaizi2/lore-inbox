Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313377AbSDLHmz>; Fri, 12 Apr 2002 03:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313421AbSDLHmy>; Fri, 12 Apr 2002 03:42:54 -0400
Received: from mail.2d3d.co.za ([196.14.185.200]:3469 "HELO mail.2d3d.co.za")
	by vger.kernel.org with SMTP id <S313377AbSDLHmx>;
	Fri, 12 Apr 2002 03:42:53 -0400
Date: Fri, 12 Apr 2002 09:43:23 +0200
From: Abraham vd Merwe <abraham@2d3d.co.za>
To: Michael De Nil <linux@aerythmic.be>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: Stolen Memory <- i830M video chip
Message-ID: <20020412094323.B8997@crystal.2d3d.co.za>
Mail-Followup-To: Michael De Nil <linux@aerythmic.be>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0204112244480.4745-100000@LiSa>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: 2d3D, Inc.
X-Operating-System: Debian GNU/Linux crystal 2.4.17-pre4 i686
X-GPG-Public-Key: http://oasis.blio.net/pgpkeys/keys/2d3d.gpg
X-Uptime: 9:33am  up 15 days, 23:49,  9 users,  load average: 0.14, 0.03, 0.01
X-Edited-With-Muttmode: muttmail.sl - 2001-06-06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michael!

It's a problem with your BIOS. There is no way to set the video modes unless
you use local memory or 8mb stolen since the setmode BIOS calls checks
whether the mode can fit in the stolen memory, whether you populated the GTT
with extra pages or not.

It is therefore a OEM BIOS problem. Dell was notified about this a long time
ago - I thought they fixed it in the mean time. Try moaning about this to
Asus as well...

> working here on an Asus L1-laptop which contains the Intel 830M graphical
> chip. when loading the agpgart module, it prints in syslog that there is
> only 1 Meg 'stolen ram'. like that, it's not possable to run X @ 1024x768
> with more then 256 colors.
>=20
> i searched on the intel-website, which told me hat i should be able to
> change this setting in my bios. *not*
>=20
> can't i reserve any more ram myselve by selecting linux only to use 256 -
> 8 Meg or something @ boot-time ?

--=20

Regards
 Abraham

Two wrights don't make a rong, they make an airplane.  Or bicycles.

__________________________________________________________
 Abraham vd Merwe - 2d3D, Inc.

 Device Driver Development, Outsourcing, Embedded Systems

  Cell: +27 82 565 4451         Snailmail:
   Tel: +27 21 761 7549            Block C, Aintree Park
   Fax: +27 21 761 7648            Doncaster Road
 Email: abraham@2d3d.co.za         Kenilworth, 7700
  Http: http://www.2d3d.com        South Africa


--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8tpAbzNXhP0RCUqMRAv/HAJ9W/zszWzkm0A3EnB1QT9Uu7q5iCACfT6WU
yUzIwEZqwgXgJ9A8OMB0ewM=
=9m/2
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
