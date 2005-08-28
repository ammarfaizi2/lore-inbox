Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbVH1BeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbVH1BeG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 21:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbVH1BeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 21:34:05 -0400
Received: from ns2.osuosl.org ([140.211.166.131]:9134 "EHLO ns2.osuosl.org")
	by vger.kernel.org with ESMTP id S1751045AbVH1BeE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 21:34:04 -0400
Message-ID: <4311148A.7000803@engr.orst.edu>
Date: Sat, 27 Aug 2005 18:34:02 -0700
From: Michael Marineau <marineam@engr.orst.edu>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050729)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, benh@kernel.crashing.org
CC: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Documentation update for radeonfb
References: <43111298.80507@engr.orst.edu>
In-Reply-To: <43111298.80507@engr.orst.edu>
X-Enigmail-Version: 0.92.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF46DA364A9ADD01DE2D60E49"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF46DA364A9ADD01DE2D60E49
Content-Type: multipart/mixed;
 boundary="------------030404050309090400030504"

This is a multi-part message in MIME format.
--------------030404050309090400030504
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Update documentation to reflect that this patch is now in the kernel.

Signed-off-by: Michael Marineau <marineam@engr.orst.edu>
-- 
Michael Marineau
marineam@engr.orst.edu
Oregon State University

--------------030404050309090400030504
Content-Type: text/x-patch;
 name="radeon-doc-update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="radeon-doc-update.patch"

Index: linux-2.6.13-rc7/Documentation/power/video.txt
===================================================================
--- linux-2.6.13-rc7.orig/Documentation/power/video.txt
+++ linux-2.6.13-rc7/Documentation/power/video.txt
@@ -42,9 +42,9 @@ There are a few types of systems where v
   vbestate restore < /tmp/delme; setfont <whatever>, and your video
   should work.
 
-(7) on some systems, it is possible to boot most of kernel, and then
-  POSTing bios works. Ole Rohne has patch to do just that at
-  http://dev.gentoo.org/~marineam/patch-radeonfb-2.6.11-rc2-mm2.
+(7) on some systems, it is possible to POST the bios from within the
+  kernel which allows for the use of a framebuffer. The radeonfb incudes
+  this capability.
 
 Now, if you pass acpi_sleep=something, and it does not work with your
 bios, you'll get a hard crash during resume. Be careful. Also it is

--------------030404050309090400030504--

--------------enigF46DA364A9ADD01DE2D60E49
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDERSKiP+LossGzjARAt3zAJ0Z3PeQ+AEj8iJ6XWE62TsavEvPTwCgjrNP
KY6tiq1TuY3/+sipRFZ9cdo=
=GRod
-----END PGP SIGNATURE-----

--------------enigF46DA364A9ADD01DE2D60E49--
