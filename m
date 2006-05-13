Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbWEMBjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWEMBjR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 21:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWEMBjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 21:39:17 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:11940 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751318AbWEMBjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 21:39:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=W6x14sSQD0BTxp0rVm/M55qKYPO9NZL4DYH2H2SMrG+Zmv/NQvr5a9pKzLQuxgZpHDGtyDwg1wdBGQsop9nh8YOA3vwPi6xLyNJ4IO/ArWuamNKBwO5xK8YJ+xHR9kWWpDBrKNDVXqV7b86hTOk6Sp80c2pgGGIwUtrbNqfD3x8=  ;
Message-ID: <446538C0.6000004@yahoo.com.au>
Date: Sat, 13 May 2006 11:39:12 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, Andy Whitcroft <apw@shadowen.org>,
       haveblue@us.ibm.com, bob.picco@hp.com, mbligh@mbligh.org, ak@suse.de,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/3] Zone boundry alignment fixes
References: <445DF3AB.9000009@yahoo.com.au> <exportbomb.1147172704@pinky> <20060511005952.3d23897c.akpm@osdl.org> <20060512141921.GA564@elte.hu>
In-Reply-To: <20060512141921.GA564@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> 
>>There's some possibility here of interaction with Mel's "patchset to 
>>size zones and memory holes in an architecture-independent manner." I 
>>jammed them together - let's see how it goes.
> 
> 
> update: Andy's 3 patches, applied to 2.6.17-rc3-mm1, fixed all the 
> crashes and asserts i saw. NUMA-on-x86 is now rock-solid on my testbox. 
> Great work Andy!

Excellent. I think these should get into 2.6.17, and possibly even the
-stable series.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
