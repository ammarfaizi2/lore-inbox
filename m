Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbUBJXbM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 18:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbUBJXbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 18:31:12 -0500
Received: from mx.eastlink.ca ([24.222.0.20]:47899 "EHLO mx.eastlink.ca")
	by vger.kernel.org with ESMTP id S262055AbUBJXbJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 18:31:09 -0500
Date: Tue, 10 Feb 2004 19:31:02 -0400
From: Peter Cordes <peter@cordes.ca>
Subject: typo: HOSTCCFLAGS instead of HOSTCFLAGS in lib/Makefile
To: linux-kernel@vger.kernel.org
Message-id: <20040210233102.GH5388@llama.nslug.ns.ca>
MIME-version: 1.0
Content-type: multipart/signed; boundary=VS++wcV0S1rZb1Fb;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


 In lib/Makefile in Linux 2.4.24, near the end there is:
gen_crc32table: gen_crc32table.c
         $(HOSTCC) $(HOSTCCFLAGS) -o $@ $<
                         ^^
 It should be HOSTCFLAGS, not HOSTCCFLAGS.

 There aren't any other instances of HOSTCCFLAGS in 2.4.24, or any in 2.6.1.

 please CC on replies, since I'm not subscribed.

--=20
#define X(x,y) x##y
Peter Cordes ;  e-mail: X(peter@cor , des.ca)

"The gods confound the man who first found out how to distinguish the hours!
 Confound him, too, who in this place set up a sundial, to cut and hack
 my day so wretchedly into small pieces!" -- Plautus, 200 BC

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQC1AwUBQClptgWkmhLkWuRTAQJ8IQT/UHdjnJEWMbHZvlfdZRRAd9TZdH99dMxt
S7TwU4qBorw3Z3A8q2kRpvUi3OSl2gFgsBNLW4loPrl+q0aHUpzJyspyagHhqVeL
YhusRbJdkqOJ/84UCtRm9FujuTIuZQtvmWI/Cr3vmhKxDoA12QZ8PWvkLZmqEXB7
aqiNcNemJVZuoWgLLsA5a72FFlOm/tUqGK+bK+I5GEEfmhg171ZLxA==
=yCQY
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
