Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbUFCGNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbUFCGNd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 02:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbUFCGNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 02:13:33 -0400
Received: from smtpsrv6.hrz.uni-oldenburg.de ([134.106.87.26]:36539 "EHLO
	smtpsrv6.hrz.uni-oldenburg.de") by vger.kernel.org with ESMTP
	id S261179AbUFCGNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 02:13:25 -0400
To: aris@cathedrallabs.org (Aristeu Sergio Rozanski Filho)
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.4.26 fails to detect two Realtek cards
References: <m1acznpz6c.fsf@ntcora.icbm.uni-oldenburg.de>
	<20040601120019.GN2159@cathedrallabs.org>
From: Kevin Bube <k.bube@web.de>
Date: Thu, 03 Jun 2004 08:13:09 +0200
In-Reply-To: <20040601120019.GN2159@cathedrallabs.org> (Aristeu Sergio
 Rozanski Filho's message of "Tue, 1 Jun 2004 09:00:19 -0300")
Message-ID: <m1oeo141ai.fsf@ntcora.icbm.uni-oldenburg.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
X-PMX-Version: 4.5.0.92886, Antispam-Core: 4.0.4.93542, Antispam-Data: 2004.6.2.102430
X-PerlMx-Spam: Gauge=IIIIIIII, Probability=8%, Report='__TO_MALFORMED_2 0, __REFERENCES 0, __IN_REP_TO 0, __HAS_MSGID 0, __SANE_MSGID 0, __USER_AGENT 0, __MIME_VERSION 0, __CT 0, __CTYPE_HAS_BOUNDARY 0, __CTYPE_MULTIPART 0, EMAIL_ATTRIBUTION 0, QUOTED_EMAIL_TEXT 0, SIGNATURE_SHORT_DENSE 0, REFERENCES 0.000, IN_REP_TO 0, USER_AGENT 0.000'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

aris@cathedrallabs.org (Aristeu Sergio Rozanski Filho) writes:

[8139 and 8029 cards]

> I guess you forgot to include ne2k-pci driver in your new kernel
> configuration. 8139too handles rtl8139 (100Mbps) cards and ne2k-pci
> your rtl8029 (10Mbps)

Thanks for the reply. Yes, that was the problem. It works now. I did not
know that the rtl8029 is a ne2000 compatible.

Regards,

Kevin

-- 
publickey 1024D/215F9C87: http://www.icbm.de/~bube/publickey.asc
fingerprint: 607B 39BC C9E9 0F5E EF7F  4557 31D4 A73C 215F 9C87

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQBAvsF7MdSnPCFfnIcRAmddAJ9U7P2TqZHDX6cRmyCHyLQyXspnsgCfQO49
n2SZN8TwmRNRE/YPYn7i8Y8=
=dmg7
-----END PGP SIGNATURE-----
--=-=-=--
