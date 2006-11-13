Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932645AbWKMSUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932645AbWKMSUq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 13:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755312AbWKMSUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 13:20:45 -0500
Received: from crystal.sipsolutions.net ([195.210.38.204]:16813 "EHLO
	sipsolutions.net") by vger.kernel.org with ESMTP id S1755310AbWKMSUo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 13:20:44 -0500
Subject: Re: [PATCH] Apple Motion Sensor driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Jean Delvare <khali@linux-fr.org>
Cc: Stelian Pop <stelian@popies.net>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Andrew Morton <akpm@osdl.org>,
       Michael Hanselmann <linux-kernel@hansmi.ch>,
       "Aristeu S. Rozanski F." <aris@cathedrallabs.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>, Robert Love <rml@novell.com>,
       Rene Nussbaumer <linux-kernel@killerfox.forkbomb.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20061113191444.1519bdb9.khali@linux-fr.org>
References: <1163280972.32084.13.camel@localhost.localdomain>
	 <d120d5000611130704r258c8946p3994c5ba1e0187e9@mail.gmail.com>
	 <1163431758.23444.8.camel@localhost.localdomain>
	 <d120d5000611130753p172c2a69n260482052f623a46@mail.gmail.com>
	 <1163434455.23444.14.camel@localhost.localdomain>
	 <1163434826.2805.2.camel@ux156>
	 <20061113191444.1519bdb9.khali@linux-fr.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-tU+00GymfR1X7XV0vAK1"
Date: Mon, 13 Nov 2006 19:18:51 +0100
Message-Id: <1163441931.5399.16.camel@johannes.berg>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
X-sips-origin: submit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tU+00GymfR1X7XV0vAK1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-11-13 at 19:14 +0100, Jean Delvare wrote:

> For what it's worth, the hdaps driver offers a parameter to invert the
> axes at the driver level.=20

Ah ok.

> It sounds sane to me, as ideally we should be
> able to detect it from the hardware, and user-space should not need to
> care about hardware specific details.

Yeah well I figured we'd just put the parameter into userspace
instead :)

Thing is, there's simply no clear standard for accelerometer input
devices. If the left side of my input device (read powerbook here) is
lower, does the mouse cursor 'fall' with gravity, or does it 'float' up?
Neverball apparently expects it to fall with gravity.

johannes

--=-tU+00GymfR1X7XV0vAK1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARVi3CqVg1VMiehFYAQLpGw//XnpJ5SXiz+s/G7U+7AYFVN/UWpp4+P35
lPAERHM4EHUt4AXrS39/enDi5iXCzCNdjkrqVUAIZ6kJzoPAmYlAiLvBU0HQrXVF
mFyiOX0NkMELPigNKglSFks+xLhjo9tslFmkJqKWPtM1AUxL6A255vd2zywepyQR
eU/PyzogLybjbJo1BFBK5zABZz9+nJ0dLOsZA/ywAKU1MGuq3h+zx6s9TKEbPtaM
iVBS13bV3Shd26jKMb9lhqaIpVA+TYXlbMGuPXVqGff7er26DY0ENAPaj+3919MM
pKT18K3Kkd1iRkf5EyaWS+ZyIQbSE/sXeP3D4L9cwX+o20ym0gkd4yasur1XzFDZ
+TfLC7a+o0tBlaURNK5RVSQZZIP1fdTuVFMaOMGvJZjSqZTgITzy1aG4sk2OTXjW
I4HJ0Ma3XeLoX7TzRaJkpGnmTkIOC1W8lKWAOTcSXtSHfQbro9cyfHepK0ME8qXP
BdA2nbjVy0qEToIkbkzeqHEw+6VAac5jaXXoh7ffhgwXTNnvKlVk5wUaSm5dA7JU
NcWlKNDcU9CRWyLVGBv3P/ClhM0gw9b+ktaNPKVdu5Ec7TO0PpviJA6cSG+opa3M
p1WlS4yekKiOcm+U2TIEAxMyx07ThaU3CIdd7E33SLhCJusHU0cmhWy+U1Nf7GhL
GdyMKCNMpsk=
=u8c6
-----END PGP SIGNATURE-----

--=-tU+00GymfR1X7XV0vAK1--

