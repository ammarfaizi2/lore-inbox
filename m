Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932660AbVKBIs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932660AbVKBIs1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 03:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932661AbVKBIs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 03:48:27 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:40843 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932660AbVKBIs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 03:48:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=dJo1RgwaVE+hvO+PGJAx1XLB1zAbKQlcfadzoNzuleqaCuczrh1vFHIumTRz9/cXduNwkyndoBdwyl004K5y/fXxhvQ8xjRMLJ88akqlSvtve+/6tarelaSbd0QDFYyh08PB5br2p6fYFW6YIAb0OnBYIWO4GBsE7GXqR0hDqTs=  ;
Message-ID: <43687DC7.3060904@yahoo.com.au>
Date: Wed, 02 Nov 2005 19:50:15 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Gerrit Huizenga <gh@us.ibm.com>
CC: Ingo Molnar <mingo@elte.hu>,
       Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Dave Hansen <haveblue@us.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
References: <E1EXDKN-0004b9-00@w-gerrit.beaverton.ibm.com>
In-Reply-To: <E1EXDKN-0004b9-00@w-gerrit.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerrit Huizenga wrote:

> So, people are working towards two distinct solutions, both of which
> require us to do a better job of defragmenting memory (or avoiding
> fragementation in the first place).
> 

This is just going around in circles. Even with your fragmentation
avoidance and memory defragmentation, there are still going to be
cases where memory does get fragmented and can't be defragmented.
This is Ingo's point, I believe.

Isn't the solution for your hypervisor problem to dish out pages of
the same size that are used by the virtual machines. Doesn't this
provide you with a nice, 100% solution that doesn't add complexity
where it isn't needed?

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
