Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbTLMEJv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 23:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263836AbTLMEJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 23:09:51 -0500
Received: from [38.119.218.103] ([38.119.218.103]:5814 "HELO
	mail.bytehosting.com") by vger.kernel.org with SMTP id S263637AbTLMEJt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 23:09:49 -0500
X-Qmail-Scanner-Mail-From: drunk@conwaycorp.net via digital.bytehosting.com
X-Qmail-Scanner: 1.20rc3 (Clear:RC:1:. Processed in 0.045737 secs)
Date: Fri, 12 Dec 2003 22:09:47 -0600
From: Nathan Poznick <kraken@drunkmonkey.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Handle R_ALPHA_REFLONG relocation on Alpha (2.6.0-test11)
Message-ID: <20031213040947.GA3447@wang-fu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031213003841.GA5213@wang-fu.org> <yw1xisklwiyt.fsf@kth.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <yw1xisklwiyt.fsf@kth.se>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thus spake M?ns Rullg?rd:
> Which gcc and binutils versions do you use?  I've seen some variation
> in which relocations they produce.

I'm using gcc 3.3.2 and binutils 2.14.90.0.7.  The patch shouldn't hurt
when using versions which may produce other relocations, correct?  If
R_ALPHA_REFLONG isn't generated, then that bit of the switch statement
just wouldn't be hit.


--=20
Nathan Poznick <kraken@drunkmonkey.org>

If you write something wrong enough, I'll be glad to make up a new
witticism just for you. -- Larry Wall


--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/2pELYOn9JTETs+URAmbEAKCf7ZnkMs4QS9zqcBszcYc/zwyo4gCfeiI4
oAgu42bjxG5D0D+vWugDtQ0=
=QTel
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
