Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbULTEWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbULTEWg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 23:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbULTEWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 23:22:36 -0500
Received: from mail02.syd.optusnet.com.au ([211.29.132.183]:44260 "EHLO
	mail02.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261411AbULTEWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 23:22:34 -0500
Message-ID: <41C6535F.40605@kolivas.org>
Date: Mon, 20 Dec 2004 15:21:51 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
Cc: Mikhail Ramendik <mr@ramendik.ru>, Andrew Morton <akpm@digeo.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, lista4@comhem.se,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
References: <14514245.1103496059334.JavaMail.tomcat@pne-ps4-sn2> <41C6073B.6030204@yahoo.com.au> <20041219155722.01b1bec0.akpm@digeo.com> <200412200303.35807.mr@ramendik.ru> <41C640DE.7050002@kolivas.org> <Pine.LNX.4.61.0412192220450.4315@chimarrao.boston.redhat.com> <41C65169.4020508@kolivas.org> <Pine.LNX.4.61.0412192317470.4315@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.61.0412192317470.4315@chimarrao.boston.redhat.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig81A130A0EDA4A49C21AF529D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig81A130A0EDA4A49C21AF529D
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Rik van Riel wrote:
> On Mon, 20 Dec 2004, Con Kolivas wrote:
> 
>> What if the token isn't handed out at all until a heavy swapping load 
>> starts? A slight delay in thrash control would be worth it.
> 
> 
> How do you define "heavy swapping" ?
> 
> How would you measure it ?
> 
> How would you relinquish the token after the "heavy swapping"
> load stopped ?
> 

N F I

Cheers,
Con

--------------enig81A130A0EDA4A49C21AF529D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBxlNhZUg7+tp6mRURAhPyAKCHeU3nuQHE0xcbMZiiTtISOT5wWQCfevPO
HRdmIngAce1YHdC8oOl5wDE=
=ffxU
-----END PGP SIGNATURE-----

--------------enig81A130A0EDA4A49C21AF529D--
