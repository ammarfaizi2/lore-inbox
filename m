Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137183AbREKRVy>; Fri, 11 May 2001 13:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137185AbREKRVo>; Fri, 11 May 2001 13:21:44 -0400
Received: from idiom.com ([216.240.32.1]:5139 "EHLO idiom.com")
	by vger.kernel.org with ESMTP id <S137183AbREKRVe>;
	Fri, 11 May 2001 13:21:34 -0400
Message-ID: <3AFBBD16.7AC1019C@namesys.com>
Date: Fri, 11 May 2001 03:21:10 -0700
From: Hans Reiser <reiser@namesys.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14cl i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: hps@intermeta.de, linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: reiserfs, xfs, ext2, ext3
In-Reply-To: <E14yFOk-0001GQ-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> > I think with the growing acceptance of ReiserFS in the Linux
> > community, it is tiresome to have to apply a patch again and again
> > just to get working NFS. 2.2 NFS horrors all over again.
>
> The zero copy patches were basically self contained and tested for 6 months.
> The reiserfs NFS hacks are ugly as hell and dont belong in the base kernel.
> There is a difference.
>
> Alan
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Are you referring to Neil Brown's nfs operations patch as being as ugly as
hell, or something else?  Just want to understand what you are saying before
arguing.....

NFS is ugly as hell, and we just try to conform to whatever is the latest trend
expected to be accepted since I really don't care so long as it works and
doesn't uglify ReiserFS more than necessary.  If you have another approach, one
that is less ugly, please let us know.  This is the first I have heard someone
complain, I thought his patch was liked by Linus architecturally and that it
would be going in sometime real soon now (which is why we coded for it).  Can
you articulate why you dislike it in more detail?

Hans

