Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbTILLd0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 07:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbTILLd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 07:33:26 -0400
Received: from M897P017.adsl.highway.telekom.at ([62.47.144.17]:41861 "EHLO
	stallburg.dyndns.org") by vger.kernel.org with ESMTP
	id S261364AbTILLdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 07:33:24 -0400
Date: Fri, 12 Sep 2003 13:33:21 +0200
From: maximilian attems <janitor@sternwelten.at>
To: linux-kernel@vger.kernel.org
Cc: coreteam@netfilter.org
Subject: [patch] eliminate duplicate Definition in ip_nat.h
Message-ID: <20030912113321.GA1663@mail.sternwelten.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


--- linux-2.6.0-test5/include/linux/netfilter_ipv4/ip_nat.h	Mon Sep  8 21:5=
0:41 2003
+++ linux/include/linux/netfilter_ipv4/ip_nat.h	Fri Sep 12 13:21:25 2003
@@ -19,11 +19,6 @@
 #define HOOK2MANIP(hooknum) ((hooknum) !=3D NF_IP_POST_ROUTING && (hooknum=
) !=3D NF_IP_LOCAL_IN)
 #endif
=20
-/* 2.3.19 (I hope) will define this in linux/netfilter_ipv4.h. */
-#ifndef SO_ORIGINAL_DST
-#define SO_ORIGINAL_DST 80
-#endif
-
 #define IP_NAT_RANGE_MAP_IPS 1
 #define IP_NAT_RANGE_PROTO_SPECIFIED 2
 /* Used internally by get_unique_tuple(). */


actually 2.4.22 _and_ 2.6.0-test5 defines it :)
please apply=20
a++ maks



--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/Ya8B6//kSTNjoX0RAuIpAJ0WQ7+jvp0t1woSxKCzbKJS4gVHlgCfXK9l
4etg8BCQOhiCf8+679o+QZI=
=cn9I
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
