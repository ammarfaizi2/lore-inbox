Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbUDRPqY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 11:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbUDRPqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 11:46:24 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:55558 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S261723AbUDRPqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 11:46:23 -0400
Date: Sun, 18 Apr 2004 23:50:40 +0800 (WST)
From: raven@themaw.net
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-mm6
In-Reply-To: <20040418083843.23c87622.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0404182349410.22142@donald.themaw.net>
References: <20040414230413.4f5aa917.akpm@osdl.org>
 <Pine.LNX.4.58.0404181756430.5049@donald.themaw.net> <20040418083843.23c87622.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-1.7, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, NO_REAL_NAME, QUOTED_EMAIL_TEXT,
	REFERENCES, REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Apr 2004, Andrew Morton wrote:

> raven@themaw.net wrote:
> >
> > 
> > Looks like something was missed here.
> > 
> > arch/sparc64/kernel/signal.c: In function `do_signal':
> > arch/sparc64/kernel/signal.c:627: warning: passing arg 2 of 
> > `get_signal_to_deliver' from incompatible pointer type
> > arch/sparc64/kernel/signal.c:627: warning: passing arg 3 of 
> > `get_signal_to_deliver' from incompatible pointer type
> > arch/sparc64/kernel/signal.c:627: error: too few arguments to function 
> > `get_signal_to_deliver'
> > 
> 
> You'll need to revert signal-race-fix.patch for now - nobody has done the
> sparc64 bit.  And I haven't pushed for it because the whole thing needs to
> be redone, if that's at all practical.
> 

I guesed that after looking around further.

Will do.

