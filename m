Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262677AbSI1BlD>; Fri, 27 Sep 2002 21:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262678AbSI1BlD>; Fri, 27 Sep 2002 21:41:03 -0400
Received: from [24.77.26.115] ([24.77.26.115]:46985 "EHLO completely")
	by vger.kernel.org with ESMTP id <S262677AbSI1BlC>;
	Fri, 27 Sep 2002 21:41:02 -0400
From: Ryan Cumming <ryan@completely.kicks-ass.org>
To: Andreas Dilger <adilger@clusterfs.com>, "Theodore Ts'o" <tytso@mit.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] Add ext3 indexed directory (htree) support
Date: Fri, 27 Sep 2002 18:46:14 -0700
User-Agent: KMail/1.4.7-cool
References: <E17uINs-0003bG-00@think.thunk.org> <20020927041234.GS22795@clusterfs.com> <200209271820.41906.ryan@completely.kicks-ass.org>
In-Reply-To: <200209271820.41906.ryan@completely.kicks-ass.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="big5"
Content-Transfer-Encoding: 8bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209271846.19750.ryan@completely.kicks-ass.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On September 27, 2002 18:20, Ryan Cumming wrote:
> Okay, got another one:
> "EXT3-fs error (device loop(7,0)): ext3_add_entry: bad entry in directory
> #2: rec_len is smaller than minimal - offset=0, inode=0, rec_len=8,
> name_len=0" fsck then reported:
> "Directory inode 2, block 166, offset 0: directory corrupted"
>
> This is while deleteing an old fsstress directory (a full fsck had been
> performed since the last time the fsstress directory had been touched)
> while running a few instances of the attached program.

You can get a 6.1MiB bzip2'ed image of the broken filesystem (fsck hasn't 
touched this copy) at:
http://completely.kicks-ass.org/image-broken.ext3.bz2

- -Ryan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9lQnrLGMzRzbJfbQRAqhBAJ9EuJ6OhH13W1B4LWjnj8IhyIMX6QCgobUt
gphiPMuRMSdewLp+67phv4g=
=10yO
-----END PGP SIGNATURE-----
