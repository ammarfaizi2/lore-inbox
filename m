Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbUBZB26 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 20:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262599AbUBZB26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 20:28:58 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:16804 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S262593AbUBZB2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 20:28:50 -0500
Message-ID: <403D4BBD.608@matchmail.com>
Date: Wed, 25 Feb 2004 17:28:29 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
CC: linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.3-mm3
References: <20040222172200.1d6bdfae.akpm@osdl.org> <403D1347.8090801@matchmail.com> <403D468D.2090901@cyberone.com.au> <200402260217.49239@WOLK>
In-Reply-To: <200402260217.49239@WOLK>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc-Christian Petersen wrote:
> On Thursday 26 February 2004 02:06, Nick Piggin wrote:
> 
> Hi,
> 
> 
>>>>>What about Nick's fix up patch for the two patches above?  Should I
>>>>>include that one also?
>>>
>>>I'm running 2.6.3-mm3-486-fazok (nick's patch), and it has improved my
>>>slab usage greatly.  It was averaging 500MB-700MB slab.  Now slab is
>>>~230MB, and page cache is ~700MB
>>
>>That is a much better sounding ratio. Of course that doesn't mean much
>>if performance is worse. Slab might be getting reclaimed a little bit
>>too hard vs pagecache now.
> 
> 
> sorry for not following this thread, but where do I find the mm3 rollup patch 
> this thread is talking about? akpm's directory does not contain it, or I am 
> blind b/c it isn't named like that or similar ;>

It's just the regular ~2MB bz2 file you normally get (ie, it's not 
"split-out" like in the directory where all patches are seperate...)
