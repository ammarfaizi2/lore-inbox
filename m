Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264910AbTBJKaP>; Mon, 10 Feb 2003 05:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264915AbTBJKaP>; Mon, 10 Feb 2003 05:30:15 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:50116 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S264910AbTBJKaO>; Mon, 10 Feb 2003 05:30:14 -0500
Message-ID: <3E47817A.2000504@namesys.com>
Date: Mon, 10 Feb 2003 13:39:54 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: andrea@suse.de, piggin@cyberone.com.au, jakob@unthought.net,
       david.lang@digitalinsight.com, riel@conectiva.com.br,
       ckolivas@yahoo.com.au, linux-kernel@vger.kernel.org, axboe@suse.de,
       vs@namesys.com
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3
 / aa / rmap with contest]
References: <Pine.LNX.4.50L.0302100211570.12742-100000@imladris.surriel.com>	<Pine.LNX.4.44.0302092018180.15944-100000@dlang.diginsite.com>	<20030209203343.06608eb3.akpm@digeo.com>	<20030210045107.GD1109@unthought.net>	<3E473172.3060407@cyberone.com.au>	<20030210073614.GJ31401@dualathlon.random>	<3E47579A.4000700@cyberone.com.au>	<20030210080858.GM31401@dualathlon.random>	<20030210001921.3a0a5247.akpm@digeo.com>	<3E477802.8070008@namesys.com> <20030210020602.0ff7d3f5.akpm@digeo.com>
In-Reply-To: <20030210020602.0ff7d3f5.akpm@digeo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Hans Reiser <reiser@namesys.com> wrote:
>  
>
>>reiser4 does directory readahead.  It gets a lot of gain from it. 
>>    
>>
>
>What is "a lot"?
>
>
>  
>
Vladimir Saveliev had the numbers ready at hand after all, and said:

The most noticeable gain is found in the folowing test (not sure that it 
can be considered as effective readahead though): ls -l over directory 
containing 30000 files (named numerically) created in random order :
4.87 with no readahead
2.99 with readahead (which is limited by 25% of ram or by directory and 
all its stat data)

-- 
Hans


