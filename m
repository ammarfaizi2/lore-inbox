Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVABU5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVABU5E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 15:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbVABU5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 15:57:03 -0500
Received: from lugor.de ([217.160.170.124]:19100 "EHLO solar.linuxob.de")
	by vger.kernel.org with ESMTP id S261334AbVABU4u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 15:56:50 -0500
From: Christian Hesse <mail@earthworm.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.10-ac2
Date: Sun, 2 Jan 2005 21:56:07 +0100
User-Agent: KMail/1.7.2
References: <1104450153.3415.1.camel@localhost.localdomain>
In-Reply-To: <1104450153.3415.1.camel@localhost.localdomain>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1491210.Z3ToMl6JKV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200501022156.12117.mail@earthworm.de>
X-AntiVirus: checked by AntiVir Milter 1.0.6; AVE 6.29.0.5; VDF 6.29.0.45
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1491210.Z3ToMl6JKV
Content-Type: multipart/mixed;
  boundary="Boundary-01=_n/F2BiI86EifpRQ"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_n/F2BiI86EifpRQ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 31 December 2004 00:42, Alan Cox wrote:
> o Restore PWC driver    (Luc Saillard)

PWC can only be build as module. I've patched it to be build=20
into the kernel. The patch is attached.

=2D-=20
Christian

--Boundary-01=_n/F2BiI86EifpRQ
Content-Type: text/x-diff;
  charset="us-ascii";
  name="pwc_Makefile.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="pwc_Makefile.patch"

=2D-- linux/drivers/usb/media/pwc/Makefile~	2005-01-02 17:06:42.569471000 +=
0100
+++ linux/drivers/usb/media/pwc/Makefile	2005-01-02 17:07:35.869471000 +0100
@@ -2,7 +2,7 @@
=20
 pwc-objs	:=3D pwc-if.o pwc-misc.o pwc-ctrl.o pwc-uncompress.o pwc-dec1.o p=
wc-dec23.o pwc-kiara.o pwc-timon.o
=20
=2Dobj-m +=3D pwc.o
+obj-$(CONFIG_USB_PWC) +=3D pwc.o
=20
 else
=20

--Boundary-01=_n/F2BiI86EifpRQ--

--nextPart1491210.Z3ToMl6JKV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.10 (GNU/Linux)

iD8DBQBB2F/slZfG2c8gdSURAqHLAKC18GHIPWnjrElV71R36yYR3NlpDQCeKbJX
4xynus/HXIFmts/onbmKgeA=
=8KFK
-----END PGP SIGNATURE-----

--nextPart1491210.Z3ToMl6JKV--
