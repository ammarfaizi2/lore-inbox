Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261889AbSI3B1b>; Sun, 29 Sep 2002 21:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261893AbSI3B1b>; Sun, 29 Sep 2002 21:27:31 -0400
Received: from h108-129-61.datawire.net ([207.61.129.108]:37858 "EHLO
	mail.datawire.net") by vger.kernel.org with ESMTP
	id <S261889AbSI3B1a> convert rfc822-to-8bit; Sun, 29 Sep 2002 21:27:30 -0400
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
To: Dave Jones <davej@codemonkey.org.uk>
Subject: Compile problems 2.5.39-dj2
Date: Sun, 29 Sep 2002 21:33:00 -0400
User-Agent: KMail/1.4.6
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209292133.07884.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

fs/built-in.o: In function `proc_pid_stat':
fs/built-in.o(.text+0x294fb): undefined reference to `jiffies_64_to_clock_t'
fs/built-in.o: In function `kstat_read_proc':
fs/built-in.o(.text+0x2abc3): undefined reference to `jiffies_64_to_clock_t'
fs/built-in.o(.text+0x2ac46): undefined reference to `jiffies_64_to_clock_t'
make: *** [.tmp_vmlinux] Error 1

Missing jiffies_64_to_clock_t function ;)

Shawn.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9l6nRePHb7Xli5GsRAgzqAJ0aeLDXpRWQTySMYZGehcfS5ZR8qgCeODJA
rfOTcFoYM6TZBCfomTPurfE=
=4Ewh
-----END PGP SIGNATURE-----

