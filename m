Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263407AbTFPGz5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 02:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263451AbTFPGz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 02:55:57 -0400
Received: from [4.5.97.206] ([4.5.97.206]:18560 "EHLO gallant")
	by vger.kernel.org with ESMTP id S263407AbTFPGz4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 02:55:56 -0400
Subject: IPSEC problems with GRE.
From: Julian Blake Kongslie <jblake@omgwallhack.org>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-0vHIMrTl5rCR2/k75JK5"
Message-Id: <1055746871.2305.7.camel@festa.omgwallhack.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 16 Jun 2003 00:01:11 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0vHIMrTl5rCR2/k75JK5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi there.

I've been playing around with IPSec, and I came across a problem with
encrypting data sent directly by the kernel.

Specifically, attempts to encrypt a GRE or IPIP tunnel with ipsec in
transport mode result in one of:
	1) No data sent.
	2) Data sent, ignored by peer.
	3) Kernel panic, with no SysRq.

Numbers 1 and 2 might be configuration problems on my part, but I have
other ipsec setups running fine, and can't see anything different for
these. Number 3 is a big problem.

This is on 2.5.70. No third-party modules or other tainting. I can
provide .configs on request.

I don't have the panic copied down, but I can reproduce it and get a
copy if required.

I know I could certainly accomplish what I want with ipsec tunnel mode,
but I'm just playing around, and it's a kernel bug in any case.

Thanks.

--=20
Julian Blake Kongslie <jblake@omgwallhack.org>

--=-0vHIMrTl5rCR2/k75JK5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+7Ws3+6o3+Z/zOlURAjuJAJoDefpMe9jMIzgflHBrMG/2W3GDiwCg2ymU
SwF4UvBg3nSaK20/+Ymu6aE=
=KNBT
-----END PGP SIGNATURE-----

--=-0vHIMrTl5rCR2/k75JK5--
