Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275335AbTHSFDq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 01:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275340AbTHSFDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 01:03:46 -0400
Received: from h80ad2781.async.vt.edu ([128.173.39.129]:43649 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S275335AbTHSFDp (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 01:03:45 -0400
Message-Id: <200308190503.h7J53dVq004714@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "Nayak, Samdeep" <Samdeep_Nayak@adaptec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux SCSI benchmarking tool?? 
In-Reply-To: Your message of "Mon, 18 Aug 2003 21:52:54 PDT."
             <E18F4A9ED285D41191FA00B0D0498DB90649D4E5@aimexc06.corp.adaptec.com> 
From: Valdis.Kletnieks@vt.edu
References: <E18F4A9ED285D41191FA00B0D0498DB90649D4E5@aimexc06.corp.adaptec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_463093572P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 19 Aug 2003 01:03:38 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_463093572P
Content-Type: text/plain; charset=us-ascii

On Mon, 18 Aug 2003 21:52:54 PDT, "Nayak, Samdeep" <Samdeep_Nayak@adaptec.com>  said:

> have used dd, dt, IOmeter and rawio utilities so far and each seemed to
> represent a different picture to me on the same setup (Single target with
> few LUNS).  (DD showed good performance on an ext2 mounted file system till
> I realized that I was writing to the buffer and not writing on the raw
> drive). Since I am trying to catch up with the SCSI world, I am just
> wondering if any one else has tried any other utilities that would provide
> better results or am I doing something wrong here??

Those tools report different things because they are measuring different
aspects of the performance.  For many system configurations, the fact that 'dd'
is writing on a buffer rather than a drive is actually a *feature*, as you
might care about just how much of a boost the cache is giving you - I don't
care how fast my compile writes to disk, I care how fast the cache and page
subsystems actually present the data to userspace...

"better results" depends on the question - otherwise "42" is as good an answer as
any, for exactly the reasons that Deep Thought gave.... ;)

--==_Exmh_463093572P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/Qa+qcC3lWbTT17ARAuWQAKCNCOW4dp9xWKvCRmUAGn6Uloo5CgCfXOGW
qlUfVyEXcDJtBbm8tKfpjjg=
=UBGw
-----END PGP SIGNATURE-----

--==_Exmh_463093572P--
