Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbTIXDd4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 23:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbTIXDdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 23:33:55 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:23558 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S261752AbTIXDcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 23:32:55 -0400
Date: Tue, 23 Sep 2003 23:31:05 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Larry McVoy <lm@bitmover.com>
cc: Andrea Arcangeli <andrea@suse.de>, <andrea@kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Subject: Re: log-buf-len dynamic
In-Reply-To: <20030924031602.GA7887@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0309232327490.15940-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Sep 2003, Larry McVoy wrote:

> Yeah.  I'm using the Linux VM.  And it _still_ isn't up to what I managed
> to accomplish in SunOS.  Wake up, dude.  You aren't the first one to
> work in this area, you are just one of the first to work in this area
> without learning from the people who came before you.  Don't believe me?
> Go to OLS and read the papers.  Then read the OS research that has
> happened in the last 20 years or so.  So far you are still catching up.

Bad example ;)

While it is true that the Linux VM doesn't do a whole
lot of the things a VM should do, there is also the
fact that the VM problem space has gotten a lot harder
over the last decade due to the fact that the size of
disk and memory has grown way faster than the speed of
disk and memory.

Simply put, nowadays it takes more than 10 times as
long to swap out a process then it took 10 years ago.
This puts interesting constraints on the design of a
VM...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

