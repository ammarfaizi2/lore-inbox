Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261599AbSLPXwS>; Mon, 16 Dec 2002 18:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261644AbSLPXwS>; Mon, 16 Dec 2002 18:52:18 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:1420 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S261599AbSLPXwR>;
	Mon, 16 Dec 2002 18:52:17 -0500
Message-ID: <3DFE690D.7000602@namesys.com>
Date: Tue, 17 Dec 2002 03:00:13 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>, linux-kernel@vger.kernel.org,
       Chris Mason <mason@suse.com>
Subject: Re: [Benchmark] AIM9 results
References: <20021216225257.5871.qmail@linuxmail.org> <3DFE5D3B.4030402@namesys.com> <3DFE60EC.3DDA2669@digeo.com> <3DFE63D3.B4D3308B@digeo.com>
In-Reply-To: <3DFE63D3.B4D3308B@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Andrew Morton wrote:
>  
>
>>Hans Reiser wrote:
>>    
>>
>>>Andrew and Chris, are these changes in performance definitely due to VM
>>>changes (and not some difference I am not thinking of between 2.5 and
>>>2.4 reiserfs code)?
>>>
>>>      
>>>
>>aim9 is just doing
>>
>>        for (lots)
>>                close(creat(filename))
>>    
>>
>                  unlink(filename);	/* of course */
>
>
>  
>
Oh, commercial fs vendors must really love tuning for this benchmark.... 
sigh....

Hans

