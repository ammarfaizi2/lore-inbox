Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWBCMhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWBCMhS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 07:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWBCMhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 07:37:18 -0500
Received: from wg.technophil.ch ([213.189.149.230]:4068 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S1750739AbWBCMhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 07:37:16 -0500
Date: Fri, 3 Feb 2006 13:37:08 +0100
From: Nico Schottelius <nico-kernel@schottelius.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [2.6.15.2 / uml] Compile error
Message-ID: <20060203123708.GF6460@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Mjqg7Yu+0hL22rav"
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Mjqg7Yu+0hL22rav
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin!

When I try to compile 2.6.15.2 with ARCH=3Dum and I did before
"make clean" and "make ARCH=3Dum menuconfig", it aborts due to
this error:

include/linux/jiffies.h:39:7: warning: "CONFIG_HZ" is not defined
include/linux/jiffies.h:42:3: error: #error You lose.

This repeats many many times.

What information do you need? (Please cc-me on reply no nico-kernel2@...)

Nico

--=20
Latest release: ccollect-0.3.1 (http://linux.schottelius.org/ccollect/)
Open Source nutures open minds and free, creative developers.

--Mjqg7Yu+0hL22rav
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ+NOc7OTBMvCUbrlAQLSPA//RgxaVofg1aYyjo8EOyU7TPIB2Wi62wDf
E/SCaM5vmKwDUXUsj0VQmpR29U3oX3NOgdyt65MVW0sGtOEDODtct5rQifoz2LL0
j8yOzxAsxBgmXg4aU8s9XC9+qMUys0NTu2p3OXioIp8N+UfgSw4YZLC+jkaV5B/P
/C5FmPpM7poUu9wxMbpMjTOrp+akLmvyInjThSPrlqdWhboCf+GAk18LO8G4/ucL
xLF46GzI7WbLRgctpCU9I3VaexGK86U2XIdTTpIg+b00uoiFrN0F7KrhDvZolZoN
rhOfi8I8lEt5tgUAFATmHsn37FG1Wx8ece3dF1XrGQYJu37dG0xq5o9FLJcORLT3
3onsgVyeu477g/+tRDkO43qjO/b89U0TJ9FhRpqyHbl68OM4MOoGXF3nt1FQ3Pyl
EORmniXpCdfcsEMxswdipnRS5f7BqcrLwCz7lPPb+pP/rzSgURmCE23QTOe5G7Fv
oytow+h3C2BLXgVMyQjCfGcqpTb8BYwZQYIeELWEno2xpWLd9F3oGHxFhp4SfA33
+Epocs9kMF56viDI3+Oro1JeuufCo4RM1kcbunOD4YuaI+kGicn1Z2XueXE0LKHd
fdFd7k/IkwIsnZVp18x8a2Q1DgGoDyjcA/YJl99UmCBgDyHEN87436J8t7rX2UMV
TwMD1Yj7GRo=
=5UO+
-----END PGP SIGNATURE-----

--Mjqg7Yu+0hL22rav--
