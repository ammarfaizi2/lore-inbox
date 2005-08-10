Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbVHJAn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbVHJAn4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 20:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbVHJAn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 20:43:56 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:15251 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751011AbVHJAnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 20:43:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=OOujcu0VHEFqAnalsBgTLt0CsPxfq2G5wGg936LzK9xQyMv0h8Bzx/QiEPF9yI6JIg86V30Ty9XvY0CyJhOgo43qg1aQQhYz5ejzBvlC4Be+TYrQE81zWq9TgvAKJ6In76ibNpj+9hFwBWpqn/HQniNZ49luxeouO5LqNEkSiAE=  ;
Message-ID: <42F94DC1.5040105@yahoo.com.au>
Date: Wed, 10 Aug 2005 10:43:45 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: "Martin J. Bligh" <mbligh@mbligh.org>, Darren Hart <dvhltc@us.ibm.com>,
       "lkml," <linux-kernel@vger.kernel.org>,
       "Piggin, Nick" <piggin@cyberone.com.au>,
       "Dobson, Matt" <colpatch@us.ibm.com>, mingo@elte.hu
Subject: Re: sched_domains SD_BALANCE_FORK and sched_balance_self
References: <42F3F669.2080101@us.ibm.com> <20050809150331.A1938@unix-os.sc.intel.com> <1187700000.1123625998@flay> <20050809174042.C1938@unix-os.sc.intel.com>
In-Reply-To: <20050809174042.C1938@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:

>On Tue, Aug 09, 2005 at 03:19:58PM -0700, Martin J. Bligh wrote:
>
>>--On Tuesday, August 09, 2005 15:03:32 -0700 "Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:
>>
>>
>>Balance on clone make some sort of sense, since you know they're not
>>going to exec afterwards. We've thrashed through this many times before
>>and decided that unless there was an explicit hint from userspace,
>>balance on fork was not a good thing to do in the general case. Not only
>>based on a large range of testing, but also previous experience from other
>>Unix's. What new data came forth to change this?
>>
>
>I agree with you. I will let Nick(the author) have a take at this.
>
>

Sorry I've taken a while with this. Darren, I'll reply to you soon.


Send instant messages to your online friends http://au.messenger.yahoo.com 
