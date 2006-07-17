Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWGQSGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWGQSGD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 14:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWGQSGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 14:06:03 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:40322 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751107AbWGQSGC (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 14:06:02 -0400
Message-Id: <200607171805.k6HI5uvD017963@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Caleb Gray <caleb@calebgray.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reiser4 Inclusion
In-Reply-To: Your message of "Sun, 16 Jul 2006 20:02:15 PDT."
             <44BAFDB7.9050203@calebgray.com>
From: Valdis.Kletnieks@vt.edu
References: <44BAFDB7.9050203@calebgray.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1153159556_13479P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 17 Jul 2006 14:05:56 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1153159556_13479P
Content-Type: text/plain; charset=us-ascii

On Sun, 16 Jul 2006 20:02:15 PDT, Caleb Gray said:
> Reiser4's responsiveness is undoubtedly at least twice as fast as ext3.
> I have deployed two nearly identical servers in Florida (I live in
> Washington state) but one difference: one uses ext3 and the other
> reiser4. The ping time of the reiser4 server is (on average) 20ms faster
> than the ext3 server.

OK, I'll bite.  What *POSSIBLE* reason is there for the choice of filesystem
to matter to an ICMP Echo Request/Reply?  I'm suspecting something else,
like the ext3 server needs to re-ARP before sending the Echo Reply, or some
such.

> and directory structures. (Both of the filesystems have slowed down at a
> similar pace for the duration of their lifetime [about 15ms].)

Unclear why *that* should matter to ICMP either.


--==_Exmh_1153159556_13479P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEu9GEcC3lWbTT17ARAubTAJ9h7U4f8SwEjkOaHhTQ1SDI9xfyMwCeLgSe
Gyx+FHH69+x3Ox8qNOJI4j0=
=9mEn
-----END PGP SIGNATURE-----

--==_Exmh_1153159556_13479P--
