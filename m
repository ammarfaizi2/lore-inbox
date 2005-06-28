Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262154AbVF1AdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbVF1AdL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 20:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbVF1AdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 20:33:11 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:25523 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262154AbVF1AdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 20:33:05 -0400
Message-ID: <42C09AB3.7030907@yahoo.com.au>
Date: Tue, 28 Jun 2005 10:32:51 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@kvack.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [rfc] lockless pagecache
References: <42BF9CD1.2030102@yahoo.com.au> <20050627004624.53f0415e.akpm@osdl.org> <42BFB287.5060104@yahoo.com.au> <20050627131710.GC13945@kvack.org>
In-Reply-To: <20050627131710.GC13945@kvack.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> On Mon, Jun 27, 2005 at 06:02:15PM +1000, Nick Piggin wrote:
> 
>>However I think for Oracle and others that use shared memory like
>>this, they are probably not doing linear access, so that would be a
>>net loss. I'm not completely sure (I don't have access to real loads
>>at the moment), but I would have thought those guys would have looked
>>into fault ahead if it were a possibility.
> 
> 
> Shared memory overhead doesn't show up on any of the database benchmarks 
> I've seen, as they tend to use huge pages that are locked in memory, and 
> thus don't tend to access the page cache at all after ramp up.
> 

To be quite honest I don't have any real workloads here that stress
it, however I was told that it is a problem for oracle database. If
there is anyone else who has problems then I'd be interested to hear
them as well.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
