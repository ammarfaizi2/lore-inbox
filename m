Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVFAXJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVFAXJa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 19:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVFAXJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 19:09:30 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:2661 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261356AbVFAXJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 19:09:28 -0400
Message-ID: <429E4023.2010308@yahoo.com.au>
Date: Thu, 02 Jun 2005 09:09:23 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: jschopp@austin.ibm.com
CC: Mel Gorman <mel@csn.ul.ie>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Avoiding external fragmentation with a placement policy Version
 12
References: <20050531112048.D2511E57A@skynet.csn.ul.ie> <429E20B6.2000907@austin.ibm.com>
In-Reply-To: <429E20B6.2000907@austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Schopp wrote:

> 
> Other than the very minor whitespace changes above I have nothing bad to 
> say about this patch.  I think it is about time to pick in up in -mm for 
> wider testing.
> 

It adds a lot of complexity to the page allocator and while
it might be very good, the only improvement we've been shown
yet is allocating lots of MAX_ORDER allocations I think? (ie.
not very useful)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
