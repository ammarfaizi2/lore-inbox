Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267977AbUIGMZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267977AbUIGMZt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 08:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267989AbUIGMZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 08:25:49 -0400
Received: from mail07.syd.optusnet.com.au ([211.29.132.188]:43488 "EHLO
	mail07.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S267977AbUIGMXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 08:23:48 -0400
Message-ID: <413DA83A.7010704@kolivas.org>
Date: Tue, 07 Sep 2004 22:23:22 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: attribute warn_unused_result
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1B50B56EB1D2EA7D8FD8DBCB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1B50B56EB1D2EA7D8FD8DBCB
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Gcc3.4.1 has recently been complaining of a number of unused results 
from function with attribute warn_unused_result set. I'm not sure of how 
you want to tackle this so I'm avoiding posting patches. Should we 
remove the attribute (seems the likely option) or set some dummy 
variable (sounds stupid now that I ask it).

Con

--------------enig1B50B56EB1D2EA7D8FD8DBCB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBPag7ZUg7+tp6mRURAiDMAJ0bovokQOPlNUfhGmDm0fb3gUPH2wCggQ22
rnXYNW/f9eUFLLkFQj3txUU=
=IB9E
-----END PGP SIGNATURE-----

--------------enig1B50B56EB1D2EA7D8FD8DBCB--
