Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbVG1WX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVG1WX4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 18:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbVG1WXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 18:23:55 -0400
Received: from hostmaster.org ([212.186.110.32]:57287 "EHLO hostmaster.org")
	by vger.kernel.org with ESMTP id S261724AbVG1WWp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 18:22:45 -0400
Subject: Re: 2.6.12: no sound on SPDIF with emu10k1
From: Thomas Zehetbauer <thomasz@hostmaster.org>
To: Avuton Olrich <avuton@gmail.com>
Cc: fedora-list@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <3aa654a4050728031376bb7a9b@mail.gmail.com>
References: <1122493585.3137.14.camel@hostmaster.org>
	 <3aa654a4050728031376bb7a9b@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-NK7RGC2eh2i8FbVW8dKw"
Date: Fri, 29 Jul 2005 00:22:44 +0200
Message-Id: <1122589364.2649.6.camel@hostmaster.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-1.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NK7RGC2eh2i8FbVW8dKw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-07-28 at 03:13 -0700, Avuton Olrich wrote:
> After upgrading to 1.0.9, I thought my emu10k1 board was broken until
> I toggled 'IEC958 Optical Raw' to Off.

Many thanks, that did the trick! I have now tried to only load the
emu10k1 driver modules and found that 2.6.12's ALSA is VERY different
from all previous versions in that it does not mute all channels by
default any more.

Tom

--=20
  T h o m a s   Z e h e t b a u e r   ( TZ251 )
  PGP encrypted mail preferred - KeyID 96FFCB89
      finger thomasz@hostmaster.org for key

-----BEGIN GEEK CODE BLOCK-----
GS/IT d-- s: a-- C++++ UL++++ P+>$ L++>$ E--- W+ N+ o? !K w++$ O M-
V? PS+++ PE++ Y+ PGP+++ t+ 5 X R- tv b- DI(+) D+ G>++ e h! !r y+
------END GEEK CODE BLOCK------




--=-NK7RGC2eh2i8FbVW8dKw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQEVAwUAQulatGD1OYqW/8uJAQJ+kwgAhqMzB+Id7b8ML+Xi03zBADGei7bhrm3o
D1WwaUOLOODGpTKftkMfZMGpgi4bKgaGnfqiSJHnkMeBFqsM9C2RGDgwFbTP/e9n
pYenxo7It7ztGrVK+T5GxABaVS8ZrpUvblHfzIMP1VdkkpQJ0IjYeI3jPLFlquyJ
jKefqnPNtV4vMec2E79HUTw9o3lDXEfw+L8h773WLHKWKI/SeS/5P9ue6HpUaU7C
Fmibw8sXoWF06j21aiSYAmKp8Frdm94dCq4tTP565KjlnAYUrS0bbozcPA8afzse
IUTcSAJfElpIhAm7UwPHLr1vfXrrtK57Bdihc+JkNa77cNsRa0rP+A==
=UxY0
-----END PGP SIGNATURE-----

--=-NK7RGC2eh2i8FbVW8dKw--

