Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261563AbRERV3S>; Fri, 18 May 2001 17:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261565AbRERV3I>; Fri, 18 May 2001 17:29:08 -0400
Received: from [63.224.227.45] ([63.224.227.45]:42863 "HELO galen.magenet.net")
	by vger.kernel.org with SMTP id <S261561AbRERV2z>;
	Fri, 18 May 2001 17:28:55 -0400
Date: Fri, 18 May 2001 14:28:43 -0700
From: Joseph Carter <knghtbrd@debian.org>
To: Joshua Corbin <jcorbin@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FIC AD11(AMD 761/VIA 686B) AGP port not supported [fixed]
Message-ID: <20010518142843.C14054@debian.org>
In-Reply-To: <20010518183141.7601.qmail@linuxmail.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tqI+Z3u+9OQ7kwn0"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010518183141.7601.qmail@linuxmail.org>; from jcorbin@linuxmail.org on Sat, May 19, 2001 at 02:31:40AM +0800
X-Operating-System: Linux galen 2.4.3-ac12
X-No-Junk-Mail: Spam will solicit a hostile reaction, at the very least.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 19, 2001 at 02:31:40AM +0800, Joshua Corbin wrote:
> Ok, so appending agp_try_unsupported at boot gets the agp working (at
> least tolerably).  The problem now appears to be with the DRI part of
> X/Radeon driver, because after adding the line:
> Option "noaccel" "true"
> to my XF86Config, all is well.
>=20
> Without it all that shows up on the screen is a bunch of boxes, from
> which you are then forced to C-A-Backspace, and C-A-Del, since the
> terminal is screwed.  So as long as I don't need 3D-accel, I'm once
> again Winblows free.  Thank-you all for the attention :-)

FWIW, I have similar problems with the Radeon 64 VIVO (retail) with my
Abit KT7A.  The DRI people are aware that it's broken but so far it works
for some people and not others, and nobody is exactly sure what the
problem is.  Your best bet is to avoid accelleration for now.

Since you have an AMD chipset, it appears the problem is not limited to
VIA.  That's too bad, I was considering upgrading to an AMD board to get
around this problem (and several others too..)

--=20
Joseph Carter <knghtbrd@debian.org>                Free software developer

Steal this tagline.  I did.


--tqI+Z3u+9OQ7kwn0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: 1024D/DCF9DAB3  20F6 2261 F185 7A3E 79FC  44F9 8FF7 D7A3 DCF9 DAB3

iEYEARECAAYFAjsFlAsACgkQj/fXo9z52rOjbACfZfFvJ+NsRON9SwF24wOIe8er
otcAn2eSH9qH4tssVz9WG4yn622ezDJc
=u+mw
-----END PGP SIGNATURE-----

--tqI+Z3u+9OQ7kwn0--
