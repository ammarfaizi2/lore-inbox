Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261489AbSKBWhU>; Sat, 2 Nov 2002 17:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261490AbSKBWhU>; Sat, 2 Nov 2002 17:37:20 -0500
Received: from grendel.firewall.com ([66.28.56.41]:37527 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id <S261489AbSKBWhT>; Sat, 2 Nov 2002 17:37:19 -0500
Date: Sat, 2 Nov 2002 23:43:18 +0100
From: Marek Habersack <grendel@debian.org>
To: linux-kernel@vger.kernel.org
Cc: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: Kconfig (qt) -> Gconfig (gtk)
Message-ID: <20021102224318.GA3206@thanes.org>
Reply-To: grendel@debian.org
References: <20020625222135.GA617@free.fr> <3DC378D0.5080703@iinet.net.au> <20021102203608.GB731@gallifrey> <20021102210724.B8549@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <20021102210724.B8549@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 02, 2002 at 09:07:24PM +0000, Russell King scribbled:
> On Sat, Nov 02, 2002 at 08:36:08PM +0000, Dr. David Alan Gilbert wrote:
> > Wouldn't it be more helpful to iron the (few) small glitches out of the
> > qt based one than write a new one just because you don't happen to like
> > the library?
>=20
> Maybe, maybe not.  Most, if not all of my boxes here don't have qt, and
> they're not going to get qt any time soon.  qt has a long list of
> dependencies which gtk doesn't have, which, imho is an overriding factor
> for why we should have a gtk implementation.
Exactly. On Debian the qt2 devel stuff is 17MB (!). Yesterday I was trying
to compile 2.5.45 just to see that even doing make menuconfig (which I
always use) breaks because of missing qt. It turned out that the problem is
in the scripts/kconfig/Makefile which executes the $(obj)/.tmp_qtcheck no
matter which configuration interface is used [1]. Adding '-' in front of the
rule served as a temporary work-around, but I got a bit shocked on finding
out that I'd have to dload 17MB of the Qt devel packages.
=20
> Not that I used the old xconfig often anyway. 8)
Neither, but since it's here, it better work on any box :)

marek

[1] That's why I'm CCing this message to Roman Zippel, forgot to send a but
report yesterday :>

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE9xFUGq3909GIf5uoRAsmKAJ9tFJTDpOy7OAO5Uuf+mpZgPzr65gCfY+qj
+XZ0ijceKsjDwZx1EOMJTY8=
=MJRS
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
