Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269753AbUHZXWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269753AbUHZXWt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 19:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269750AbUHZXVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 19:21:55 -0400
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:46515 "EHLO
	mail08.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S269736AbUHZXT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 19:19:58 -0400
Message-ID: <412E7004.3070503@kolivas.org>
Date: Fri, 27 Aug 2004 09:19:32 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Rick Lindsley <ricklind@us.ibm.com>
Subject: Re: 2.6.9-rc1-mm1
References: <20040826014745.225d7a2c.akpm@osdl.org> <412DC47B.4000704@kolivas.org> <200408261636.06857.rjw@sisk.pl> <412E11ED.7040300@kolivas.org> <52540000.1093553736@flay>
In-Reply-To: <52540000.1093553736@flay>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3603B260ED5D1E946D144C9B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3603B260ED5D1E946D144C9B
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Martin J. Bligh wrote:
> --On Friday, August 27, 2004 02:38:05 +1000 Con Kolivas <kernel@kolivas.org> wrote:
>>Rafael J. Wysocki wrote:
>>>Actually, with the current scheduler, updatedb really sucks.  It's supposed to 
>>>be a background task, but it hogs IO resources and memory like crazy 
>>>(disclaimer: it's my personal subjective observation).
>>
>>The cpu scheduler plays almost no part in this. It's the I/O scheduler and the vm. IOnice will help the former _when it comes out_. Dropping the swappiness kind of helps the latter; although there are numerous alternative tweaks appearing for that too.
> 
> Yup. I can open a large 8Mpixel camera image in "display" and hang the whole
> system for about 30s too ;-(

If you're talking about using the embedded image viewer in kde, that 
spins on wait and wastes truckloads of cpu (a perfect example of poor 
coding). Try loading it an external viewer and it will be 1000 times 
faster. If you're talking about it keeping the disk too busy on the 
other hand, that's I/O scheduling.

Cheers,
Con

--------------enig3603B260ED5D1E946D144C9B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBLnAGZUg7+tp6mRURAk65AJ4zRytQ4Qim3NsROSlcSi1mgm7X+ACfeOcf
e1hpb5MyX+32CDH2S17DGzw=
=Aivt
-----END PGP SIGNATURE-----

--------------enig3603B260ED5D1E946D144C9B--
