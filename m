Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267832AbTBJMvO>; Mon, 10 Feb 2003 07:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267834AbTBJMvN>; Mon, 10 Feb 2003 07:51:13 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:46794 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S267832AbTBJMvL>; Mon, 10 Feb 2003 07:51:11 -0500
Message-ID: <3E47A283.3080406@namesys.com>
Date: Mon, 10 Feb 2003 16:00:51 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: andrea@suse.de, piggin@cyberone.com.au, jakob@unthought.net,
       david.lang@digitalinsight.com, riel@conectiva.com.br,
       ckolivas@yahoo.com.au, linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3
 / aa / rmap with contest]
References: <3E473172.3060407@cyberone.com.au>	<20030210073614.GJ31401@dualathlon.random>	<3E47579A.4000700@cyberone.com.au>	<20030210080858.GM31401@dualathlon.random>	<20030210001921.3a0a5247.akpm@digeo.com>	<20030210085649.GO31401@dualathlon.random>	<20030210010937.57607249.akpm@digeo.com>	<3E4779DD.7080402@namesys.com>	<20030210101539.GS31401@dualathlon.random>	<3E4781A2.8070608@cyberone.com.au>	<20030210111017.GV31401@dualathlon.random>	<3E478C39.602@namesys.com> <20030210034220.75710fc3.akpm@digeo.com>
In-Reply-To: <20030210034220.75710fc3.akpm@digeo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Hans Reiser <reiser@namesys.com> wrote:
>  
>
>>Is it true that there is no manpage available anywhere for fadvise?
>>
>>    
>>
>
>It's pretty simple.
>
>http://www.opengroup.org/onlinepubs/007904975/functions/posix_fadvise.html
>
>It's also basically unimplementable without the radix tree, so I don't how
>other systems can be doing it.  Maybe they just lock up for a day when
>someone does fadvise64(fd, 0, -1, FADV_DONTNEED) ;)
>
>
>
>  
>
Andrew, don't you think you should write a linux manpage and/or other 
documentation when you add system calls like fadvise to linux?  Also, 
Andrew, your measurements would be a lot more understandable if you did 
not use programs written by you and not present in any linux distro (do 
I understand that correctly?) without defining what they do.  Yes? ;-)

-- 
Hans


