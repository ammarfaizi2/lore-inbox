Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278703AbRJXS2P>; Wed, 24 Oct 2001 14:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278705AbRJXS2F>; Wed, 24 Oct 2001 14:28:05 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:29197 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S278703AbRJXS16>; Wed, 24 Oct 2001 14:27:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: David Lang <david.lang@digitalinsight.com>
Subject: Re: VM
Date: Wed, 24 Oct 2001 20:29:26 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Keith Owens <kaos@ocs.com.au>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0110240936160.14041-100000@dlang.diginsite.com>
In-Reply-To: <Pine.LNX.4.40.0110240936160.14041-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011024182831Z16142-698+189@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On October 24, 2001 06:50 pm, David Lang wrote:
> those were the files that his patches were changing, since then we also
> have had linus, rik and alan making changes in the various trees.
> 
> are you willing to bet that the only changes in those files are related to
> the VM system changes and that there are no other -ac related changes in
> those files due to the other ac changes? without someone who really
> understands the rik VM I wouldn't trust breaking them out of the -ac
> tree and the same thing goes for the aa VM and the linus tree (to add that
> into the ac tree)
> 
> as I see it this requires a few steps.
> 
> 1. linus and alan agree to implement such a thing (which includes
> alanbeing willing to track the appropriate differences)

My advice is: don't try to waste Linus's or Alan's time on this.  Just make 
the patch, it isn't that hard.  Just post it, and if you get it partly wrong 
Rik and/or Andrea will be sure to tell you.

> 2. rik and/or aa and/or alan seperate out the rik VM from the ac tree and
> submit it to linus.
> 
> 3. rik and/or aa and/or alan seperate out the aa VM from the linus tree
> and submit it to alan.
> 
> it's a lot of work to get it setup this way, and it does duplicate a bunch
> of files that could get out of sync if not carefully managed but it's
> about the only way that I can see people able to test just the different
> VM systems.

So why are you asking developers who have plenty of other things to do, to do 
that work?

> now if one of the above four states that there are files (or directories)
> that are only the VM system and it is as simple as swapping out everything
> in those files between the linus and ac trees then steps 2&3 get much
> simpler.

Do it whatever way you want, that's why you have the source.  I'd suggest 
'diff', starting with the files in Andrea's list.  Then edit the patch by 
hand, removing the chunks that obviously aren't related.

--
Daniel
