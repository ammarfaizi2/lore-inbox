Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161258AbVIPSh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161258AbVIPSh2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 14:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161259AbVIPSh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 14:37:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:32134 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161258AbVIPSh2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 14:37:28 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.14-rc1-mm1
Date: Fri, 16 Sep 2005 20:41:58 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20050916022319.12bf53f3.akpm@osdl.org>
In-Reply-To: <20050916022319.12bf53f3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5679153.gQJviRyZ5V";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509162042.07376.dominik.karall@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5679153.gQJviRyZ5V
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 16 September 2005 11:23, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc1/=
2.
>6.14-rc1-mm1/ (temp copy at
> http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.14-rc1-mm1.gz)

I don't get a /dev/input/mice device with this kernel, so Xorg reports=20
following error (udev 070 in use):

(**) Option "Protocol" "ImPS/2"
(**) Mouse1: Device: "/dev/input/mice"
(**) Mouse1: Protocol: "ImPS/2"
(**) Option "CorePointer"
(**) Mouse1: Core Pointer
(**) Option "Device" "/dev/input/mice"
(EE) xf86OpenSerial: Cannot open device /dev/input/mice
        No such file or directory.
(EE) Mouse1: cannot open input device
(EE) PreInit failed for input device "Mouse1"


with other kernels:
(**) Option "Protocol" "ImPS/2"
(**) Mouse1: Device: "/dev/input/mice"
(**) Mouse1: Protocol: "ImPS/2"
(**) Option "CorePointer"
(**) Mouse1: Core Pointer
(**) Option "Device" "/dev/input/mice"
(=3D=3D) Mouse1: Emulate3Buttons, Emulate3Timeout: 50
(**) Option "ZAxisMapping" "4 5"
(**) Mouse1: ZAxisMapping: buttons 4 and 5
(**) Mouse1: Buttons: 5
(**) Mouse1: SmartScroll: 1


dominik

--nextPart5679153.gQJviRyZ5V
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2-ecc0.1.6 (GNU/Linux)

iQCVAwUAQysR/wvcoSHvsHMnAQKyzQP/aQzYu9OR6kd2vUzFxwLV4/FrFl+Q2kXL
mLCJd+Q6bt9j0d8xGml/yN5/TT4/K39PS91um5FdNRDYPpD/ekC/5zcE7HeBa/At
jmuN4dkea8J7HOBwZUozsDCbzPQD+AXChwH459KmDrTa9jU3llGTCdD1poW8mDFb
a+YteP5CWqM=
=M6My
-----END PGP SIGNATURE-----

--nextPart5679153.gQJviRyZ5V--
