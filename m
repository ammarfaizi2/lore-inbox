Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbTIURbr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 13:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbTIURbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 13:31:47 -0400
Received: from h80ad2765.async.vt.edu ([128.173.39.101]:1152 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262470AbTIURbq (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 13:31:46 -0400
Message-Id: <200309211731.h8LHVR9r001634@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PCMCIA] Xircom nic hang on boot since cs.c race condition patch 
In-Reply-To: Your message of "Sat, 20 Sep 2003 22:22:07 BST."
             <20030920222207.B4517@flint.arm.linux.org.uk> 
From: Valdis.Kletnieks@vt.edu
References: <20030917144406.753953dd.seanlkml@rogers.com>
            <20030920222207.B4517@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1529249308P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 21 Sep 2003 13:31:24 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1529249308P
Content-Type: text/plain; charset=us-ascii

On Sat, 20 Sep 2003 22:22:07 BST, Russell King said:

> Ok, can you try the attached patch please?  It basically juggles the
> initialisation so that we avoid the locking issues by moving the init
> between our the socket driver and our private thread.
> 
> The patch is against Linus' tree as of last Wednesday.
> 
> Note that I haven't compile-tested this exact patch, (but one similar)
> so I need feedback from both cardbus and pcmcia-using people before I
> submit it.

Applied clean to -test5-mm3, work as expected on a Dell Latitude C840
with yenta sockets.



--==_Exmh_1529249308P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/beBscC3lWbTT17ARAveXAJ9rvMFxmI+oQnGUXREZAE6gfC5Q0QCgiOc6
Q0R+vd/JGX2aY79MjY4GPGU=
=x6kn
-----END PGP SIGNATURE-----

--==_Exmh_1529249308P--
