Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbVBWWJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVBWWJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 17:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbVBWWJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 17:09:05 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:2530 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S261635AbVBWWHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 17:07:15 -0500
Message-ID: <421CFEA3.6000207@arcor.de>
Date: Wed, 23 Feb 2005 23:07:31 +0100
From: Prakash Punnoor <prakashp@arcor.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050222)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Roland Dreier <roland@topspin.com>
Cc: Alexey Dobriyan <adobriyan@mail.ru>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Mark Lord <mlord@pobox.com>
Subject: Re: [BK PATCHES] 2.6.x libata fixes (mostly)
References: <421CE018.5030007@pobox.com>	<200502232345.23666.adobriyan@mail.ru> <421CF575.20801@arcor.de> <528y5faqbb.fsf@topspin.com>
In-Reply-To: <528y5faqbb.fsf@topspin.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEB3B400014431A70F3978E05"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEB3B400014431A70F3978E05
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Roland Dreier schrieb:
>     Prakash> If I am not totally mistaken this is not gcc4 friendly
>     Prakash> code. (lvalue thing...)
>
> Actually you misread the code slightly.  It's a little subtle, but
> code like
>
> 		*(__le32 *)prd = cpu_to_le32(len);
>
> is not using a cast as an lvalue.  It's dereferencing a cast and as
> such is totally correct, idiomatic and clean C.

OK, thanks for clearing that up. Obviously my C knowledge needs to be improved...

--
Prakash Punnoor

formerly known as Prakash K. Cheemplavam

--------------enigEB3B400014431A70F3978E05
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCHP6jxU2n/+9+t5gRAmsKAJ9wD9iCmwul3rypinb/ycQFaw2cpQCeOrOM
oyVStwkKdej1fR8VkGct9PI=
=MyVF
-----END PGP SIGNATURE-----

--------------enigEB3B400014431A70F3978E05--
