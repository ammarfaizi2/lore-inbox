Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316387AbSEOOz3>; Wed, 15 May 2002 10:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316388AbSEOOz2>; Wed, 15 May 2002 10:55:28 -0400
Received: from 216-42-72-147.ppp.netsville.net ([216.42.72.147]:43925 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S316387AbSEOOzZ>; Wed, 15 May 2002 10:55:25 -0400
Subject: Re: [reiserfs-dev] [PATCH] [BK] ReiserFS cleanups (third sending,
	but two fixes added now)
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
In-Reply-To: <200205151424.g4FEOm115147@namesys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 15 May 2002 10:54:31 -0400
Message-Id: <1021474471.14986.700.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-05-15 at 10:24, Hans Reiser wrote:
> 
> You can pull the changes from our public server at
> 
> bk://thebsh.namesys.com/bk/reiser3-linux-2.5
> 
> Plain text patches are at the end of messages.
> 
> Some of the changesets contain cleanups regarding labeling the code
> ownership correctly.  Let me know if you want more details.
> 
> 5 bugs were fixed: 
> 
> * journal replay from wrong device 
> 
> * deadlock with iput. (will duplicate patch sent separately to you by
>   Mason, don't know why he sent it separately)

Because the one in the namesys tree is almost unreadable.  It is
intermixed with 16 other changes (in a single changeset) then modified
by incremental fixes and merge sets.  The bug fix is complex enough as
it is, the namesys version is very difficult to verify.

Please let Oleg and I work out an actual coherent group of changesets
instead of this mess.

-chris


