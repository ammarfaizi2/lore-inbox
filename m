Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129397AbRBVSYT>; Thu, 22 Feb 2001 13:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130820AbRBVSYJ>; Thu, 22 Feb 2001 13:24:09 -0500
Received: from www.wen-online.de ([212.223.88.39]:7434 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130814AbRBVSXs>;
	Thu, 22 Feb 2001 13:23:48 -0500
Date: Thu, 22 Feb 2001 19:23:39 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Adam Schrotenboer <ajschrotenboer@lycosmail.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: linux ac20 patch got error:
In-Reply-To: <3A953C80.9030609@lycosmail.com>
Message-ID: <Pine.LNX.4.33.0102221907270.427-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Feb 2001, Adam Schrotenboer wrote:

> Mike Galbraith wrote:
>
>  > On Wed, 21 Feb 2001, Adam Schrotenboer wrote:
>  >
>  >> A rather incomprehensible message, so let's flesh this out a bit.
>  >>
>  >> Basically the problem occurs when patching linux/fs/reiserfs/namei.c It
>  >> can't find it, presumably due to an error in 2.4.1, where it appears to
>  >> me that reiserfs/ is located off of linux/ not linux/fs/. Simple to fix,
>  >> I guess, though this would appear to mean that Linus made a mistake w/
>  >> 2.4.1 (plz correct me if I'm wrong), though it could also be said that
>  >> this means that Alan diff'd the wrong tree (basically a fixed tree in re
>  >> reiserfs/)
>  >
>  >
>  > A third possibility: an elf/gremlin munged your tree for grins ;-)
>
> maybe I coffed. 8-)
>
>  >
>  > ac20 went in clean here.
>  >
>  > 	-Mike
>
> Granted that this is possible, yet how likely is it that two people
> would come up with the same problem, when they don't even know each
> other. 2nd, this was a fresh tree, i.e. 2.4.0 from tar.bz2, patch to
> 2.4.1, then patch to 2.4.1-ac20, therefore there likely must be
> something else. Maybe a similarly corrupted (shouldn't be possible w/
> bz2, let alone gz) 2.4.1 patch, or some such. Still, given that it was a
> d/l from zeus.kernel.org, it should be ok (short of somebody hacking the
> server. I rarely check the sigs)

Who shot John doesn't matter much.  Bottom line is that your tree was
corrupt.. and now it's likely clean as a whistle ;-)

	-Mike

