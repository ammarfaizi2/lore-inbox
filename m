Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265299AbUAMSnn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 13:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265327AbUAMSnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 13:43:43 -0500
Received: from adsl-67-124-157-189.dsl.pltn13.pacbell.net ([67.124.157.189]:53469
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S265299AbUAMSnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 13:43:40 -0500
Date: Tue, 13 Jan 2004 10:43:33 -0800
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA 1.0.1
Message-ID: <20040113184333.GB14261@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	LKML <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0401082059300.13704@pnote.perex-int.cz> <20040109101759.GC12107@triplehelix.org> <20040112100746.GC2169@charite.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Content-Disposition: inline
In-Reply-To: <20040112100746.GC2169@charite.de>
User-Agent: Mutt/1.5.4i
From: joshk@triplehelix.org (Joshua Kwan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2004 at 11:07:46AM +0100, Ralf Hildebrandt wrote:
> It seems to work here. I found that the new ALSA drivers change or
> activate new mixer options, thus causing background noise. Once I
> fixed the mixer values, all was well.

This seems to be something far more insidious.

When the CPU is under load, the buzzing disappears.
When something else is using /dev/dsp, the buzzing disappears.
When I reboot to 2.6.1-rc1-mm1, the buzzing disappears ;)

Any idea what is going on? And plus, even when the buzzing is gone,
there is a lot of static in played music, etc. It's overall not a good
listening experience. I know this could be due to the fact that I use
onboard sound but since it worked just fine in 2.6.1-rc1-mm1 I don't see
why it should be screwed up in 2.6.1-mm2.

--=20
Joshua Kwan

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iQIVAwUBQAQ8VKOILr94RG8mAQIkdg//XDWsCGG+YqRDOwmy/mR/QY/2jMfe3WMl
IUWL4O9TB8Kc9u16FsIR6VKaMFG41H4f5sx6XdxvGmECDnihXsZaGzt2BWMzfpQ2
g3qlKKZqrdMXhgy+e1ZRopGlP79+AY4xFalQqNjCB23bJBdBUOGm0E+RwzdsOzfz
+X1mcSiT4QBdF4LaogyuS3rmGPiTQskp9RI26dy0opzdWgZddffdVU6XALjY3fKo
GwwpnPm/BYpGbgh173ahCts0PCiXU1cYj5ql5qMyamiMXhV+78m6Q5E739u5/ken
0729eWFj/3jErJ71MwDxIf4MkFrMIl1qeruSpspR5J3i5o/lymdWa+L9tWh8UaC4
waSJ76C9M4hdshRKnqkIUmR0W8X/jsuwMS+Uly2UYLDsRaVeX+I77Tdp+b7zzNwR
gGhbaRWUv6W4Jl//LjSi0Y1+cTpW6nnMtx35yxMoWBy9GssLBZZeXlFCy93+cvGk
4YAu4wNLtvRCq0ndzVqLMJAdSG5D7aT+YCaNlqXBZ3Z8RW1jrf3TPSjMCpaWq/68
xJkXgfse+ek8jgF1xCrFq1qvToA/ZFSmYgBvENhnLKthBTWrHLwMrEKTaPFzkHhi
kzsLYNopXfTMUrGynmeMIahm7+63RBHqdQ9u8GDe69z7KDU0v2pnXX6kt7qH9xc1
lbQvG9mDN90=
=QWvX
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
