Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261448AbSIZTDo>; Thu, 26 Sep 2002 15:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261449AbSIZTDn>; Thu, 26 Sep 2002 15:03:43 -0400
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:4480 "EHLO
	completely") by vger.kernel.org with ESMTP id <S261448AbSIZTDn>;
	Thu, 26 Sep 2002 15:03:43 -0400
From: Ryan Cumming <ryan@completely.kicks-ass.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [BK PATCH] Add ext3 indexed directory (htree) support
Date: Thu, 26 Sep 2002 12:08:54 -0700
User-Agent: KMail/1.4.7-cool
Cc: linux-kernel@vger.kernel.org
References: <E17uINs-0003bG-00@think.thunk.org> <200209260041.59855.ryan@completely.kicks-ass.org> <20020926154217.GA10551@think.thunk.org>
In-Reply-To: <20020926154217.GA10551@think.thunk.org>
MIME-Version: 1.0
Content-Description: clearsigned data
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="big5"
Content-Transfer-Encoding: 8bit
Message-Id: <200209261208.59020.ryan@completely.kicks-ass.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On September 26, 2002 08:42, Theodore Ts'o wrote:
> Hmm... I just tried biult 2.4.19 with the ext3 patch on my UP P3
> machine, using GCC 3.2, and I wasn't able to replicate your problem.
> (This was using Debian's gcc 3.2.1-0pre2 release from testing.)
The whole GCC 3.2 thing was a red herring. Although it ran stable for a few 
hours last night (cvs up, compiled a kernel, etc), the filesystem was once 
again read-only when I came to check my mail this morning.

The interesting fsck errors this time were:
245782 was part of the orphaned inode list FIXED
245792 was part of the orphaned inode list FIXED
245797...

245782,245792 don't exist according to ncheck.

- -Ryan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9k1tKLGMzRzbJfbQRAj/AAJ9/yPnuSPF3kUTlwFt2wF2JFSJlJwCfc39B
ZKxRtt+hpDHQ7XuiyAYkpNM=
=MHW8
-----END PGP SIGNATURE-----
