Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbVCUCFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVCUCFm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 21:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVCUCFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 21:05:42 -0500
Received: from downeast.net ([204.176.212.2]:59605 "EHLO downeast.net")
	by vger.kernel.org with ESMTP id S261427AbVCUCFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 21:05:32 -0500
From: Patrick McFarland <pmcfarland@downeast.net>
To: linux-kernel@vger.kernel.org
Subject: Re: alsa es1371's joystick functionality broken in 2.6.11-mm4
Date: Sun, 20 Mar 2005 21:04:39 -0500
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>
References: <200503201557.58055.pmcfarland@downeast.net> <20050320163900.75f30a9f.akpm@osdl.org>
In-Reply-To: <20050320163900.75f30a9f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5009594.qRrBt9hiXs";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200503202104.46144.pmcfarland@downeast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5009594.qRrBt9hiXs
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 20 March 2005 07:39 pm, Andrew Morton wrote:
> Patrick McFarland <pmcfarland@downeast.net> wrote:
> > It seems that the es1371 driver (which provides its own joystick port
> > driver) is broken in at least 2.6.11-mm4. I don't know when it broke, b=
ut
> > it used to work around in the 2.6.8/9 days (I haven't used the joystick
> > in awhile). The hardware and joystick still both work (tested in
> > Windows).
>
> Please define "broken".  I assume that audio still comes out, but that the
> joystick doesn't work?

Yup, audio works fine, this is why I never noticed. Also, the external midi=
=20
interface also works fine. Digging around, /proc/asound/card0/audiopci says=
=20
"Joystick enable: off, Joystick port: 0x200".=20

I've also been looking through alsa's cvs for alsa-kernel, and I can't see =
any=20
changes that might have broken it.

Also, I have a usb gamepad that currently works fine.

=2D-=20
Patrick "Diablo-D3" McFarland || pmcfarland@downeast.net
"Computer games don't affect kids; I mean if Pac-Man affected us as kids, w=
e'd=20
all be running around in darkened rooms, munching magic pills and listening=
 to
repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989

--nextPart5009594.qRrBt9hiXs
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCPiu+8Gvouk7G1cURAiyPAKCAk0w1BlAzeThtmMO3y5fkxSyPFgCeJU/j
ixnOBxPmccjC5LdtRpvO4Ng=
=bKEs
-----END PGP SIGNATURE-----

--nextPart5009594.qRrBt9hiXs--
