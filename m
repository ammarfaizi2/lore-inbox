Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263895AbTKGXTb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 18:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbTKGXRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 18:17:20 -0500
Received: from h80ad2630.async.vt.edu ([128.173.38.48]:11650 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261916AbTKGWWd (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 17:22:33 -0500
Message-Id: <200311072221.hA7MLuMU006752@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: davidsen@tmr.com (bill davidsen)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suspend to disk panicked in -test9. 
In-Reply-To: Your message of "Fri, 07 Nov 2003 15:14:06 GMT."
             <bogcru$l3g$1@gatekeeper.tmr.com> 
From: Valdis.Kletnieks@vt.edu
References: <200310291857.40722.rob@landley.net>
            <bogcru$l3g$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1730782063P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 07 Nov 2003 17:21:45 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1730782063P
Content-Type: text/plain; charset=us-ascii

On Fri, 07 Nov 2003 15:14:06 GMT, davidsen@tmr.com (bill davidsen)  said:

> Or people who want it that way could put the setterm call in their
> rc.local, of course. No patches required and the rest of the world
> doesn't have to turn it on.

Of course, this means that you have to know beforehand that your
machine is going to panic.  And of course, since the screen is  blanked,
you don't get a clue what caused it so you don't get any information
on how to reproduce it....  We're supposed to be designing a quality
operating system, not something that's a set-up for a Dilbert strip.

Rob Landley is right - there should be a patch to make it go away
if the kernel panics.  

--==_Exmh_1730782063P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/rBr5cC3lWbTT17ARAnT0AKCCoGm3t9rDebj+98dRnsnK8eGVggCg+l7L
Tdy2uGbcATyDxxypD6N7RaQ=
=hO6e
-----END PGP SIGNATURE-----

--==_Exmh_1730782063P--
