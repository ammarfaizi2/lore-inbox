Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266275AbUJATnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266275AbUJATnp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 15:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266233AbUJATld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 15:41:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:7898 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266291AbUJATjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 15:39:24 -0400
Date: Fri, 1 Oct 2004 12:39:21 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Hansen <haveblue@us.ibm.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Loops in the Signed-off-by process
In-Reply-To: <1096658717.3684.980.camel@localhost>
Message-ID: <Pine.LNX.4.58.0410011233370.2403@ppc970.osdl.org>
References: <1096658717.3684.980.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 1 Oct 2004, Dave Hansen wrote:
> 
> Or, does it even really matter?

I don't think it matters that much, although I personally prefer to see 
the person who sent it to me ("touched it last") be last in the list. 
That's partly because of the fact that especially with bigger merges (ie 
with Andrew), I just do a search-and-replace, and replace any "signed off 
by sender" with "signed off by sender and me".

At the same time, I think it's pretty unnecessary (and possibly confusing)
to have somebody mentioned twice, so I'd actually prefer to see people
just move their (previous) sign-off to be last when they send it on.

Side note: I also like seeing "Acked-by:" or "Cc:" things just above the
sign-off lines, because it ends up being useful if there are any technical
issues with the patch - if a bug is found, it's very convenient to just
take all the sign-off people _and_ the other "involved" people and send
off a query to them all. Even if that "Acked-by:" has no other meaning
than as a mention of the fact that somebody else was involved in
discussions, even if they may not have been involved in actually writing
or passing off the ptch.

		Linus
