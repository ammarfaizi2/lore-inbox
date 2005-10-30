Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbVJ3OpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbVJ3OpG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 09:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbVJ3OpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 09:45:06 -0500
Received: from psionic.psi5.com ([212.112.229.180]:19098 "EHLO
	psionic8.psi5.com") by vger.kernel.org with ESMTP id S1750720AbVJ3OpE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 09:45:04 -0500
Message-ID: <4364DC64.5000103@in.tum.de>
Date: Sun, 30 Oct 2005 15:44:52 +0100
From: Simon Richter <Simon.Richter@in.tum.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051018)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: kkeil@suse.de, kai.germaschewski@gmx.de, isdn4linux@listserv.isdn4linux.de,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/isdn/: "extern inline" -> "static inline"
References: <20051030004304.GQ4180@stusta.de>
In-Reply-To: <20051030004304.GQ4180@stusta.de>
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3A5F1E1491C9861615E5F7FE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3A5F1E1491C9861615E5F7FE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

Adrian Bunk schrieb:

> "extern inline" doesn't make much sense.

In fact, it does[1], but not in this particular case.

   Simon

[1] "if this function is not inlined, treat it as extern instead of
creating a copy in this TU".

--------------enig3A5F1E1491C9861615E5F7FE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQCVAwUBQ2TcZFYr4CN7gCINAQJcKAP+MwZTNGvo0hoMlLFXqrsj7+mtx3K5Ijfq
pUr0yuNBV4eeihI7IocPJAjO8N4QOgh9/+MRTvbpoU5gkb/T6AZu2dJWByPUz1Zv
WJ3djCcuv1lPJJVdZMtxXGqWDBTuwPC3j4RgkWvgGBZB2nzLkdHqmwmjMjDcUaVk
DvwOlIwxxFc=
=4dqp
-----END PGP SIGNATURE-----

--------------enig3A5F1E1491C9861615E5F7FE--
