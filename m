Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283770AbRLJQmP>; Mon, 10 Dec 2001 11:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284460AbRLJQmF>; Mon, 10 Dec 2001 11:42:05 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.1.197.194]:4284 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S283770AbRLJQl5>;
	Mon, 10 Dec 2001 11:41:57 -0500
Message-ID: <3C14E5CD.9050906@candelatech.com>
Date: Mon, 10 Dec 2001 09:41:49 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
CC: Chris Wright <chris@wirex.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: question on select:  How big can the empty buffer space be before select returns ready-to-write?
In-Reply-To: <E16DLx4-0001Ds-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox wrote:

>>* Ben Greear (greearb@candelatech.com) wrote:
>>
>>>For instance, it appears that select will return that a socket is
>>>writable when there is, say 8k of buffer space in it.  However, if
>>>I'm sending 32k UDP packets, this still causes me to drop packets
>>>due to a lack of resources...
>>>
>>udp has a fixed 8k max payload. did you try breaking up your packets?
>>
> 
> UDP has a 64K - headers max payload. 


Yes, and I am writing code to specifically try out large UDP
packet sizes, so limiting myself to a certain size is not at
all useful in this case....

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


