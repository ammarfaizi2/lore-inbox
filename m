Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262877AbVCDOTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262877AbVCDOTi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 09:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262898AbVCDOTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 09:19:35 -0500
Received: from harmonie.imag.fr ([147.171.130.40]:61867 "EHLO harmonie.imag.fr")
	by vger.kernel.org with ESMTP id S262877AbVCDOT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 09:19:26 -0500
Message-ID: <42286E5D.9040509@naurel.org>
Date: Fri, 04 Mar 2005 15:19:09 +0100
From: =?ISO-8859-1?Q?Aur=E9lien_Francillon?= <aurel@naurel.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050117)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Aur=E9lien_Francillon?= <aurel@naurel.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm1
References: <20050304033215.1ffa8fec.akpm@osdl.org> <422869BA.3030802@naurel.org>
In-Reply-To: <422869BA.3030802@naurel.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAB324552BA3CC8ADCDCCD13F"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (harmonie.imag.fr [147.171.130.40]); Fri, 04 Mar 2005 15:19:10 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-MailScanner-From: aurel@naurel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAB324552BA3CC8ADCDCCD13F
Content-Type: multipart/mixed;
 boundary="------------080704070008050107070702"

This is a multi-part message in MIME format.
--------------080704070008050107070702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Aur=E9lien Francillon wrote:
> Andrew Morton wrote:
>=20
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2=
=2E6.11-mm1/=20
>>
>>
>>
>=20

(updated patch )
By the way is there something like the Trivial Patch Monkey for mm kernel=
 ?
thanks
Aurel

trivial patch for fscache menuconfig help documentation path and typo

Signed-off-by: Aur=E9lien Francillon <aurel@naurel.org>




--------------080704070008050107070702
Content-Type: text/plain;
 name="fscache-menuconfig-help-fix-documentation-path.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fscache-menuconfig-help-fix-documentation-path.patch"

--- 2.6.11-mm1-orig/fs/Kconfig	2005-03-04 15:12:41.000000000 +0100
+++ 2.6.11-mm1/fs/Kconfig	2005-03-04 15:08:13.000000000 +0100
@@ -442,10 +442,10 @@
 	help
 	  This option enables a generic filesystem caching manager that can be
 	  used by various network and other filesystems to cache data
-	  locally. Diffent sorts of caches can be plugged in, depending on the
+	  locally. Different sorts of caches can be plugged in, depending on the
 	  resources available.
 
-	  See Documentation/filesystems/fscache.txt for more information.
+	  See Documentation/filesystems/caching/fscache.txt for more information.
 
 config CACHEFS
 	tristate "Filesystem caching filesystem"
@@ -464,7 +464,7 @@
 	  The cache can be journalled so that the cache contents aren't
 	  destroyed in the event of a power failure.
 
-	  See Documentation/filesystems/cachefs.txt for more information.
+	  See Documentation/filesystems/caching/cachefs.txt for more information.
 
 endmenu
 

--------------080704070008050107070702--

--------------enigAB324552BA3CC8ADCDCCD13F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCKG5dtsnPPsovZP0RAj0KAKCIG96eGWjO0SYSQ9CtNdWfENVyCQCaAjN3
MPIyZ5uzZjnqHOEN9Bpb6nE=
=gz2Q
-----END PGP SIGNATURE-----

--------------enigAB324552BA3CC8ADCDCCD13F--
