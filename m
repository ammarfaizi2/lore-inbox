Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbULXFkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbULXFkv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 00:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbULXFkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 00:40:51 -0500
Received: from h80ad252a.async.vt.edu ([128.173.37.42]:46553 "EHLO
	h80ad252a.async.vt.edu") by vger.kernel.org with ESMTP
	id S261375AbULXFkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 00:40:45 -0500
Message-Id: <200412240540.iBO5ebvF015327@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: selvakumar nagendran <kernelselva@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Intercepting system calls in Linux kernel 2.6.x 
In-Reply-To: Your message of "Thu, 23 Dec 2004 20:45:53 PST."
             <20041224044553.84241.qmail@web60607.mail.yahoo.com> 
From: Valdis.Kletnieks@vt.edu
References: <20041224044553.84241.qmail@web60607.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_256094804P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 24 Dec 2004 00:40:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_256094804P
Content-Type: text/plain; charset=us-ascii

On Thu, 23 Dec 2004 20:45:53 PST, selvakumar nagendran said:
>  In linux kernel 2.6.x, what should we do to intercept
> system calls? When I used sys_call_table from a
> module, it returned the following error 'undefined
> variable sys_call_table'. What is the way to export
> system call table in kernel 2.6.x?

That's generally very deprecated.

What problem are you trying to solve by intercepting system calls? There
may very well be some other way to achieve what you're trying to do...

--==_Exmh_256094804P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBy6vNcC3lWbTT17ARAtPrAJ9dhpRQBAs5tEQvkp7HuE08xWLxlACffSWf
Srz7P6hvfEc8rjbvCCvqXGQ=
=s3jo
-----END PGP SIGNATURE-----

--==_Exmh_256094804P--
