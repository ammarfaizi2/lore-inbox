Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262610AbRFLODm>; Tue, 12 Jun 2001 10:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262596AbRFLODc>; Tue, 12 Jun 2001 10:03:32 -0400
Received: from smtp.dynatec.com ([206.111.126.213]:57353 "EHLO
	smtp.dynatec.com") by vger.kernel.org with ESMTP id <S262610AbRFLODV>;
	Tue, 12 Jun 2001 10:03:21 -0400
Message-ID: <3B26213C.4000503@dynatec.com>
Date: Tue, 12 Jun 2001 07:03:40 -0700
From: Matt Nelson <mnelson@dynatec.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.4 i686; en-US; rv:0.9.1) Gecko/20010607
X-Accept-Language: en-us
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Any limitations on bigmem usage?
In-Reply-To: <3B255FC1.90501@dynatec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to all that replied.  I've never needed to use so much memory before, and 
was ignorant to how much magic was implemented in the 64G support on IA32. 
Unfortunately, there's not quite enough magic in there for my needs... now to 
find an affordable SMP Alpha system....

Thanks again,

-Matt

Matt Nelson wrote:

> I am about to embark on a data processing software project that will 
> require a LOT of memory (about, ohhh, 6GB or so), and I was wondering if 
> there are any limitations to how one can use very large chunks of memory 
> under Linux. Specifically, is there anything to prevent me from 
> malloc()ing 6GB of memory, then accessing that memory as I would any 
> other buffer?  FYI, the application
> will be buffering a stream of data, then performing a variety of 
> calculations on large blocks of data at a time, before writing it out to 
> a socket.
> 
> I've been eyeing an 8-way Intel box with gobs of memory, but if there 
> are subtle issues with using that much memory, I need to know now.
> 
> I haven't seen this specifcally addressed, so I figured I should ask you 
> folk. Any insights/comments/reccomendations would be greatly appreciated.
> 
> Thanks,
> 
> Matt
> 


-- 
Matthew Nelson
Dynamics Technology, Inc.
21311 Hawthorne Blvd., Suite 300, Torrance, CA 90503-5610
Voice: (310) 543-5433   FAX: (310) 543-2117   Email: mnelson@dynatec.com

