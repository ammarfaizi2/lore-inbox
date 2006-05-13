Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWEMSCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWEMSCE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 14:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWEMSCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 14:02:04 -0400
Received: from hostmaster.org ([212.186.110.32]:50848 "EHLO hostmaster.org")
	by vger.kernel.org with ESMTP id S932179AbWEMSCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 14:02:03 -0400
Date: Sat, 13 May 2006 20:01:59 +0200
From: Thomas Zehetbauer <thomasz@hostmaster.org>
To: linux-kernel@vger.kernel.org
Subject: No DPMS for Console on x86_64
Message-ID: <20060513180158.GB2795@localhost.localdomain>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Unfortunately it seems that setterm's powersaving (DPMS) capabilities depen=
d=20
an APM support in the kernel and are therefore unavailable on the x86_64=20
architecture.

This shortcoming may have seemed unimportant when Opteron started in the=20
server segment but there is a growing number of AMD Turion mobiles that cou=
ld=20
greatly benefit from this feature.

I wonder how difficult it would be, to port APM to the x86_64 architecture =
or=20
to provide DPMS support in the FBDev drivers.

Tom

--=20
GMX - Die Totengr=C3=A4ber des Message Exchange
http://www.hostmaster.org/GMX.html

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iQEVAwUBRGYfFmD1OYqW/8uJAQLCJAf9Ht3r3MmP0/gjT4T9ozoRhbDW0Rs++vY8
qezjZgW6T9yrGvoLaHa12K7vdum3JeJOoA7oW8HtmubCOcTowiGxon0gwTwo7vJV
zf2YWtyL0cwns0vJH8R6S7IlzxDc9C/4mEbHoPVQNPQ5foMeT469oHbD90xEhFsT
x2hR3imESPoJ801GDZ71lTOlppNitt3WV1jbqnCV9g+iJyGN5bjFkm77Ax744Jy9
ywaAgwLRKGuRCD507x2fheTmnE12eMwmvGI6uBO0A24BJUkviCJnBSc5+1dDLZE9
D7HMXouvv/awFhXmdpqUKTsh+tWMLKQU++oMzw2yQjvu5BMafPtcSA==
=Bmwv
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
