Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261557AbUKOJRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbUKOJRX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 04:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbUKOJRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 04:17:23 -0500
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:55730 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261557AbUKOJRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 04:17:19 -0500
Message-ID: <4198740E.7070306@kolivas.org>
Date: Mon, 15 Nov 2004 20:17:02 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Cc: ck@vds.kolivas.org
Subject: Staircase 9.1 for 2.6.10-rc2
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBE267D3095B24BEB676A30B8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBE267D3095B24BEB676A30B8
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I've resynced the staircase cpu scheduler v9.1 with linux-2.6.10-rc2.

http://ck.kolivas.org/patches/2.6/2.6.10/2.6.10-rc2/2.6.10-rc2_to_staircase9.1.diff

Note that a minute change from version 9.0 to v9.1 caused a massive 
change in the behaviour of frequently waking tasks that could get stuck 
at lowest priority for a while in all versions of the staircase 
scheduler has been fixed. This causes quite large improvements in 
fairness, latency and behaviour of high performance gaming with more 
stable and slightly higher fps and better audio behaviour. (note this 
change is already present in 2.6.9-ck3).

Cheers,
Con

--------------enigBE267D3095B24BEB676A30B8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBmHQSZUg7+tp6mRURAqDvAJ9yZkPIw9F2ncuCE91CI5IQ2tIlaQCffGEK
yXbo4L56sDAHiZ3B6SL2Oyw=
=fA/V
-----END PGP SIGNATURE-----

--------------enigBE267D3095B24BEB676A30B8--
