Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbUKIVuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbUKIVuW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 16:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbUKIVuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 16:50:22 -0500
Received: from mail19.syd.optusnet.com.au ([211.29.132.200]:36837 "EHLO
	mail19.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261710AbUKIVuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 16:50:14 -0500
Message-ID: <41913B75.1050500@kolivas.org>
Date: Wed, 10 Nov 2004 08:49:41 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Patrick Mau <mau@oscar.ping.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Workaround for wrapping loadaverage
References: <20041108001932.GA16641@oscar.prima.de> <20041108012707.1e141772.akpm@osdl.org> <20041108102553.GA31980@oscar.prima.de> <20041108155051.53c11fff.akpm@osdl.org> <20041109004335.GA1822@oscar.prima.de> <20041109185103.GE29661@mail.13thfloor.at>
In-Reply-To: <20041109185103.GE29661@mail.13thfloor.at>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFA1AEB4C5C19C470ADA788D3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFA1AEB4C5C19C470ADA788D3
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Herbert Poetzl wrote:
> but I agree that a higher resolution would be a good
> idea ... also doing the calculation when the number
> of running/uninterruptible processes has changed would
> be a good idea ...

This could get very expensive. A modern cpu can do about 700,000 context 
switches per second of a real task with the current linux kernel so I'd 
suggest not doing this.

Cheers,
Con

--------------enigFA1AEB4C5C19C470ADA788D3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBkTt1ZUg7+tp6mRURAgK0AJ49jAGM2yMf6Cn6AOyVejHIKAGcmwCbBWtd
j/p7dkjDgpULdxgkGXb7wUg=
=WgSb
-----END PGP SIGNATURE-----

--------------enigFA1AEB4C5C19C470ADA788D3--
