Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262230AbSJFXRP>; Sun, 6 Oct 2002 19:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262252AbSJFXRP>; Sun, 6 Oct 2002 19:17:15 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:62983 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S262230AbSJFXRO>; Sun, 6 Oct 2002 19:17:14 -0400
Message-ID: <3DA0C5C3.3060304@namesys.com>
Date: Mon, 07 Oct 2002 03:22:43 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miquel van Smoorenburg <miquels@cistron.nl>
CC: linux-kernel@vger.kernel.org, jmacd <jmacd@cs.berkeley.edu>,
       Rik van Riel <riel@conectiva.com.br>
Subject: Re: New BK License Problem?
References: <20021006075627.I9032@work.bitmover.com> <Pine.LNX.4.44.0210061718370.9062-100000@localhost.localdomain> <anqa2m$cr4$2@ncc1701.cistron.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg wrote:

>In article <Pine.LNX.4.44.0210061718370.9062-100000@localhost.localdomain>,
>Ingo Molnar  <mingo@elte.hu> wrote:
>  
>
>>so BK cannot be used to access the kernel tree in that case, correct? I'm
>>just wondering where the boundary line is. Eg. if i started working on a
>>versioned filesystem today, i'd not be allowed to use BK. I just have to
>>keep stuff like that in mind when using BK.
>>    
>>
>
>And what if that versioning filesystem got accepted into mainline?
>Every kernel developer would have to buy a BK license.
>
>Either that or a versioning filesystem cannot get into mainline.
>Sorry Hans, no reiser4 in the kernel.
>
>Mike.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>
reiser4 will not contain version control.  I don't know when version 
control will go into ReiserFS.  I do think it should go in eventually 
though, as it makes distributed filesystems more effective if there is 
version control functionality.  We would do something that in no way 
resembled BK.  We would do it after implementing the core distributed 
tree algorithms.  Probably not going to happen in less than 3-5 years. 
 Unless I became a much larger business, it would not have the fancy gui 
and all that, and it would not really be targeted at source code, it 
would be targeted at distributed file system users and applications.  It 
would handle source code only as an accidental side effect.  I don't 
find the version control for programmers market nearly as interesting as 
the version control for distributed/disconnected filesystem users 
market.  Probably Larry could buy a license from us for it, and then do 
his source code targeted stuff on top of it.;-)

But hey, talk to Josh Macdonald, the author of PRCS.  If he wants to 
code it, I'll pay for his time to do it.  Right now, I think he is 
recovering from the stress of working on reiser4, and last we spoke he 
was more interested in doing key based file system security models than 
in adding version control to reiser5.

There are so many features missing from ReiserFS, and I am not really 
picky about what order they go in.....  With Reiser4 we finally have 
storage layer performance "good enough for now", and now we can focus on 
semantic features and fun/easy stuff for a few years.

Hans




