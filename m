Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266691AbUBFVnt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 16:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266752AbUBFVnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 16:43:49 -0500
Received: from h80ad2503.async.vt.edu ([128.173.37.3]:64902 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266691AbUBFVnm (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 16:43:42 -0500
Message-Id: <200402062135.i16LZIih022001@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Alex Davis <alex14641@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Issues with linux-2.6.2 
In-Reply-To: Your message of "Fri, 06 Feb 2004 13:22:05 PST."
             <20040206212205.46151.qmail@web40501.mail.yahoo.com> 
From: Valdis.Kletnieks@vt.edu
References: <20040206212205.46151.qmail@web40501.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1776367970P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 06 Feb 2004 16:35:18 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1776367970P
Content-Type: text/plain; charset=us-ascii

On Fri, 06 Feb 2004 13:22:05 PST, Alex Davis <alex14641@yahoo.com>  said:
> I have a few issues with 2.6.2. Ths first issue is when upgrading from 2.4, I
 had to create 
> the symlinks:
> 
>    ln -s /usr/include/asm /usr/src/linux/include/asm-i386
>    ln -s /usr/include/asm-generic /usr/src/linux/include/asm-generic
> 
> This requirement was not mentioned in any documentation I could find.

That requirement isn't mentioned because it's an *anti*-requirement.

Don't Do That.  Install what your distro uses for 'glibc-kernheaders' instead.

> The second issue is when trying to build util-linux-2.11z I get the following error:
> 
> cc -pipe -O2 -mcpu=i486 -fomit-frame-pointer -I../lib -Wall -Wmissing-prototypes
> -Wstrict-prototypes -I/usr/include/ncurses -DNCH=0   -D_FILE_OFFSET_BITS=64 -DSBINDIR=\"/sbin\"
> -DUSRSBINDIR=\"/usr/sbin\" -DLOGDIR=\"/var/log\" -DVARPATH=\"/var\"
> -DLOCALEDIR=\"/usr/share/locale\" -O2  -s  blockdev.c   -o blockdev
> blockdev.c:70: error: parse error before '[' token

See? We *TOLD* you not to do that. :)

--==_Exmh_-1776367970P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAJAiWcC3lWbTT17ARAnn0AJ9dfRnO1S+NgnwG84Vi20PkA/3BlQCggl9R
ncoQ/0ZJfto1CEB8mkabhB0=
=z6uU
-----END PGP SIGNATURE-----

--==_Exmh_-1776367970P--
