Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbVLGNfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbVLGNfk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 08:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbVLGNfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 08:35:40 -0500
Received: from mout1.freenet.de ([194.97.50.132]:11474 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S1750987AbVLGNfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 08:35:39 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: Broadcom 43xx first results
Date: Wed, 7 Dec 2005 14:34:22 +0100
User-Agent: KMail/1.8.3
References: <4394902C.8060100@pobox.com> <20051206151046.GF4038@rama.exocore.com> <20051206.151919.72043193.davem@davemloft.net>
In-Reply-To: <20051206.151919.72043193.davem@davemloft.net>
Cc: davej@redhat.com, jgarzik@pobox.com, jbenc@suse.cz, josejx@gentoo.org,
       mbuesch@freenet.de, linux-kernel@vger.kernel.org,
       bcm43xx-dev@lists.berlios.de, netdev@vger.kernel.org,
       laforge@gnumonks.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1801062.7lD3BpfnaP";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200512071434.23706.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1801062.7lD3BpfnaP
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 07 December 2005 00:19, you wrote:
> From: Harald Welte <laforge@gnumonks.org>
> Date: Tue, 6 Dec 2005 20:40:47 +0530
>=20
> > I'm also in favor of merging the devicescape code, but I don't see it
> > happening without somebody taking care to provide all the required
> > levels of interfaces (I see at least three levels of API's that a wirel=
ess
> > driver would need, depending on how much stuff is done in
> > hardware/firmware and how much in software.
>=20
> I hate to say this, but part of the problem is exactly the fact
> that all the implementors have implemented different levels of
> hardware-MAC'ness in their wireless products.
>=20
> Stated even further, things might have been more consistent if M$ had
> specified a set of driver interfaces into their own softmac stack,
> which I am to understand they are working on now.
>=20
> So every M$ wireless driver essentially links in their own softmac
> stack, if needed.
>=20
> This has resulted in a complicated situation for an already
> complicated technology.  Therefore, the fact that it's taking this
> long to accomodate all of the cases in the vanilla tree is quite
> understandable.
>=20
> I'm at the point where I frankly don't care which softmac
> implementation we go with, but rather I'm more concerned that we pick
> _ONE_ and just stick with it, and then adding the necessary interfaces
> and infrastructure as different wireless devices require.
>=20
> Yes, you hear me right, it's more important to agree to one
> implementation as the basis, even if it's the worst one currently.
> Division of labor is something we simply cannot afford on the wireless
> stack at this time.

I agree with you, and that is exactly what we are doing:
We take the existing code and add functionality to it. If the
added functionality is an external module, well, consinder this
as an extra cookie for devices which do not need MAC handling.

=2D-=20
Greetings Michael.

--nextPart1801062.7lD3BpfnaP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDluTflb09HEdWDKgRAkzMAKCl1t/hPpe1cfb1wygotPs+kbLa6QCZAV+i
sSmnauJ0TnAFqxyPQ/iYd2A=
=wzEO
-----END PGP SIGNATURE-----

--nextPart1801062.7lD3BpfnaP--
