Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268918AbTGTXco (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 19:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268925AbTGTXco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 19:32:44 -0400
Received: from mailc.telia.com ([194.22.190.4]:3285 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id S268918AbTGTXcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 19:32:42 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1-mm2 music skips
From: Christian Axelsson <smiler@lanil.mine.nu>
To: Lukas Kolbe <lucky@knup.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org
In-Reply-To: <1058733270.1169.32.camel@tigris.chaoswg>
References: <1058733270.1169.32.camel@tigris.chaoswg>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-JG7rIbmhaHs7p/6vqhHd"
Message-Id: <1058744854.32319.7.camel@sm-wks1.lan.irkk.nu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 21 Jul 2003 01:47:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JG7rIbmhaHs7p/6vqhHd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-07-20 at 22:34, Lukas Kolbe wrote:
> Hi!
>=20
> Just wanted to let you know that on my System (Debian Sid, Kernel
> 2.6.0-test1-mm2, .config attached) I get sound-skips with all recent
> Kernels (tested 2.5.69 'til 2.6.0-test1-mm2).=20
> With each new version it gets better, but I still can produce
> audio-skips.
>=20
> For music-hearing-pleasure I use xmms, it plays .oggs, .mp3s.
> With .mp3s I potentially get more skips than with .oggs.
> The skips occur while switching desktops in Gnome 2.2 with many windows
> open, or while marking the Desktop drawn by Nautilus with it's
> nice-looking shading square, or while starting large apps like the Gimp
> or Mozilla.
>=20
> Intersting though is that I'm not able to produce audio-skips for Mod's
> (.mt2, .xm, .it) in xmms.
>=20
> A switch from X to a VC and back also reproducibly produces a ~1.5
> seconds skip.
>=20
> System is as follows:
>=20
> Duron 1.3
> 256MB DDR-RAM
> Elitegroup K7S5A
> WDC WD800BB-00CAA0
> Ensoniq 5880 AudioPCI (rev 02)
> nVidia Corporation NV11 [GeForce2 MX/MX 400] (rev a1)
>=20
> And no, Xfree is not reniced :)
> I'm not on the list, so pleas Cc me on reply. Although I'm periodically
> reading the archives.
>
> Can I help somehow?

Please read the O*int threads.
It's probably Con's new scheduler that is causing these problems.
If you are using alsa, try the OSS emulation as it seems to help abit.

--=20
Christian Axelsson
  smiler@lanil.mine.nu

GPG ID:
  6C3C55D9 @ ldap://keyserver.pgp.com

--=-JG7rIbmhaHs7p/6vqhHd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/GyoWyqbmAWw8VdkRAi+/AKDIBPd4nBtB5ahBy5r/qUIFNeVvqwCcDHAd
YI8m6thri/7luGctUQ3ICDE=
=ZFOQ
-----END PGP SIGNATURE-----

--=-JG7rIbmhaHs7p/6vqhHd--

