Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265040AbUHRIVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265040AbUHRIVm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 04:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265029AbUHRIVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 04:21:42 -0400
Received: from ender.smtp.cz ([81.95.97.119]:5015 "EHLO out.smtp.cz")
	by vger.kernel.org with ESMTP id S265027AbUHRIUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 04:20:50 -0400
Subject: network regression using 2.6.8.x behind Cisco 1712
From: =?iso-8859-2?Q?Ond=F8ej_Sur=FD?= <ondrej@sury.org>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-fh01tjMp4sefyrWOmPV6"
Date: Wed, 18 Aug 2004 10:20:47 +0200
Message-Id: <1092817247.5178.6.camel@ondrej.sury.org>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fh01tjMp4sefyrWOmPV6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

I encountered regression in 2.6.8.1 when behind Cisco 1712 router.
There is huge network slowdown, my connections rate drops to ~10K/s on
2.6.8.1, local network is fine.  When using 2.6.7 connection rate is
~400K/s (depending on what I am downloading).

Network configuration is same on 2.6.8.1 and 2.6.7.  My .config can be
found at http://www.sury.org/kernel/config-2.6.8.1

Kernel is vanilla with MPPE+MPPC patch applied, but same behaviour has
distribution debian kernel.  Also I have tried to disable QoS and IPv6
in 2.6.8.1, but without any result.

It could be some bug in IOS, but it is triggered by some change between
2.6.7 and 2.6.8.  Any hints what should I try or where to look?
I could try some -pre and -rc kernel to locate where this was
introduced, but at least try to hint me which version should be
considered, I am not so willing to compile all -preX and -rcX, but could
do that if neccessary to hunt this regression.

Please Cc: me, I am not on list.

O.
--=20
Ond=C5=99ej Sur=C3=BD <ondrej@sury.org>

--=-fh01tjMp4sefyrWOmPV6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBIxFe9OZqfMIN8nMRAqTaAKCGRyh6WXRlpkehvZdJUh+5HSQRpgCfYRtE
krAflCcXZe153MP7UxUpGIA=
=bPwE
-----END PGP SIGNATURE-----

--=-fh01tjMp4sefyrWOmPV6--

