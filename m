Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261287AbSJLWNy>; Sat, 12 Oct 2002 18:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261291AbSJLWNx>; Sat, 12 Oct 2002 18:13:53 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:15110 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S261287AbSJLWNx>; Sat, 12 Oct 2002 18:13:53 -0400
Message-ID: <3DA89FFD.6010803@namesys.com>
Date: Sun, 13 Oct 2002 02:19:41 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-15?Q?Dieter_N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: Linux v2.5.42
References: <200210122220.29381.Dieter.Nuetzel@hamburg.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dieter Nützel wrote:

>>>>Should EVMS be included, the team will make it our top priority to
>>>>resolve the disputed design issues. If the ruling should be that some of
>>>>our design decisions must change, so be it, we will comply. Certainly
>>>>some changes can not be done by the 20th or 31st, however I feel
>>>>the team can handle most changes before 2.6 ships.
>>>>        
>>>>
>>>Thats good to hear. Right now the debate appears to be - "users: please
>>>add EVMS" "hackers: oh my god no" - so you got the feature set right it
>>>seems
>>>      
>>>
>>Obvious point:
>>
>>* Linus can always thaw the tree after 31st just for one addition, if
>>something _really_ needs to be added for 2.6
>>    
>>
>
>Beside EVMS there is another one: Reiser4
>Getting such an FS "for free" is worth it.
>http://www.namesys.com/v4/v4.html
>
>Hans, can you please send a summary of the "new" FS limits?
>PB/EB, etc.? ;-)
>
>Regards,
>	Dieter
>
>  
>
The new size limits are those of the Linux VFS layer (we use 64 bit 
numbers most places so that if we port to another architecture, or ia64 
becomes viable....).   I don't think anyone will find them motivating.  

Dramatic performance gains while offering transactional FS operations 
(wandering logs work, woohoo!), plugins, scalability due to per node 
locking, obsoleting a whole slew of traditional database tree algorithms 
for better performance, those are motivating.  Wait for Linux Journal to 
come out, it will have the benchmarks, and you'll see what I mean by 
dramatic.   It will be good enough that we can focus mostly on getting 
the semantics in place for the competition with OFS.

Hans


