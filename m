Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265243AbUAYUme (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 15:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUAYUme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 15:42:34 -0500
Received: from adsl-67-124-158-125.dsl.pltn13.pacbell.net ([67.124.158.125]:6555
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S265243AbUAYUmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 15:42:31 -0500
Date: Sun, 25 Jan 2004 12:42:25 -0800
To: linux-kernel@vger.kernel.org
Subject: Re: snd-intel8x0 and 2.6.2-rc1-mm3
Message-ID: <20040125204225.GF6974@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org, linux-kernel@vger.kernel.org
References: <20040125174647.087087b5@EozVul.WORKGROUP>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ILuaRSyQpoVaJ1HG"
Content-Disposition: inline
In-Reply-To: <20040125174647.087087b5@EozVul.WORKGROUP>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: joshk@triplehelix.org (Joshua Kwan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ILuaRSyQpoVaJ1HG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 25, 2004 at 05:46:47PM +0000, DaMouse Networks wrote:
> Hey all,
> 	I recently upgraded to 2.6.2-rc1-mm3 and now I can't here anything via t=
he snd-intel8x0 module, it worked perfectly in 2.6.2-rc1 vanilla. I tested =
to see if it was a speaker glitch by hooking up another sound card which wo=
rked fine, any ideas?

There seem to be a number of issues with intel8x0 in ALSA 1.0.1, which
is included in 2.6.2-rc1-mm3. For now I've just reverted alsa-101.patch
in my local tree so I can use the old ALSA.

--=20
Joshua Kwan

--ILuaRSyQpoVaJ1HG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iQIVAwUBQBQqMKOILr94RG8mAQLRWg//d/kTOryPYCIRRqoi/FJlZ0NKSV6W/mfb
vDzrGEn9/XGe2goJGVNzChIYP2oHn11wFd4sGHgr5hO8nNdI82ssdewBedRH1JLr
9sVeZ3Ybk/Kl5Ls86X2LNXKsNX/+MxMMxALxwUk9yQkfVHdXpNjxZ3I+1B2g31qi
J/lUhXkihgG+pw/6p7adkreP12l2TF6HxpAQ4pKDQgoW44yiLP12qGnzpywknIOJ
atXik/441ZaXHfqeiqRg9Bw6qDo2/iK0wy9Buy1CjDsP23Nq09MLOijZHWzaoIyV
MHeAt6d1nU1a37L4Po0ZnAFOy4jlcvPB1nKBEFuEYRVgRH9fLcTcbHqw0kqhQyg3
Hms9xQ0f9Kz5jM1wfd7NbDBXK5ExS5IQr+rXERYpkEmZEo3R+H+sGjVj3AALyECs
X1tPhkVMqo1BHMF8VAc4iqbUdIYhKNot2KWSVopeVb7FNe7QGmbMAPDrs06krdSh
w8Crz4Y/VU/ChKooagy0sr0BCwkNg5crGKG2rPW3OcZ5kNzg08Qix8qmqzOmA8NR
wpElKghQmlpAhokXBjjEvxe7I7F/j9t8zoFG2DU/9HUAazNgdpkaB87BtucQmyC0
ylxnm1weU+hfvfCQtjXuLiKa8Z4wX2yHVJ1T08XyijNvCAoO+jze5V89PH2EJr7G
eO04j0yuRl4=
=/noh
-----END PGP SIGNATURE-----

--ILuaRSyQpoVaJ1HG--
