Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262088AbULRK0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262088AbULRK0U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 05:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbULRK0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 05:26:20 -0500
Received: from cs.earlham.edu ([159.28.230.3]:10248 "EHLO quark.cs.earlham.edu")
	by vger.kernel.org with ESMTP id S262088AbULRK0Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 05:26:16 -0500
Message-ID: <41C4054D.10105@cs.earlham.edu>
Date: Sat, 18 Dec 2004 05:24:13 -0500
From: Skylar Thompson <skylar@cs.earlham.edu>
Organization: Earlham College Computer Science Department
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: krishna <krishna.c@globaledgesoft.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: What does a dead CPU means in CONFIG_HOTPLUG_CPU
References: <41C3B5D2.70801@globaledgesoft.com>
In-Reply-To: <41C3B5D2.70801@globaledgesoft.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA16EE793A6073EF2E0163414"
X-Earlham-CS-Dept-MailScanner-Information: Please contact the ISP for more information
X-Earlham-CS-Dept-MailScanner: Found to be clean
X-MailScanner-From: skylar@cs.earlham.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA16EE793A6073EF2E0163414
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

krishna wrote:

> Hi all,
>
>    Can any one tell what is a  "dead CPU" in CONFIG_HOTPLUG_CPU .

It's a CPU that needs to be swapped out while the system is still 
running. Some high-end systems (Sun SPARCs and IBM POWERs come to mind) 
don't require a system shutdown to replace a bad CPU.

-- 
-- Skylar Thompson (skylar@cs.earlham.edu)
-- http://www.cs.earlham.edu/~skylar/


--------------enigA16EE793A6073EF2E0163414
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBxAVRsc4yyULgN4YRAj/vAJ4ySoDyQcFMo/LxxH1YFDwyS5Q09gCeKHqY
YkivVVe3RatLuamPh011rBo=
=SEiD
-----END PGP SIGNATURE-----

--------------enigA16EE793A6073EF2E0163414--
