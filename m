Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264822AbTBJJtr>; Mon, 10 Feb 2003 04:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264836AbTBJJtr>; Mon, 10 Feb 2003 04:49:47 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:9412 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S264822AbTBJJtq>;
	Mon, 10 Feb 2003 04:49:46 -0500
Message-ID: <3E477802.8070008@namesys.com>
Date: Mon, 10 Feb 2003 12:59:30 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Andrea Arcangeli <andrea@suse.de>, piggin@cyberone.com.au,
       jakob@unthought.net, david.lang@digitalinsight.com,
       riel@conectiva.com.br, ckolivas@yahoo.com.au,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3
 / aa / rmap with contest]
References: <Pine.LNX.4.50L.0302100211570.12742-100000@imladris.surriel.com>	<Pine.LNX.4.44.0302092018180.15944-100000@dlang.diginsite.com>	<20030209203343.06608eb3.akpm@digeo.com>	<20030210045107.GD1109@unthought.net>	<3E473172.3060407@cyberone.com.au>	<20030210073614.GJ31401@dualathlon.random>	<3E47579A.4000700@cyberone.com.au>	<20030210080858.GM31401@dualathlon.random> <20030210001921.3a0a5247.akpm@digeo.com>
In-Reply-To: <20030210001921.3a0a5247.akpm@digeo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Andrea Arcangeli <andrea@suse.de> wrote:
>  
>
>>BTW, one thing that should definitely do readhaead and it's
>>not doing that (at least in 2.4) is the readdir path, again to generate
>>big commands, no matter the seeks.  It was lost with the directory in
>>pagecache.
>>    
>>
>
>Yes.  But ext3 is still doing directory readahead, and I have never
>noticed it gaining any particular benefit over ext2 from it.
>
>And neither fs performs inode table readahead.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>
reiser4 does directory readahead.  It gets a lot of gain from it. 

-- 
Hans


