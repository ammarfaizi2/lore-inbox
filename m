Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263726AbTKFTwl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 14:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263747AbTKFTwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 14:52:41 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:22913 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263726AbTKFTwj (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 14:52:39 -0500
Message-Id: <200311061952.hA6Jq9HG004043@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: gene.heskett@verizon.net
Cc: viro@parcelfarce.linux.theplanet.co.uk, Marcel Lanz <marcel.lanz@ds9.ch>,
       linux-kernel@vger.kernel.org
Subject: Re: load 2.4.x binary only module on 2.6 
In-Reply-To: Your message of "Thu, 06 Nov 2003 14:33:12 EST."
             <200311061433.12555.gene.heskett@verizon.net> 
From: Valdis.Kletnieks@vt.edu
References: <20031106153004.GA30008@ds9.ch> <200311061243.19536.gene.heskett@verizon.net> <200311061922.hA6JMsHG003109@turing-police.cc.vt.edu>
            <200311061433.12555.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-944760801P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 06 Nov 2003 14:52:09 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-944760801P
Content-Type: text/plain; charset=us-ascii

On Thu, 06 Nov 2003 14:33:12 EST, Gene Heskett said:

> I've got minions 4496 here, so how did you make it work?  I had to 
> revert to the kernel driver nv which doesn't do as much, but is 
> easily 100000% more stable.

Got NVidia's tarball, did the --extract-only thing, applied
the Minion patch, 'cp Makefile.kbuild Makefile', reboot to the
-mm2 kernel, 'cd src/NVdia<mumble>/usr/src/nv && make'.

Actually, I've just had to do the 'make' for the last umpteen kernel
revs - the Makefile dates back to Aug 4, and Sep 5 I had to apply a
2-line fix to nv-linux.h.

Not sure if the nv driver could be more stable - the last time I was
able to tickle the NVidia code into crashing either XFree86 or the kernel
was back in the 2.5.6* time frame.

--==_Exmh_-944760801P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/qqZpcC3lWbTT17ARAthrAJ4kudsauMUoZ1cQI4Uz0vvRl7v4zQCbBvdS
sFQ71CcnQhIG2N0YLoGjXFQ=
=zJVx
-----END PGP SIGNATURE-----

--==_Exmh_-944760801P--
