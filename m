Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317371AbSGXQF1>; Wed, 24 Jul 2002 12:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317380AbSGXQF1>; Wed, 24 Jul 2002 12:05:27 -0400
Received: from ip68-9-71-221.ri.ri.cox.net ([68.9.71.221]:40492 "EHLO
	mail.blue-labs.org") by vger.kernel.org with ESMTP
	id <S317371AbSGXQF0>; Wed, 24 Jul 2002 12:05:26 -0400
Message-ID: <3D3ED0E4.9020902@blue-labs.org>
Date: Wed, 24 Jul 2002 12:08:04 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a+) Gecko/20020708
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, John Covici <covici@ccs.covici.com>,
       linux-kernel@vger.kernel.org
Subject: Re: is flock broken in 2.4 or 2.5 kernels or what does this mean?
References: <m37kjmik0g.fsf@ccs.covici.com> <1027441872.31787.139.camel@irongate.swansea.linux.org.uk> <20020723214410.GA3249@werewolf.able.es>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Bmilter: Processing completed, Bmilter version 0.1.0 build 762; timestamp 2002-07-24 12:08:08, message serial number 151360
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Alan)
Actually I posted a "is sendmail on crack?" question last month when 
8.12.5 was released and this was in the release notes.  We got a bunch 
of confirmations that Linux flock() was broken due to the accounting.

David

J.A. Magallon wrote:

>On 2002.07.23 Alan Cox wrote:
>  
>
>>On Tue, 2002-07-23 at 15:41, John Covici wrote:
>>    
>>
>>>In the latest release notes of sendmail I have read the following:
>>>
>>>		NOTE: Linux appears to have broken flock() again.  Unless
>>>			the bug is fixed before sendmail 8.13 is shipped,
>>>			8.13 will change the default locking method to
>>>			fcntl() for Linux kernel 2.4 and later.  You may
>>>			want to do this in 8.12 by compiling with
>>>			-DHASFLOCK=0.  Be sure to update other sendmail
>>>			related programs to match locking techniques.
>>>
>>>Can anyone tell me what this is all about -- is there any basis in
>>>reality for what they are saying?
>>>      
>>>
>>First I've heard of it, so it would be useful if someone has access to
>>the sendmail problem report/test in question that shows it and I'll go
>>find out.
>>
>>    
>>
>
>Perhaps if you have your spool over nfs:
>
>man flock:
>
>NOTES
>       flock(2) does not  lock  files  over  NFS.   Use  fcntl(2)
>       instead:  that  does  work  over NFS, given a sufficiently
>       recent version of Linux and a server which supports  lock­
>       ing.
>
>       flock(2)  and fcntl(2) locks have different semantics with
>       respect to forked processes and dup(2).
>
>  
>

-- 
I may have the information you need and I may choose only HTML.  It's up to
you. Disclaimer: I am not responsible for any email that you send me nor am
I bound to any obligation to deal with any received email in any given
fashion.  If you send me spam or a virus, I may in whole or part send you
50,000 return copies of it. I may also publically announce any and all
emails and post them to message boards, news sites, and even parody sites. 
I may also mark them up, cut and paste, print, and staple them to telephone
poles for the enjoyment of people without internet access.  This is not a
confidential medium and your assumption that your email can or will be
handled confidentially is akin to baring your backside, burying your head in
the ground, and thinking nobody can see you butt nekkid and in plain view
for miles away.  Don't be a cluebert, buy one from K-mart today.


