Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265144AbUHSLHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbUHSLHo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 07:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265224AbUHSLHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 07:07:44 -0400
Received: from mail020.syd.optusnet.com.au ([211.29.132.131]:60568 "EHLO
	mail020.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265144AbUHSLHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 07:07:42 -0400
Message-ID: <412489E5.7000806@kolivas.org>
Date: Thu, 19 Aug 2004 21:07:17 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg Afinogenov <antisthenes@inbox.ru>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       garloff@suse.de
Subject: Re: [PATCH] bio_uncopy_user mem leak
References: <1092909598.8364.5.camel@localhost>
In-Reply-To: <1092909598.8364.5.camel@localhost>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0D3C32387DBF95F08638C907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0D3C32387DBF95F08638C907
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Greg Afinogenov wrote:
> I'd just like to point out that this patch does not, as may be expected,
> result in functional audio CDs.  It merely results in a successful burn
> process and a CD full of noise.
> 
> Perhaps this should be tested/fixed?

Ok I just tested this patch discretely and indeed the memory leak goes 
away but it still produces coasters so something is still amuck. Just as 
a data point; burning DVDs and data cds is ok. Burning audio *and 
videocds* is not.

Con

--------------enig0D3C32387DBF95F08638C907
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBJInoZUg7+tp6mRURAqtbAJ9r1482BNH3fzMvfSxXF5WbcoralACfWmK1
ZEoO7KRdUxHAgL9IeyILM98=
=WnNE
-----END PGP SIGNATURE-----

--------------enig0D3C32387DBF95F08638C907--
