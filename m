Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261399AbSJUPev>; Mon, 21 Oct 2002 11:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261401AbSJUPev>; Mon, 21 Oct 2002 11:34:51 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:15378 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S261399AbSJUPeu>; Mon, 21 Oct 2002 11:34:50 -0400
Message-ID: <3DB42008.5000906@namesys.com>
Date: Mon, 21 Oct 2002 19:40:56 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
Subject: Re: Crunch time continues: the merge candidate list v1.1
References: <200210202303.46848.landley@trommello.org> <20021021144656.GF11594@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>
>  
>
>>9) Hans Reiser said:
>>
>>    
>>
>>>We will send Reiser4 out soon, probably around the 27th.
>>>
>>>Hans
>>>      
>>>
>
>Hans thinks there's a chance in hell that anyone would want to merge
>code that's never actually been posted anywhere yet (do correct me if
>I'm wrong, but not even Hans gave me a straight answer on that one) is
>beyond me.
>
>  
>
It is marked experimental.  This is not an upgrade to "reiserfs", this 
is a completely separate "reiser4" filesystem with no code in common 
that you won't even be aware of unless you click on experimental drivers 
desired.   Please remember that we do a good job with QA, so in 
evangelical efforts to impose a sense of severe feature freeze, please 
target past offenders we won't name here who deserve the attention.  I 
see no point in burdening users when there are bugs we are able to hit 
ourselves, and that is part of why the delay.

Also, last time I spoke with Linus I said that freezes for filesystems 
should occur not less than 6 weeks after freezes for VM and VFS, and he 
agreed with that.  I would prefer not to hold him to his past 
statements, but if I must then I will try to.;-)

On the other hand, if there are persons who would like to give us a hand 
with debugging and tweaking reiser4, we will be happy to send them 
tarballs.  Such tarballs would be for developers, not users.   What we 
need help with on reiser4 is probably just the sort of thing a weekend 
coder can enjoy.  We need people hitting and patching bugs, and we need 
persons carefully employing a profiler and tweaking code paths.  Persons 
who are interested in that would be very appreciated.

So, in summary, we should be included because we harm no other code (we 
are non-core), marked experimental, you know from the past that we will 
get it debugged, by next week we really will be in need of feedback from 
others, and because increasing Linux filesystem performance by 50-105% 
is worth some inconvenience.  

We are currently figuring out why reiser4 went in the last 2 weeks from 
105% faster than V3 to only 50% faster, and we want to fix it before we 
release.  (I am pretty sure I know why it was.)

See www.namesys.com/v4/fast_reiser4.html for some details on what we 
implemented.

Hans

