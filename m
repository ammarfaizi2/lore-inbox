Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbTJSL0v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 07:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbTJSL0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 07:26:51 -0400
Received: from c-24-99-36-145.atl.client2.attbi.com ([24.99.36.145]:21778 "EHLO
	babylon.d2dc.net") by vger.kernel.org with ESMTP id S262104AbTJSL0t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 07:26:49 -0400
Date: Sun, 19 Oct 2003 07:26:48 -0400
From: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
To: DervishD <raul@pleyades.net>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Console escape sequences
Message-ID: <20031019112647.GA8497@babylon.d2dc.net>
Mail-Followup-To: DervishD <raul@pleyades.net>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <20031018000531.GB17198@DervishD> <20031018112330.GH17198@DervishD>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20031018112330.GH17198@DervishD>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 18, 2003 at 01:23:30PM +0200, DervishD wrote:
>     Hi all :))
>=20
>     My excuses, I've had problems with my mail and lost the two
> responses to my original mail. The fact is that I've already read the
> manpage you say (console_codes(4)), but that page seems to be from
> 1996, so I was asking myself if a more recent referend existed.
>=20
>     Is there any more up to date reference or any place in the source
> code? Thanks for the answer anyway :))) and thanks in advance for all
> your help, together with my excuses to the two persons who answered
> for having lost their emails.

The code that seems to handle it in 2.6.0-test7-mm1 is in
drivers/char/vt.c, starting in do_con_write and actually dealt with in
do_con_trol.

Good luck.

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

     "First they came for the Jews, and I didn't speak out - because I
was not a jew. Then they came for the Communists, and I did not speak
out - because I was not a Communist. Then they came for the trade
unionists, and I did not speak out - because I was not a trade unionist.
Then they came for me and there was no one left to speak for me!"
  - Pastor Niemoeller - victim of Hitler's Nazis

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/knT3RFMAi+ZaeAERAqwYAKCeAVJMZ3crNGbgFWC0nUCozX2nWQCfe4pm
DmTBgZDExJ3FtKHMrgiJzlk=
=k49j
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
