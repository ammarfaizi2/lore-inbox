Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270659AbTG0Duc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 23:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270660AbTG0Dub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 23:50:31 -0400
Received: from dsl093-170-248.sfo2.dsl.speakeasy.net ([66.93.170.248]:31443
	"HELO parts-unknown.org") by vger.kernel.org with SMTP
	id S270659AbTG0Dua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 23:50:30 -0400
Date: Sat, 26 Jul 2003 21:05:31 -0700
From: David Benfell <benfell@greybeard95a.com>
To: linux-kernel@vger.kernel.org
Subject: SOLVED: touchpad doesn't work under 2.6.0-test1-ac2
Message-ID: <20030727040531.GA14776@parts-unknown.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <bXg8.4Wg.1@gated-at.bofh.it> <S270097AbTGXUNM/20030724201313Z+7864@vger.kernel.org> <20030724212416.GA18141@vana.vc.cvut.cz> <20030725070806.GB15819@parts-unknown.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <20030725070806.GB15819@parts-unknown.org>
User-Agent: Mutt/1.3.28i
X-stardate: [-29]0650.83
X-moon: The Moon is Waning Crescent (5% of Full)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 25 Jul 2003 00:08:06 -0700, David Benfell wrote:
> Hello all,
>=20
> First someone pointed me at the driver available through
>=20
> http://w1.894.telia.com/~u89404340/touchpad/index.html
>=20
This driver does not work on the HP ZT1180.

What does work is enabling CONFIG_INPUT_EVDEV in the kernel
configuration.  The trick then is to NOT combine this with the
Synaptics driver mentioned above.

Full details are available at:

	http://www.greybeard95a.com/hp/zt1180/

Thanks to everyone for their help!

--=20
David Benfell
benfell@parts-unknown.org

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (Darwin)

iQEXAwUBPyNPinw5zqzgtjVOFALI9QQAiCnR2lZb5U0e9w9iE9JNHy2BSguWiPCY
QtAtyKiCyUbevGS+8gx0VynLx0/sCpf+EytmNn/7JNmG7Wka+037fMNUmB8KuPBO
De7g1uUUKvDnwb/Hac0DpHoSxXSkAAmGZ5axNtDTlN4z5SgVdlARold6QiITZmft
65hl2l6MZaUD/isc/xeRaxekrb/kam0nZX9VKPQn8j3liQcSTGD62BjUbvO099rK
tndbjro97PIKi85li+ZS6Lg8E4ZE3ef4kasNiEygOHjzpORsaewI0mnSmaHBfPBb
wrFmpHFxXI5Wy8t78+FVIQbQqD8JjiYAVHCepmxI7xm4lXXaj/uvjgor
=a35f
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
