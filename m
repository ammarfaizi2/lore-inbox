Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274874AbTHFDGy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 23:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274876AbTHFDGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 23:06:54 -0400
Received: from h80ad2506.async.vt.edu ([128.173.37.6]:23168 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S274874AbTHFDGw (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 23:06:52 -0400
Message-Id: <200308060306.h7636k5m003563@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5/2.6 NVidia (was Re: 2.4 vs 2.6 ver# 
In-Reply-To: Your message of "Tue, 05 Aug 2003 22:53:57 EDT."
             <200308052253.57257.gene.heskett@verizon.net> 
From: Valdis.Kletnieks@vt.edu
References: <200308051041.08078.gene.heskett@verizon.net> <200308051807.00179.gene.heskett@verizon.net> <200308060208.h7628w5m002801@turing-police.cc.vt.edu>
            <200308052253.57257.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1913808319P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 05 Aug 2003 23:06:46 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1913808319P
Content-Type: text/plain; charset=us-ascii

On Tue, 05 Aug 2003 22:53:57 EDT, Gene Heskett said:

> >10) 'make install' to put the /usr/lib parts in place.
> 
> check, its rather verbose, even complained about something but I 
> didn't capture it :(

This is almost certainly the cause of...

> >11) Start X in the usual manner - you've probably got an XFconfig
> > file with the right NVidia pieces in it already (or you'd not be
> > asking ;)
> 
> check.  Just one problem, went to black screen about the time the NV 
> logo should have popped up, and locked the machine up tight, had to 
> use the hardware reset button.

this hang here.  Things to check:

1) what it complained about when doing the 'make install' of the userspace.
2) What /var/log/XFree86.log (or wherever your X server output goes) says - it's
usually pretty good about logging what it's upset about.
3) Make sure you have a sane setting for "Option NvAGP" in your XF86Config that
matches what your kernel has.  It's documented in Appendix D of the README....


--==_Exmh_1913808319P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/MHDFcC3lWbTT17ARAkOzAJ9xynnBGp1QMp4NqN/8bRMXeTzeVgCeJAt8
12/+VNsslTHQWAbP/b5hgcc=
=5k10
-----END PGP SIGNATURE-----

--==_Exmh_1913808319P--
