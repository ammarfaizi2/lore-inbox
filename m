Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261933AbULVBAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbULVBAT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 20:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbULVBAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 20:00:19 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:53002 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261933AbULVBAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 20:00:05 -0500
Date: Wed, 22 Dec 2004 01:59:54 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Manfred Schwarb <manfred99@gmx.ch>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       trond.myklebust@fys.uio.no
Subject: Re: 2.4.29-pre2 Oops at find_inode/reiserfs_find_actor
Message-ID: <20041222005954.GL17946@alpha.home.local>
References: <20041221164610.GC3596@logos.cnet> <1730.1103673365@www47.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1730.1103673365@www47.gmx.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 22, 2004 at 12:56:05AM +0100, Manfred Schwarb wrote:
 
> No, not at all. This machine was running for 10 months with 2.4.xx 
> kernels without any problems. Since this oops, I tried to reproduce
> the particular situation (rsync over nfs, and some additional load),
> put I had no success in crashing the box:
> I mirrored the box (ca. 1 million files) 5 times, no problem.
(...) 
> Hardware issue: you mean memory? Last winter I ran memtest86
> during a weekend, everything was fine. At the moment I can't
> take this box offline for a longer period to test again, so I 
> tend to belive memory is ok, and knock on wood...

Does this machine have ECC memory ? If so, have you tried to check the
error counters ? And if not, well, it might be some random bit flips
in memory.

Last year, I encountered a really strange situation. During about one week,
I had 3 or 4 machines that have panic'd several times each, and sometimes
only some multi-threaded apps would freeze (eg: pdnsd). These machines
were installed at different customers' in different locations, and at
different times. They had never crashed before, nor did they after. Most
other similar machines at other customer's, or some at the sames did not
experience this. This was during the first week of november, when there
were the very strong solar flares. I never told the customers about my
thoughts on the subject, they would have definitely made fun of me. So
we replaced the RAM sticks, to report something more believable...

Regards,
Willy

