Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbVEXH34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbVEXH34 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 03:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVEXH34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 03:29:56 -0400
Received: from mail.dvmed.net ([216.237.124.58]:21709 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261414AbVEXH3p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 03:29:45 -0400
Message-ID: <4292D7E1.80601@pobox.com>
Date: Tue, 24 May 2005 03:29:37 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, Netdev <netdev@oss.sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [git patches] 2.6.x net driver updates
References: <4292BA66.8070806@pobox.com> <Pine.LNX.4.58.0505232253160.2307@ppc970.osdl.org> <4292C8EF.3090307@pobox.com> <Pine.LNX.4.58.0505232343260.2307@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505232343260.2307@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 24 May 2005, Jeff Garzik wrote:
> 
>>You are getting precisely the same thing you got under BitKeeper:  pull 
>>from X, you get my tree, which was composed from $N repositories.  The 
>>tree you pull was created by my running 'bk pull' locally $N times.
> 
> 
> No. Under BK, you had DIFFERENT TREES.
> 
> What does that mean? They had DIFFERENT NAMES.
> 
> Which meant that the commit message was MEANINGFUL.

Ok, I'll fix the commit message.

As for different trees, I'm afraid you've written something that is _too 
useful_ to be used in that manner.

Git has brought with it a _major_ increase in my productivity because I 
can now easily share ~50 branches with 50 different kernel hackers, 
without spending all day running rsync.  Suddenly my kernel development 
is a whole lot more _open_ to the world, with a single "./push".  And 
it's awesome.

That wasn't possible before with BitKeeper, just due to sheer network 
overhead of 50 trees.  With BitKeeper, the _only_ thing that kernel 
hackers and users could get from me is a mush tree with everything 
merged into a big 'ALL' repository.

So I'll continue to be the oddball, because more people can work in 
parallel with me that way.  I'll just have to make sure the commit 
messages look right to you.

	Jeff


