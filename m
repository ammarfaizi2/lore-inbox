Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266015AbUBCP7l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 10:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266033AbUBCP7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 10:59:41 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:20352 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266015AbUBCP7h (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 10:59:37 -0500
Message-Id: <200402031558.i13FwvwF022759@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Samium Gromoff <deepfire@sic-elvis.zel.ru>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, philip@codematters.co.uk
Subject: Re: 2.6.1 slower than 2.4, smp/scsi/sw-raid/reiserfs 
In-Reply-To: Your message of "Tue, 03 Feb 2004 18:57:27 +1100."
             <401F5467.50702@cyberone.com.au> 
From: Valdis.Kletnieks@vt.edu
References: <87smhsy7n4.wl@canopus.ns.zel.ru> <20040202230745.237dd5b6.akpm@osdl.org> <87r7xcy4zy.wl@canopus.ns.zel.ru>
            <401F5467.50702@cyberone.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1008540096P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 03 Feb 2004 10:58:57 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1008540096P
Content-Type: text/plain; charset=us-ascii

On Tue, 03 Feb 2004 18:57:27 +1100, Nick Piggin said:

> >>Perhaps you could test Nick's patches.   They are at
> >>
> >>	http://www.kerneltrap.org/~npiggin/vm/
> >>
> >>Against 2.6.2-rc2-mm2.  First revert vm-rss-limit-enforcement.patch, then
> >>apply those three.
> >Hmmm, i`d prefer plain 2.6, but i`ll try it anyway.
> It should go against plain 2.6 with luck.

Applies with offsets against 2.6.2-rc3-mm1-1 and boots.  Haven't tested it
under high memory pressure yet though.


--==_Exmh_-1008540096P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAH8VAcC3lWbTT17ARAptKAJ9yH7AJxOhzt6g/y6+qpcVjaNELPwCgjtpO
4BccroM7n3zMb6jduuaMJWs=
=Vdsu
-----END PGP SIGNATURE-----

--==_Exmh_-1008540096P--
