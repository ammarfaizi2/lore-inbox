Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318067AbSIJTf4>; Tue, 10 Sep 2002 15:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318076AbSIJTfW>; Tue, 10 Sep 2002 15:35:22 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:11279 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S318067AbSIJTeG>; Tue, 10 Sep 2002 15:34:06 -0400
Message-ID: <3D7E4A4C.4050104@namesys.com>
Date: Tue, 10 Sep 2002 23:38:52 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Oleg Drokin <green@namesys.com>, linux-kernel@vger.kernel.org
Subject: Re: [BK] ReiserFS changesets for 2.4 (performs writes more than 4k
 at a time)
References: <Pine.LNX.4.44.0209101504590.16518-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

>On Tue, 10 Sep 2002, Oleg Drokin wrote:
>
>  
>
>>Hello!
>>
>>On Tue, Sep 10, 2002 at 11:09:38AM -0300, Marcelo Tosatti wrote:
>>    
>>
>>>>  This patch should only go in if 2.4.20 is 3 weeks or more away,
>>>>otherwise it should wait for the next pre1.
>>>>It passes all of our testing, but it is the kind of code that is more
>>>>likely than most to have elusive lurking bugs.  It cannot be tested in
>>>>2.5 first because 2.5 is too broken at this particular moment.  For the
>>>>lkml readers let me say that it also should not go onto any distros
>>>>without three weeks of testing.;-)
>>>>        
>>>>
>>>So lets wait for 2.4.21pre for this one.
>>>We already have enough stuff to be tested on 2.4.20-pre for reiserfs.
>>>      
>>>
>>Please pick up at least the fixes from
>>bk://thebsh.namesys.com/bk/reiser3-linux-2.4
>>I am removed everything related to reiserfs_file_write from there now, so you
>>can just do a pull.
>>    
>>
>
>Huh, now that I released -pre6 _with_ this stuff by accident its too late.
>Silly me.
>
>Can you make me a tree which backouts the big write code please?
>
>Will be releasing a -pre7 shortly due to that.
>
>
>
>  
>
We'll send it to you.  Oleg has gone home and trying his cell phone does 
not reach him, but hopefully he will read his email before bedtime.  

It is not the end of the world though if this goes in....  Oleg sent it 
out for testing, a user hit a bug, and then he fixed the bug and it 
worked for the user.  It passed testing by Oleg and Elena and some 
unknown number of users on our mailing list.  If you are going to 
release in less than 10 days, then it needs to be yanked back out 
though.  If you want to yank it back out anyway, I also understand.  

For now we will assume you want it out, and we'll send you the reverse 
for it.

Hans

