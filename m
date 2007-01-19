Return-Path: <linux-kernel-owner+w=401wt.eu-S965147AbXASOAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965147AbXASOAx (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 09:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965161AbXASOAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 09:00:53 -0500
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:45957 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965147AbXASOAw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 09:00:52 -0500
From: Prakash Punnoor <prakash@punnoor.de>
To: Oliver Neukum <oliver@neukum.org>
Subject: Re: [linux-usb-devel] 2.6.20-rc4: usb somehow broken
Date: Fri, 19 Jan 2007 15:00:45 +0100
User-Agent: KMail/1.9.5
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200701111820.46121.prakash@punnoor.de> <200701191229.58151.oliver@neukum.org> <200701191438.50285.prakash@punnoor.de>
In-Reply-To: <200701191438.50285.prakash@punnoor.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1494631.13DUri0rgi";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200701191500.48600.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1494631.13DUri0rgi
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> Am Donnerstag, 11. Januar 2007 18:20 schrieb Prakash Punnoor:
> > Hi,
> >
> > I can't scan anymore. :-( I don't know which rc kernel introduced it, b=
ut
> > this are the messages I get (w/o touching the device/usb cable except
> > pluggin it in for the first time):
>
Hi,

I found quickly booted into a 2.6.19-rc5 kjernel which was lying around her=
e=20
and here CONFIG_USB_SUSPEND doesn't make any problems with my scanner...

gunzip /proc/config.gz -c|grep USB|grep -v "#"
CONFIG_USB_ARCH_HAS_HCD=3Dy
CONFIG_USB_ARCH_HAS_OHCI=3Dy
CONFIG_USB_ARCH_HAS_EHCI=3Dy
CONFIG_USB=3Dy
CONFIG_USB_DEVICEFS=3Dy
CONFIG_USB_BANDWIDTH=3Dy
CONFIG_USB_SUSPEND=3Dy
CONFIG_USB_EHCI_HCD=3Dy
CONFIG_USB_EHCI_SPLIT_ISO=3Dy
CONFIG_USB_EHCI_ROOT_HUB_TT=3Dy
CONFIG_USB_EHCI_TT_NEWSCHED=3Dy
CONFIG_USB_OHCI_HCD=3Dy
CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy
CONFIG_USB_PRINTER=3Dy
CONFIG_USB_STORAGE=3Dy

uname -a
Linux graviton 2.6.19-rc5 #74 SMP Fri Nov 24 22:59:14 CET 2006 x86_64 AMD=20
Athlon(tm) 64 X2 Dual Core Processor 3800+ AuthenticAMD GNU/Linux

Do you want me to try out kernels until I find one rc which breaks or do yo=
u=20
have an idea what was changed which could lead to the problem I am=20
experiencing?

Cheers,
=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart1494631.13DUri0rgi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.1 (GNU/Linux)

iD8DBQBFsM8QxU2n/+9+t5gRAmXLAJ4mbRBCpjPh5Sb/ka5NluYo1kn2PQCgv2Ng
TIgtiCwexaZV13q88OU5pFY=
=jfJv
-----END PGP SIGNATURE-----

--nextPart1494631.13DUri0rgi--
