Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266013AbTFWNPr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 09:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266029AbTFWNPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 09:15:15 -0400
Received: from twinette.cri2000.ens-lyon.fr ([140.77.13.45]:28288 "EHLO
	twinette.migus.eu.org") by vger.kernel.org with ESMTP
	id S266028AbTFWNN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 09:13:58 -0400
Date: Mon, 23 Jun 2003 15:28:03 +0200
From: Pierre Machard <pmachard@tuxfamily.org>
To: linux-kernel@vger.kernel.org
Subject: My 2.5.73 kernel is losing time
Message-ID: <20030623132803.GC3774@twinette.migus.eu.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I am sorry but I cannot find the origin of the problem. Since 2.5.70, my
kernel has a lot of problems with its clock.

Take a look :

while ;  do ntpdate -u ntp.tuxfamily.net ; sleep 2 ; done

23 Jun 14:53:17 ntpdate[2018]: step time server 80.67.179.98 offset -1764.5=
08569 sec
23 Jun 14:53:18 ntpdate[2020]: step time server 80.67.179.98 offset -1.0987=
48 sec
23 Jun 14:53:19 ntpdate[2022]: step time server 80.67.179.98 offset -1.0815=
69 sec
23 Jun 14:53:20 ntpdate[2024]: step time server 80.67.179.98 offset -1.1155=
21 sec
23 Jun 14:53:22 ntpdate[2026]: step time server 80.67.179.98 offset -1.0964=
97 sec
23 Jun 14:53:23 ntpdate[2028]: step time server 80.67.179.98 offset -1.0972=
01 sec
23 Jun 14:53:24 ntpdate[2031]: step time server 80.67.179.98 offset -1.0819=
53 sec
23 Jun 14:53:26 ntpdate[2033]: step time server 80.67.179.98 offset -1.0975=
88 sec
23 Jun 14:53:26 ntpdate[2035]: step time server 80.67.179.98 offset -1.5777=
33 sec
23 Jun 14:53:28 ntpdate[2037]: step time server 80.67.179.98 offset -1.0898=
77 sec
23 Jun 14:53:29 ntpdate[2039]: step time server 80.67.179.98 offset -1.1160=
14 sec
23 Jun 14:53:30 ntpdate[2041]: step time server 80.67.179.98 offset -1.0809=
28 sec
23 Jun 14:53:31 ntpdate[2043]: step time server 80.67.179.98 offset -1.0988=
49 sec

I am running an AuthenticAMD  mobile AMD Duron(tm) Processor with an ALi
Corporation M1647 Northbridge=20

If you give me some advices, i'll be able to provide more information
about this bug. For instance I don't see anything strange in the syslog.

Cheers,
--=20
                                Pierre Machard
<pmachard@tuxfamily.org>                                  TuxFamily.org
<pmachard@techmag.net>                                     techmag.info
+33(0)668 178 365                    http://migus.tuxfamily.org/gpg.txt
GPG: 1024D/23706F87 : B906 A53F 84E0 49B6 6CF7 82C2 B3A0 2D66 2370 6F87

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+9wBjs6AtZiNwb4cRArVJAKC4Bi/k8xssALZyi/ewlfqPuou1bQCfZ/Gu
DDlzNHisq9yMA4hvaM7dcXQ=
=h4Km
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
