Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263334AbUDEVoo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263322AbUDEVnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:43:04 -0400
Received: from smtp-hub.mrf.mail.rcn.net ([207.172.4.107]:21417 "EHLO
	smtp-hub.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id S263301AbUDEVje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:39:34 -0400
Message-ID: <4071D210.2070309@lycos.com>
Date: Mon, 05 Apr 2004 17:39:28 -0400
From: James Vega <vega_james@lycos.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
CC: linux-kernel@vger.kernel.org
Subject: Re: fat32 all upper-case filename problem
References: <4070910E.7020808@lycos.com> <87k70utw5n.fsf@devron.myhome.or.jp> <4071B70E.3090400@lycos.com>
In-Reply-To: <4071B70E.3090400@lycos.com>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig69166E1420B2C36ECD5219C0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig69166E1420B2C36ECD5219C0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

James Vega wrote:
> OGAWA Hirofumi wrote:
>  > Are you using the "iocharset=utf8" or CONFIG_NLS_DEFAULT="utf8"?
> 
>> If so, it's buggy.
>>
>> Please don't use it for now.
> 
> 
> I am using CONFIG_NLS_DEFAULT="utf8". I'll see if I get the same results 
> that changed back to iso8859-1.

Now I am able to ls both 'case' and 'CASE' even though an ls of the directory 
shows 'case'.  Thanks.

--------------enig69166E1420B2C36ECD5219C0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iEYEARECAAYFAkBx0hUACgkQDb3UpmEybUCaYQCghMQ8N/GPpcDSvqiDVKbsmWat
rocAoJK5Vpwv+ZRvWAuhajIIj/Zq57uF
=jBPQ
-----END PGP SIGNATURE-----

--------------enig69166E1420B2C36ECD5219C0--
