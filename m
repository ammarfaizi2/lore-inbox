Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbUFRU6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbUFRU6a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 16:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbUFRU6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 16:58:18 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:46979 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261712AbUFRUxu (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 16:53:50 -0400
Message-Id: <200406182054.i5IKs8WZ002814@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: David Lang <david.lang@digitalinsight.com>
Cc: 4Front Technologies <dev@opensound.com>, linux-kernel@vger.kernel.org
Subject: Re: Stop the Linux kernel madness 
In-Reply-To: Your message of "Fri, 18 Jun 2004 13:29:11 PDT."
             <Pine.LNX.4.60.0406181326210.3688@dlang.diginsite.com> 
From: Valdis.Kletnieks@vt.edu
References: <40D232AD.4020708@opensound.com> <3217460000.1087518092@flay> <40D23701.1030302@opensound.com> <1087573691.19400.116.camel@winden.suse.de> <40D32C1D.80309@opensound.com> <20040618190257.GN14915@schnapps.adilger.int> <40D34CB2.10900@opensound.com> <200406181940.i5IJeBDh032311@turing-police.cc.vt.edu>
            <Pine.LNX.4.60.0406181326210.3688@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1798891183P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 18 Jun 2004 16:54:08 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1798891183P
Content-Type: text/plain; charset=us-ascii

On Fri, 18 Jun 2004 13:29:11 PDT, David Lang said:

> the problem with this is that you can have the situation where it's a SuSE 
> box with a kernel.org kernel. I've had significant problems with 
> installers for 3rd party software that decided what distro they were 
> running on based on what kernel version showed up in uname

Of course, this only happens in 2 main categories of situations:

1) The sysadmin watches it fail, and says "D'Oh! I've been shot in the foot
because of my customized configuration", and proceeds to work around it
(if you're clued enough to get into that mess, you're usually clued enough to
fix it).

2) The previous, now-departed sysadmin got you into the mess - at this point,
the error is a sign telling you it's time to get your system rebuilt to some
maintainable configuration.

The installer will almost certainly fail on any sort of linux-from-scratch configuration
as well.  I pity the poor software developer that thinks that an automated build
should work in every case(*) - requiring the sysadmin to make a few symlinks if
the system config is odd/unknown isn't at all outlandish or unheard of.

(*) I've seen at least one box where uname reported 2.4.12 or so, even though
the kernel was 2.4.20 or so - said box had been dutifully upgraded on a regular
basis and the kernel rebuild, via 'patch'.  Due to a unseen mod in the top
level Makefile, the patch fragment that updated the variables kept failing.
Never got noticed till some kernel code that did a check on the version finally
got upset and compiled in the wrong stuff.... 


--==_Exmh_1798891183P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFA01ZvcC3lWbTT17ARAu0OAJ4wOXPhxtxThs3X7A/rB3zZj8AECwCeM83s
fJl/1NGC616h7ChRcRPVWS0=
=Ku2M
-----END PGP SIGNATURE-----

--==_Exmh_1798891183P--
