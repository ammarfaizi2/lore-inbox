Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267295AbRG0PF2>; Fri, 27 Jul 2001 11:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267602AbRG0PFS>; Fri, 27 Jul 2001 11:05:18 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:31752 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267643AbRG0PFE>; Fri, 27 Jul 2001 11:05:04 -0400
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
To: reiser@namesys.com (Hans Reiser)
Date: Fri, 27 Jul 2001 16:06:16 +0100 (BST)
Cc: menion@srci.iwpsd.org (Joshua Schmidlkofer),
        linux-kernel@vger.kernel.org (kernel)
In-Reply-To: <no.id> from "Hans Reiser" at Jul 27, 2001 06:55:09 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Q9Bw-0005q5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> Don't use RedHat with ReiserFS, they screw things up so many ways.....
> For instance, they compile it with the wrong options set, their boot scripts are wrong, they just
> shovel software onto the CD.

Sorry Hans you can rant all you like but you know you are wrong on most
of that. RH did weeks of stress testing on multiple systems up to 8Gb 8 way
and didn't ship until we stopped seeing corruption problems with the mm/fs
code. 

That test suite caught bugs in kernel revisions other vendors shipped
blindly to their customers without fixing.

That is hardly shovelling software onto the CD.

> Actually, I am curious as to exactly how they manage to make ReiserFS boot longer than ext2.  Do
> they run fsck or what?

No. The only thing I can think of that might slow it is that we build with
the reiserfs paranoia/sanity checks on. Thats because at the time 7.1 was
done the kernel list was awash with reiserfs bug reports and Chris Mason
tail recursion bug patch of the week.

That might be something to check to get a fair comparison

Alan
