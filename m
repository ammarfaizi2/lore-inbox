Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262736AbVCWChV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbVCWChV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 21:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbVCWCeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 21:34:44 -0500
Received: from downeast.net ([204.176.212.2]:44529 "EHLO downeast.net")
	by vger.kernel.org with ESMTP id S262712AbVCWCUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 21:20:03 -0500
From: Patrick McFarland <pmcfarland@downeast.net>
To: dtor_core@ameritech.net
Subject: Re: alsa es1371's joystick functionality broken in 2.6.11-mm4
Date: Tue, 22 Mar 2005 21:19:31 -0500
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <200503201557.58055.pmcfarland@downeast.net> <200503220706.13029.pmcfarland@downeast.net> <d120d50005032205584fd37a94@mail.gmail.com>
In-Reply-To: <d120d50005032205584fd37a94@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1831945.UrdDUNcyHc";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200503222119.55270.pmcfarland@downeast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1831945.UrdDUNcyHc
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 22 March 2005 08:58 am, Dmitry Torokhov wrote:
> On Tue, 22 Mar 2005 07:06:07 -0500, Patrick McFarland
> Ok, just so I know where we stand: your gameport/joystick does work in
> plain 2.6.11 but does not in 2.6.11-mm4, correct? When you load the
> module with "joystick_port=3D1" is there any messages from ens1371 in
> dmesg? Have you tried specifying exact port, like
> "joystick_port=3D0x200" or "joystick_port=3D0x218"? Do you see these ports
> reserved in /proc/ioports? What about /sys/bus/gameport/devices/? Do
> you see anything in that directory?

I haven't tested it with 2.6.11 yet... real life showed up, and hasn't gone=
=20
away yet. *stab!* I'll be testing it right after I send this email.

With joystick_port=3D1 there are no messages from the module, I've tried a =
bunch=20
of specific ports, and it doesn't work. The ports are not reserved=20
in /proc/ioports. /sys/bus/gameport/devices is empty.

=2D-=20
Patrick "Diablo-D3" McFarland || pmcfarland@downeast.net
"Computer games don't affect kids; I mean if Pac-Man affected us as kids, w=
e'd=20
all be running around in darkened rooms, munching magic pills and listening=
 to
repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989

--nextPart1831945.UrdDUNcyHc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCQNJL8Gvouk7G1cURAi8YAKC8RRySuHucUT9mzJYy4EJ+DaNLFACeMs2+
xI1pVC2wIG6RMByKJa0BYNc=
=cv/n
-----END PGP SIGNATURE-----

--nextPart1831945.UrdDUNcyHc--
