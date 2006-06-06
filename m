Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751228AbWFFCXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWFFCXE (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 22:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWFFCXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 22:23:03 -0400
Received: from pool-72-66-198-190.ronkva.east.verizon.net ([72.66.198.190]:28102
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751228AbWFFCXB (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 22:23:01 -0400
Message-Id: <200606060222.k562Mdvd003616@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.17-rc5-mm3-lockdep - locking error in quotaon
In-Reply-To: Your message of "Mon, 05 Jun 2006 22:26:23 +0200."
             <1149539183.3111.126.camel@laptopd505.fenrus.org>
From: Valdis.Kletnieks@vt.edu
References: <200606051700.k55H015q004029@turing-police.cc.vt.edu> <1149528339.3111.114.camel@laptopd505.fenrus.org> <200606051920.k55JKQGx003031@turing-police.cc.vt.edu> <20060605193552.GB24342@atrey.karlin.mff.cuni.cz> <1149537156.3111.123.camel@laptopd505.fenrus.org> <20060605200652.GC24342@atrey.karlin.mff.cuni.cz>
            <1149539183.3111.126.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1149560559_3257P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 05 Jun 2006 22:22:39 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1149560559_3257P
Content-Type: text/plain; charset=us-ascii

On Mon, 05 Jun 2006 22:26:23 +0200, Arjan van de Ven said:

> ok since you know this doesn't deadlock the patch below (concept; akpm
> please don't apply yet) ought to describe this special locking situation
> to lockdep; I would really appreciate someone who does use quota to test
> this out and see if it works....

It boots, quotas work, it doesn't issue BUG about the quota system.  I'm
however not qualified to comment on whether the patch is in fact *correct*.
But if Jan is happy with it to, it's probably ready to be pushed to Andrew....


--==_Exmh_1149560559_3257P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEhObvcC3lWbTT17ARAhh7AJ4nHz8dCvbDDd1o/W5WDZgVD8aHggCg4NOl
brhzB+dxk4LWiktg91PWmlU=
=5sUg
-----END PGP SIGNATURE-----

--==_Exmh_1149560559_3257P--
