Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263429AbUJ3DWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbUJ3DWm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 23:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263459AbUJ3DWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 23:22:42 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:24421 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S263429AbUJ3DWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 23:22:36 -0400
Date: Fri, 29 Oct 2004 21:24:57 -0600
From: Chad Christopher Giffin <typo@shaw.ca>
Subject: [Fwd: Re: Linuxant/Conexant HSF/HCF Modem Drivers]
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: typo@shaw.ca
Message-id: <1099106697.16956.2.camel@localhost>
Organization: T-Net Information Systems
MIME-version: 1.0
X-Mailer: Evolution 2.0.0
Content-type: multipart/signed; boundary="=-APamtTHtsXj+Adi6fUYD";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-APamtTHtsXj+Adi6fUYD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I'm not going to post much more about this topic.
The contents of this describe the lack of any notice of the actual
licensing scheme of conexant/linuxant modems and their Linux drivers

-------- Forwarded Message --------
From: Chad Christopher Giffin <typo@shaw.ca>
Reply-To: typo@shaw.ca
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Majordomo@vger.kernel.org
<Majordomo@vger.kernel.org>, Paulo Marques <pmarques@grupopie.com>, Marc
Boucher <marc@linuxant.com>
Subject: Re: Linuxant/Conexant HSF/HCF Modem Drivers Unlocked
Date: Fri, 29 Oct 2004 10:42:42 -0600
On Fri, 2004-10-29 at 14:50 +0100, Alan Cox wrote:
> On Gwe, 2004-10-29 at 13:43, Chad Christopher Giffin wrote:
> > I still find myself deeply troubled and questioning the legalities of
> > using "GPL\0[...]" in the license string of a non-GPL module.  As it is
> > a blatant lie. =20
>=20
> Oh its almost certainly a criminal offence in the USA - the DMCA for
> example. The \0 stupidity checker needs to go into the kernel.

Well, as I expected, after learning my mistake, I am being told I was in
the legal wrong.

Examine this:

I have a gentoo system.  I bought a used pci modem card.  Someone told
me to use the hcfpcimodem package for the drivers, cause it's of course
a piece of sh*t winmodem.  I ran:

emerge hcfpcimodem

I get something installed in non-standard places.  I can't find any
documentation.  It doesn't tell me ANYTHING upon install EXCEPT
something similar to: "run hcfpciconfig to install your modem"

I'm left thinking this is just another free package.

When I run hcfpciconfig, I'm told to enter my  kernel module build
directory name, my email address, and a license number or "FREE".  It
tells me that I need a license from linuxant to do fax, voice or
anything higher then 14.4k.

I do a search on the web for "linuxant license" and get keygen.pl.

I run keygen.pl and enter the key it gives me.

Upon questioning why I need a key, I strings the modules and see:
"license=3DGPL".  I continue on my merry way thinking everything is OK.

Now where have I gone wrong here?  And plus... when I go into the
standard directories for documentation:=20
"/usr/man:/usr/share/man:/usr/info:/usr/share/info:/usr/share/doc"
I find nothing about hcfpcimodem or hcfpciconfig(1).  And I certainly
find no license file in any of those directories OR the
'/lib/modules/<kernel version>/misc' directory it places these magically
appearing binaries.

/usr/sbin/hcfpciconfig says:
# Copyright (c) 2003 Linuxant inc.

but there is no mention of where the license is or what kind of license
there is.  and its a sh script that, normally, is too arcane for one to
decipher.

Following all of this, does anyone have a clue what the licensing scheme
is of linuxant drivers?  there is no mention of anything except the
string "license=3DGPL" in the binaries. =20



It upsets me that I have to pay TWICE for this modem.  Once for the
hardware and again for the driver.  sheeesh!


--=20
-
Chad Christopher Giffin
mailto:typo@shaw.ca

There are 10 kinds of people in this world, those who understand binary
and those who do not.   -- anonymous

--=-APamtTHtsXj+Adi6fUYD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBgwmIE11tuFHhP4oRApOlAJ9n+v68aFiCk71Wo/pzl8zjHrfWCQCbBPEW
VDu7bTMuGHhVEwUpHjGUCjg=
=lgTW
-----END PGP SIGNATURE-----

--=-APamtTHtsXj+Adi6fUYD--
