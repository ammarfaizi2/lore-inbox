Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750884AbVJAWvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbVJAWvT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 18:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbVJAWvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 18:51:18 -0400
Received: from bay105-f22.bay105.hotmail.com ([65.54.224.32]:30003 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1750882AbVJAWvS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 18:51:18 -0400
Message-ID: <BAY105-F2270EEA37B83483AE53063A48E0@phx.gbl>
X-Originating-IP: [62.79.29.130]
X-Originating-Email: [lokumsspand@hotmail.com]
In-Reply-To: <433F0BF1.2020900@concannon.net>
From: "lokum spand" <lokumsspand@hotmail.com>
To: mike@concannon.net, arjan@infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: A possible idea for Linux: Save running programs to disk
Date: Sat, 01 Oct 2005 14:51:17 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 01 Oct 2005 22:51:17.0955 (UTC) FILETIME=[A263D930:01C5C6DA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




>From: Michael Concannon <mike@concannon.net>
>To: Arjan van de Ven <arjan@infradead.org>
>CC: lokum spand <lokumsspand@hotmail.com>, linux-kernel@vger.kernel.org
>Subject: Re: A possible idea for Linux: Save running programs to disk
>Date: Sat, 01 Oct 2005 18:21:37 -0400
>
>Arjan van de Ven wrote:
>
>>On Sat, 2005-10-01 at 13:30 -0800, lokum spand wrote:
>>
>>
>>>I allow myself to suggest the following, although not sure if I post in
>>>the right group:
>>>
>>>Suppose Linux could save the total state of a program to disk, for
>>>instance, imagine a program like mozilla with many open windows. I give
>>>it a SIGNAL-SAVETODISK and the process memory image is dropped to a
>>>file. I can then turn off the computer and later continue using the
>>>program where I left it, by loading it back into memory.
>>>
>>>Would that be possible? At least a program can be given a ctrl-z and is
>>>
>>>
>>
>>there is a LOT of state though.. the moment you add networking in the
>>picture the amount of state just isn't funny anymore. Your X example is
>>a good one as well...
>>
>>
>There are a few cluster/parallel computing libraries out there that are 
>starting to allow "process migration"...
>
>One would assume that "saving it to a disk" is simply a degenerate case of 
>migrating the process...
>
>Presuming they have process migration working (and it seemed close a while 
>ago when I last looked), saving to a file might already be supported...  
>I'd google "process migration" and you are likely to find a lot of 
>discussion on this topic...
>
>/mike
>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>
>>
>>
>

In fact moving processes from one machine to another would be a brilliant 
feature at my work, since we run fairly large and time-consuming simulations 
on electronic circuits. If the kernel could natively support bouncing jobs 
back and forth, that would really be something. Since we simulate with 
proprietary software, I suppose we can't rely on the simulator being 
rewritten to support such special libraries.

Does any other Unix variant have process bouncing already?

_________________________________________________________________
On the road to retirement? Check out MSN Life Events for advice on how to 
get there! http://lifeevents.msn.com/category.aspx?cid=Retirement

