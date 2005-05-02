Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVEBP3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVEBP3h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 11:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVEBP3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 11:29:37 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:55569 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261327AbVEBP3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 11:29:35 -0400
Message-Id: <200505021528.j42FS5QJ006515@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Adrian Bunk <bunk@stusta.de>
Cc: Ed Tomlinson <tomlins@cam.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm1 
In-Reply-To: Your message of "Sun, 01 May 2005 15:30:40 +0200."
             <20050501133040.GB3592@stusta.de> 
From: Valdis.Kletnieks@vt.edu
References: <20050429231653.32d2f091.akpm@osdl.org> <Pine.LNX.4.61.0504301700470.3559@montezuma.fsmlabs.com> <20050430161032.0f5ac973.rddunlap@osdl.org> <200505010909.38277.tomlins@cam.org>
            <20050501133040.GB3592@stusta.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1115047685_5213P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 02 May 2005 11:28:05 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1115047685_5213P
Content-Type: text/plain; charset=us-ascii

On Sun, 01 May 2005 15:30:40 +0200, Adrian Bunk said:

> How much bandwith does this require?
> 
> Currently, 2.6.12-rc3-mm1 requires 3.7 MB for the -rc3 patch (which can 
> be used for several -mm patches) plus 2.6 MB for the -mm patch.
> 
> The 47 MB download for 2.6.11 are required only once for the many -mm 
> kernels between 2.6.11 and 2.6.12.
> 
> Looking at these numbers, the average download required for every -mm 
> kernel is currently far below 10 MB.

And even *more* importantly, note that when downloading a -mm or -rc3 patch,
there's minimal server overhead - it opens *one* file and streams it to the
FTP connection.  sendfile() anybody? ;)

How many open/close/etc are needed to sync up 2 'git' mirrors?  I don't care *how*
stupendous git/mercurial/whatever are, they're going to have a *really* hard time
getting down to the overhead of an FTP session sending a .bz2 file.

Unless of course, there's only me and a dozen other people even *trying* -mm
kernels and the distinction is lost in the noise... (Out of curiosity, how
many downloads *DO* the -mm kernels get?  I know Linus and Andrew want more
testing.. let's keep that in mind here.. ;)

--==_Exmh_1115047685_5213P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCdkcFcC3lWbTT17ARAuQNAKDLsSdO4gqooCpWfWHHHdlCF5Dc6ACg6hgF
P0FBZ6rzpmvFItCA6qMPU5s=
=1cCw
-----END PGP SIGNATURE-----

--==_Exmh_1115047685_5213P--
