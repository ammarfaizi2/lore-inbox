Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270962AbTGPQzr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 12:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270952AbTGPQyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 12:54:19 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:8832 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S270957AbTGPQxw (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 12:53:52 -0400
Message-Id: <200307161708.h6GH8UU1001456@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] O6int for interactivity 
In-Reply-To: Your message of "Thu, 17 Jul 2003 00:30:25 +1000."
             <200307170030.25934.kernel@kolivas.org> 
From: Valdis.Kletnieks@vt.edu
References: <200307170030.25934.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1548023285P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 16 Jul 2003 13:08:30 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1548023285P
Content-Type: text/plain; charset=us-ascii

On Thu, 17 Jul 2003 00:30:25 +1000, Con Kolivas said:
> O*int patches trying to improve the interactivity of the 2.5/6 scheduler for 
> desktops. It appears possible to do this without moving to nanosecond 
> resolution.
> 
> This one makes a massive difference... Please test this to death.

This one looks *awesome* here - the base -mm1 version (which was -O5int if I
remember right) was still subject to very tiny stutters (sound like "clicks")
in xmms (everybody's favorite tester ;) under some conditions (changing folders
in the Exmh mail client was usually good for a click).  -O6int has stuttered
exactly once in the past hour, and that was with Exmh going, a large grep
running, a sudden influx of fetchmail/sendmail/procmail (probably 30-50 fork/
exec pairs/sec there), launching Mozilla (oink ;), and something else big all at the
same time (in other words, under as extreme load as this laptop ever sees in
actual production useage).

/Valdis

--==_Exmh_1548023285P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/FYaNcC3lWbTT17ARAlj6AKCQJgrqrIgOugvBN2nriKFP3e5pHgCgspYE
exSltgeWylne1nCoDI5kzkw=
=3kri
-----END PGP SIGNATURE-----

--==_Exmh_1548023285P--
