Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317325AbSGIGrq>; Tue, 9 Jul 2002 02:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317324AbSGIGrp>; Tue, 9 Jul 2002 02:47:45 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:25807 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317320AbSGIGro>;
	Tue, 9 Jul 2002 02:47:44 -0400
Message-ID: <3D2A8779.9070104@us.ibm.com>
Date: Mon, 08 Jul 2002 23:49:29 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: readprofile from 2.5.25 web server benchmark
References: <3D2A8152.7040200@us.ibm.com> <3D2A863D.DC0AF866@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Dave Hansen wrote:
> 
>>...
>>and some which help this too: (akpm's smptimers and some smart
>>updating logic)
>>    5822 mod_timer                                 24.2583
> 
> Ingo's smptimers.  akpm's "don't mod the timer if it won't change
> anything" tweak.

I think Martin Bligh has told me that about 20 times.  I keep 
attributing it to you :)

> I'd be interested in the effect of the latter.  It's very 2.4-able.

Do you mean 2.5-able?
http://www.google.com/search?hl=en&ie=UTF-8&oe=UTF-8&q=smptimers+2.5

I found a couple of 2.5.*teen patches, but they're miles away from 
applying cleanly.  Work for tomorrow, sigh...

-- 
Dave Hansen
haveblue@us.ibm.com

