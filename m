Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137193AbREKSA4>; Fri, 11 May 2001 14:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137196AbREKSAq>; Fri, 11 May 2001 14:00:46 -0400
Received: from idiom.com ([216.240.32.1]:63500 "EHLO idiom.com")
	by vger.kernel.org with ESMTP id <S137193AbREKSAf>;
	Fri, 11 May 2001 14:00:35 -0400
Message-ID: <3AFBC643.42631F5C@namesys.com>
Date: Fri, 11 May 2001 04:00:20 -0700
From: Hans Reiser <reiser@namesys.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14cl i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: hps@intermeta.de, linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: [reiserfs-dev] Re: reiserfs, xfs, ext2, ext3
In-Reply-To: <E14yH0c-0001Q8-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> > Are you referring to Neil Brown's nfs operations patch as being as ugly as
> > hell, or something else?  Just want to understand what you are saying before
> > arguing.....
>
> Andi has sent me some stuff to look at. He listed four implementations and I've
> only seen two of them

did you see an implementation which adds operations to VFS and is written by Neil
Brown (with reiserfs portions by Chris and Nikita)?

>
>
> > NFS is ugly as hell, and we just try to conform to whatever is the latest trend
> > expected to be accepted since I really don't care so long as it works and
> > doesn't uglify ReiserFS more than necessary.  If you have another approach, one
> > that is less ugly, please let us know.  This is the first I have heard someone
>
> Oh believe me we agree in great detail where the -problem- is. Unfortunately
> the spec is kind of stuck.  Its finding a minimally invasive solution for 2.4
> pending fixing it properly in 2.5
>
> Alan

Tell us what to code for, and so long as it doesn't involve looking up files by
their 32 bit inode numbers we'll probably be happy to code to it.  The Neil Brown
stuff is already coded for though.

Hans

