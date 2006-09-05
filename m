Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWIEMS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWIEMS2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 08:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWIEMS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 08:18:28 -0400
Received: from pool-72-66-207-181.ronkva.east.verizon.net ([72.66.207.181]:22467
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932116AbWIEMS1 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 08:18:27 -0400
Message-Id: <200609051217.k85CH5j7004648@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm3 crypto issues with encrypted disks
In-Reply-To: Your message of "Mon, 04 Sep 2006 17:25:22 EDT."
             <200609042125.k84LPMYR003633@turing-police.cc.vt.edu>
From: Valdis.Kletnieks@vt.edu
References: <200609041602.k84G2SYc005390@turing-police.cc.vt.edu>
            <200609042125.k84LPMYR003633@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1157458625_3367P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 05 Sep 2006 08:17:05 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1157458625_3367P
Content-Type: text/plain; charset=us-ascii

On Mon, 04 Sep 2006 17:25:22 EDT, Valdis.Kletnieks@vt.edu said:
> --==_Exmh_1157405122_3505P
> Content-Type: text/plain; charset=us-ascii
> 
> On Mon, 04 Sep 2006 12:02:28 EDT, Valdis.Kletnieks@vt.edu said:
> 
> > Sorry for not catching this one earlier..  Sometime between 2.6.18-rc4-mm2
> > and -mm3, something crept into the git-cryptodev.patch that breaks mounting
> > encrypted disks.  What I have in /etc/fstab:
> 
> And of course, after I spend time doing a -mm bisect, the problem evaporates
> in -rc5-mm1. ;)

I'm an idiot, had a typo in grub.conf and booted an old working kernel.
It's still broken in -rc5-mm1.  Unfortunately, I'm going to be cleaning
manure off the impellers for the rest of the week, so I won't be able to
dig further into it before the weekend.

--==_Exmh_1157458625_3367P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFE/WrBcC3lWbTT17ARAsGTAKDqC78PNWCPVa4l8TQYIPDWOqDZbACeNLe1
iNvMT6TA9a46pf1fO4dk32A=
=oNxe
-----END PGP SIGNATURE-----

--==_Exmh_1157458625_3367P--
