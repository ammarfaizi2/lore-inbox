Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262668AbVAVGdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262668AbVAVGdd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 01:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262669AbVAVGdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 01:33:33 -0500
Received: from os.inf.tu-dresden.de ([141.76.48.99]:49656 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id S262668AbVAVGda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 01:33:30 -0500
Date: Fri, 21 Jan 2005 22:32:47 -0800
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.11-rc2
Message-ID: <20050121223247.65c544f8@laptop.hypervisor.org>
In-Reply-To: <Pine.LNX.4.58.0501211806130.3053@ppc970.osdl.org>
References: <Pine.LNX.4.58.0501211806130.3053@ppc970.osdl.org>
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary="Signature_Fri__21_Jan_2005_22_32_47_-0800_Inflkorvg=_NbhcJ";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature_Fri__21_Jan_2005_22_32_47_-0800_Inflkorvg=_NbhcJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jan 2005 18:13:55 -0800 (PST) Linus Torvalds (LT) wrote:

LT> Ok, trying to calm things down again for a 2.6.11 release.

Connection tracking does not compile...

 CC      net/ipv4/netfilter/ip_conntrack_standalone.o
In file included from net/ipv4/netfilter/ip_conntrack_standalone.c:34:
include/linux/netfilter_ipv4/ip_conntrack.h:135: warning: "struct ip_conntrack" declared inside parameter list
include/linux/netfilter_ipv4/ip_conntrack.h:135: warning: its scope is only this definition or declaration, which is probably not what you want
include/linux/netfilter_ipv4/ip_conntrack.h:305: warning: "enum ip_nat_manip_type" declared inside parameter list
include/linux/netfilter_ipv4/ip_conntrack.h:306: error: parameter `manip' has incomplete type
include/linux/netfilter_ipv4/ip_conntrack.h: In function `ip_nat_initialized':
include/linux/netfilter_ipv4/ip_conntrack.h:307: error: `IP_NAT_MANIP_SRC' undeclared (first use in this function)
include/linux/netfilter_ipv4/ip_conntrack.h:307: error: (Each undeclared identifier is reported only once
include/linux/netfilter_ipv4/ip_conntrack.h:307: error: for each function it appears in.)


-Udo.

--Signature_Fri__21_Jan_2005_22_32_47_-0800_Inflkorvg=_NbhcJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFB8fOTnhRzXSM7nSkRAjaPAJ0aODjjkA0B4jAbp7o8avd8Mj6ltQCggXao
xpVGKQC8nA22IwyUFY+b7iQ=
=331y
-----END PGP SIGNATURE-----

--Signature_Fri__21_Jan_2005_22_32_47_-0800_Inflkorvg=_NbhcJ--
