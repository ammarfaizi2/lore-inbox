Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265198AbUGLRKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265198AbUGLRKI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 13:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266891AbUGLRKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 13:10:07 -0400
Received: from null.rsn.bth.se ([194.47.142.3]:59305 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S265198AbUGLRKC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 13:10:02 -0400
Subject: Re: [PATCH] Instrumenting high latency
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040712113114.GA21066@holomorphy.com>
References: <cone.1089613755.742689.28499.502@pc.kolivas.org>
	 <20040712003418.02997a12.akpm@osdl.org>
	 <20040712080259.GV21066@holomorphy.com>
	 <20040712083820.GW21066@holomorphy.com>
	 <20040712113114.GA21066@holomorphy.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-hM9fkG0Dy11bzpktjIip"
Message-Id: <1089652199.1064.1.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 12 Jul 2004 19:09:59 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hM9fkG0Dy11bzpktjIip
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-07-12 at 13:31, William Lee Irwin III wrote:

> (b) the damn thing finally boots on my craptop, where else did it break?

Con sent me the version he later posted here, and it broke during boot
with a preempt_count() of 0xffffff6d which didn't make in_interrupt()
very friendly and kmem_cache_create() doesn't like that...

I'll test this new version in a while.

--=20
/Martin

--=-hM9fkG0Dy11bzpktjIip
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA8sXmWm2vlfa207ERAj1hAKCoLkUPxsnXaRFnnrn3Cyq34hQM5wCgsUhi
CYSKRM43BubmI/4xTcPw0ew=
=Kulz
-----END PGP SIGNATURE-----

--=-hM9fkG0Dy11bzpktjIip--
