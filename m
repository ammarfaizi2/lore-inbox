Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263167AbUFNOg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263167AbUFNOg2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 10:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263169AbUFNOg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 10:36:28 -0400
Received: from trantor.org.uk ([213.146.130.142]:35221 "EHLO trantor.org.uk")
	by vger.kernel.org with ESMTP id S263079AbUFNOgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 10:36:14 -0400
Subject: Re: [PATCH] fix for Re: timer + fpu stuff locks my console race
From: Gianni Tedesco <gianni@scaramanga.co.uk>
To: Andi Kleen <ak@muc.de>
Cc: stian@nixia.no, linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <m3n038o76h.fsf@averell.firstfloor.org>
References: <25iEn-7bv-3@gated-at.bofh.it>
	 <m3n038o76h.fsf@averell.firstfloor.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xk0aWRGzJAwDQ3foW2yN"
Date: Mon, 14 Jun 2004 15:36:03 +0100
Message-Id: <1087223763.3375.23.camel@sherbert>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xk0aWRGzJAwDQ3foW2yN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-06-12 at 22:25 +0200, Andi Kleen wrote:
> Please test.

Thats fixed it for me on PIII (Katmai) / 2.6.6.

Exploit runs and runs, no oopsen.

--=20
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/scaramanga.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-xk0aWRGzJAwDQ3foW2yN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAzbfSkbV2aYZGvn0RAqHRAJ0ZQU9DgoTuD1t3MpLzmSnWw3TGpQCbB0lY
OH8i9Jwu6nRxlAxy2EgwYGM=
=TUmq
-----END PGP SIGNATURE-----

--=-xk0aWRGzJAwDQ3foW2yN--

