Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264752AbUEESWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264752AbUEESWb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 14:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264756AbUEESWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 14:22:31 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:27522 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S264752AbUEESW3 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 14:22:29 -0400
Message-Id: <200405051822.i45IM2uT018573@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Dominik Karall <dominik.karall@gmx.net>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK) 
In-Reply-To: Your message of "Wed, 05 May 2004 13:12:30 +0200."
             <200405051312.30626.dominik.karall@gmx.net> 
From: Valdis.Kletnieks@vt.edu
References: <20040505013135.7689e38d.akpm@osdl.org>
            <200405051312.30626.dominik.karall@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1688188716P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 05 May 2004 14:22:02 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1688188716P
Content-Type: text/plain; charset=us-ascii

On Wed, 05 May 2004 13:12:30 +0200, Dominik Karall <dominik.karall@gmx.net>  said:

> Is there any reason why this patch was applied? Because NVidia users can't 
> work with the original drivers now without removing this patch every time.

The NVidia users will also have to back out the regparm patch, or insert
'asmlinkage' on all the appropriate definitions in the glue code.  Note that
the patches on www.minion.de already fix this for the 5341 drivers as of
03/24/2004.

In any case, even though I'm one of those NVidia users, I'm OK with the
patch being in there - anybody who's clued enough to build and run a -mm
kernel shouldn't have much trouble figuring out how to build it with 2 patches
reverted.

--==_Exmh_-1688188716P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAmTDJcC3lWbTT17ARAv68AKDyilbSnkS6BP98u1SsT+P5EAyo6wCeJHFZ
+t/pxFJrewHrHM8WHGngFU0=
=KB4u
-----END PGP SIGNATURE-----

--==_Exmh_-1688188716P--
