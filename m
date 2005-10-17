Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbVJQKaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbVJQKaL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 06:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbVJQKaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 06:30:11 -0400
Received: from mail02.solnet.ch ([212.101.4.136]:10219 "EHLO mail02.solnet.ch")
	by vger.kernel.org with ESMTP id S932257AbVJQKaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 06:30:09 -0400
From: Damir Perisa <damir.perisa@solnet.ch>
To: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: 2.6.14-rc4-mm1 - drivers/serial/jsm/jsm_tty.c: no member named 'flip'
Date: Mon, 17 Oct 2005 12:29:54 +0200
User-Agent: KMail/1.8.3
References: <20051016154108.25735ee3.akpm@osdl.org>
In-Reply-To: <20051016154108.25735ee3.akpm@osdl.org>
X-Face: +)fhYFmn|<pyRIlgch_);krg#jn!^z'?xy(Ur#Z6rZi)KD+_-V<Y@i>0pOVfJ4<=?iso-8859-1?q?Q1/=26/=26z=0A=093cxqRa=3B7O=5C4g=5C=7C=5DF-!H0!ew9kx1LqK/?=
 =?iso-8859-1?q?iPOv8eXi=26I7=60Pez0V0VNMAxnqRL8-30qqKK=3DxGM=0A=09pExQc=5B?=
 =?iso-8859-1?q?2=7Cl6v=23?=<iwBvEO9+h|_YS[48z%/kuD2*aT*S/$0323VCL3V9?@}jq<
 =?iso-8859-1?q?Ns6V=3A0m=27Qia=0A=09?="[#oJg[RVe}Sy/lP95E@pa[vdKzqLqn&M`exb91"`,<k`3;Vt97cLjhub0.v+]m`%|>@Z(
 =?iso-8859-1?q?=0A=09EeC/zU7=25?=@"L6mi#..8Q^M
Cc: linux-kernel@vger.kernel.org
Alanine: true
Glycine: true
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1601068.CSgrmsYEQp";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200510171229.57785.damir.perisa@solnet.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1601068.CSgrmsYEQp
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

just found that jsm-tty is still not compiling:

  LD      drivers/serial/jsm/built-in.o
  CC [M]  drivers/serial/jsm/jsm_driver.o
  CC [M]  drivers/serial/jsm/jsm_neo.o
  CC [M]  drivers/serial/jsm/jsm_tty.o
drivers/serial/jsm/jsm_tty.c: In function 'jsm_input':
drivers/serial/jsm/jsm_tty.c:592: error: 'struct tty_struct' has no member =
named 'flip'
drivers/serial/jsm/jsm_tty.c:619: error: 'struct tty_struct' has no member =
named 'flip'
drivers/serial/jsm/jsm_tty.c:620: error: 'struct tty_struct' has no member =
named 'flip'
drivers/serial/jsm/jsm_tty.c:623: error: 'struct tty_struct' has no member =
named 'flip'
=2E..

greetings,
Damir

=2D-=20
Who does not trust enough will not be trusted.
		-- Lao Tsu

--nextPart1601068.CSgrmsYEQp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDU30lPABWKV6NProRAi78AKCoVuXLVIyv1B9TrHkQ4WyCwwMfqwCfba1t
FlPqT2YV8lmKudwmt3fDDgQ=
=LhwP
-----END PGP SIGNATURE-----

--nextPart1601068.CSgrmsYEQp--
