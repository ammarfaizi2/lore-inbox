Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270866AbTGVPPj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 11:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270869AbTGVPPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 11:15:39 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:27027 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id S270866AbTGVPPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 11:15:30 -0400
Date: Tue, 22 Jul 2003 17:30:31 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Michael =?ISO-8859-1?Q?Tro=DF?= <mtross@compu-shack.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CPU Lockup with 2.4.21 and 2.4.22-pre
Message-Id: <20030722173031.338fcf32.us15@os.inf.tu-dresden.de>
In-Reply-To: <1058887570.2357.157.camel@mtross2.csintern.de>
References: <0001F49C@gwia.compu-shack.com>
	<1058887570.2357.157.camel@mtross2.csintern.de>
Organization: Fiasco Core Team
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Fiasco-Rulez: Yes
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.s_eQInzYHF1fFB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.s_eQInzYHF1fFB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 22 Jul 2003 17:26:10 +0200 Michael Tro=DF (MT) wrote:

MT> Seems that a spin lock is already held. Do you get this oops right after
MT> opening the device? Then please try NoSelfTest.

No, the lockup happens during operation. Sometimes the kernel runs only for
about one hour, sometimes for a day, but never longer before the lockups
happen.

I don't think going back to 2.4.18 will make a difference for this case,
or do you think it will?

Regards,
-Udo.

--=.s_eQInzYHF1fFB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.3.1 (GNU/Linux)

iD8DBQE/HViYnhRzXSM7nSkRAmmKAJkBoydc5TEeiZohFXzQGgRt/0TW4wCdHIoW
jRoV6FntKvsqBl1l/VYq270=
=+KaP
-----END PGP SIGNATURE-----

--=.s_eQInzYHF1fFB--
