Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbVCUKnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbVCUKnl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 05:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVCUKnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 05:43:41 -0500
Received: from vds-320151.amen-pro.com ([62.193.204.86]:63672 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S261743AbVCUKnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 05:43:10 -0500
Subject: vsecurity 0.2-cvs (security fix revision)
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: narahimi@us.ibm.com,
       "linux-security-module@wirex.com" <linux-security-module@wirex.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-uAD+ZX/lQt4myNVvqRMT"
Date: Mon, 21 Mar 2005 11:42:36 +0100
Message-Id: <1111401756.8193.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uAD+ZX/lQt4myNVvqRMT
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

A week ago, some buffer overflow conditions inside the ACL handling code
of vsecurity were fixed, more concretely in the *_read_file functions
used within the vsecfs (sysfs) code to read ACL parameters.

I apologize for the inconveniences of being away for a week and not
announcing it before.

These buffer overflow conditions were noticed at first time by Brad
Spengler and more later by Nguyen Anh Quynh (who contributed many TPE
related enhancements to the under-development 0.3 revision).

Subsequently, the TPE code at issue, based in the first work made by IBM
and more concretely, by Niki Rahimi, is also vulnerable, and if the user
base makes it worthy, it should be fixed ASAP.

No proof of concept code is available, at least in the public eye or
under my knowledge, nor I have intention to prepare any as it's already
fixed.

The changes can be found in the CVS, also it's worthy to say that
currently vsecurity is not prepared for the new API changes since
2.6.10, and this is on-going work for the 0.3 release (among many other
enhancements and changes).

http://cvs.tuxedo-es.org/cgi-bin/viewcvs.cgi/vsecurity/

Thanks for your attention,
Cheers.
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-uAD+ZX/lQt4myNVvqRMT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCPqUcDcEopW8rLewRAvsfAJkBP0Woxbr1YTTJGUruB1P25TeGOwCg4E1w
5nxYy25UoTmIe9d7ONvNz/8=
=yn1f
-----END PGP SIGNATURE-----

--=-uAD+ZX/lQt4myNVvqRMT--

