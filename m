Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265355AbRF0SWx>; Wed, 27 Jun 2001 14:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265354AbRF0SWp>; Wed, 27 Jun 2001 14:22:45 -0400
Received: from james.kalifornia.com ([208.179.59.2]:62267 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S265350AbRF0SWb>; Wed, 27 Jun 2001 14:22:31 -0400
Message-ID: <3B3A23C5.6070601@kalifornia.com>
Date: Wed, 27 Jun 2001 11:19:49 -0700
From: Ben Ford <ben@kalifornia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.1+) Gecko/20010625
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, progeny-debian@lists.progeny.com
Subject: Re: mixer    (was: eye candy)
In-Reply-To: <20010627175440.A2562@progeny> <3B3A10D9.6040605@kalifornia.com> <3B3A13EE.9000906@webninja.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Caleb Shay wrote:

> I'm thinking that this may be a gmix bug as ANY other mixer I try 
> works (so I've just switched to using aumix-gtk).  However, it's 
> probably a kernel bug also since now "cat /dev/sndstat" no longer 
> returns anything. I'm assuming (though I haven't looked at the source) 
> that gmix checks sndstat to see what card(s) you have while other 
> mixers just attempt to open /dev/mixer.  gmix's solution is actually 
> better since it lets it handle multiple soundcards/mixers, so ignore 
> my first statement.  This is a kernel bug.



Are you sure of that?  I have another box that works fine, including 
gmix.  However, cat /dev/sndstat give me the no such device error.


>> This sounds as if it is a known problem.  I just installed a Progeny 
>> box for my wife and recompiled a kernel for her box.  There is sound 
>> support, but gmix won't work.  It says "no mixers found".  However, 
>> the gnome panel applet for volume will work just fine.
>>
>> What do I need to do to take care of this?
>>
>> -b
>>
>> (Yamaha YMF724, 2.4.5 kernel)
>>


-- 
:    __o
:   -\<,
:   0/ 0
-----------



