Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263005AbUKYH2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263005AbUKYH2r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Nov 2004 02:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbUKYH2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Nov 2004 02:28:47 -0500
Received: from imap.gmx.net ([213.165.64.20]:29875 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263005AbUKYH2p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Nov 2004 02:28:45 -0500
X-Authenticated: #4512188
Message-ID: <41A589A6.6020406@gmx.de>
Date: Thu, 25 Nov 2004 08:28:38 +0100
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041114)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Eric Sandeen <sandeen@sgi.com>
CC: Nathan Scott <nathans@sgi.com>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: [2.6.10-rc2] XFS filesystem corruption
References: <200411221530.30325.lkml@kcore.org> <20041122155106.GG2714@holomorphy.com> <41A30D3E.9090506@gmx.de> <20041124082736.E6205230@wobbly.melbourne.sgi.com> <41A44071.9040101@gmx.de> <41A48395.60100@sgi.com>
In-Reply-To: <41A48395.60100@sgi.com>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC0352BB9DF78E0E8E6555B72"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC0352BB9DF78E0E8E6555B72
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Eric Sandeen schrieb:
> Prakash K. Cheemplavam wrote:
> 
>> Nathan Scott schrieb:
>>
>>> Did you see
>>> any of those device errors since switching to ext3?
>>
>>
>>
>> No. That's why I am wondering. I read about such errors like I got 
>> before in lkml and usually they were not fs related but libata siimage 
>> driver related. It could be just a coincidence that it came up with 
>> xfs, but till now (I guess 5 days now, though not 24/7 running) ext3 
>> is behaving nicely.
> 
> 
> It's almost certainly not a filesystem problem, but an IO layer problem. 
>  Maybe you only see it with xfs due to different disk IO patterns with 
> xfs vs. ext3...  the two will certainly be allocating & writing to the 
> disk in different ways.

Hmm, OK. When I have some hd space again. I might try to reproduce this 
error. Whom should I bug then if it reappears?

Cheers,

Prakash

--------------enigC0352BB9DF78E0E8E6555B72
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBpYmqxU2n/+9+t5gRAgODAKC3zjwhU5k4rEv97iPfTUh+EtVYlwCgv6n1
K82DDtufau9KK4KXDBYkN5s=
=cBUq
-----END PGP SIGNATURE-----

--------------enigC0352BB9DF78E0E8E6555B72--
