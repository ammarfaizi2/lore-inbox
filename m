Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264699AbSJOSWe>; Tue, 15 Oct 2002 14:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264715AbSJOSWe>; Tue, 15 Oct 2002 14:22:34 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:58272 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264699AbSJOSWd>; Tue, 15 Oct 2002 14:22:33 -0400
Message-ID: <3DAC5C11.4060507@watson.ibm.com>
Date: Tue, 15 Oct 2002 14:18:57 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Benjamin LaHaise <bcrl@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>, Andrew Morton <akpm@digeo.com>,
       David Miller <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] async poll for 2.5
References: <20021015135048.F14596@redhat.com> <Pine.LNX.4.44.0210151114070.1554-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> On Tue, 15 Oct 2002, Benjamin LaHaise wrote:
> 
> 
>>On Tue, Oct 15, 2002 at 01:38:53PM -0400, Shailabh Nagar wrote:
>>
>>>So I guess the question would now be: whats keeping /dev/epoll from
>>>being included in the kernel given the time left before the feature freeze ?
>>
>>We don't need yet another event reporting mechanism as /dev/epoll presents.
>>I was thinking it should just be its own syscall but report its events in
>>the same way as aio.
> 
> 
> Yes, Linus ( like myself ) hates magic inodes inside /dev. At that time it
> was the fastest way to have a kernel interface exposed w/out having to beg
> for a syscall. I'm all for a new syscall obviously, and IMHO /dev/epoll
> might be a nice complement to AIO for specific applications.


So what would the syscall look like ? Could you give a few more details on the interface ?

- Shailabh




