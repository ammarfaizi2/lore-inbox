Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262305AbUKQNHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262305AbUKQNHK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 08:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262304AbUKQNHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 08:07:10 -0500
Received: from mail12.syd.optusnet.com.au ([211.29.132.193]:58344 "EHLO
	mail12.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262305AbUKQNGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 08:06:03 -0500
Message-ID: <419B4CAF.4090302@kolivas.org>
Date: Thu, 18 Nov 2004 00:05:51 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Cc: CK Kernel <ck@vds.kolivas.org>, Peter Williams <pwil3058@bigpond.net.au>,
       Chris Han <xiphux@gmail.com>
Subject: Plugsched 041117
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig56D6C42215F630142E0311FF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig56D6C42215F630142E0311FF
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

An updated version of the pluggable cpu scheduler framework is available 
for 2.6.10-rc2-mm1
http://ck.kolivas.org/patches/plugsched/2.6.10-rc2-mm1/

The main changes in this version are a more robust version of minisched 
and the addition of "nanosched".

Nanosched is a minimal uniprocessor non preemptive scheduler with no 
priority support at all for the smallest environments.

Peter Williams is working on sharing more code between schedulers and 
Chris Han has a working sysfs interface to the scheduler tunables that I 
will be looking at merging in some form in the near future (thanks).

Cheers,
Con

--------------enig56D6C42215F630142E0311FF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBm0yvZUg7+tp6mRURAo2UAJ92w8gu9VwB59H+F8Fv0kKLQ6WoGACfe+1h
eCRftH70GgDRQ2JhJ351zWg=
=Nu4B
-----END PGP SIGNATURE-----

--------------enig56D6C42215F630142E0311FF--
