Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262797AbSJLEaj>; Sat, 12 Oct 2002 00:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262799AbSJLEaj>; Sat, 12 Oct 2002 00:30:39 -0400
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:31872 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S262797AbSJLEai> convert rfc822-to-8bit; Sat, 12 Oct 2002 00:30:38 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Contest v0.51 benchmark
Date: Sat, 12 Oct 2002 14:33:59 +1000
User-Agent: KMail/1.4.3
Cc: Cliff White <cliffw@osdl.org>, Paolo Ciarrocchi <ciarrocchi@linuxmail.org>,
       Robinson Maureira Castillo <rmaureira@alumno.inacap.cl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210121434.05130.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I've updated the contest benchmark to v0.51
http://contest.kolivas.net

I've now included the experimental loads I've been posting to lkml.
These added loads are:

read_load: reads a file the size of the physical memory
list_load: lists the entire directory structure
xtar_load: extracts a tar archive of the kernel tree
ctar_load: creates a tar archive of the kernel tree

Note that the tar loads use up a _lot_ of filesystem space and for safety are 
disabled by default. Use -l all to include them in the contest.

Lots of other minor internal changes.

Con.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9p6Y3F6dfvkL3i1gRAgA6AJ9BprWHFBUDkUmlCzl9mHI4lCQspwCgjhyk
dYC79/tUXPZQuBO90LSVjek=
=lAJq
-----END PGP SIGNATURE-----

