Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932510AbWFMFhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbWFMFhV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 01:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752325AbWFMFhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 01:37:20 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:9836 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1752321AbWFMFhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 01:37:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=dOpJ6g1m39a8G+v1jmG1lfhjOKMhilLfTGPwQg1bFia076/MymNbjj48vjyQejvSnX8VfFrZzAeoYpjSQ8svzT9HR6FY9pWQZEnjVkKreuQdqJhAVn/6QUPL2/gZl/ND0bIZ927qngeHbB8OKlAVpV7LZkeBYkLKIGowPMXZ5V4=  ;
Message-ID: <448E4F05.9040804@yahoo.com.au>
Date: Tue, 13 Jun 2006 15:37:09 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Hugh Dickins <hugh@veritas.com>, Con Kolivas <kernel@kolivas.org>,
       Marcelo Tosatti <marcelo@kvack.org>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Dave Chinner <dgc@sgi.com>
Subject: Re: zoned vm counters: per zone counter functionality
References: <20060612211244.20862.41106.sendpatchset@schroedinger.engr.sgi.com> <20060612211255.20862.39044.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060612211255.20862.39044.sendpatchset@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

Looks like a nice patchset. I really like that you've moved the counters
out of page alloc.

Is there any point in using a more meaningful namespace prefix than NR_
for the zone_stat_items?


> +enum zone_stat_item {
> +	NR_STAT_ITEMS };
> +

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
