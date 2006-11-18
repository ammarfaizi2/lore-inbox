Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753946AbWKRJVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946AbWKRJVY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 04:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754098AbWKRJVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 04:21:23 -0500
Received: from c-71-197-74-6.hsd1.ca.comcast.net ([71.197.74.6]:24505 "EHLO
	nofear.bounceme.net") by vger.kernel.org with ESMTP
	id S1753946AbWKRJVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 04:21:23 -0500
Message-ID: <455ED08E.1060501@syphir.sytes.net>
Date: Sat, 18 Nov 2006 01:21:18 -0800
From: "C.Y.M" <syphir@syphir.sytes.net>
Reply-To: syphir@syphir.sytes.net
Organization: CooLNeT
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: BUG: warning at fs/inotify.c:181 with linux-2.6.18
References: <452581D7.5020907@syphir.sytes.net> <4525B546.7070305@yahoo.com.au> <6bffcb0e0610141056t44365ab2p3972d0a95dba33da@mail.gmail.com> <45312CDC.8090703@syphir.sytes.net> <4531E80A.6@yahoo.com.au>
In-Reply-To: <4531E80A.6@yahoo.com.au>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>
>> Thank you for the confirmation.  Please include me in this thread if
>> someone
>> finds the answer. This bug seems to occur very frequently on my
>> machine with
>> 2.6.18.1 so I have been forced to revert back to 2.6.17.13 until I can
>> fix it.
> 
> I haven't got around to looking at it yet, sorry.
> 
> It does seem like my inotify scalability patch is involved, however it is
> interesting that you cannot reproduce the problem in 2.6.17.13.
> 
> I probably won't get around to having a look at it for a while, but if you
> would like to speed up the process you could try running a git bisect to
> find which patch is making the error trigger for you.
> 

I finally got around to try 2.6.18.2 and I still seem to have this problem.  Has
anyone had a chance to make a patch for this yet?

Best Regards.

