Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266307AbUBLIqU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 03:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266309AbUBLIqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 03:46:20 -0500
Received: from h80ad25b9.async.vt.edu ([128.173.37.185]:26478 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266307AbUBLIqO (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 03:46:14 -0500
Message-Id: <200402120846.i1C8k6x7006645@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm4 
In-Reply-To: Your message of "Thu, 12 Feb 2004 08:30:54 +0100."
             <402B2BAE.9090208@gmx.de> 
From: Valdis.Kletnieks@vt.edu
References: <20040115225948.6b994a48.akpm@osdl.org> <4007B03C.4090106@gmx.de> <400EC908.4020801@gmx.de> <200401211920.i0LJKZ2a003504@turing-police.cc.vt.edu> <402AAB2C.8050207@gmx.de> <200402120552.i1C5qAHS024041@turing-police.cc.vt.edu>
            <402B2BAE.9090208@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1544958270P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 12 Feb 2004 03:46:06 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1544958270P
Content-Type: text/plain; charset=us-ascii

On Thu, 12 Feb 2004 08:30:54 +0100, "Prakash K. Cheemplavam" said:

> Well, I don't know whether my system actually locks up, it is like it 
> seems the log gets flooded (when I wait long enough) but I cannot do 
> anything with the system at that point, ie it seems like frozen.

I don't think anybody's going to be able to shoot that bug report without more
info.  "seems like frozen" doesn't give us much to go on.  Does the machine
still ping/ssh/etc on the net?  Is it totally locked up?  Any disk activity
lights left on/flickering, indicating life? Can you get a serial console or
kgdb-ethernet or something to see if there's an oops/panic?

> Furthermore I am using latest 53.36 drivers and I am not the only one 
> having this problem if I look into nvnews forums. As I said this is a 
> problem which came with something changed in the newer kernels. 2.6.1 
> (and 2.6.2-rc1) works OK for me, 2.6.2-rc2 and later not.

Well, the 53.36 drivers are rock-solid on my Dell laptop with a GeForce4 440Go
and the 2.6.3-rc1-mm1 kernel.  There very well may be bugs in there, but
they're not ones I can replicate or diagnose...


--==_Exmh_1544958270P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAKz1OcC3lWbTT17ARAhICAJ4hqJ8+Z0nYUF/reAx3fAVlsf141QCbByln
aJmv1oxrr1I3bvek7awiFZo=
=Pv3f
-----END PGP SIGNATURE-----

--==_Exmh_1544958270P--
