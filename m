Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267006AbUBGRsp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 12:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267007AbUBGRsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 12:48:45 -0500
Received: from h80ad2633.async.vt.edu ([128.173.38.51]:23430 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S267006AbUBGRs3 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 12:48:29 -0500
Message-Id: <200402071748.i17HmIBw023631@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: Unknown symbol _exit when compiling VMware vmmon.o module 
In-Reply-To: Your message of "Sat, 07 Feb 2004 18:40:16 +0100."
             <1076175615.798.9.camel@teapot.felipe-alfaro.com> 
From: Valdis.Kletnieks@vt.edu
References: <1076175615.798.9.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-416470388P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 07 Feb 2004 12:48:18 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-416470388P
Content-Type: text/plain; charset=us-ascii

On Sat, 07 Feb 2004 18:40:16 +0100, Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>  said:
> Hi!
> 
> After installing VMware Workstation 4.5.0-7174 and running
> vmware-config.pl, I get the following error when trying to insert
> vmmon.ko into the kernel:
> 
> vmmon: Unknown symbol _exit
> 
> What can I use instead of _exit(code) inside a module?

panic()? (Where would the kernel _exit() *TO*?)

I think you misbuilt the kernel module...



--==_Exmh_-416470388P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAJSTicC3lWbTT17ARAu6VAJ4vDQWiikvDNhR9drJzjE46QYxHAQCgvzsf
rhlMcxr6fqm974Xgo4HAqIo=
=Q32p
-----END PGP SIGNATURE-----

--==_Exmh_-416470388P--
