Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315950AbSEGTXJ>; Tue, 7 May 2002 15:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315951AbSEGTXI>; Tue, 7 May 2002 15:23:08 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:64273 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S315950AbSEGTXG>; Tue, 7 May 2002 15:23:06 -0400
Message-ID: <3CD82859.5060707@namesys.com>
Date: Tue, 07 May 2002 23:17:45 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Drokin <green@namesys.com>
CC: Chris Mason <mason@suse.com>, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: [reiserfs-dev] [BK] [2.4] Reiserfs changeset 2 out of 4, please
 apply.
In-Reply-To: <200205071505.g47F5iE04039@namesys.com> <1020785252.32097.165.camel@tiny> <20020507193719.A28170@namesys.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin wrote:

>Hello!
>
>On Tue, May 07, 2002 at 11:27:32AM -0400, Chris Mason wrote:
>  
>
>>> You can get this changeset from bk://thebsh.namesys.com/bk/reiser3-linux-2.4
>>> This changeset are cleaning up reiserfscode, removes stale comments, and
>>> rewrites some "borrowed" functions so that all of the code in reiserfs subdir
>>> should now only belong to NAMESYS.
>>>      
>>>
>>It is the end of a release cycle on a stable kernel with huge changes to
>>the IDE layer, and we have at least one unconfirmed report of problems
>>with reiserfs+IDE after a crash.
>>    
>>
>
>That's true.
>
>  
>
>>This is not the right time to send in cleanups like this, especially
>>when they bits as useless as the stuff below.  #1, #2 and #4 look like
>>valid fixes.  #3 should probably be mixed with the iput deadlock fix
>>like Oleg did in 2.5, and should wait until after 2.4.19.
>>    
>>
>
>#2 and $4 are cleanups, #1 and #3 are bugfixes.
>And iput deadlock fix is too big of a change for 2.4.19, so it is not included.
>Let's see how will it behave in 2.5 first.
>And cleanups are harmless ones, so there is no risk of getting these in.
>
>In short, these changes are not "huge", and mostly non-intrusive.
>
Chris, I had much the same reaction initially, and then I looked at the 
details, and either it fixes a real bug in a simple manner, or it is a 
comment change, etc.  It looks bigger than it is was what I finally 
concluded.  Perhaps there is some detail in which I am wrong, but since 
it was all tested together I didn't feel like picking out just a few 
lines of change to leave out (since that would actually increase the 
risk of introducing a bug).

Hans


