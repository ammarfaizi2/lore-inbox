Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268951AbRHLEa1>; Sun, 12 Aug 2001 00:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268954AbRHLEaR>; Sun, 12 Aug 2001 00:30:17 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:6928 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S268951AbRHLEaB>;
	Sun, 12 Aug 2001 00:30:01 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 1.1 is available. 
In-Reply-To: Your message of "Sun, 12 Aug 2001 01:03:00 +1000."
             <1904.997542180@ocs3.ocs-net> 
Date: Sun, 12 Aug 2001 14:30:07 +1000
Message-ID: <9479.997590607@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

I have replaced kbuild-2.5-2.4.8-1.bz2 with 2.5-2.4.8-2.bz2 under
http://sourceforge.net/projects/kbuild/, Package kbuild-2.5, download
release 1.1.  The patch is against a clean 2.4.8 kernel.

Changes from -1.

  Update emu10k1/Makefile.in to the full 2.4.8 list of objects.

  Correct a bug that dropped some objects from the build list.

  Rework the generation of assembler offsets from C.  It uses %0
  instead of %c0, RMK says that %c0 does not work reliably on arm.  The
  sample awk code handles %0 and has been cleaned up.  The output to a
  .tmp file followed by compare has been removed, it caused problems
  for make install.  More documentation, including settings for include
  files.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.3 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE7dgZOi4UHNye0ZOoRAj/rAJ48whc56FMuUpf9SIu4n/lwx8XUGACfcT6S
Q34ZBrZfXQKJPjzbyTAQ+g0=
=rAh+
-----END PGP SIGNATURE-----

