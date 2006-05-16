Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbWEPPJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWEPPJP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 11:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWEPPJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 11:09:15 -0400
Received: from crystal.sipsolutions.net ([195.210.38.204]:19176 "EHLO
	sipsolutions.net") by vger.kernel.org with ESMTP id S1750853AbWEPPJM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 11:09:12 -0400
Subject: Re: /dev/random on Linux
From: Johannes Berg <johannes@sipsolutions.net>
To: Michael Buesch <mb@bu3sch.de>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jonathan Day <imipak@yahoo.com>, linux-kernel@vger.kernel.org,
       Zvika Gutterman <zvi@safend.com>, Muli Ben-Yehuda <muli@il.ibm.com>
In-Reply-To: <200605161658.33855.mb@bu3sch.de>
References: <20060515213956.31627.qmail@web31508.mail.mud.yahoo.com>
	 <20060516025003.GC18645@rhun.haifa.ibm.com>
	 <B2E79864-3AC6-4B72-B97B-222FEDA136A1@mac.com>
	 <200605161658.33855.mb@bu3sch.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-SVQzVvOE1sq3SXH4GQ+C"
Date: Tue, 16 May 2006 17:08:13 +0200
Message-Id: <1147792093.983.26.camel@johannes>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SVQzVvOE1sq3SXH4GQ+C
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-05-16 at 16:58 +0200, Michael Buesch wrote:

> I think most (all?) of the machines, OpenWRT runs on, are running
> a bcm43xx wireless chip. This chip has a hardware random number
> generator. patches to utilize it recently went into -mm.
> But I must admit, we don't know how it generates random numbers.
> But someone did some RNG tests on it in the past (I think it was
> Johannes).

I did, but no predictability tests, only FIPS 140-2 or so. It checked
out pretty well but someone claimed that the RNG was predictable because
it was probably only used for some of the coding for wireless. I don't
know how to test this hypothesis as I don't know enough about QAM and
whatever codings are used there (nor do I know where you'd need
(pseudo-)random numbers)

johannes

--=-SVQzVvOE1sq3SXH4GQ+C
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARGnq26Vg1VMiehFYAQK1DA/9GokEqikklB9nQ/NIEJJ1gXGJOJN4HElV
U5qWYc/OXZIchg7bECxKU7h3LCgb2Uge+a0c/XFSzo9IvukBnJx8QUKe2x0vbyrZ
wl4z6EXOhTlqUYyvptJ+iapan/b5Hl9L7M9JrRuLiuF/ZukMIA8nyn1IzKXiFNPR
lAX3g2noJMr00ZLICbMei4UFj+agRvCTe+gGOQvnSD+6ap4ZwLDQ/zx68NNYwwi5
CU8V/Mi2rQtUeohaL7QFcxZV706gS6pq7u/qJz9vpAoSLFFM9CZc4xwEbIa8UqP1
J5Is42Sd1WSVt1VsQ60wSHckKhGsIMzIFw1VQcQR/ozELRHBgUmty3clgUg27Cfu
U8CqM7rRheapgQuYelGEC8rAgtUZL/ImPHvFAfDSS42+/3D3Pkwq2XMMRqhiTuaF
991JGyD1vxiKLklUe6gpVlixFLtbil8vFpH6GNTmncWvChp40BzTbXe+cZ/jHAXG
8HWHoUTgQOBEZyQiS60/tlNTFNDZisMqK//qoa4eQMOpHR2lbsJWxldsAtrNrMci
8fE1QjjUjOmLJKS6oAiM3Xivc8ST6r3UJ9IDDc+jWSPlFKfakmMje2jhbTboFB4e
qVvuVCrlBANHvvBANzUb3QMYTmxf+10nl/4HWZBVORb0o/UtL06a8WXAXxBYJ5FE
iUUTRoX2GUw=
=g+w8
-----END PGP SIGNATURE-----

--=-SVQzVvOE1sq3SXH4GQ+C--

