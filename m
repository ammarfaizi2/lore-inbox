Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVAWDcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVAWDcq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 22:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVAWDcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 22:32:46 -0500
Received: from mail26.syd.optusnet.com.au ([211.29.133.167]:31963 "EHLO
	mail26.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261199AbVAWDcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 22:32:39 -0500
Message-ID: <41F31AD4.6030707@kolivas.org>
Date: Sun, 23 Jan 2005 14:32:36 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gustavo Guillermo Perez <gustavo@compunauta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Supermount / ivman
References: <200501232126.08575.gustavo@compunauta.com>
In-Reply-To: <200501232126.08575.gustavo@compunauta.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC86CB9805E45688B3F7E449A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC86CB9805E45688B3F7E449A
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Gustavo Guillermo Perez wrote:
> Cause I play with old toys, (floppys) and ivman doesn't work properly on the 
> lastest gentoo with floppys, I retouch for a while the supermount patch from 
> sourceforge for kernel 2.6.11-rc1.
> 
> I'm a n00b on kernel, I do this only for general purposes helping some 
> friends, I know supermount should not be used, and is not mantained, I've 
> tested it just only for IDE/ATAPI CD/DVD and floppys.
> 
> Cause Supermount seems to be a filesystem I replace vfs_permission by 
> generic_permission instead of permission as I read on the lkml. Other stuffs 
> too in scsi section (I don't have scsi hardware).
> 
> If Help someone else:
> 
> http://www.compunauta.com/forums/linux/instalarlinux/supermount_en.html
> 

I've been silently maintaining it offlist. No real development but 
keeping it in sync and fixing obvious bugs that show up that I can fix.

Here's a patch for 2.6.10-ck5 (should apply fairly cleanly to 2.6.10):
http://ck.kolivas.org/patches/2.6/2.6.10/2.6.10-ck5/patches/supermount-ng208-10ck5.diff

and for 2.6.11-rc1
http://ck.kolivas.org/patches/2.6/2.6.11-rc1/patches/supermount-ng208-2611rc1.diff

Cheers,
Con

--------------enigC86CB9805E45688B3F7E449A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB8xrXZUg7+tp6mRURAhVXAJ0TKQbp5wc+CfhgKlZfQt701qjnnQCfaktr
L27f2byVUG9UFMYpWMqfqpk=
=uckE
-----END PGP SIGNATURE-----

--------------enigC86CB9805E45688B3F7E449A--
