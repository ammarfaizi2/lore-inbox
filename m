Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317261AbSG1Tg0>; Sun, 28 Jul 2002 15:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317264AbSG1Tg0>; Sun, 28 Jul 2002 15:36:26 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:50960 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S317261AbSG1TgZ>; Sun, 28 Jul 2002 15:36:25 -0400
Date: Sun, 28 Jul 2002 12:33:30 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: David Ford <david+cert@blue-labs.org>
Cc: linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Linux booting from USB HD / USB interface devices
Message-ID: <20020728123329.C12344@one-eyed-alien.net>
Mail-Followup-To: David Ford <david+cert@blue-labs.org>,
	linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <3D42E333.4010602@blue-labs.org> <20020727144922.E2730@one-eyed-alien.net> <3D441051.4060304@blue-labs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="wxDdMuZNg1r63Hyj"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D441051.4060304@blue-labs.org>; from david+cert@blue-labs.org on Sun, Jul 28, 2002 at 11:40:01AM -0400
Organization: One Eyed Alien Networks
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 28, 2002 at 11:40:01AM -0400, David Ford wrote:
> Thank you for your reply.  I've started a rough draft of this project,=20
> http://blue-labs.org/ranger.php
>=20
> Matthew Dharm wrote:
>=20
> >>2) There are some vague comments about some devices requiring the=20
> >>ability to boot, are there some USB hard drives that are incapable of=
=20
> >>acting as a boot device?
> >>   =20
> >>
> >
> >Yes.  They are few, tho.  The USB-IF is currently working on a bootabili=
ty
> >standard to eliminate this problem.
> >
>=20
> Is there a list of these somewhere that point out components that I=20
> should avoid?

Not to my knowledge.  USB bootability is a very touch-and-go thing for the
BIOS vendors right now... hopefully the specification being worked on now
will help.

> >THe stock kernel won't work.  There are patches floating around to make
> >this work.  Basically, the kernel needs to pause for a couple of seconds
> >before attempting to mount the root fs so that the plug-n-pray detection
> >can work, identify the drive, and get going.
> >
>=20
> I'll go look for these patches, pointers are welcome of course.

Sorry, no pointers.  See if you can find a linux-usb-devel or
linux-usb-users archive.  You're searching for something that introduces a
"delay" (good keyword) in the boot process.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Sir, for the hundreth time, we do NOT carry 600-round boxes of belt-fed=20
suction darts!
					-- Salesperson to Greg
User Friendly, 12/30/1997

--wxDdMuZNg1r63Hyj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9REcJIjReC7bSPZARAkr+AKCliI/Ch8A7wS4fQQIHd+ra0PF9uQCguhnu
knaoI5RzwwNheTD/C0MEPzY=
=28SQ
-----END PGP SIGNATURE-----

--wxDdMuZNg1r63Hyj--
