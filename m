Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264222AbUDRXoI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 19:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264226AbUDRXoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 19:44:08 -0400
Received: from florence.buici.com ([206.124.142.26]:16003 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S264222AbUDRXoG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 19:44:06 -0400
Date: Sun, 18 Apr 2004 16:44:04 -0700
From: Marc Singer <elf@buici.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Marc Singer <elf@buici.com>, William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: vmscan.c heuristic adjustment for smaller systems
Message-ID: <20040418234404.GA11231@flea>
References: <20040417233037.GA15576@flea> <20040417165151.24b1fed5.akpm@osdl.org> <20040418002343.GA16025@flea> <4081F809.4030606@yahoo.com.au> <20040418041748.GW743@holomorphy.com> <408206E8.5000600@yahoo.com.au> <20040418051024.GA19595@flea> <40820FFF.8090906@yahoo.com.au> <20040418053553.GB19595@flea> <40821504.8050700@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40821504.8050700@yahoo.com.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 18, 2004 at 03:41:24PM +1000, Nick Piggin wrote:
> >We'll, I'll try applying his patch and then yours.  If it doesn't work
> >I'll let you know.
> >
> 
> OK thanks.

There appear to be a lot of conflicts between my development tree and
the -mm6 patch.  Even your patch doesn't apply cleanly, though I think
it is only because a piece has already been applied.

I'm starting with 2.6.5, applying Russell King's 2.6.5 patch from the
8th, applying -mm6 patch, and then yours.  It looks like a good bit of
Russell's patch has been included in the -mm6.  But not enough of mm6
is present in my tree for your patch to work.

I'm working on the scripts and BK docs.  At this point, I may have to
wait for 2.6.6 before we can make another test.

