Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280838AbRLLPlq>; Wed, 12 Dec 2001 10:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280825AbRLLPlh>; Wed, 12 Dec 2001 10:41:37 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:29455 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S280002AbRLLPlY>; Wed, 12 Dec 2001 10:41:24 -0500
Message-ID: <3C177A55.1010200@namesys.com>
Date: Wed, 12 Dec 2001 18:40:05 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: Anton Altaparmakov <aia21@cus.cam.ac.uk>, Nathan Scott <nathans@sgi.com>,
        Andreas Gruenbacher <ag@bestbits.at>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: reiser4 (was Re: [PATCH] Revised extended attributes   interface)
In-Reply-To: <Pine.SOL.3.96.1011212015827.2712B-100000@draco.cus.cam.ac.uk> <5.1.0.14.2.20011212133045.02649740@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:

> At 12:02 12/12/01, Hans Reiser wrote:
>
>> Anton Altaparmakov wrote:
>>
>>> On Wed, 12 Dec 2001, Hans Reiser wrote:
>>>
>>>> Anton Altaparmakov wrote:
>>>>
>>>>> Both MacOS and as of recently Windows do this kind of stuff, too, 
>>>>> and it
>>>>> can't be long before Linux goes the same way, provided file systems
>>>>> support the required features (i.e. EAs and/or named streams) so I
>>>>> disagree with you this is only a compatibility thing. It might 
>>>>> start out
>>>>> as one but it will find real world applications very quickly...
>>>>
>>>> I am not saying that the features of EAs are not useful, I am 
>>>> saying that I want to choose them individually for particular files.
>>>>
>>>> It could be so much better to have EDIBLE_PIZZA (example from 
>>>> previous email) instead of just PIZZA, sigh.
>>>
>>>
>>> I am not quite sure what you mean. Surely you can just have all 
>>> features
>>> available at all times/to all files and then you just use the ones you
>>> want, just ignoring/not using the rest. Why do you see the need for
>>> "selecting features of EAs individually for particular files"? It makes
>>> sense when buying EDIBLE_PIZZA but I don't see how that can be 
>>> transferred
>>> onto files. After all I can just have all pizza ingredients and only 
>>> put
>>> the ones I want on the pizza just ignoring the others.
>>
>> Inheriting stat data from the parent directory should be a feature 
>> available not just for streams, but for all files that want it. 
>> Efficient small file access to a 32 byte file should be a feature 
>> available to all files, not just EAs.  Not being listed in readdir 
>> should be a feature available to all files, not just EAs.  
>> Constraining what is written to them should be a feature available to 
>> all files, not just EAs, and arbitrary plugin based constraints 
>> should be possible.
>>
>> Is this more clear?
>
>
> Yes it is, thanks. And yes it makes sense. But this is talking about 
> files as a whole and has nothing to do with EAs as such (but it would 
> obviously apply to EAs, too under your proposed API). 

There would be no need for EAs if files as a whole could have these 
properties, as EAs would just be particular files with particular 
properties within a directory/file object.

>
>
> I will be looking forward to seeing this stuff implemented. (-:
>
> Anton
>
>

If Linux users get really unlucky, which seems likely, :-/, 2.6 will 
take as long as 2.4, in which case I think we will complete the task in 
plenty of time for 2.6, and we can ask Linus which implementation he 
prefers before he has committed to one in a stable release.

Hans

