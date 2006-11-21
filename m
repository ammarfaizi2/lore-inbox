Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031273AbWKUSig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031273AbWKUSig (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 13:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031284AbWKUSig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 13:38:36 -0500
Received: from crystal.sipsolutions.net ([195.210.38.204]:65438 "EHLO
	sipsolutions.net") by vger.kernel.org with ESMTP id S1031273AbWKUSif
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 13:38:35 -0500
Subject: Re: RFC/T: Trial fix for the bcm43xx - wpa_supplicant -
	NetworkManager deadlock
From: Johannes Berg <johannes@sipsolutions.net>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Ray Lee <ray-lk@madrabbit.org>, Dan Williams <dcbw@redhat.com>,
       Broadcom Linux <bcm43xx-dev@lists.berlios.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1164133962.3631.14.camel@johannes.berg>
References: <4561DBE0.2060908@lwfinger.net> <45628C05.405@madrabbit.org>
	 <45633FF8.6010209@lwfinger.net>  <1164133962.3631.14.camel@johannes.berg>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-spaxijl+mvp97IVdNDC2"
Date: Tue, 21 Nov 2006 19:36:41 +0100
Message-Id: <1164134201.3631.16.camel@johannes.berg>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-spaxijl+mvp97IVdNDC2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-11-21 at 19:32 +0100, Johannes Berg wrote:

> I don't think this is the right thing to do.

Or put differently, this won't fix the problem if that "something:
that's triggering the deadlock happens while you're in the locked
section.

johannes

--=-spaxijl+mvp97IVdNDC2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFY0c5/ETPhpq3jKURAmnRAKC1I4rdr6ELOWhRJP/pXj64bsQE0gCeLu9w
iAdvsP9Ib393yWtF5J/IaME=
=TSFH
-----END PGP SIGNATURE-----

--=-spaxijl+mvp97IVdNDC2--

