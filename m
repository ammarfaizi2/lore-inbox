Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262381AbUKQUTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262381AbUKQUTq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 15:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbUKQURc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 15:17:32 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:29395 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S262378AbUKQUQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 15:16:14 -0500
Subject: Re: Network slowdown from 2.6.7 to 2.6.9
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Harry Edmon <harry@atmos.washington.edu>
Cc: Con Kolivas <kernel@kolivas.org>, Stephen Hemminger <shemminger@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <419BA5C4.4020503@atmos.washington.edu>
References: <419A9151.2000508@atmos.washington.edu>
	 <20041116163257.0e63031d@zqx3.pdx.osdl.net>
	 <cone.1100651833.776334.15267.502@pc.kolivas.org>
	 <419BA5C4.4020503@atmos.washington.edu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-pK99aYG2vDrTTe1704Wr"
Message-Id: <1100722571.20185.9.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 17 Nov 2004 21:16:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pK99aYG2vDrTTe1704Wr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-11-17 at 20:25, Harry Edmon wrote:
> Tried your suggestion - no improvement.

I saw fron your .config that you have ip_conntrack as module, is it
loaded? The TCP part of ip_conntrack got a pretty huge makeover in 2.6.9
which also added more complexity to the code... and now it verifies the
checksums of all TCP packets.

--=20
/Martin

--=-pK99aYG2vDrTTe1704Wr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBm7GKWm2vlfa207ERAteqAJ9FWBvjqsWKIezSzvgZSbd4scx8RgCgvAsa
AIMjNsfevjSgJn7AsZqUorM=
=cVg9
-----END PGP SIGNATURE-----

--=-pK99aYG2vDrTTe1704Wr--
