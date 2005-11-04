Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161070AbVKDB5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161070AbVKDB5a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 20:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161103AbVKDB5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 20:57:30 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:24925 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1161070AbVKDB53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 20:57:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=uTSTq8FmsOED8qOEnq2dMyrkguiwdssVZMynrsiq7MTPgKqylHf81QW8bKSB4Zfcmne69ikChT3k4fNC1xMyqFwDnCLk+Q5bYwGAVBMuHCwjsGgLR7iX0Yq8BicNc8DJGAmOiNlYedxWHC5Bzb75j41x8RwmE6k7U+04mH8nAqE=  ;
Message-ID: <436AC07D.2070602@yahoo.com.au>
Date: Fri, 04 Nov 2005 12:59:25 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
CC: Linus Torvalds <torvalds@osdl.org>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Arjan van de Ven <arjanv@infradead.org>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
References: <4366C559.5090504@yahoo.com.au> <1130856555.14475.77.camel@localhost><20051101150142.GA10636@elte.hu> <1130858580.14475.98.camel@localhost><20051102084946.GA3930@elte.hu> <436880B8.1050207@yahoo.com.au><1130923969.15627.11.camel@localhost> <43688B74.20002@yahoo.com.au><255360000.1130943722@[10.10.2.4]> <4369824E.2020407@yahoo.com.au> <306020000.1131032193@[10.10.2.4]> <1131032422.2839.8.camel@laptopd505.fenrus.org>  <Pine.LNX.4.64.0511030747450.27915@g5.osdl.org> <Pine.LNX.4.58.0511031613560.3571@skynet>  <Pine.LNX.4.64.0511030842050.27915@g5.osdl.org> <309420000.1131036740@[10.10.2.4]>  <Pine.LNX.4.64.0511030918110.27915@g5.osdl.org> <311050000.1131040276@[10.10.2.4]> <1131040786.2839.18.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0511031006550.27915@g5.osdl.org> <312300000.1131041824@[10.1! 0.2.4]> <436AB241.2030403@yahoo.com.au> <Pine.LNX.4.64.0511031704590.27915@g5.osdl.org> <436AB7CA.6060603@yahoo.com.au> <Pine.LNX.4.58.0511040134460.9172@skynet>
In-Reply-To: <Pine.LNX.4.58.0511040134460.9172@skynet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman wrote:
> On Fri, 4 Nov 2005, Nick Piggin wrote:
> 
> Todays massive machines are tomorrows desktop. Weak comment, I know, but
> it's happened before.
> 

Oh I wouldn't bet against it. And if desktops of the future are using
100s of GB then they probably would be happy to use 64K pages as well.

> 
>>Maybe the solution is to bloat the kernel sources enough to make
>>64KB pages worthwhile?
>>
> 

Sorry this wasn't meant to be a dig at your patches - I guess it turned
out that way though :\

But yes, if anybody is adding complexity or size to core code it
obviously does need to be justified -- and by no means does this only
apply to you.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
