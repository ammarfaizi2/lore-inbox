Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWGMDDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWGMDDY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 23:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWGMDDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 23:03:24 -0400
Received: from mx1.suse.de ([195.135.220.2]:35235 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932329AbWGMDDY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 23:03:24 -0400
Date: Thu, 13 Jul 2006 05:04:02 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] let CONFIG_SECCOMP default to n
Message-ID: <20060713030402.GC9102@opteron.random>
References: <20060630014050.GI19712@stusta.de> <p73wtain80h.fsf@verdi.suse.de> <20060712210732.GA10182@elte.hu> <200607130006.12705.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607130006.12705.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2006 at 12:06:12AM +0200, Andi Kleen wrote:
> I don't know any details about this, but I would generally trust Andrea not to
> attempt to do anything evil regarding kernel & patents.

I appreciate Andi.

For the ones that don't seem to trust me I quote Alan (and I also know
that what Alan said is correct):

  As to patented code for the kernel. That itself is a non-issue providing
  the patent owner or someone with permission from them submitted the
  code. The law recognizes that you cannot go around making promises
  (estoppel) and then trying to sue people for acting on them. The GPL
  likewise makes this clear.

What Ingo complains about is the fact somebody could be selling a
patented mp3 player that uses alsa. Should alsa be rejected from the
kernel? Does that mean alsa has anything to do with the mp3 patent?

Another example is when you make a search on google.com, you use the
tcp/ip kernel stack to connect to a software covered by
patents. Should the tcp/ip stack be removed from the kernel? Does that
mean that the tcp/ip code has anything to do with the google patents?

Yes I also use tcp/ip, so do you want to reject tcp/ip from the kernel
to prevent people to run the software that connects the seccomp task
to the server? seccomp alone won't allow the client software to work
unless I can connect to the server, so tcp/ip is guilty exactly the
same way as seccomp.

There are infinite other examples...

About the GPL, I'm a huge believer on the GPL, I said multiple times I
think Linux has got the success it has because it's under the GPL and
not under the BSD. The GPL works perfectly for the kernel.

But it doesn't mean the GPL works for everything, infact the GPL
translates to a sort of BSD behind the firewall.

Ask to Ingo the link to the kernel source running in the google
supercomputer if he keeps saying that the GPL works universally.

Ask to Ingo what was deadly wrong with the LGPL that made he decide
that it would have been bad if people writing LGPL code would have
been allowed to use his patent-pending ideas. (Then re-ask him the
same question after replacing the LGPL with the BSD license).
