Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263733AbTH1Gcr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 02:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263734AbTH1Gcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 02:32:47 -0400
Received: from [64.5.56.18] ([64.5.56.18]:12203 "EHLO pico.surpasshosting.com")
	by vger.kernel.org with ESMTP id S263733AbTH1Gcp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 02:32:45 -0400
Date: Wed, 27 Aug 2003 15:34:54 -0500
From: Chris Cheney <ccheney@debian.org>
To: linux-kernel@vger.kernel.org
Cc: B.Zolnierkiewicz@elka.pw.edu.pl
Subject: HPT372 2.344 slow drive issue
Message-ID: <20030827203454.GA1492@cheney.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pico.surpasshosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - conr-adsl-cheney.txucom.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I have a Soyo P4I875P motherboard that has a HPT372 chip with bios 2.344
The hard drive on the controller is a Maxtor DiamondMax Plus 9 200GB. I
have tested the drive on ICH5 and it does around 48-52MB/s but on HPT372
it does ~ 9MB/s. This still shows up on 2.6.0-test4-bk2 and did on 2.4.x
but I haven't tested on 2.4 for several weeks.


hdparm -Tt /dev/hdi
/dev/hdi:
 Timing buffer-cache reads:   4128 MB in  2.00 seconds = 2063.28 MB/sec
 Timing buffered disk reads:  156 MB in  3.00 seconds =  51.99 MB/sec


bonnie++

calc,2G,9054,32,8713,3,7028,1,19993,59,27927,2,144.0,0,16,3190,99,+++++,+++,+++++,+++,2980,91,+++++,+++,7685,85


Thanks,

Chris Cheney

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/TRXu0QZas444SvIRAmoaAJ4yW8fon9uKO+gSf53t85KiwzPHOwCfbgDs
eC6HKo1dUAtbRsdOIJpfrLE=
=PkjF
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
