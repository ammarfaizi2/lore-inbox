Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261508AbSJHIp7>; Tue, 8 Oct 2002 04:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261554AbSJHIp7>; Tue, 8 Oct 2002 04:45:59 -0400
Received: from k100-28.bas1.dbn.dublin.eircom.net ([159.134.100.28]:51977 "EHLO
	corvil.com.") by vger.kernel.org with ESMTP id <S261508AbSJHIp6>;
	Tue, 8 Oct 2002 04:45:58 -0400
Message-ID: <3DA29C17.1020005@corvil.com>
Date: Tue, 08 Oct 2002 09:49:27 +0100
From: Padraig Brady <padraig.brady@corvil.com>
Organization: Corvil Networks
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Daniel Phillips <phillips@arcor.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Oliver Neukum <oliver@neukum.name>, Rob Landley <landley@trommello.org>,
       linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not
 3.0  -  (NUMA))
References: <Pine.LNX.4.33.0210071455070.1337-100000@penguin.transmeta.com> <E17yfxq-0003vd-00@starship> <3DA206C3.9AD2941A@digeo.com>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Daniel Phillips wrote:
> 
>>On Monday 07 October 2002 23:55, Linus Torvalds wrote:
>>
>>>On Mon, 7 Oct 2002, Daniel Phillips wrote:
>>>
>>>>>Sure. The mey is:
>>>>
>>>>            ^^^ <---- "bet" ?
>>>
>>>Yeah. What the heck happened to my fingers?
>>
>>Apparently, one of them missed the key it was aiming for and the other one
>>changed hands.
>>
> 
> They don't call him Kubys for nothing.
> 
> I dug out and dusted off Al's Orlov allocator patch.  And found
> a comment which rather helps explain how it works.
> 
> I performance tested this back in November.  See
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0111.1/0281.html
> 
> Bottom line: it's as good as the use-first-fit-everywhere
> approach, and appears to have better long-term antifragmentation
> characteristics.
> 
> I shall test it.

See dirpref (Orlov's allocator) here:
http://www.maths.tcd.ie/~dwmalone/p/usenix02.pdf
I was going to do this myself but of course it's
already done, silly me.

Pádraig.

