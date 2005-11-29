Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbVK2K4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbVK2K4h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 05:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbVK2K4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 05:56:37 -0500
Received: from [80.251.174.142] ([80.251.174.142]:178 "EHLO FAP-MSP.emfa.pt")
	by vger.kernel.org with ESMTP id S1751170AbVK2K4g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 05:56:36 -0500
Subject: [PATCH] Fix budget-ci linking problem
From: Carlos Silva <r3pek@gentoo.org>
To: linux-dvb-maintainer@linuxtv.org
Cc: inux-dvb@linuxtv.org, linux-kernel@vger.kernel.org, michael@mihu.de,
       adq_dvb@lidskialf.net
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-iTKbWgb2GW34R8Gt7LuZ"
Date: Tue, 29 Nov 2005 10:54:06 +0000
Message-Id: <1133261646.13000.19.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
X-FAP-MailScanner-Information: Please contact the ISP for more information
X-FAP-MailScanner: Found to be clean
X-FAP-MailScanner-MCPCheck: MCP-Clean, MCP-Checker (score=0, required 4)
X-FAP-MailScanner-SpamCheck: not spam, SpamAssassin (score=0, required 4,
	autolearn=not spam)
X-FAP-MailScanner-From: r3pek@gentoo.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-iTKbWgb2GW34R8Gt7LuZ
Content-Type: multipart/mixed; boundary="=-y2c43ptyOA9XUHEv9tSs"


--=-y2c43ptyOA9XUHEv9tSs
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi, a user reported that had linking problems when compiling the kernel.
After looking at his problem I found out that there was missing the
compilation of stv0297.c when budget-ci.c was selected. So I made this
simple patch that solved the user's problem.
The downstream bug report is this one:
http://bugs.gentoo.org/show_bug.cgi?id=3D112997

If you need anything more from me, just mail me.

Signed-of-by: Carlos Silva <r3pek@gentoo.org>

Best regards
--=20
Carlos "r3pek" Silva
Gentoo Developer (kernel/amd64/mobile-phone)

--=-y2c43ptyOA9XUHEv9tSs
Content-Disposition: attachment; filename=fix-budget-ci-linking.patch
Content-Type: text/x-patch; name=fix-budget-ci-linking.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64

LS0tIGRyaXZlcnMvbWVkaWEvZHZiL3R0cGNpL0tjb25maWcub2xkCTIwMDUtMTEtMTkgMjA6MjM6
NTAuMDAwMDAwMDAwICswMDAwDQorKysgZHJpdmVycy9tZWRpYS9kdmIvdHRwY2kvS2NvbmZpZwky
MDA1LTExLTE5IDIwOjIyOjQ5LjAwMDAwMDAwMCArMDAwMA0KQEAgLTgxLDYgKzgxLDcgQEANCiAJ
dHJpc3RhdGUgIkJ1ZGdldCBjYXJkcyB3aXRoIG9uYm9hcmQgQ0kgY29ubmVjdG9yIg0KIAlkZXBl
bmRzIG9uIERWQl9DT1JFICYmIFBDSQ0KIAlzZWxlY3QgVklERU9fU0FBNzE0Ng0KKwlzZWxlY3Qg
RFZCX1NUVjAyOTcNCiAJc2VsZWN0IERWQl9TVFYwMjk5DQogCXNlbGVjdCBEVkJfVERBMTAwNFgN
CiAJaGVscA0K


--=-y2c43ptyOA9XUHEv9tSs--

--=-iTKbWgb2GW34R8Gt7LuZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2-ecc0.1.6 (GNU/Linux)

iD8DBQBDjDNOttk+BQds59QRAvanAJ9OUjJYjqvyhAEknBD/gohiHUgfkwCeKLzV
0WIqhhl/PnxuqrIeE21unms=
=sbEj
-----END PGP SIGNATURE-----

--=-iTKbWgb2GW34R8Gt7LuZ--

