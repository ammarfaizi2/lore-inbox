Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316684AbSHJJK5>; Sat, 10 Aug 2002 05:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316695AbSHJJK5>; Sat, 10 Aug 2002 05:10:57 -0400
Received: from zok.SGI.COM ([204.94.215.101]:28578 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S316684AbSHJJK4>;
	Sat, 10 Aug 2002 05:10:56 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: kdb@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: kdb v2.3 i386 updates for kernels 2.4.18 and 2.4.19 
In-Reply-To: Your message of "Fri, 09 Aug 2002 16:52:18 +1000."
             <1076.1028875938@kao2.melbourne.sgi.com> 
Date: Sat, 10 Aug 2002 19:14:33 +1000
Message-ID: <11934.1028970873@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

Updated files in ftp://oss.sgi.com/projects/kdb/download/v2.3/

  kdb-v2.3-2.4.18-common-2.bz2
  kdb-v2.3-2.4.18-i386-3.bz2
  kdb-v2.3-2.4.18-ia64-020722-2.bz2

  kdb-v2.3-2.4.19-common-2.bz2
  kdb-v2.3-2.4.19-i386-3.bz2

These add support for consoles using memory mapped IO instead of
inb/outb, based on a patch by David Mosberger.  Primarily for ia64 zx1
serial i/o but it should work on other memory mapped consoles.

NOTE: These patches go together.

      kdb-v2.3-2.4.18-i386-3 and kdb-v2.3-2.4.18-ia64-020722-2 need
      kdb-v2.3-2.4.18-common-2, and vice versa.

      kdb-v2.3-2.4.19-i386-3 needs kdb-v2.3-2.4.19-common-2, and vice
      versa.

If you get undefined variables kdb_port or kdb_serial then you have
mixed the wrong patches.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE9VNl3i4UHNye0ZOoRAt+UAKClOLtJ+m3uB5KwAGsJsHCPYNbpUgCfXywB
VKjKGpljLryFI2WlNYh8ei8=
=2/Cx
-----END PGP SIGNATURE-----

