Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbVDZRpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbVDZRpI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 13:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbVDZRoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 13:44:02 -0400
Received: from mail.dif.dk ([193.138.115.101]:23998 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261566AbVDZRnf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 13:43:35 -0400
Date: Tue, 26 Apr 2005 19:46:50 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Robert Love <rml@novell.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       kpreempt-tech@lists.sourceforge.net
Subject: Re: preempt-count oddities - still looking for comments :)
In-Reply-To: <1114536937.6851.1.camel@betsy>
Message-ID: <Pine.LNX.4.62.0504261944020.2071@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0504232254050.2474@dragon.hyggekrogen.localhost>
  <Pine.LNX.4.62.0504261929230.2071@dragon.hyggekrogen.localhost>
 <1114536937.6851.1.camel@betsy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2005, Robert Love wrote:

> On Tue, 2005-04-26 at 19:31 +0200, Jesper Juhl wrote:
> > Replying to myself here since the initial mail got no response. Here's 
> > hoping that it showing up on the list again draws some comments :-)
> 
> I didn't think it was that big of a deal.  ;-)
> 
It's not really that big of a deal. I was just currious if I'd gotten it 
right since I spend a good deal of time digging for possible reasons for 
the differences (and finding none). :-)

> It seems the right approach.  Personally, I would of made the type an
> s32, since fixed-sizes seems to be sensible in the thread_info
> structure, but an int is the same thing.  Cool with me.
> 
I'll update the patch(es) then and use __s32 in the structure and s32 
elsewhere.

> Acked-by: Robert Love <rml@novell.com>
> 
Thanks.

> 	Robert Love
> 

-- 
Jesper Juhl


