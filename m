Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264356AbUAVEjc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 23:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264376AbUAVEjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 23:39:32 -0500
Received: from h80ad2664.async.vt.edu ([128.173.38.100]:30593 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264356AbUAVEjb (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 23:39:31 -0500
Message-Id: <200401220439.i0M4dPKJ008274@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: sclark46@earthlink.net
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.2-rc1 
In-Reply-To: Your message of "Wed, 21 Jan 2004 23:32:59 EST."
             <400F527B.3070505@earthlink.net> 
From: Valdis.Kletnieks@vt.edu
References: <400F527B.3070505@earthlink.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-610853172P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 21 Jan 2004 23:39:25 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-610853172P
Content-Type: text/plain; charset=us-ascii

On Wed, 21 Jan 2004 23:32:59 EST, Stephen Clark <stephen.clark@earthlink.net>  said:
> Hello,
> 
> I am running RH9 with the latest kernel and get the following when I try 
> to use rpm:
> rpm -qa
> rpmdb: unable to join the environment
> error: db4 error(11) from dbenv->open: Resource temporarily unavailable
> error: cannot open Packages index using db3 - Resource temporarily 
> unavailable (11)
> error: cannot open Packages database in /var/lib/rpm
> no packages

1) Later releases of RPM (from Fedora) have this fixed.  Fedora-development
currently has rpm-4.3-0.7.  Pre-reqs are your problem. :)

2) 'LD_ASSUME_KERNEL=2.4.1 rpm -qa' also works around it.

--==_Exmh_-610853172P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAD1P8cC3lWbTT17ARAkmRAJ4gtLbng5kG3EaiSBaT2RbA7Jb8zgCfT+cd
Dw7chMgYehB5Ap2rB4k6qIw=
=M+l3
-----END PGP SIGNATURE-----

--==_Exmh_-610853172P--
