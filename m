Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261552AbSKCBCu>; Sat, 2 Nov 2002 20:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261553AbSKCBCu>; Sat, 2 Nov 2002 20:02:50 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:33176 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S261552AbSKCBCq>; Sat, 2 Nov 2002 20:02:46 -0500
Message-ID: <3DC47735.9060206@namesys.com>
Date: Sat, 02 Nov 2002 17:09:09 -0800
From: reiser <reiser@namesys.com>
Reply-To: reiser@namesys.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Cliff White <cliffw@osdl.org>
CC: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       Oleg Drokin <green@namesys.com>, Nikita Danilov <Nikita@namesys.com>
Subject: Re: We need help benchmarking and debugging reiser4
References: <200211012236.gA1MaqT20507@mail.osdl.org>
In-Reply-To: <200211012236.gA1MaqT20507@mail.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cliff White wrote:

>>Can some of you help us by doing such things as replicating our 
>>benchmarks, and helping us debug it as we enter the last stretch before 
>>Halloween?
>>
>>    
>>
>
>We are interested in helping, but i haven't seen the follow-up mail 
>mentioned below - if you could send us some more specifics, we'd be
>glad to join the fun.
>cliffw
>OSDL
>
>  
>
>>Nikita and Oleg will describe the details of what to do to replicate the 
>>benchmarks, please be sure to use reiser4 readdir order for writes to 
>>reiser4 (that means don't use tarballs made from ext2 (Remember that 
>>writes determine subsequent read performance.)), and to use the latest 
>>hard drives and fast processors with udma 5 turned on.  We are quite 
>>sensitive to transfer speed since we do a good job of avoiding seeks.  
>>We are sensitive to readdir order because we sort directory entries 
>>(which is necessary for having efficient large directory lookups).   In 
>>reiser4.1 we will ship a repacker, and then it won't matter what order 
>>you do writes in so long as the repacker gets a chance to run at night.  
>>
>>-- 
>>Hans
>>
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>
>>    
>>
>
>
>
>
>  
>
Cliff, has there been a russian timezone working day since you requested 
it?  (I don't have access to your original email at the moment.) If 
there has been, then Nikita, please explain why the request was lost, 
and assure me that next time it goes into someone's todo list, and gets 
responded to on the same day.

Hans

