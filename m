Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUCLTDP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 14:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbUCLTDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 14:03:15 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:38811 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262406AbUCLTDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 14:03:14 -0500
Message-ID: <40520928.4050409@nortelnetworks.com>
Date: Fri, 12 Mar 2004 14:02:00 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: anon_vma RFC2
References: <Pine.LNX.4.44.0403121346580.6494-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0403121346580.6494-100000@chimarrao.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Fri, 12 Mar 2004, Linus Torvalds wrote:
> 
> 
>>I think your approach could work (reverse map by having separate address
>>spaces for unrelated processes), but I don't see any good "page->index"  
>>allocation scheme that is implementable.

> Note that since we count page->index in PAGE_SIZE unit we
> have PAGE_SIZE times as much space as a process can take,
> so we definately have enough address space to come up with
> a creative allocation scheme.

What happens when you have more than PAGE_SIZE processes running?

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
