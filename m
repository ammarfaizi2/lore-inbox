Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267770AbTGLGjr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 02:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267771AbTGLGjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 02:39:47 -0400
Received: from h80ad249b.async.vt.edu ([128.173.36.155]:4736 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S267770AbTGLGjq (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 02:39:46 -0400
Message-Id: <200307120654.h6C6sJMQ001146@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Joe Thornber <thornber@sistina.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 2/2] dm: v4 ioctl interface 
In-Reply-To: Your message of "Fri, 11 Jul 2003 11:00:41 BST."
             <20030711100041.GC9111@fib011235813.fsnet.co.uk> 
From: Valdis.Kletnieks@vt.edu
References: <20030711095739.GA9111@fib011235813.fsnet.co.uk>
            <20030711100041.GC9111@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-41755464P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 12 Jul 2003 02:54:18 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-41755464P
Content-Type: text/plain; charset=us-ascii

On Fri, 11 Jul 2003 11:00:41 BST, Joe Thornber said:

> If you want to use v4 you will have to update your tools
> (libdevmapper/lvm).  The latest tools at the time of writing are:
> 
> dmsetup + libdevmapper + replacement kernel patches for 2.4.20 & 2.4.21:
>   ftp://ftp.sistina.com/pub/LVM2/device-mapper/device-mapper-testing-new-vers
ion4-interface.tgz
> 
> Updated LVM2 tools to work with the above:
>   ftp://ftp.sistina.com/pub/LVM2/tools/LVM2.0-testing.tgz

The v4 interface does work with the 64-bit kdev_t patch in 2.5.75-mm1, fixing the
problems I noted the other day (I already had the updated libdevmapper and LVM2,
was missing the 2 patches for the v4 ioctl).

--==_Exmh_-41755464P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/D7CacC3lWbTT17ARAjv6AKCLWUURk6FxzC2djqWAf3XSqDUSFQCghxXs
U2F76AOrYh4MLo8pNt9N+s4=
=OP0j
-----END PGP SIGNATURE-----

--==_Exmh_-41755464P--
