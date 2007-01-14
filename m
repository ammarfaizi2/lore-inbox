Return-Path: <linux-kernel-owner+w=401wt.eu-S1751203AbXANJoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbXANJoY (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 04:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbXANJoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 04:44:24 -0500
Received: from mail-in-11.arcor-online.net ([151.189.21.51]:60800 "EHLO
	mail-in-11.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751203AbXANJoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 04:44:23 -0500
From: Prakash Punnoor <prakash@punnoor.de>
To: Oliver Neukum <oliver@neukum.org>
Subject: Re: 2.6.20-rc4: usb somehow broken
Date: Sun, 14 Jan 2007 10:44:19 +0100
User-Agent: KMail/1.9.5
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
References: <200701111820.46121.prakash@punnoor.de> <200701141008.49986.prakash@punnoor.de> <200701141028.35533.oliver@neukum.org>
In-Reply-To: <200701141028.35533.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1766987.8F8870u85X";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200701141044.20056.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1766987.8F8870u85X
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Sonntag 14 Januar 2007 10:28 schrieb Oliver Neukum:
> Am Sonntag, 14. Januar 2007 10:08 schrieb Prakash Punnoor:
> > Am Donnerstag 11 Januar 2007 18:28 schrieb Oliver Neukum:
> > > Am Donnerstag, 11. Januar 2007 18:20 schrieb Prakash Punnoor:
> > > > Hi,
> > > >
> > > > I can't scan anymore. :-( I don't know which rc kernel introduced i=
t,
> > > > but this are the messages I get (w/o touching the device/usb cable
> > > > except pluggin it in for the first time):
> > > >
> > > > usb 1-1.2: new full speed USB device using ehci_hcd and address 4
> > > > ehci_hcd 0000:00:0b.1: qh ffff81007bc6c280 (#00) state 4
> > > > usb 1-1.2: configuration #1 chosen from 1 choice
> > > > usb 1-1.2: USB disconnect, address 4
> > > > usb 1-1.2: new full speed USB device using ehci_hcd and address 5
> > > > usb 1-1.2: configuration #1 chosen from 1 choice
> > > > usb 1-1.2: USB disconnect, address 5
> > > > usb 1-1.2: new full speed USB device using ehci_hcd and address 6
> > > > usb 1-1.2: configuration #1 chosen from 1 choice
> > > > usb 1-1.2: USB disconnect, address 6
> > > > usb 1-1.2: new full speed USB device using ehci_hcd and address 7
> > > > usb 1-1.2: configuration #1 chosen from 1 choice
> > > > usb 1-1.2: USB disconnect, address 7
> > > > usb 1-1.2: new full speed USB device using ehci_hcd and address 8
> > > > usb 1-1.2: configuration #1 chosen from 1 choice
>
> [..]
>
> > Hi, I did more tests and I was wrong about "broken". It seems more a
> > time-out problem, ie if I try to use sane again in short intervalls, I
> > will get my device working. The cause seems CONFIG_USB_SUSPEND=3Dy. With
> > 2.6.20-rc5 the
>
> Have you confirmed that by using a kernel without  CONFIG_USB_SUSPEND ?

Yes. I compiled the modules with various settings, reloaded the modules and=
=20
above option made the difference. I also don't get the disconnect mesages, =
as=20
well, w/o USB_SUSPEND.

Cheers,
=2D-=20
(=C2=B0=3D                 =3D=C2=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart1766987.8F8870u85X
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.1 (GNU/Linux)

iD8DBQBFqft0xU2n/+9+t5gRAho5AJ0S58PpRenDvthfN3A8EkHXv7vqKACcDxby
1hSOXk5oUrfjlxKaokcPF08=
=8hw+
-----END PGP SIGNATURE-----

--nextPart1766987.8F8870u85X--
