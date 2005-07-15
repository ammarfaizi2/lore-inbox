Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261871AbVGOKqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbVGOKqn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 06:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263273AbVGOKoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 06:44:24 -0400
Received: from natfrord.rzone.de ([81.169.145.161]:45740 "EHLO
	natfrord.rzone.de") by vger.kernel.org with ESMTP id S263287AbVGOKex
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 06:34:53 -0400
Subject: Re: sata_sil 3112 activity LED patch
From: Christian Kroll <christian.kroll@bglug.org>
To: Aric Cyr <acyr@alumni.uwaterloo.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050715055743.GA8041@alumni.uwaterloo.ca>
References: <1121393712.4770.6.camel@localhost>
	 <20050715055743.GA8041@alumni.uwaterloo.ca>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-sJyeOCYmfJG7SrqwUtn3"
Date: Fri, 15 Jul 2005 12:34:36 +0200
Message-Id: <1121423676.4838.23.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sJyeOCYmfJG7SrqwUtn3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 15, 2005 at 02:57PM +0900, Aric Cyr wrote:
> Out of curiosity, did the LED
> usage change at all before and after the patch, or was it totally
> unaffected.  I would guess the latter.

It was totally unaffected. If the LED is turned on by the BIOS (while it
examines the bus at boot time), it remains on as long as Linux is
running. If it isn't turned on by the BIOS (Silicon Image's reference
BIOS), it doesn't light up under Linux as well.

> Thanks, I will.  I have emailed Silicon Image in the (slim) chance
> that they will provide me with the information I require.  If they
> come through then I might be able to whip something up and have you
> test it.

Thanks for looking into this!

--=20
Christian Kroll <christian.kroll@bglug.org>
GnuPG Fingerprint: DA5D 5BFA 5C95 FD09 2A72  517E 10CB DCD5 71ED 7E35

--=-sJyeOCYmfJG7SrqwUtn3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC15E8EMvc1XHtfjURAtYJAJ9EH99GduTtrRafSbMy+9vn9qeG2wCePasm
LNrxpJb6rXEpJ24MH5TAdVE=
=VF13
-----END PGP SIGNATURE-----

--=-sJyeOCYmfJG7SrqwUtn3--

