Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263817AbTDXSYA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 14:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbTDXSYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 14:24:00 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:23681 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263817AbTDXSX6 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 14:23:58 -0400
Message-Id: <200304241835.h3OIZxvj006418@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Henti Smith <bain@tcsn.co.za>
Cc: linux-kernel@vger.kernel.org
Subject: Re: maximum possible memory limit .. 
In-Reply-To: Your message of "Thu, 24 Apr 2003 20:05:24 +0200."
             <20030424200524.5030a86b.bain@tcsn.co.za> 
From: Valdis.Kletnieks@vt.edu
References: <20030424200524.5030a86b.bain@tcsn.co.za>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1095087500P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 24 Apr 2003 14:35:59 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1095087500P
Content-Type: text/plain; charset=us-ascii

On Thu, 24 Apr 2003 20:05:24 +0200, Henti Smith <bain@tcsn.co.za>  said:
> I had a discussion with somebody watching the whole M$ server launch and
> mentioned then new systems supports up to a terabyte of ram. 

Well.. sure.. it's easy enough to write something that supports plugging in
a terabyte.  The *tricky* part is supporting it well - you have page table
issues, you have swapping/thrashing issues (if you *do* have to page something
out, you're in trouble.. ;), you have process scheduling issues (how many
Apache processes does it take to use up a terabyte?  What's your load average
at that point?), you have multi-processor scaling issues (you're gonna want
to have 64+ processors, etc..)

Consider - the number of machines with over a terabyte of RAM is limited:

http://www.llnl.gov/asci/platforms/platforms.html

That's the sort of box that has a terabyte.  Do you *really* think that
M$ 2003 has all the stuff needed to scale to THAT size?



--==_Exmh_-1095087500P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+qC6OcC3lWbTT17ARAiTKAJ0dW8tQewctUVkGYWKkgUv/DHRQBQCgjwpi
W4LsmUb6JnjdbMvfI3Kob+Q=
=WdO8
-----END PGP SIGNATURE-----

--==_Exmh_-1095087500P--
