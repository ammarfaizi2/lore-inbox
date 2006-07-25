Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932500AbWGYWZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbWGYWZq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 18:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbWGYWZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 18:25:45 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:14527 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932500AbWGYWZo (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 18:25:44 -0400
Message-Id: <200607252225.k6PMP4Sf029794@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>
Cc: Josh Triplett <josht@us.ibm.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org
Subject: Re: vxfs_readdir locking incorrect: add lock_kernel() or remove unlock_kernel()?
In-Reply-To: Your message of "Mon, 24 Jul 2006 17:20:40 PDT."
             <20060724172040.c177f173.akpm@osdl.org>
From: Valdis.Kletnieks@vt.edu
References: <1153780937.31581.13.camel@josh-work.beaverton.ibm.com>
            <20060724172040.c177f173.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1153866304_3092P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 25 Jul 2006 18:25:04 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1153866304_3092P
Content-Type: text/plain; charset=us-ascii

On Mon, 24 Jul 2006 17:20:40 PDT, Andrew Morton said:
> That would appear to imply that nobody has used freevxfs in four years.

Given that...

> I don't see anything in there which needs the locking, apart from perhaps
> f_pos updates.  But it's probably best to add the lock_kernel() - this is a
> bugfixing exercise, not a remove-BKL-from-freevxfs exercise.

Should we consider a remove-freevxfs-from-kernel exercise?

--==_Exmh_1153866304_3092P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFExppAcC3lWbTT17ARAk+CAKCUQ/ySUYWXZP8IrOsaqmRqQgs3nACfZcOu
tiCrRCP3dzWh6VpRUTfPwXM=
=6XmS
-----END PGP SIGNATURE-----

--==_Exmh_1153866304_3092P--
