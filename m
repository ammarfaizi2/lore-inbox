Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbWBJERw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWBJERw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 23:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbWBJERw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 23:17:52 -0500
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:16541 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751066AbWBJERv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 23:17:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Sz1G74xmAfFPhi5fBYSnOaR+bmch2jHhJu8YN6u6rCdDNJvFL7bRqd7z/IaJ9GQQBI4UJ5WYcKaF3uzwCiuQwTzNml/2h0dyLAo/44BiQohZFMxUrnqAHGDZn218ES1MQuEwYtfUCsnQYduymSUY4R98qAfpkpC6gsXCatutjn4=  ;
Message-ID: <43EC13EB.3010501@yahoo.com.au>
Date: Fri, 10 Feb 2006 15:17:47 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org, ck@vds.kolivas.org,
       pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Implement Swap Prefetching v23
References: <200602101355.41421.kernel@kolivas.org> <200602101449.59486.kernel@kolivas.org> <43EC1164.4000605@yahoo.com.au> <200602101514.40140.kernel@kolivas.org>
In-Reply-To: <200602101514.40140.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Friday 10 February 2006 15:07, Nick Piggin wrote:

>>Well they go on the head of the inactive list and will kick out file
>>backed pagecache. Which was my concern about reducing the usefulness
>>of useful swapping on desktop systems.
> 
> 
> Ok I see. We don't have a way to add to the tail of that list though? Is that 
> a worthwhile addition to this (ever growing) project? That would definitely 

Don't know, can you tell us?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
