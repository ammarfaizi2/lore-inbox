Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264145AbUARVyN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 16:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbUARVyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 16:54:13 -0500
Received: from ms-smtp-02-qfe0.nyroc.rr.com ([24.24.2.56]:31979 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S264145AbUARVyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 16:54:11 -0500
Date: Sun, 18 Jan 2004 16:53:52 -0500
To: linux-kernel@vger.kernel.org, Natalia Portillo <claunia@terra.es>
Subject: Re: Bug report on UHCI driver.
Message-ID: <20040118215352.GA1678@andromeda>
References: <BAB7DAB2-49F5-11D8-9B47-000393CFF340@terra.es>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <BAB7DAB2-49F5-11D8-9B47-000393CFF340@terra.es>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Justin Pryzby <justinpryzby@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I get the same thing while trying to write a driver for a USB webcam.
The webcam works fine until this happens.  Rebooting doesn't fix the
problem.
Justin

On Sun, Jan 18, 2004 at 08:34:35PM +0000, Natalia Portillo wrote:
> Dear Kernel Developers.
>=20
> This is the bug I'm getting with kernels 2.4.20-xfs-r3, 2.4.23-aa1 and=20
> 2.6.0-test5 (hardware information at bottom).
>=20
> It seems to be a problem of IRQ conflict.
> USB works perfectly, but, suddenly, it stops working and dmesg starts=20
> saying (and doesn't stop until reboot) the following:
> "drivers/usb/host/uhci-hcd.c: cc00: host controller halted. very bad"
>=20
> It happens after a random working time. I observed this time is less if=
=20
> I remove the nVidia graphics card and substitute it for an 3Dfx one=20
> (the second one doesn't use an IRQ).
> It also seems to happen faster in 2.4 kernels.
>=20
> Regards,
> Natalia Portillo
:CLIP:

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFACwBwh7yD3l4ITTYRAgTvAJ9aAbFHxFstzTptBWi4WLHswJM5vgCdE8An
HX+8vR2BYb1pdDAUhJkthHw=
=JFtc
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
