Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932605AbWCOXsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605AbWCOXsS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 18:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752127AbWCOXsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 18:48:18 -0500
Received: from rwcrmhc13.comcast.net ([204.127.192.83]:59853 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1751840AbWCOXsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 18:48:17 -0500
Message-ID: <4418A77D.20309@comcast.net>
Date: Wed, 15 Mar 2006 18:47:09 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: ORMAP
References: <44178429.90808@comcast.net> <44180784.6020608@yahoo.com.au> <44183E75.3080406@comcast.net> <4418A3DC.9010809@yahoo.com.au>
In-Reply-To: <4418A3DC.9010809@yahoo.com.au>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Nick Piggin wrote:
> John Richard Moser wrote:
> 
>> Nick Piggin wrote:
>>
>>> 2.6 has an object based rmap system working nicely for quite
>>> a while now (though it was probably not exactly what you saw
>>> in the -wli tree, but a derivative).
>>>
>>> It would be surprising if that made your system boot 3 times
>>> faster though (unless it was on the edge of a swap storm or
>>> something)
>>>
>>
>> Dramatization.  It was probably around 30 seconds faster on a 2-3 minute
>> boot sequence (I had a lot in rc.d), but it was noticeable :P
>>
>> I was wondering about that stuff.  There used to be a few cute things
>> out there but I can't remember any of it now.  Page clustering etc etc.
>>
>>
> 
> Well I don't think any of that stuff was simply forgotten. Page
> clustering for
> i386, for example became less important because of objrmap, reductions
> in size
> of struct page, and the demise of insane highmem machines (due to x86-64).
> 

Cool cool.  What juicy things are out there these days that will
probably make future kernels faster and more memory-light?  New
schedulers?  Ingo's SLAB rewrite and priority inheritance?

> Nick
> -- 
> 
> Send instant messages to your online friends http://au.messenger.yahoo.com

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                                     -- Evil alien overlord from Blasto
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRBinews1xW0HCTEFAQImWw/7BHYd5gcvV/eeIaBaeNSJfsBX4nKcgdBY
48viuCDoXAmTS+YGNb4bZ6y0I24mzErx6xjynibiBmioh3xmC64uWrnEvY33cN7Z
NxNReGauriJLsyHswKkd5FN0Wsu4HBSq++6KIvUhE+wuE0hhel+Y3GdzD6prlZG4
Suxfm7ft44BhrMjQhypky5tmnB/uqA5DdaATavVwM3F2IOCE9naeSIINgS0z9MQs
VatSJt/lz9C/27SD2Uk6Fj0JbtxlECS7I4sRvf3pLH0XPuojRwq6gTUcd+lFm83T
CDtqAYcirBXtBOO8twXCcrHMEwjcc4ILkxj7tMAz1QIQQ7oMsMdS2ee2fQi+5f/N
vTrH9G0DauFmZIwsCDH46o7p7R9zEhpaVfW7L7WMdVT5VDuf4WL2L/3sug6s8lse
NDm71RdqYPjWfxc1F40V3oIlq0BHWRKhkKHnd//zi2j+Z5GlVLU+wd7jTVr+hIcK
ENIb2Tl1+SajOEWWzRoIsZchMu8KvR1MWP+srCy4jLJMrRgnb2LCZk2vK2uOzLam
RQxxEZZ4lONaTPCJoMJbS7s9rME4tRr1KsQ/JwkMrfnLWdELnITu8BjP/2Jy8ljQ
ElzMcjwREc2MCJHUmuY0cNPCbjn/dMwrQhQAxJQAWcbEt62qr0W+3F3SfGUeUT+Z
M9THE1Fl5z4=
=jO4u
-----END PGP SIGNATURE-----
