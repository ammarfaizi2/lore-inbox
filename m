Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265523AbSKRXWg>; Mon, 18 Nov 2002 18:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265541AbSKRXWg>; Mon, 18 Nov 2002 18:22:36 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:38084 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S265523AbSKRXWe>; Mon, 18 Nov 2002 18:22:34 -0500
Message-ID: <3DD97D4D.3010801@kegel.com>
Date: Mon, 18 Nov 2002 15:52:45 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows 98)
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
References: <Pine.LNX.4.44.0211181520140.979-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> On Mon, 18 Nov 2002, Dan Kegel wrote:
> 
>>>The interface ( edge-triggered ) is quite different and we saw in the
>>>previous experience how this might lead to confusion for the user. Putting
>>>epoll bits inside poll.h will IMHO increase this.
>>
>>The only difference is the edge-triggered nature, though, right?
> 
> Yes, but we have seen that it's enough :)

I'm not so sure.  If the epoll documentation were clear enough
(which at the moment, frankly, it isn't), I think
there's a good chance users would not be confused
by the difference between level-triggered and edge-triggered
events.

I'd be happy to contribute better doc... has the man page
for sys_epoll been written yet?
- Dan

