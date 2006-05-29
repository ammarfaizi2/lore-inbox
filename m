Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbWE2N6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbWE2N6n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 09:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWE2N6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 09:58:43 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:27079 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S1750829AbWE2N6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 09:58:43 -0400
Message-ID: <447AFE09.80005@isotton.com>
Date: Mon, 29 May 2006 15:58:33 +0200
From: Aaron Isotton <aaron@isotton.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Alan Menegotto <macnish@gmail.com>
Subject: Re: Dump the tcp_sock structure for every packet
References: <4479E2C5.90708@isotton.com> <447AF09F.705@gmail.com>
In-Reply-To: <447AF09F.705@gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig20E5641255E96EEE1C94FFD9"
X-DCC-spamcheck-01.tornado.cablecom.ch-Metrics: smtp-07.tornado.cablecom.ch 1377;
	Body=2 Fuz1=2 Fuz2=2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig20E5641255E96EEE1C94FFD9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Alan Menegotto wrote:
 > The last routine done in tcp is tcp_transmit_skb, which passes the skb=

> down to the IP layer. See net/ipv4/tcp_output.c for details.

Ok, thank you very much. Is there some similar function for incoming
packets too?

Greetings,
Aaron
--=20
Aaron Isotton | http://www.isotton.com/
I'll give you a definite maybe. --Samuel Goldwyn


--------------enig20E5641255E96EEE1C94FFD9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEev4Lm2HPKfVbHyoRAlm+AKDvCD9ioLuDV/y1uiGPAsb//HhrjwCcC4LP
+CwEg8IdI7uTV+uC9Ld2Mnw=
=kFEa
-----END PGP SIGNATURE-----

--------------enig20E5641255E96EEE1C94FFD9--
