Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261643AbVBHTgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbVBHTgi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 14:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVBHTgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 14:36:37 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:15370 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261643AbVBHTg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 14:36:28 -0500
Message-Id: <200502081935.j18JZxYB022227@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: out-of-line x86 "put_user()" implementation 
In-Reply-To: Your message of "Mon, 07 Feb 2005 17:20:06 PST."
             <Pine.LNX.4.58.0502071717310.2165@ppc970.osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.58.0502062212450.2165@ppc970.osdl.org> <20050207114415.GA22948@elte.hu>
            <Pine.LNX.4.58.0502071717310.2165@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1107891359_3999P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 08 Feb 2005 14:35:59 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1107891359_3999P
Content-Type: text/plain; charset=us-ascii

On Mon, 07 Feb 2005 17:20:06 PST, Linus Torvalds said:

> I'm not going to put this into 2.6.11, since I worry about compiler 
> interactions, but the more people who test it anyway, the better.

Well, since I'm a known glutton for punishment. ;)

a 2.6.11-rc3-RT tree I had handy from last night shows about a 0.5% size reduction:
   text    data     bss     dec     hex filename
3033417  680824  436188 4150429  3f549d vmlinux.before
3017443  681068  436188 4134699  3f172b vmlinux

Am running a 2.6.11-rc3-mm1-RT kernel with it applied, and have probably 40-50
hours of uptime on it with no noticed issues on a Dell laptop.  Sorry, don't
have any comparative performance stats...

--==_Exmh_1107891359_3999P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCCRSfcC3lWbTT17ARAg44AKDvDeL42ttlWICj2UcoYzptKh6qRQCgzHFW
vDaBQUdaPn3zvaVRpObMQT0=
=WPCP
-----END PGP SIGNATURE-----

--==_Exmh_1107891359_3999P--
