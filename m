Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263647AbTLJPby (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 10:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263650AbTLJPby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 10:31:54 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:30594 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263647AbTLJPbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 10:31:53 -0500
Message-ID: <3FD73C61.80708@earthlink.net>
Date: Wed, 10 Dec 2003 08:31:45 -0700
From: "Ian S. Nelson" <nelsonis@earthlink.net>
Reply-To: nelsonis@earthlink.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031015
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Any known issues with MPT SCSI?
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig414F627D1298A5C3EEAFDA83"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig414F627D1298A5C3EEAFDA83
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I'm running some Dell 1750s with a moderately customized 2.4.20 kernel,  
it has a couple of newer drivers but it's fairly standard.   I have 3 
identical systems that are turning up ext3 corruption fairly regularly.  
They are using the MPT/53c1030 SCSI.  2 of the 3 reported log corruption 
on a boot and mounted the root filesystem in read only.  The other is 
spitting

Dec  9 19:59:58 localhost Unexpected dirty buffer encountered at 
do_get_write_access:616 (08:02 blocknr 0)

 From time to time, I haven't rebooted it yet.

thanks,
Ian



--------------enig414F627D1298A5C3EEAFDA83
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/1zxiV28blwDT2YMRApXxAKC8GBCMa/n1Io8J0KM2QM371NOxmgCgkEXC
5pSkdfDjUyNjWPwPYO7gWs8=
=8uNY
-----END PGP SIGNATURE-----

--------------enig414F627D1298A5C3EEAFDA83--

