Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262595AbUBZBdK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 20:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262599AbUBZBdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 20:33:10 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:20420 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S262595AbUBZBdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 20:33:04 -0500
Message-ID: <403D4CBE.9080805@matchmail.com>
Date: Wed, 25 Feb 2004 17:32:46 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm3
References: <20040222172200.1d6bdfae.akpm@osdl.org>	<403BCE9E.7080607@matchmail.com> <20040224143025.36395730.akpm@osdl.org> <403D1347.8090801@matchmail.com> <403D468D.2090901@cyberone.com.au>
In-Reply-To: <403D468D.2090901@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> 
> 
> Mike Fedyk wrote:
> 
>>>
>>>> What about Nick's fix up patch for the two patches above?  Should I 
>>>> include that one also?
>>>
>>>
>>
>> I'm running 2.6.3-mm3-486-fazok (nick's patch), and it has improved my 
>> slab usage greatly.  It was averaging 500MB-700MB slab.  Now slab is 
>> ~230MB, and page cache is ~700MB
>>
> 
> That is a much better sounding ratio. Of course that doesn't mean much
> if performance is worse. Slab might be getting reclaimed a little bit
> too hard vs pagecache now.
> 

I'll let you know.  My graphs are looking better, except for one 
instance of Xvnc (for one user -- I'm still tracking that one down) 
hitting a memory grabbing loop that made me kill it.

>> See:
>> http://www.matchmail.com/stats/lrrd/matchmail.com/srv-lnx2600.matchmail.com-memory.html 
>>
>>
>> Is there any way I can get the VM patches against 2.6.3?  I'm not 
>> comfortable with running -mm3 on this production server, especially 
>> seeing the "sync hang" bug.
>>
> 
> Well your server wasn't going too badly with 2.6.3, wasn't it? Might
> as well just wait for them to get into the the tree.

I might as well take out the third 512MB DIMM in that machine then...

Any chance you could post a VM patch roll-up against 2.6.3 for little 
ole me?

Mike
