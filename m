Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264701AbUEXWBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264701AbUEXWBy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 18:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264379AbUEXWBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 18:01:54 -0400
Received: from colin2.muc.de ([193.149.48.15]:11012 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264701AbUEXWBn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 18:01:43 -0400
Date: 25 May 2004 00:01:36 +0200
Date: Tue, 25 May 2004 00:01:36 +0200
From: Andi Kleen <ak@muc.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFD] Explicitly documenting patch submission
Message-ID: <20040524220136.GC18532@colin2.muc.de>
References: <1YUY7-6fF-11@gated-at.bofh.it> <m3fz9pd2dw.fsf@averell.firstfloor.org> <Pine.LNX.4.58.0405241326400.32189@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405241326400.32189@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2004 at 01:31:49PM -0700, Linus Torvalds wrote:
> > You're just asking that they read it and confirm to the maintainer
> > that they did, right?
> 
> Right. We'd add it to the Documentation directory, and add pointers to it 
> to anything that mentions the "Signed-off-by:" thing (eg things like 
> SubmittingPatches). All just to make sure that people are aware of what it 
> means to say "Signed-off-by:"

Hmm, but it would still take a long time until everybody does this
by default (and there will be always people who don't read all
the instructions before sending a patch, so it's not that this will
stop at some point). Would you require maintainers
to reject patches when the signoff lines are missing?

I personally would hate to reject a value bug fix because of a policy
like this...

In practice I guess it would end up with that maintainers would spend a lot
of time explaining to everybody what this new policy is about and 
possibly are forced to reject a lot of patches initially. 

-Andi
