Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264958AbRGNWQ5>; Sat, 14 Jul 2001 18:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264959AbRGNWQr>; Sat, 14 Jul 2001 18:16:47 -0400
Received: from ns.snowman.net ([63.80.4.34]:3847 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id <S264958AbRGNWQk>;
	Sat, 14 Jul 2001 18:16:40 -0400
Date: Sat, 14 Jul 2001 18:16:07 -0400
From: Stephen Frost <sfrost@snowman.net>
To: Ion Badulescu <ionut@cs.columbia.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Starfire issues
Message-ID: <20010714181607.O11136@ns>
Mail-Followup-To: Ion Badulescu <ionut@cs.columbia.edu>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wNuK6YNcq0QdMr8v"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.2.16 (i686)
X-Uptime: 6:12pm  up 331 days, 20:37, 12 users,  load average: 2.00, 2.00, 2.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wNuK6YNcq0QdMr8v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

	I've been having some trouble with a starfire I have in that it seems
	to drop packets every once in a while for a little bit and then start
	up again.  Also getting strange kernel messages:

----
eth2: Increasing Tx FIFO threshold to 320 bytes
eth2: Something Wicked happened! 2049001.
eth2: Increasing Tx FIFO threshold to 336 bytes
eth2: Something Wicked happened! 2049001.
eth2: Increasing Tx FIFO threshold to 352 bytes
eth2: Something Wicked happened! 2048101.
eth2: Increasing Tx FIFO threshold to 368 bytes
eth2: Something Wicked happened! 2049001.
eth2: Increasing Tx FIFO threshold to 384 bytes
eth2: Something Wicked happened! 2049001.
eth2: Increasing Tx FIFO threshold to 400 bytes
eth2: Something Wicked happened! 2049001.
eth2: Increasing Tx FIFO threshold to 416 bytes
eth2: Something Wicked happened! 2049001.
eth2: Increasing Tx FIFO threshold to 432 bytes
eth2: Something Wicked happened! 2048101.
eth2: Increasing Tx FIFO threshold to 448 bytes
eth2: Something Wicked happened! 2049001.
eth2: Increasing Tx FIFO threshold to 464 bytes
eth2: Something Wicked happened! 2049001.
eth2: Increasing Tx FIFO threshold to 480 bytes
eth2: Something Wicked happened! 2049001.
eth2: Increasing Tx FIFO threshold to 496 bytes
eth2: Something Wicked happened! 2049001.
----

	This happens on other interfaces, not just this one.  The kernel being
	used is stock 2.4.6-ac2.  Would the patches you've posted to lkml help?
	If so I can give them a shot...

		Thanks!

			Stephen

--wNuK6YNcq0QdMr8v
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7UMSnrzgMPqB3kigRAi15AKCSgqChSF20bYCbnq4ZCJK21WIoswCeO4Lm
n/kLeUsBzYuOfhm8r8DhW8k=
=6TES
-----END PGP SIGNATURE-----

--wNuK6YNcq0QdMr8v--
