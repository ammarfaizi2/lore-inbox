Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264637AbSJORnO>; Tue, 15 Oct 2002 13:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264673AbSJORnJ>; Tue, 15 Oct 2002 13:43:09 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:2183 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264637AbSJORmx>;
	Tue, 15 Oct 2002 13:42:53 -0400
Message-ID: <3DAC52AD.3080904@watson.ibm.com>
Date: Tue, 15 Oct 2002 13:38:53 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] async poll for 2.5
References: <3DAB46FD.9010405@watson.ibm.com> <20021015110501.B11395@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:

>On Mon, Oct 14, 2002 at 06:36:45PM -0400, Shailabh Nagar wrote:
>
>>As of today, there is no scalable alternative to poll/select in the 2.5
>>kernel even though the topic has been discussed a number of times
>>before. The case for a scalable poll has been made often so I won't
>>get into that.
>>
>
>Have you bothered addressing the fact that async poll scales worse than 
>/dev/epoll?  That was the original reason for dropping it.
>
>		-ben
>
Hi Ben,

I didn't address async poll's scalability  vs. /dev/epoll because 
/dev/epoll isn't in the kernel either. I wasn't sure whether you had a 
better async poll
in the making.

Either solution (/dev/epoll or async poll) would be a considerable 
improvement over what we have today.

So I guess the question would now be: whats keeping /dev/epoll from 
being included in the kernel given the time left before the feature freeze ?

-- Shailabh




