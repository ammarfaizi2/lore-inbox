Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265292AbTLMUwV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 15:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265296AbTLMUwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 15:52:21 -0500
Received: from mbox.serv4.servweb.de ([80.239.142.80]:17641 "EHLO
	serv4.servweb.de") by vger.kernel.org with ESMTP id S265292AbTLMUwT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 15:52:19 -0500
Date: Sat, 13 Dec 2003 21:52:32 +0100
From: Patrick Plattes <patrick@erdbeere.net>
To: linux-kernel@vger.kernel.org
Subject: [2.4.23] kernel BUG at page_alloc.c:105!
Message-ID: <20031213205231.GA2422@erdbeere.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hello,

i try to use a ibm thinkpad 560e notebook and while booting the kernel
<F9>stoped with this message (a screenshot from this notebook is here: [1])

kernel BUG at page_alloc.c:105!
invalid operand: 0000
CPU:	0
EIP	0010:[<c0128d07>]	Not tainted
EFLAGS:	00010206
eax: 00000000	ebx: c1000a6c	ecx: c1000a6c	edx: 00000000
esi: 00000000	edi: c02af980	ebp: 00002000	esp: c0293f60
=2E..
=2E..
=2E..


i have to type this by hand from the notbook, so there may be typing
errors. please have a look at the screenshot for the correct (and
complete) errormessage. the page_alloc line (?) 105 changes sometimes=20
=66rom 105 to 103 or 106

please send me an e-mail if you need to know more and i will send you
the information as soon as i can.

maybe anyone withe an idea? thanks,
patrick

[1] http://erdbeere.net/lkml1.jpeg

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/23wPQ7Xfys5M9aQRAlDrAJ9ZbBxyd1Qa1qL4jz47mU4FBhuBOACbBd4Y
f+CaACRKiSS0PSnqrq7N140=
=MS4O
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
