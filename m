Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271002AbTG1CZO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 22:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271001AbTG1AAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:00:43 -0400
Received: from zeus.kernel.org ([204.152.189.113]:14071 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272952AbTG0XCV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:02:21 -0400
Date: Sun, 27 Jul 2003 21:13:53 +0200
From: Martin Loschwitz <madkiss@madkiss.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problems with Linux 2.6.0-test1-bk3 regarding ACPI
Message-ID: <20030727191353.GA2845@minerva.local.lan>
References: <20030727174108.GA2208@minerva.local.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
In-Reply-To: <20030727174108.GA2208@minerva.local.lan>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 27, 2003 at 07:41:08PM +0200, Martin Loschwitz wrote:
> Hello folks,
>=20
> I am experiencing an unexpected problem with Linux 2.6.0-test1-bk3 on
> my Acer TravelMate 800LCi Centrino Notebook (Intel 855PM, Pentim M at
> 1.3GHz). It appears ACPI loads fine at boot time but after I logged in,=
=20
> there is no /proc/acpi/sleep which is necessary to send the notebook=20
> into sleep state and the like. Is this maybe a known problem is a fix=20
> for it available somewhere? If you need other information like the=20
> dmesg output or something else, let me know please.
>=20
Uh, it appears I ran into the problem that ACPI sleep states need software=
=20
suspend to be enabled. After enabling swsusp, I was able to enable the
"Sleep states". Since I can't see how these two things are related to each
other, I guess they should be changed to be independent.

--=20
  .''`.   Martin Loschwitz           Debian GNU/Linux developer
 : :'  :  madkiss@madkiss.org        madkiss@debian.org
 `. `'`   http://www.madkiss.org/    people.debian.org/~madkiss/
   `-     Use Debian GNU/Linux 3.0!  See http://www.debian.org/

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/JCRxHPo+jNcUXjARAg5ZAJ9A2YCbSclki2BNAtVIPJzpk7C39QCfRySL
Gxu1gAcrUWxO2R1KSe58dzc=
=bf7M
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
