Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264334AbTLETKF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 14:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264339AbTLETKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 14:10:05 -0500
Received: from h80ad26ab.async.vt.edu ([128.173.38.171]:21902 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264334AbTLETJz (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 14:09:55 -0500
Message-Id: <200312051909.hB5J9fps019007@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause? 
In-Reply-To: Your message of "Fri, 05 Dec 2003 10:44:02 PST."
             <3FD06172.28193.4801EF18@localhost> 
From: Valdis.Kletnieks@vt.edu
References: <MDEHLPKNGKAHNMBLJOLKMEIDIHAA.davids@webmaster.com>
            <3FD06172.28193.4801EF18@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_307326300P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 05 Dec 2003 14:09:40 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_307326300P
Content-Type: text/plain; charset=us-ascii

On Fri, 05 Dec 2003 10:44:02 PST, Kendall Bennett said:

> Right, and by extension of the same argument you cannot use kernel 
> headers to create non-GPL'ed binaries that run IN USER SPACE! Just 
> because a program runs in user space does not mean that it is not a 
> dervived work. 

That's a bad idea for technical reasons too - how often do we have to tell
people not to use kernel headers from userspace?  glibc-kernheaders (and whatever
non-RedHat boxes call it) exists for a reason.

Interestingly enough, at least on my Fedora box, 'rpm -qi' reports glibc as LGPL,
but glibc-kernheaders as GPL, which seems right to me - linking against glibc gives
the LGPL semantics as we'd want, but forces userspace that's poking in the kernel
to be GPL as a derived work....

--==_Exmh_307326300P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/0Nf0cC3lWbTT17ARArreAKDUUQEb4qc8NIjvQaAtLOAVfxW02wCgvmR8
F5Oj79D2LVAkgJTT73gtMU4=
=2ppb
-----END PGP SIGNATURE-----

--==_Exmh_307326300P--
