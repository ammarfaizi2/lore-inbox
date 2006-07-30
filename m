Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWG3QS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWG3QS0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 12:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWG3QS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 12:18:26 -0400
Received: from pool-72-66-202-44.ronkva.east.verizon.net ([72.66.202.44]:11719
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932350AbWG3QSZ (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 12:18:25 -0400
Message-Id: <200607301618.k6UGIHEt023129@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andi Kleen <ak@suse.de>
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: Building the kernel on an SMP box?
In-Reply-To: Your message of "Sat, 29 Jul 2006 21:29:17 +0200."
             <200607292129.17682.ak@suse.de>
From: Valdis.Kletnieks@vt.edu
References: <14CFC56C96D8554AA0B8969DB825FEA0012B3898@chicken.machinevisionproducts.com> <p73wt9x4zay.fsf@verdi.suse.de> <44CBB7F5.1080704@tmr.com>
            <200607292129.17682.ak@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1154276297_2988P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 30 Jul 2006 12:18:17 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1154276297_2988P
Content-Type: text/plain; charset=us-ascii

On Sat, 29 Jul 2006 21:29:17 +0200, Andi Kleen said:
> 
> > That sounds really useful, although I bet it assumes that the build 
> > environment is the same on all machines. Or at least similar. 
> 
> No it doesn't.

What happens with the 'gcc version magic' with modules if the main kernel
and modules are compiled on separate machines with different GCC releases
installed?   Certainly seems like a requirement for a "similar" environment
to me, if compiling with gcc 4.1.0 vs 4.1.1. results in a module that won't
insmod....

--==_Exmh_1154276297_2988P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEzNvJcC3lWbTT17ARAqfEAKCwkQjQsqjSPMP0Rm1q//t1gCphMgCgywuw
SpTHqD7cEJkKWouJ9oxeMBc=
=hPfY
-----END PGP SIGNATURE-----

--==_Exmh_1154276297_2988P--
