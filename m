Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264833AbUEPWL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264833AbUEPWL5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 18:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264836AbUEPWL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 18:11:57 -0400
Received: from taco.zianet.com ([216.234.192.159]:41231 "HELO taco.zianet.com")
	by vger.kernel.org with SMTP id S264833AbUEPWLs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 18:11:48 -0400
From: Steven Cole <elenstev@mesatop.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s && s->tree' failed: The saga continues.)
Date: Sun, 16 May 2004 16:11:16 -0600
User-Agent: KMail/1.6.1
Cc: andrea@suse.de, torvalds@osdl.org, adi@bitmover.com, scole@lanl.gov,
       support@bitmover.com, linux-kernel@vger.kernel.org
References: <200405132232.01484.elenstev@mesatop.com> <200405161519.03834.elenstev@mesatop.com> <20040516142916.7d07c9f3.akpm@osdl.org>
In-Reply-To: <20040516142916.7d07c9f3.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405161611.17688.elenstev@mesatop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 May 2004 03:29 pm, Andrew Morton wrote:
> Steven Cole <elenstev@mesatop.com> wrote:
> >
> > Anyway, although the regression for my particular machine for this
> >  particular load may be interesting, the good news is that I've seen
> >  none of the failures which started this whole thread, which are relatively
> >  easily reproduceable with PREEMPT set.  
> 
> So...  would it be correct to say that with CONFIG_PREEMPT, ppp or its
> underlying driver stack
> 
> a) screws up the connection and hangs and
> 
> b) scribbles on pagecache?
> 
> Because if so, the same will probably happen on SMP.
> 
Perhaps someone has the hardware to test this.

To summarize my experience with the past 24 hours of testing:
Without PREEMPT , everything is rock solid. 

I may have a window of time later this evening to continue testing,
and I (cringes at the thought) may repeat some bk pulls with
PREEMPT set.

Later,
Steven
