Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbUEFQNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbUEFQNa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 12:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUEFQNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 12:13:30 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:14724 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261197AbUEFQN2 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 12:13:28 -0400
Message-Id: <200405061613.i46GDKK2018200@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: MalteSch@gmx.de
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK) 
In-Reply-To: Your message of "Thu, 06 May 2004 18:03:14 +0200."
             <20040506180314.3cea176b@highlander.Home.LAN> 
From: Valdis.Kletnieks@vt.edu
References: <20040505013135.7689e38d.akpm@osdl.org> <200405051312.30626.dominik.karall@gmx.net> <200405051822.i45IM2uT018573@turing-police.cc.vt.edu> <20040505215136.GA8070@wohnheim.fh-wedel.de> <200405061518.i46FIAY2016476@turing-police.cc.vt.edu>
            <20040506180314.3cea176b@highlander.Home.LAN>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1005326616P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 06 May 2004 12:13:20 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1005326616P
Content-Type: text/plain; charset=us-ascii

On Thu, 06 May 2004 18:03:14 +0200, Malte =?ISO-8859-1?B?U2NocvZkZXI=?= said:

> I use 2.6.6-rc3  w/ 4k-stack enabled (-mm is a bit too experimental for my =
> taste ;) ), ATIs binary-module is working w/o problems.
> but IIRC I had to disable REGPARMS.

Alternatively, www.minion.de has a patch against the 5341 drivers that makes
it work with the regparms (basically, it sticks an asmlinkage in all the right
places)....

http://www.minion.de/files/NVIDIA_kernel-1.0-5341-2.6.diff

Of course, if you hit problems running a 3rd party patch against a mostly-binary
driver, you're on your own... ;)

--==_Exmh_1005326616P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAmmQfcC3lWbTT17ARAlZRAKCtDnWAYe/hE6gqsggPOBngX2Ug6wCffoBF
2aS2z5r/RihgSMFdOYP6Jjk=
=ZmG1
-----END PGP SIGNATURE-----

--==_Exmh_1005326616P--
