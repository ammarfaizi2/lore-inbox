Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262832AbTHZTHn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 15:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262876AbTHZTHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 15:07:42 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:39346 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S262832AbTHZTHh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 15:07:37 -0400
Message-ID: <3F4BB043.6010805@softhome.net>
Date: Tue, 26 Aug 2003 21:08:51 +0200
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: cache limit
References: <oJ5P.699.21@gated-at.bofh.it> <oJ5P.699.23@gated-at.bofh.it> <oJ5P.699.25@gated-at.bofh.it> <oJ5P.699.27@gated-at.bofh.it> <oJ5P.699.19@gated-at.bofh.it> <oQh2.4bQ.13@gated-at.bofh.it>
In-Reply-To: <oQh2.4bQ.13@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> On Tue, Aug 26, 2003 at 12:15:46PM +0200, Ihar 'Philips' Filipau wrote:
>>  If I have 1GB of memory and my applications for use only 16MB - it 
>>doesn't mean I want to fill 1GB-16MB with garbage like file my momy had 
>>viewed two weeks ago.
>>
>>  That's it: OS should scale for *application* *needs*.
>>
>>  Can you compare in your mind overhead of managing 1GB of cache with 
>>managing e.g. 16MB of cache?
>>
> 
> Ok, let's benchmark it.
> 
> Yes, I can see the logic in your argument, but at this point, numbers are
> needed to see if or how much of a win this might be.

   [ I beleive you can see those thread about O_STREAMING patch. 
Not-caching was giving 10%-15% peformance boost for gcc on kernel 
compiles. Isn't that overhead? ]

   I will try to produce some benchmarktings tomorrow with different 
'mem=%dMB'. I'm afraid to confirm that it will make difference.
   But in advance: mantainance of page tables for 1GB and for 128MB of 
RAM are going to make a difference.

