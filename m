Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbWDGS3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWDGS3y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 14:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbWDGS3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 14:29:54 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:4704 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964848AbWDGS3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 14:29:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=M29oMbNGX+Rbczp9hJ7HGtMcDrICHaWagbPiQGitMzMk1V6CVH1QETJ4DTArXEwSZ2oCIeF1MNSbjuS033bgcUSwgcW2AHS+7PpTyWMSvqDb/6bfPSMV1mL7qkp8kW9/NWh5hTVDIh0QB584aeckHXCuclpQY66dQ97y6Jrr8P0=  ;
Message-ID: <44365DC2.1010806@yahoo.com.au>
Date: Fri, 07 Apr 2006 22:40:34 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Andrew Morton <akpm@osdl.org>, ck@vds.kolivas.org,
       linux list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] mm: limit lowmem_reserve
References: <200604021401.13331.kernel@kolivas.org> <200604061110.35789.kernel@kolivas.org> <443605E1.7060203@yahoo.com.au> <200604071902.16011.kernel@kolivas.org>
In-Reply-To: <200604071902.16011.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Friday 07 April 2006 16:25, Nick Piggin wrote:
> 
>>Con Kolivas wrote:
>>
>>>It is possible with a low enough lowmem_reserve ratio to make
>>>zone_watermark_ok always fail if the lower_zone is small enough.
>>
>>I don't see how this would happen?
> 
> 
> 3GB lowmem and a reserve ratio of 180 is enough to do it.
> 

How would zone_watermark_ok always fail though?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
