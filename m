Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262649AbVDHBdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbVDHBdn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 21:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbVDHBdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 21:33:43 -0400
Received: from downeast.net ([204.176.212.2]:35804 "EHLO downeast.net")
	by vger.kernel.org with ESMTP id S262649AbVDHBdk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 21:33:40 -0400
From: Patrick McFarland <pmcfarland@downeast.net>
To: Ian Pilcher <i.pilcher@comcast.net>
Subject: Re: alsa es1371's joystick functionality broken in 2.6.11-mm4
Date: Thu, 7 Apr 2005 21:33:33 -0400
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <200503201557.58055.pmcfarland@downeast.net> <200504070717.34113.pmcfarland@downeast.net> <d342u5$2rt$1@sea.gmane.org>
In-Reply-To: <d342u5$2rt$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4350888.rNbrKNfG4j";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200504072133.38977.pmcfarland@downeast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4350888.rNbrKNfG4j
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 07 April 2005 03:52 pm, Ian Pilcher wrote:
> Any chance the joystick is just broken?

Nope.=20

What works:
1) _Both_ joysticks (one that uses the analog driver, the other that uses t=
he=20
sidewinder driver) work fine under Win2k.
2) Sound works under both Linux and Win2k.
3) The analog joystick (I didn't have the sidewinder yet) use to work at so=
me=20
point in the past on this system with a 2.6 kernel.

What doesn't work:
1) Either the analog or sidewinder joysticks using any kernel I've tested s=
o=20
far, loading snd_ens1371 using either joystick=3D1 or joystick_port=3D1 (I =
test=20
both out of habit). (Loaded in the order of snd_ens1371 (which loads=20
gameport), joydev, and then analog or sidewinder. Putting joydev or gamepor=
t=20
or both before snd_ens1371 doesn't improve the situation.)

=2D-=20
Patrick "Diablo-D3" McFarland || pmcfarland@downeast.net
"Computer games don't affect kids; I mean if Pac-Man affected us as kids, w=
e'd=20
all be running around in darkened rooms, munching magic pills and listening=
 to
repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989

--nextPart4350888.rNbrKNfG4j
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCVd9y8Gvouk7G1cURAhiwAJ0U+0MNXUhUAzcX0mHR4jVgX0NZiQCdHEet
UcgcrSYVPkg0pF2HNythv9o=
=mrAM
-----END PGP SIGNATURE-----

--nextPart4350888.rNbrKNfG4j--
