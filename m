Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265488AbUAKATP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 19:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265493AbUAKATP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 19:19:15 -0500
Received: from h80ad254f.async.vt.edu ([128.173.37.79]:31618 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265488AbUAKATN (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 19:19:13 -0500
Message-Id: <200401110019.i0B0J2Ld014059@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Job 317 <job317@mailvault.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: HELP!! 2.6.x build problem with make xconfig 
In-Reply-To: Your message of "Sun, 11 Jan 2004 01:00:33 +0100."
             <20040110235440.7962B8400A3@gateway.mailvault.com> 
From: Valdis.Kletnieks@vt.edu
References: <20040110235440.7962B8400A3@gateway.mailvault.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-2004626072P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 10 Jan 2004 19:19:02 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-2004626072P
Content-Type: text/plain; charset=us-ascii

On Sun, 11 Jan 2004 01:00:33 +0100, Job 317 <job317@mailvault.com>  said:

> cd /usr/include
> rm asm linux scsi
> ln -fs /usr/src/linux/include/asm-i386 asm
> ln -fs /usr/src/linux/include/linux linux
> ln -fs /usr/src/linux/include/scsi scsi

Don't do that.

Use what's in the glibc-kernheaders RPM for userspace, and let the kernel
provide its own headers for its use.


--==_Exmh_-2004626072P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAAJZ2cC3lWbTT17ARAos3AJ9rvZ91rjM8f7qJ+/qJvT4JKIlBDwCfQD1v
mSxRSx06xLvdhVf3U0apd5Q=
=h2p1
-----END PGP SIGNATURE-----

--==_Exmh_-2004626072P--
