Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbWFNBVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbWFNBVt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 21:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWFNBVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 21:21:48 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:5801 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932372AbWFNBVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 21:21:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=DhfC55VQaHbomyV77Rjtnajo7jPirwi8xsFi13LBT0uoxg83CbuQalSRQE6YZa1xXS7N87UcD8Nn3nei0Gb8oDxanxuSebLmxF3Iy55ei57/dwr3LonEzdZFG/wr3SkfH9APQSZ4SwQ8CSqElGHCVEW+8VUvdGTXiB8K4HqMgwI=  ;
Message-ID: <448F64A0.9090705@yahoo.com.au>
Date: Wed, 14 Jun 2006 11:21:36 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Hugh Dickins <hugh@veritas.com>, Con Kolivas <kernel@kolivas.org>,
       Marcelo Tosatti <marcelo@kvack.org>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Dave Chinner <dgc@sgi.com>
Subject: Re: zoned vm counters: per zone counter functionality
References: <20060612211244.20862.41106.sendpatchset@schroedinger.engr.sgi.com> <20060612211255.20862.39044.sendpatchset@schroedinger.engr.sgi.com> <448E4F05.9040804@yahoo.com.au> <Pine.LNX.4.64.0606130854480.29796@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0606130854480.29796@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:

>On Tue, 13 Jun 2006, Nick Piggin wrote:
>
>
>>Is there any point in using a more meaningful namespace prefix than NR_
>>for the zone_stat_items?
>>
>>
>>
>>>+enum zone_stat_item {
>>>+	NR_STAT_ITEMS };
>>>+
>>>
>
>How about
>
>NR_VM_ZONE_STAT_ITEMS ?
>
>
>

I guess that's OK.

Hmm, then NR_ANON would become VM_ZONE_STAT_NR_ANON? That might be a bit
long for your tastes, maybe the prefix could be hidden by "clever" macros?

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
