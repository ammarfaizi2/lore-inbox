Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271256AbUJVMUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271256AbUJVMUA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 08:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271251AbUJVMUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 08:20:00 -0400
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:54924 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S271261AbUJVMTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 08:19:11 -0400
Message-ID: <4178FAB4.9070208@kolivas.org>
Date: Fri, 22 Oct 2004 22:19:00 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Markus Trippelsdorf <markus@trippelsdorf.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BT848 video support dropped in 2.6.9?
References: <1098447230.12289.12.camel@localhost>
In-Reply-To: <1098447230.12289.12.camel@localhost>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5C013DB54122AD56BFA332E3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5C013DB54122AD56BFA332E3
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Markus Trippelsdorf wrote:
> The "BT848 video for linux" item does not show up
> with menuconfig in the "Video for linux" category.
> It was there in all previous kernels that I've used.
> Am I missing something obvious?

config VIDEO_BT848
	depends on VIDEO_DEV && PCI && I2C && FW_LOADER

Therefore you need those options or else you wont even be allowed to try 
to turn the option on.

Cheers,
Con

--------------enig5C013DB54122AD56BFA332E3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBePq0ZUg7+tp6mRURAlaFAJ9ciIi13Q3dvmV0MxcQANMsTBs1DACeNAjM
mwHeFlCYo7lbuF9AwSfHSyI=
=Te88
-----END PGP SIGNATURE-----

--------------enig5C013DB54122AD56BFA332E3--
