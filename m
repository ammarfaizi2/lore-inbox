Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267458AbTANG0O>; Tue, 14 Jan 2003 01:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267463AbTANG0O>; Tue, 14 Jan 2003 01:26:14 -0500
Received: from adsl-67-121-154-100.dsl.pltn13.pacbell.net ([67.121.154.100]:9696
	"EHLO kanoe.ludicrus.net") by vger.kernel.org with ESMTP
	id <S267458AbTANG0N>; Tue, 14 Jan 2003 01:26:13 -0500
Date: Mon, 13 Jan 2003 22:34:57 -0800
To: linux-kernel@vger.kernel.org
Subject: intense disk or tty activity SEGV's X
Message-ID: <20030114063457.GA11073@kanoe.ludicrus.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
From: "Joshua M. Kwan" <joshk@ludicrus.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Lately, using the nForce IDE driver I have noticed a few glitches with=20
it that affect stability.

I use the BK tree for my kernel source. Lately, if I 1) clone a fresh=20
tree (i pull from a few places so sometimes there are some boggling=20
conflicts that a fresh tree fixes) or 2) run a bk pull, X will SEGV out=20
of nowhere. At first I thought it was the amount of disk activity.

But after reading the saga of the flukey tty code in the kernel, I am=20
thinking this could also be because of that? Lots of stuff scrolls by=20
when doing a bk clone, and when resolve runs after a bk pull there is=20
often lots of output.

There is no oops at all, nor anything that might be of help in dmesg.
Any ideas? I started noticing it around halfway through 2.5.56...

Regards
Josh

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+I6+R6TRUxq22Mx4RAt1+AKC32imc2Qhf5Jejm2S89rCV01A95ACfZ/OZ
mnWVDEsMPdLiOcrTSK5ummc=
=FhYF
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
