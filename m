Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVBGSx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVBGSx4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 13:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVBGSx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 13:53:56 -0500
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:25499 "EHLO
	mail-in-06.arcor-online.net") by vger.kernel.org with ESMTP
	id S261204AbVBGSxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 13:53:53 -0500
Message-ID: <4207B93A.2070506@arcor.de>
Date: Mon, 07 Feb 2005 19:53:46 +0100
From: Prakash Punnoor <prakashp@arcor.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050121)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Jeff Cooper <jacooper@visi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disk corruption problem with nVidia motherboard and Silicon Image
 680 ATA controller
References: <4207B453.2090203@visi.com>
In-Reply-To: <4207B453.2090203@visi.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig32B7FA5456356B451D4DD20D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig32B7FA5456356B451D4DD20D
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Cooper schrieb:
> I'm running a Gentoo system with a 2.6.10-r6 kernel.  This is the
> gentoo-dev-sources ebuild.  My motherboard is a Asus A7N8X with an
> nForce2 nVidia chipset.  The system has five 40 gig hard drives, all set
>
>
> Thanks for any advice anyone can offer!

Search in bios for ext-p2p discard time and set it to a higher value, at least
1ms. I alrealdy reported this to lkml but there apperantly is no interest in
implementing a kernel quirk.


--
Prakash Punnoor

formerly known as Prakash K. Cheemplavam

--------------enig32B7FA5456356B451D4DD20D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCB7k+xU2n/+9+t5gRAllUAJ94HWlvi0/WxKv4PocIMeNwLHd7kACgvvaO
dDmVrt+p28cKBe4nOBNY57g=
=pZxa
-----END PGP SIGNATURE-----

--------------enig32B7FA5456356B451D4DD20D--
