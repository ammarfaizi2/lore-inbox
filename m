Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264076AbUDBPfY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 10:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264083AbUDBPfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 10:35:24 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:28044
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264076AbUDBPfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 10:35:21 -0500
Date: Fri, 2 Apr 2004 17:35:22 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-aa vma merging
Message-ID: <20040402153522.GC21341@dualathlon.random>
References: <Pine.LNX.4.44.0403292044530.19124-100000@localhost.localdomain> <Pine.LNX.4.44.0404021208500.4414-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404021208500.4414-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2004 at 12:34:29PM +0100, Hugh Dickins wrote:
> Sorry to be boring, Andrea, but 2.6.5-rc3-aa2 is now out, and you
> have still not fixed the vma merging issue: I don't believe you can.

Hugh, it will get fixed perfectly, so please give me the time to fix
swap suspend, then I can care about minor issues.

Swap suspend now works, swap resume is still broken and I cannot yet
care about mprotect, after I fixed swapsuspend (and swap resume) I will
be allowed to spend time on non-blocker bugs. I promise mprotect will
merge perfectly your testcase without any problem a few days after swap
suspend and swap resume works.
