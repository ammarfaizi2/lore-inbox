Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261530AbSLAILZ>; Sun, 1 Dec 2002 03:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261544AbSLAILY>; Sun, 1 Dec 2002 03:11:24 -0500
Received: from mithra.wirex.com ([65.102.14.2]:63501 "EHLO mail.wirex.com")
	by vger.kernel.org with ESMTP id <S261530AbSLAILX>;
	Sun, 1 Dec 2002 03:11:23 -0500
Message-ID: <3DE9C5B2.4070404@wirex.com>
Date: Sun, 01 Dec 2002 00:17:54 -0800
From: Crispin Cowan <crispin@wirex.com>
Organization: WireX Communications, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] LSM fix for stupid "empty" functions
References: <20021201083056.GJ679@kroah.com>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-md5;
 protocol="application/pgp-signature";
 boundary="------------enig14779EA52B3E854D27FF0E32"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig14779EA52B3E854D27FF0E32
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Greg KH wrote:

>I'm _really_ tired of all of the "empty" functions that all security
>modules need to provide.  So here's a brute force patch that lets any
>security module only set the functions that it wants to override.  If
>the function is NULL, then the "dummy" function will be used instead.
>
Sounds good to me. So you're just creating a default null function, and 
then stuffing all the stubs with a pointer to that function?

>Comments welcome (if there are none, I'll send it on to Linus.)
>
I suggest holding that post to Linus until Tuesday am. Lots of people 
are likely taking a long weekend away from software, and won't see your 
post until Monday morning.

Thanks,
    Crispin

-- 
Crispin Cowan, Ph.D.
Chief Scientist, WireX                      http://wirex.com/~crispin/
Security Hardened Linux Distribution:       http://immunix.org
Available for purchase: http://wirex.com/Products/Immunix/purchase.html
			    Just say ".Nyet"


--------------enig14779EA52B3E854D27FF0E32
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE96cW+5ZkfjX2CNDARAQKEAJ0ZGqxFpQIFgq1RiU/llsFATivCZQCgkTyW
S8KdUL/yXFMrWcBy2u72ePI=
=GFZj
-----END PGP SIGNATURE-----

--------------enig14779EA52B3E854D27FF0E32--

