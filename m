Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264077AbTKJT0d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 14:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264078AbTKJT0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 14:26:33 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:25107 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264077AbTKJT03
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 14:26:29 -0500
Date: Mon, 10 Nov 2003 14:15:54 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Valdis.Kletnieks@vt.edu
cc: linux-kernel@vger.kernel.org
Subject: Re: Suspend to disk panicked in -test9. 
In-Reply-To: <200311072221.hA7MLuMU006752@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.3.96.1031110140716.6278D-101000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: MULTIPART/SIGNED; BOUNDARY="==_Exmh_1730782063P"; MICALG=pgp-sha1; PROTOCOL="application/pgp-signature"
Content-ID: <Pine.LNX.3.96.1031110140716.6278E@gatekeeper.tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--==_Exmh_1730782063P
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-ID: <Pine.LNX.3.96.1031110140716.6278F@gatekeeper.tmr.com>

On Fri, 7 Nov 2003 Valdis.Kletnieks@vt.edu wrote:

> On Fri, 07 Nov 2003 15:14:06 GMT, davidsen@tmr.com (bill davidsen)  said:
> 
> > Or people who want it that way could put the setterm call in their
> > rc.local, of course. No patches required and the rest of the world
> > doesn't have to turn it on.
> 
> Of course, this means that you have to know beforehand that your
> machine is going to panic.

Unless it panics in the boot and never loads the first startup file you
can execute the blank disable there.

> Rob Landley is right - there should be a patch to make it go away
> if the kernel panics.  

There should be a lot of things, including writing the dump to a disk
partition like AIX, Solaris, etc, etc. That never got in, either. I'd
rather see the blank disable as a configurable boot time option, so people
who don't want it don't get it, and vice-versa. 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

--==_Exmh_1730782063P
Content-Type: APPLICATION/PGP-SIGNATURE
Content-ID: <Pine.LNX.3.96.1031110140716.6278G@gatekeeper.tmr.com>
Content-Description: 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/rBr5cC3lWbTT17ARAnT0AKCCoGm3t9rDebj+98dRnsnK8eGVggCg+l7L
Tdy2uGbcATyDxxypD6N7RaQ=
=hO6e
-----END PGP SIGNATURE-----

--==_Exmh_1730782063P--
