Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbVASOCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbVASOCe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 09:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVASOCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 09:02:32 -0500
Received: from mail12.syd.optusnet.com.au ([211.29.132.193]:30344 "EHLO
	mail12.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261726AbVASOCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 09:02:25 -0500
Message-ID: <41EE6847.3040706@kolivas.org>
Date: Thu, 20 Jan 2005 01:01:43 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: utz <utz@s2y4n2c.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       rlrevell@joe-job.com, paul@linuxaudiosystems.com, joq@io.com,
       CK Kernel <ck@vds.kolivas.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][RFC] sched: Isochronous class for unprivileged soft rt
 scheduling
References: <41ED08AB.5060308@kolivas.org> <1106112369.3956.7.camel@segv.aura.of.mankind>
In-Reply-To: <1106112369.3956.7.camel@segv.aura.of.mankind>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0C2629350A76E8D937875848"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0C2629350A76E8D937875848
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Just as a headsup there is a new cleaned up patch here:
http://ck.kolivas.org/patches/SCHED_ISO/2.6.11-rc1-iso-0501192240.diff

The yield bug is still eluding my capture but appears to be related to 
the array switch of yielding and rescheduling as ISO after the fact. 
Still working on it.

Cheers,
Con

--------------enig0C2629350A76E8D937875848
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB7mhHZUg7+tp6mRURAlY5AJ0XrMBmJgapk5mqL31TjQoKHg0GpwCeLm7C
sjDUynsOSJUI5bM0DknJRNY=
=0/1A
-----END PGP SIGNATURE-----

--------------enig0C2629350A76E8D937875848--
