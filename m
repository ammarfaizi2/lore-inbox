Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261792AbUKIXxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbUKIXxt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 18:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbUKIXwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 18:52:11 -0500
Received: from mail21.syd.optusnet.com.au ([211.29.133.158]:21891 "EHLO
	mail21.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261777AbUKIXuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 18:50:13 -0500
Message-ID: <419157A6.5070705@kolivas.org>
Date: Wed, 10 Nov 2004 10:49:58 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Cc: Peter Williams <pwil3058@bigpond.net.au>
Subject: plugsched for 2.6.10-rc1-mm4
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA57EC0859F5960F94DC74181"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA57EC0859F5960F94DC74181
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

A new version of plugsched is available for 2.6.10-rc1-mm4

http://ck.kolivas.org/patches/plugsched/2.6.10-rc1-mm4/

Mainly this is a resync and cleanup.

The only new feature is the addition of the first in a family of 
minimalist schedulers: minisched

Minisched is a uniprocessor only scheduler that has support for the real 
time scheduling policies SCHED_RR, and SCHED_FIFO, with only very simple 
RR scheduling for SCHED_NORMAL. It is designed for use in an environment 
that mainly uses real time scheduling and wishes minimum overhead.

Microsched and nanosched are also planned. Microsched will have no 
support for real time tasks and have simple RR scheduling for 
SCHED_NORMAL. Nanosched will have no priority support at all.

A non-mm version is planned in the not too distant future...

After a hint from Peter I've trimmed the version number to only 7 digits 
(datestamp + release that date) :P

Cheers,
Con

--------------enigA57EC0859F5960F94DC74181
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBkVeoZUg7+tp6mRURApMkAJ9aPzGaQVBnmwoqb8LvaDv72whGyACeJQDy
12m2wMo1iYtrU1QqhrxE5WM=
=WvpL
-----END PGP SIGNATURE-----

--------------enigA57EC0859F5960F94DC74181--
