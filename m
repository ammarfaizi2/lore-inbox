Return-Path: <linux-kernel-owner+w=401wt.eu-S1751184AbXANJsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbXANJsI (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 04:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbXANJsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 04:48:08 -0500
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:38100 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751202AbXANJsH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 04:48:07 -0500
From: Prakash Punnoor <prakash@punnoor.de>
To: Oliver Neukum <oliver@neukum.org>
Subject: Re: 2.6.20-rc4: usb somehow broken
Date: Sun, 14 Jan 2007 10:48:04 +0100
User-Agent: KMail/1.9.5
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
References: <200701111820.46121.prakash@punnoor.de> <200701141008.49986.prakash@punnoor.de> <200701141028.35533.oliver@neukum.org>
In-Reply-To: <200701141028.35533.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3293781.FX5LFpc3gH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200701141048.04247.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3293781.FX5LFpc3gH
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Sonntag 14 Januar 2007 10:28 schrieb Oliver Neukum:
>
> Have you confirmed that by using a kernel without  CONFIG_USB_SUSPEND ?

BTW, these are my USB config options, which don't seem to make problems=20
anymore as long as USB_SUSPEND isn't activated:

CONFIG_USB_ARCH_HAS_HCD=3Dy
CONFIG_USB_ARCH_HAS_OHCI=3Dy
CONFIG_USB_ARCH_HAS_EHCI=3Dy
CONFIG_USB=3Dm
CONFIG_USB_DEVICEFS=3Dy
CONFIG_USB_BANDWIDTH=3Dy
CONFIG_USB_MULTITHREAD_PROBE=3Dy
CONFIG_USB_EHCI_HCD=3Dm
CONFIG_USB_EHCI_SPLIT_ISO=3Dy
CONFIG_USB_EHCI_ROOT_HUB_TT=3Dy
CONFIG_USB_EHCI_TT_NEWSCHED=3Dy
CONFIG_USB_OHCI_HCD=3Dm
CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy
CONFIG_USB_PRINTER=3Dm
CONFIG_USB_STORAGE=3Dm

=2D-=20
(=C2=B0=3D                 =3D=C2=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart3293781.FX5LFpc3gH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.1 (GNU/Linux)

iD8DBQBFqfxUxU2n/+9+t5gRAlTzAKCE8TaZ8d9L2K7jFET+zMGrLM0PJACg6jch
6pwwGfR1smvGtY4OaIwa43U=
=eHjN
-----END PGP SIGNATURE-----

--nextPart3293781.FX5LFpc3gH--
