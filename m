Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbWIXTWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWIXTWp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 15:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbWIXTWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 15:22:44 -0400
Received: from pool-71-254-65-206.ronkva.east.verizon.net ([71.254.65.206]:18886
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750968AbWIXTWo (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 15:22:44 -0400
Message-Id: <200609241922.k8OJMeHs008932@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Tilman Schmidt <tilman@imap.cc>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.18-rc7-mm1] slow boot
In-Reply-To: Your message of "Sun, 24 Sep 2006 18:59:18 +0200."
             <4516B966.3010909@imap.cc>
From: Valdis.Kletnieks@vt.edu
References: <4516B966.3010909@imap.cc>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1159125759_7036P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 24 Sep 2006 15:22:39 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1159125759_7036P
Content-Type: text/plain; charset=us-ascii

On Sun, 24 Sep 2006 18:59:18 +0200, Tilman Schmidt said:

> FYI: On my Dell OptiPlex GX110 (Intel Pentium III, 933 MHz, 512 MB
> RAM, i810 chipset), kernel 2.6.18-rc7-mm1 takes drastically longer
> to boot than 2.6.18 mainline release. Some data points from the
> respective dmesg outputs:

> <<<<<<< 2.6.18
> <4>[   26.336075] ------------------------
> <4>[   26.336130] | Locking API testsuite:

Try building your -rc7-mm1 kernel without CONFIG_DEBUG_LOCKING_API_SELFTESTS
(and you've probably got a few other high-impact DEBUG options turned
on - CONFIG_PROVE_LOCKING is another possible culprit).

--==_Exmh_1159125759_7036P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFFtr/cC3lWbTT17ARAlgDAKCb/bnRwl+3k+yc9LhaahIRnQnerACferL9
5iWwrgVZ5/n8HCSQCWzBzqk=
=VScA
-----END PGP SIGNATURE-----

--==_Exmh_1159125759_7036P--
