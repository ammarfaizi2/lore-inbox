Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263793AbUDPUz5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 16:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbUDPUxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 16:53:55 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:6154 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263733AbUDPUxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 16:53:31 -0400
Date: Fri, 16 Apr 2004 22:50:28 +0200
From: Willy Tarreau <w@w.ods.org>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: SATA support merge in 2.4.27
Message-ID: <20040416205028.GC596@alpha.home.local>
References: <Pine.LNX.4.10.10404160227080.22035-100000@master.linux-ide.org> <Pine.LNX.4.10.10404160259480.22035-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10404160259480.22035-100000@master.linux-ide.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Marcelo,
> 
> You are suggesting that 2.6 is not stable ?  How could that be ?

Andre, ressure me, you were drunk ?

A stable kernel is a kernel in which a new release does not induce 20 rejects
when applying the same patches as on the previous one, and in which you can
confidently upgrade to fix a security issue without worrying that everything
else will break under your feet. I'm really happy that 2.4 *WILL* become
stable with 2.4.27, and probably will be the first 2.4 kernel ready for far
remote deployment. Since about 2.4.23, it has become a lot easier to maintain
up-to-date parallel trees in sync with Marcelo's because of less core changes
all the time, and I really thank him for this progressive feature freeze.
When I'll have a fair insurance that 2.6 does not change so fast, may be I'll
start to think about it. But right now, 2.6 only serves me as a boot loader
in conjunction with Randy's kexec patch. Sad but true.

> Should it not be backported to 2.2 and why not 2.0 ?

I thought you were more aware than that about the number of people still
using 2.0 and 2.2. They are "a lot". What does "a lot" mean ? Well, I think
that there are more people still running production machines on 2.2 and 2.0
than people who have ever used 1.0 or 1.2. And at these times, we considered
that "a lot". I know some people who still install RedHat 6.2 from time to
time. Why do they do this ? certainly because a standard 2.2.26 kernel +
grsecurity offers them enough stability and security to satisfy their needs
and not to have to upgrade every 4 months.

> Necessary? But their is the new and improved called 2.6.
> It is time for the old and lousy to quietly wimper off and die.

I would better say that it's time for the old and stable to live long and
quitely, and for the young baby to slowly discover the desktop world, then
the production world before engaging its reputation on mission-critical
systems.

Regards,
Willy

