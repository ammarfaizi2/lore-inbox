Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVDUDEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVDUDEc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 23:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVDUDEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 23:04:32 -0400
Received: from downeast.net ([204.176.212.2]:47596 "EHLO downeast.net")
	by vger.kernel.org with ESMTP id S261195AbVDUDE2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 23:04:28 -0400
From: Patrick McFarland <pmcfarland@downeast.net>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: alsa es1371's joystick functionality broken in 2.6.11-mm4
Date: Wed, 20 Apr 2005 23:03:27 -0400
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <200503201557.58055.pmcfarland@downeast.net> <200504202221.57718.pmcfarland@downeast.net> <200504202129.04083.dtor_core@ameritech.net>
In-Reply-To: <200504202129.04083.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3858483.6yuBmCxLph";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200504202303.33898.pmcfarland@downeast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3858483.6yuBmCxLph
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 20 April 2005 10:29 pm, Dmitry Torokhov wrote:
> Ok... I know that sidewinder needs its timeouts increased to about 6ms to
> work with 2.6. Have you tried OSS driver - to make sure that layer above
> the soundcard works?

Well, thats what I've been thinking thats screwing me. Because I've been us=
ing=20
ALSA since my 2.4.x days (I switched over to 2.6 and 2.6.1), and I know my=
=20
analog joystick works with ALSA and 2.6 (I just don't know when the bug=20
appeared) and I've also upgraded my ALSA userland over the years. Infact, I=
'm=20
almost convinced that the ALSA userland is causing the bug.

=2D-=20
Patrick "Diablo-D3" McFarland || pmcfarland@downeast.net
"Computer games don't affect kids; I mean if Pac-Man affected us as kids, w=
e'd=20
all be running around in darkened rooms, munching magic pills and listening=
 to
repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989

--nextPart3858483.6yuBmCxLph
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCZxgF8Gvouk7G1cURAofyAJ9zh+SX+tt7dj9qCbphtQf3y8/KogCcCwfT
faRedFMTrBGQ7qlZU2J3NJ0=
=/fe1
-----END PGP SIGNATURE-----

--nextPart3858483.6yuBmCxLph--
