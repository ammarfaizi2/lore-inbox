Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270421AbTGSRqz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 13:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270423AbTGSRqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 13:46:54 -0400
Received: from h80ad2559.async.vt.edu ([128.173.37.89]:7831 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S270421AbTGSRqq (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 13:46:46 -0400
Message-Id: <200307191801.h6JI1VbF012692@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Bernardo Innocenti <bernie@develer.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] fix include/linux/sysctl.h for userland 
In-Reply-To: Your message of "Sat, 19 Jul 2003 19:52:35 +0200."
             <200307191952.35499.bernie@develer.com> 
From: Valdis.Kletnieks@vt.edu
References: <200307191952.35499.bernie@develer.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-462566367P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 19 Jul 2003 14:01:31 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-462566367P
Content-Type: text/plain; charset=us-ascii

On Sat, 19 Jul 2003 19:52:35 +0200, Bernardo Innocenti said:
> 
> Include linux/compiler.h in include/linux/sysctl.h. Needed to get __user
> defined when C library uses this header (ie: no __KERNEL__).

Umm... shouldn't this be in the glibc-kernheaders version of sysctl.h
that ends up in /usr/include rather than the kernel version?

--==_Exmh_-462566367P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/GYd6cC3lWbTT17ARAmD3AJwL7wrVIN8++etvhutSqx+co0I9QwCfXTHZ
Ze77v5DzVzuVr8qDG13sf2A=
=KIec
-----END PGP SIGNATURE-----

--==_Exmh_-462566367P--
