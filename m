Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbUA3OAS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 09:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263868AbUA3OAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 09:00:18 -0500
Received: from 82-68-84-57.dsl.in-addr.zen.co.uk ([82.68.84.57]:24021 "EHLO
	lenin.trudheim.com") by vger.kernel.org with ESMTP id S263861AbUA3OAM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 09:00:12 -0500
Subject: Re: Bluetooth oddity
From: Anders Karlsson <anders@trudheim.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1075469610.26729.108.camel@pegasus>
References: <1075462349.9698.4.camel@tor.trudheim.com>
	 <1075469610.26729.108.camel@pegasus>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-h8XJaLT9lp5IzZsbvkFy"
Organization: Trudheim Technology Limited
Message-Id: <1075471246.11889.5.camel@tor.trudheim.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 Rubber Turnip www.usr-local-bin.org 
Date: Fri, 30 Jan 2004 14:00:47 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-h8XJaLT9lp5IzZsbvkFy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-01-30 at 13:33, Marcel Holtmann wrote:
> Hi Anders,

Hello Marcel,

> I assume that you have enabled the SCO support of the HCI USB driver.
> The unlink of ISOC URB's fails on UHCI host controllers and actually I
> don't know why. So disable the SCO support of the HCI USB driver and you
> can switch on and off your Bluetooth device as often as you like.

I just checked, and I did have the SCO support switched on. Shows that
the name can not be trusted... ;-)

> What is your USB host controller chipset? Do you see an oops?

No oops, rebuilding the kernel with serial support built in so I can
attach serial console. After that I should be able to capture any
information required.

> This was a bug in the RFCOMM layer that has been already fixed. Why
> don't you say what 2.6 kernel do you use? Try the latest 2.6.2-rc2 or
> 2.6.1-mh3 and this will go away.

I am currently using 2.6.1 proper, but saw it in 2.6.0 and a couple of
half-way houses between 2.6.0 and 2.6.1.

I will give 2.6.2-rc2 a try over the weekend.

Regards,

--=20
Anders Karlsson <anders@trudheim.com>
Trudheim Technology Limited

--=-h8XJaLT9lp5IzZsbvkFy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQBAGmOOLYywqksgYBoRAh7gAJoDtFbTF1HCAcGb0kWw6D+CZ1M+zgCfTXIK
4iITgHtFvt8x+JQcwJqfRnI=
=DNoI
-----END PGP SIGNATURE-----

--=-h8XJaLT9lp5IzZsbvkFy--
