Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from old-vger ([199.183.24.235]:10255 "EHLO unused")
	by vger.kernel.org with ESMTP id <S262939AbREMR3Y>;
	Sun, 13 May 2001 13:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143363AbREKTH6>; Fri, 11 May 2001 15:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143366AbREKTHx>; Fri, 11 May 2001 15:07:53 -0400
Received: from idiom.com ([216.240.32.1]:57870 "EHLO idiom.com")
	by vger.kernel.org with ESMTP id <S143373AbREKTHd>;
	Fri, 11 May 2001 15:07:33 -0400
Message-ID: <3AFC385C.CE9BD596@namesys.com>
Date: Fri, 11 May 2001 12:07:08 -0700
From: Hans Reiser <reiser@namesys.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14cl i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, hps@intermeta.de,
        linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: [reiserfs-dev] Re: reiserfs, xfs, ext2, ext3
In-Reply-To: <200105111850.f4BIolB503014@saturn.cs.uml.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" wrote:

> Hans Reiser writes:
>
> > Tell us what to code for, and so long as it doesn't involve looking
> > up files by their 32 bit inode numbers we'll probably be happy to
> > code to it.  The Neil Brown stuff is already coded for though.
>
> Next time around, when you update the on-disk format, how about
> allowing for such a thing?
>
> You could have a tree that maps from inode number to whatever
> you need to find a file. This shouldn't affect much more than
> file creation and deletion. Maybe it will allow for a more
> robust fsck as well, helping to justify the cost.
>
> It would be really nice to be able to find all filenames that
> refer to a given inode number.

It would have a significant performance impact and use disk space.

Hans

