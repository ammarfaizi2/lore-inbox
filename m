Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269488AbUIZDEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269488AbUIZDEw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 23:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269489AbUIZDEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 23:04:52 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:59348 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S269488AbUIZDEu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 23:04:50 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [sched.h 6/8] move aio include to mm.h
Date: Sun, 26 Sep 2004 05:03:51 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040925024513.GL9106@holomorphy.com> <200409260356.27499.arnd@arndb.de> <20040926020637.GS9106@holomorphy.com>
In-Reply-To: <20040926020637.GS9106@holomorphy.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_YGjVBpAnT9d2EMK";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200409260503.53088.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_YGjVBpAnT9d2EMK
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sonntag, 26. September 2004 04:06, William Lee Irwin III wrote:
> Grepping by hand turned up 186 files missing potentially missing direct
> includes of workqueue.h, though I don't have a way to tell if I got
> false negatives.
>=20
I just realized that I was using an old kernel tree (2.6.7 with
some patches), which might be the reason for getting fewer results
(38 of my 175 findings were extra #include lines, not missing ones).

Running my script against the linux.bkbits.net tree gives now gives
me 178 missing and 35 extraneous inclusions of workqueue.h, so your
list is probably exact if you are grepping against -mm.

	Arnd <><

--Boundary-02=_YGjVBpAnT9d2EMK
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBVjGY5t5GS2LDRf4RAv2FAJ4ruS5NsxToZi8PovwL62F9l9jCcACfavzj
YQxEjgRtRPZKCZBjHpxrfcU=
=MPcZ
-----END PGP SIGNATURE-----

--Boundary-02=_YGjVBpAnT9d2EMK--
