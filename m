Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316103AbSEJUCt>; Fri, 10 May 2002 16:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316104AbSEJUCs>; Fri, 10 May 2002 16:02:48 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:13516 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S316103AbSEJUCp>;
	Fri, 10 May 2002 16:02:45 -0400
Date: Fri, 10 May 2002 16:02:42 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jan Harkes <jaharkes@cs.cmu.edu>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        trond.myklebust@fys.uio.no, reiserfs-dev@namesys.com
Subject: Re: [PATCH] iget_locked [4/6]
In-Reply-To: <20020510160757.GE18065@ravel.coda.cs.cmu.edu>
Message-ID: <Pine.GSO.4.21.0205101601310.19226-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 May 2002, Jan Harkes wrote:

> 
> Now that we have no more users of iget4 we can kill the function and the
> associated read_inode2 callback (i.e. the 'reiserfs specific hack').
> 
> Document iget5_locked as the replacement for iget4 in filesystems/porting.

OK with me, but I suspect that function name is going to make Linus
unhappy.  And no, I have no better suggestions right now.

