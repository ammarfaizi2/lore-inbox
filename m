Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbUBDROf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 12:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbUBDROf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 12:14:35 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:58548
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S263851AbUBDROa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 12:14:30 -0500
Message-ID: <402128D0.2020509@tmr.com>
Date: Wed, 04 Feb 2004 12:16:00 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: VM patches (please review)
References: <402065DE.9090902@cyberone.com.au>
In-Reply-To: <402065DE.9090902@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> http://www.kerneltrap.org/~npiggin/vm/
> (may need to reload)
> 
> Here are the patches to go with my earlier post.
> kernel is 2.6.2-rc3-mm1.
> 
> I'm suire I've upset at least one uncommented^Wdivine
> balance so if anyone has time to review and comment
> it would be appreciated.
> 
> I can email the patches to the lists if anyone would
> like?

Since this is broken down nicely, a line or two about what each patch 
does or doesn't address would be useful. In particular, having just 
gotten a working RSS I'm suspicious of the patch named vm-no-rss-limit 
being desirable ;-)

Nice work, but it would be nice to see what problem a patch addresses to 
check for blowback under some other load.


-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
