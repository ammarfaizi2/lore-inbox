Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbVKLXOr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbVKLXOr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 18:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbVKLXOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 18:14:47 -0500
Received: from mout2.freenet.de ([194.97.50.155]:9148 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S932507AbVKLXOq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 18:14:46 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: asm/delay.h missing on powerpc (was: Re: Linuv 2.6.15-rc1)
Date: Sun, 13 Nov 2005 00:13:45 +0100
User-Agent: KMail/1.8.3
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org> <Pine.LNX.4.64.0511121257000.3263@g5.osdl.org> <1131834254.7406.43.camel@gaston>
In-Reply-To: <1131834254.7406.43.camel@gaston>
Cc: linuxppc-dev@ozlabs.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart35388533.skd0ZB2N8m";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200511130013.45610.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart35388533.skd0ZB2N8m
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 12 November 2005 23:24, you wrote:
> =C3=8Ct should still work. I'm running -rc1 with "powerpc" on mine so tha=
t at
> least works, it's possible that we broke "ppc", I'll have a look and
> send a fix.

powerpc arch builds and runs now, but
I have problems compiling the bcm430x driver. It includes linux/delay.h.
linux/delay.h includes asm/delay.h, which does not exist.
What to do now?

=2D-=20
Greetings Michael.

--nextPart35388533.skd0ZB2N8m
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDdncplb09HEdWDKgRAkYPAJsHxod/e8y4MY1892gcWqqMkzfJRgCdGbc8
oUpxsllA+Duypvur1BVQujY=
=/+wy
-----END PGP SIGNATURE-----

--nextPart35388533.skd0ZB2N8m--
