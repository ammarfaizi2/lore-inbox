Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbVB1Hwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVB1Hwd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 02:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVB1Hwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 02:52:33 -0500
Received: from ylpvm25-ext.prodigy.net ([207.115.57.56]:33965 "EHLO
	ylpvm25.prodigy.net") by vger.kernel.org with ESMTP id S261357AbVB1HwM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 02:52:12 -0500
Message-ID: <4222CCB6.1080005@ecs.fullerton.edu>
Date: Sun, 27 Feb 2005 23:48:06 -0800
From: Eric Gaumer <gaumerel@ecs.fullerton.edu>
User-Agent: Debian Thunderbird 1.0 (X11/20050117)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] orinoco rfmon
References: <4220BB87.2010806@ecs.fullerton.edu> <200502262259.30897.adobriyan@mail.ru> <4220FC1D.6010404@ecs.fullerton.edu> <20050228074407.GA25480@kroah.com>
In-Reply-To: <20050228074407.GA25480@kroah.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB9FB7359B136F53412181987"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB9FB7359B136F53412181987
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:
> On Sat, Feb 26, 2005 at 02:45:49PM -0800, Eric Gaumer wrote:
>
>>What is the difference between u* and uint*_t ? Both are derived from the
>>same basic data type.
>>
>>typedef unsigned char __u8;
>>typedef         __u8            uint8_t;
>>
>>And...
>>
>>typedef unsigned char u8;
>
>
> Don't use the uint*_t types, they are not correct.  See the lkml
> archives for why this is true.
>
> Use the u8 for when you are in the kernel, and __u8 when you need it for
> a variable that crosses the userspace/kernelspace barrier.
>
> thanks,
>

Thanks, I'll dig up those archives.


--
"Education is what remains after one has forgotten everything he learned in school."
	- Albert Einstein

--------------enigB9FB7359B136F53412181987
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCIsy2ZWL8hfFdQekRAjV0AKCVp/+FucA8H9mZEfp1WU5hJpXENwCeIAJS
1BP3v2n3GcKbvAzlSznKlZk=
=RyyV
-----END PGP SIGNATURE-----

--------------enigB9FB7359B136F53412181987--
