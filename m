Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262340AbSI1WaL>; Sat, 28 Sep 2002 18:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262342AbSI1WaL>; Sat, 28 Sep 2002 18:30:11 -0400
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:15247 "EHLO
	completely") by vger.kernel.org with ESMTP id <S262340AbSI1WaL>;
	Sat, 28 Sep 2002 18:30:11 -0400
From: Ryan Cumming <ryan@completely.kicks-ass.org>
To: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger@clusterfs.com>,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [BK PATCH] Add ext3 indexed directory (htree) support
Date: Sat, 28 Sep 2002 15:35:27 -0700
User-Agent: KMail/1.4.7-cool
References: <E17uINs-0003bG-00@think.thunk.org> <20020928141330.GA653@think.thunk.org> <20020928141841.GB653@think.thunk.org>
In-Reply-To: <20020928141841.GB653@think.thunk.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="big5"
Content-Transfer-Encoding: 8bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209281535.30061.ryan@completely.kicks-ass.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On September 28, 2002 07:18, Theodore Ts'o wrote:
> Oh, one other thing.  I'm pretty sure the rest of the errors you saw
> were a result of the fact that you had your filesystem set to remount
> the filesystem read-only after running into errors.  When the error
> was detected, all existing updates to the filesystem are aborted (to
> minimize damage to the filesystem), and that can leave the filesystem
> in a somewhat inconsistent state, although nothing which e2fsck
> shouldn't be able to fix.
The loopback filesystem was set to continue on errors. The only things fsck 
noticed were the short directory entries and unattached inodes. It actually 
tried to connect lost+found to lost+found, BTW ;)

- -Ryan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9li6yLGMzRzbJfbQRAtn2AKCUoXTYKuVMkfB17wd4RWua0YtTmgCfV+Uh
Gg//dy/RviPA5LWvpfDYQAw=
=lno1
-----END PGP SIGNATURE-----
