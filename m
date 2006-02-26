Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbWBZXsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbWBZXsk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 18:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbWBZXsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 18:48:40 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:49048 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1751432AbWBZXsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 18:48:40 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: Building 100 kernels; we suck at dependencies and drown in warnings
Date: Mon, 27 Feb 2006 09:45:40 +1000
User-Agent: KMail/1.9.1
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
References: <200602261721.17373.jesper.juhl@gmail.com> <20060226193121.GG7851@redhat.com> <200602262043.22463.jesper.juhl@gmail.com>
In-Reply-To: <200602262043.22463.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3829535.YKHpssmRRk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602270945.44279.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3829535.YKHpssmRRk
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Monday 27 February 2006 05:43, Jesper Juhl wrote:
> rand13.log-drivers/acpi/osl.c:249: error: `AmlCode' undeclared (first use
> in this function) rand13.log-drivers/acpi/osl.c:249: error: (Each
> undeclared identifier is reported only once
> rand13.log-drivers/acpi/osl.c:249: error: for each function it appears in=
=2E)
> rand13.log:make[2]: *** [drivers/acpi/osl.o] Error 1
> rand13.log:make[1]: *** [drivers/acpi] Error 2
> rand13.log:make: *** [drivers] Error 2

Ignoring this one will probably also help - it's for people who require a=20
fixed dsdt - they need to add an extra file that's generated manually after=
=20
they fix whatever problems they have with their acpi tables. If the file is=
=20
missing, it will cause this error.

Regards,

Nigel

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--nextPart3829535.YKHpssmRRk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEAj2oN0y+n1M3mo0RAqgHAJ0fxaDtpKLUMg6n01YDBYZO4Lt/JgCgqVrg
FIdCC6/7G8KqIdjuR7pfubg=
=2Ex0
-----END PGP SIGNATURE-----

--nextPart3829535.YKHpssmRRk--
