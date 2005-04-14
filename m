Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbVDNWwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbVDNWwy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 18:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbVDNWwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 18:52:54 -0400
Received: from vsmtp14.tin.it ([212.216.176.118]:33012 "EHLO vsmtp14.tin.it")
	by vger.kernel.org with ESMTP id S261593AbVDNWwi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 18:52:38 -0400
Message-ID: <425EF3D7.7090103@tin.it>
Date: Thu, 14 Apr 2005 17:51:03 -0500
From: "Franco \"Sensei\"" <senseiwa@tin.it>
Reply-To: Sensei <senseiwa@tin.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041207 Thunderbird/1.0 Mnenhy/0.7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: David Lang <dlang@digitalinsight.com>, Krzysztof Halasa <khc@pm.waw.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: [INFO] Kernel strict versioning
References: <4256C89C.4090207@tin.it> <20050408190500.GF15688@stusta.de> <425B1E3F.5080202@tin.it> <20050412015018.GA3828@stusta.de> <425B3864.8050401@tin.it> <m3mzs4kzdp.fsf@defiant.localdomain> <425C03D6.2070107@tin.it> <Pine.LNX.4.62.0504121053583.17233@qynat.qvtvafvgr.pbz> <425E9FE2.6090102@tin.it> <20050414200101.GC3628@stusta.de>
In-Reply-To: <20050414200101.GC3628@stusta.de>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig04524603D994DCBE1D868DE2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig04524603D994DCBE1D868DE2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Adrian Bunk wrote:
> Are you sure you know what you are talking about?
> 
> ABI stability requires API stability [1].

Of course it requires API stability... as I said ``API and data 
structure stability should be something in mind''. I really meant that 
API shouldn't change suddenly. And from the moment in which API are 
stable, still having even different implementations, *then* (not before) 
probably ABI can be taken in consideration.

> [1] you can break the API without breaking the ABI, but these are
>     mostly pathological examples

I don't want to even think about an incredible coincidence of having a 
_working_ ABI with different API... different function calls, different 
data structures, different behaviors, and still working in binary mode...

-- 
Sensei <mailto:senseiwa@tin.it> <pgp:8998A2DB>
        <icqnum:241572242>
        <yahoo!:sensei_sen>
        <msn-id:sensei_sen@hotmail.com>

--------------enig04524603D994DCBE1D868DE2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCXvPX4LBKhYmYotsRAvKlAJ9xbVhAtmUUoUfH/zXnviyDRlvzFgCeL7oH
+ifozgVex+lU3ZrHESvUpV4=
=4CAc
-----END PGP SIGNATURE-----

--------------enig04524603D994DCBE1D868DE2--
