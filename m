Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269670AbUHZXzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269670AbUHZXzR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 19:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUHZXyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 19:54:38 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:36250 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269705AbUHZXuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 19:50:19 -0400
Message-ID: <412E7730.4050309@triplehelix.org>
Date: Thu, 26 Aug 2004 16:50:08 -0700
From: Joshua Kwan <joshk@triplehelix.org>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040819)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix bug in sparc64 user copy patch
References: <20040820155250.69c09781.davem@redhat.com>
In-Reply-To: <20040820155250.69c09781.davem@redhat.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFDB2027838FC4A445F970F99"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFDB2027838FC4A445F970F99
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

David S. Miller wrote:
> There were a few slight bugs in the UltraSPARC-I/II/IIi/IIe
> parts of that patch I sent you, here is the fix.

This patch was merged into our kernel tree, thanks; I'm testing it now.

Since I have you 'on the line', would you know why serial output on 
sparc64 now:

1) clears the screen twice right after Remapping the kernel...
2) omits every other character when it does start printing messages? such as

Iv vrIv unln rvr

which means

IPv6 over IPv4 tunneling driver

Some stuff, though, appears intact:

Vno: PLEXTOR  oe: CD-ROM PX-20TS   e: 1.00

which really says

Vendor: PLEXTOR   Model: CD-ROM PX-20TS    Rev: 1.00

It looks to me that when formats are being expanded, there is no 
problem. Hope that helps.

Anyway.. yes, I've asked before, but at least a confident "I don't know" 
from the Man would be better than nothing :)

-- 
Joshua Kwan

--------------enigFDB2027838FC4A445F970F99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQS53NKOILr94RG8mAQI5fBAAl8nlUSuIL0OXCdS7xBaUC+jyiiNJgaas
eNvw36pnF+R33VLevc3wxhNoYS2Q7tg8Ef06LmZOrdQnEWLvGeGdX7BMEOYU6D4u
azAbXqMDttvz5Z0T/FqHpIIwFn8eg6THYrDQW6t1BswKeWo2TfRYLwk/ZALtJ+R/
cc00GqUUqan03MdbMToTnmVrSiWnCkAZPSz4ZJmpjPJ6IANwLLoE5kXnQwUdZeIu
pJ3+juN3RLvD6GNlVVz4todoBZdIAwqgSKqnZqp8wlXxJ5JglLhzMGiK1xrArnfU
So78KpU9LLPUznZzXn00GYA/QN3m7ahUSpeES8ReDjwglZdFxS/T2ZUp4a4CVfj3
fDOFiLJIKlA3I8OFXMY5VnY0uda2oj2AxQKGzj3lp9A/7Hmb7cy6xuWoGHT6CEDp
oSFJMLdh+E5hktT9tPmH8+8jAcLBknqGIddAfjNQUY5P/WJQll60X0v351oTFdW1
TVoIffvq/wlqMkPTQkkjqa8hJTscKf7iHo/yFICSZliqjk2OrQfMz3GnuiHi2V16
EYuLbdQ4nYhYpsw2CbkQyQQaKy12ud6mE/OggQwmQ5BP73i2geToOgzeUWwTSqTF
D9mY7n8HutEG+SFstA0gQxuGazxH0aSsgWzHNy/xLVv1wkdS+0N0XEAibxsCTbFW
+xZRHRo5qpE=
=6DnD
-----END PGP SIGNATURE-----

--------------enigFDB2027838FC4A445F970F99--
