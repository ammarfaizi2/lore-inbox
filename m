Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314278AbSEYIkW>; Sat, 25 May 2002 04:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314277AbSEYIkV>; Sat, 25 May 2002 04:40:21 -0400
Received: from squeaker.ratbox.org ([63.216.218.7]:268 "EHLO
	squeaker.ratbox.org") by vger.kernel.org with ESMTP
	id <S314278AbSEYIkU>; Sat, 25 May 2002 04:40:20 -0400
Date: Sat, 25 May 2002 04:40:14 -0400 (EDT)
From: Aaron Sethman <androsyn@ratbox.org>
To: linux-kernel@vger.kernel.org
Subject: RT Sigio broken on 2.4.19-pre8
Message-ID: <Pine.LNX.4.44.0205250433050.9132-100000@simon.ratbox.org>
X-GPG-FINGRPRINT: 1024D/D4DE2553 0E60 59B5 60DA 2FD3 F6F5  27A3 6CD2 21AD D4DE 2553
X-GPG-PUBLIC_KEY: http://squeaker.ratbox.org/androsyn.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Using the Dan Kegel's Poller_bench utility I noticed that RT SIGIO is not
working on 2.4.19-pre8.  Basically sigtimedwait() is always returning
SIGIO.  Note that 2.4.18 works fine.

Regards,

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8703wbNIhrdTeJVMRAlcgAJ9Bga4Y9Dj+YP1jGq6iQAtWHsTo7gCfYtC0
MrGouDbev2gSs2nymlXNVuw=
=R0yb
-----END PGP SIGNATURE-----

