Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbUKGFpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbUKGFpv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 00:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbUKGFpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 00:45:51 -0500
Received: from mail26.syd.optusnet.com.au ([211.29.133.167]:42151 "EHLO
	mail26.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261539AbUKGFpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 00:45:42 -0500
Message-ID: <418DB67D.2000903@kolivas.org>
Date: Sun, 07 Nov 2004 16:45:33 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Cc: Peter Williams <pwil3058@bigpond.net.au>
Subject: [PATCH] Plugsched for 2.6.10-rc1-mm3
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB5E3912CF309AB635081A01B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB5E3912CF309AB635081A01B
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

While mainline seems uninterested in pluggable cpu schedulers, it seems 
the demand and response off-list has been rather large so I'll continue 
to develop it.

http://ck.kolivas.org/patches/plugsched/2.6.10-rc1-mm3/

has a patch tarball and a rolled up patch for applying the current 
plugsched infrastructure.


Changes:
Rolled up the bugfixes into their respective parent patches.
Added an optional private set_task_cpu.
Privatised get_idle for kgdb.
Privatised normalise rt sysrq.
Updated staircase cpu scheduler.


Planned:
More shared code between schedulers.
Sysfs tunables.


Note that mm3 has some vm bugs leading to compile problems and 
instability that you'd need to add on if you wish to try these patches.

Cheers,
Con

--------------enigB5E3912CF309AB635081A01B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBjbZ/ZUg7+tp6mRURAuDKAJ9ic7jcNzshLslE62StfrlN/7q4UgCdFJxH
IFg3hKd2Hya07tLd4B2WY0Y=
=vTat
-----END PGP SIGNATURE-----

--------------enigB5E3912CF309AB635081A01B--
