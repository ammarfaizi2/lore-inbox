Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266292AbUBLFyJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 00:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266295AbUBLFyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 00:54:08 -0500
Received: from h80ad25b9.async.vt.edu ([128.173.37.185]:9173 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266292AbUBLFyE (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 00:54:04 -0500
Message-Id: <200402120553.i1C5rqpE023727@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Steve G <linux_4ever@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Vfat increases file permissions 
In-Reply-To: Your message of "Wed, 11 Feb 2004 14:44:33 PST."
             <20040211224433.92148.qmail@web9602.mail.yahoo.com> 
From: Valdis.Kletnieks@vt.edu
References: <20040211224433.92148.qmail@web9602.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_872977206P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 12 Feb 2004 00:53:50 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_872977206P
Content-Type: text/plain; charset=us-ascii

On Wed, 11 Feb 2004 14:44:33 PST, Steve G <linux_4ever@yahoo.com>  said:
> In the DOS world, not every file is executable. It uses the file
> extention to decide if the file is executable. A text file is not
> implicitly executable unless it has a .bat file extention.

Welcome to Linux, where files actually have permissions bits.  Of
course, the vfat filesystem doesn't have those bits, so we have to
invent something.  Sanest thing to do is just pretend all vfat
files are mode 0777...

> I am concerned about world writeable, executable files existing
> on my floppies or USB devices that are formatted vfat. This seems
> like a security concern to me.

mount -o noexec,nodev,nosuid /dev/floppy /mnt/floppy



--==_Exmh_872977206P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAKxTucC3lWbTT17ARAjsSAJwL8tVPks2aG0nOGkCT1OuEExphNQCg1P25
n7ttHEAyPpBYW2lIq2pnAB8=
=L8wi
-----END PGP SIGNATURE-----

--==_Exmh_872977206P--
