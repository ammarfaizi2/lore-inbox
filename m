Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262517AbVG2I7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262517AbVG2I7X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 04:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbVG2I7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 04:59:23 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:8098 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262517AbVG2I7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 04:59:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=uDf83HaqMs/aHESVUWjucFxQJdNSRejjZhiFyrEtfeA3dKanXJGP/GxtYFo26f/j/i7ihd70okmLvc8zCyOkxMMXg4lUPUVE3yBkUgxa8MjLUv+4SHXoUyafgHhEt9Bw9bvJUDpZ2kv00Du5jeVMBFaKZz9WFqjdbiSxf/iYa9w=  ;
Message-ID: <42E9EFDD.4020703@yahoo.com.au>
Date: Fri, 29 Jul 2005 18:59:09 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: Delete scheduler SD_WAKE_AFFINE and SD_WAKE_BALANCE flags
References: <200507290627.j6T6Rrg06842@unix-os.sc.intel.com> <42E9ED47.1030003@yahoo.com.au> <20050729085340.GA8699@elte.hu>
In-Reply-To: <20050729085340.GA8699@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>processes    1               2               3              4
>>
>>2.6.13-rc4:  187, 183, 179   260, 259, 256   340, 320, 349  504, 496, 500
>>no wake-bal: 180, 180, 177   254, 254, 253   268, 270, 348  345, 290, 500
>>
>>Numbers are MB/s, higher is better.
> 
> 
> what type of network was used - localhost or a real one?
> 

Localhost. Yeah it isn't a real world test, but it does show the
erratic behaviour without wake affine.

I don't have a setup with multiple fast network adapters otherwise
I would have run a similar test using a real network.

Send instant messages to your online friends http://au.messenger.yahoo.com 
