Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266708AbTBCOy3>; Mon, 3 Feb 2003 09:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266728AbTBCOy3>; Mon, 3 Feb 2003 09:54:29 -0500
Received: from h80ad247a.async.vt.edu ([128.173.36.122]:649 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S266708AbTBCOy1>; Mon, 3 Feb 2003 09:54:27 -0500
Message-Id: <200302031503.h13F3Ka0023572@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Nohez <nohez@cmie.com>
Cc: linux-kernel@vger.kernel.org, bgana@cmie.com
Subject: Re: timer interrupts on HP machines 
In-Reply-To: Your message of "Mon, 03 Feb 2003 18:52:14 +0530."
             <Pine.LNX.4.33.0302031706090.28669-100000@venus.cmie.ernet.in> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.33.0302031706090.28669-100000@venus.cmie.ernet.in>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-548637083P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 03 Feb 2003 10:03:19 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-548637083P
Content-Type: text/plain; charset=us-ascii

On Mon, 03 Feb 2003 18:52:14 +0530, Nohez said:

> server: # date
> Mon Feb  3 17:38:30 IST 2003
> server: # date
> Mon Feb  3 17:38:20 IST 2003

> We have xntpd daemon running on all our servers.

Any xntpd messages in the syslog that correlate with these events? I've
seen similar behavior on my laptop (although the clock ran very slow and
was getting slammed 10-15 seconds forward by xntpd - was a missing interrupt
problem).   I've seen oddness with corrupted /etc/ntp/drift files as well...
-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_-548637083P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+PoS3cC3lWbTT17ARAvOeAKDPQYG9WPlcNKpSGoa8ywWomnLDdQCgzaLJ
pGfhhzeaS5qYg76HggrLFcU=
=Wb3L
-----END PGP SIGNATURE-----

--==_Exmh_-548637083P--
