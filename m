Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263899AbSLaRB6>; Tue, 31 Dec 2002 12:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263977AbSLaRB6>; Tue, 31 Dec 2002 12:01:58 -0500
Received: from 132-11-27-206.netunlimited.net ([206.27.11.132]:40197 "EHLO
	mail.sportvision.com") by vger.kernel.org with ESMTP
	id <S263899AbSLaRBx>; Tue, 31 Dec 2002 12:01:53 -0500
Date: Tue, 31 Dec 2002 12:10:15 -0500
Message-Id: <200212311210.AA54722848@mail.sportvision.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "Roberto Peon" <robertopeon@sportvision.com>
Reply-To: <robertopeon@sportvision.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Mark Rutherford <mark@justirc.net>
Subject: Re: Why is Nvidia given GPL'd code to use in closed source drivers?
X-Mailer: <IMail v7.12>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yea, I'm happy I can use my NVidia hardware with linux-x86, however I have no chance of adding render-to-texture support or various other extensions that would make MY life a heck of a lot easier in the longrun. Note that all of those WGL extensions are NOT supported under linux, and somehow, the seem pretty dang important.

On that note, NVidia hasn't done -nothing- as I've heard some people suggest. They havn't even done nothing for the open source community. 

They've made their hardware run on many/most current versions of linux-x86. This encourages more end-user class people with NVidia hardware to use linux. Depending on who you are and what your goals are (i.e. world domination?) this may be a good thing for the community.

I really hate it when people have a knee-jerk reaction to providing binary-only support one way or the other.

There are obvious disadvantages to a binary-only driver/distribution, however you shouldn't overlook that the fact that it works it all is important too! (And yea, I'd like to have the source open too, That should be apparant from my first paragraph)



-Roberto JP
robertopeon@sportvision.com


---------- Original Message ----------------------------------
From: Mark Rutherford <mark@justirc.net>
Date: 	Tue, 31 Dec 2002 08:49:49 -0500

>I doubt this would 'destroy the community'...
>Do I like it? Nope.
>But here is the way I look at it...
>Nvidia provides the driver, and it works. it means I can use their cards in
>Linux.
>the Linux drivers, are in my opinion far more superior than the Window$
>drivers.
>After all, you do get the kernel module source code....
>Another thing you must realise is that these companies want to stay in
>buisness and
>just the fact that Nvidia has a linux driver probably torques m$ off as it is
>they do not want to upset this company, lets face it, they are barbaric and
>they are cabable of
>bringing hardware makers to their knees if they wanted to.
>They even have a *BSD driver now....
>I like Nvidia, because they provide me with a driver that I can use, and it
>works.
>I also recall reading that they have code in their driver(s) that belongs to a
>third party, making it
>hard to release the source to the driver without upsetting the third party.
>perhaps one day, they will be able to.
>I dont think we should fault them, at least they give us something, we need to
>focus on the companies that
>give us NOTHING.
>
>end of rant :)
>
>
>
>Andre Hedrick wrote:
>
>> On Tue, 31 Dec 2002 Hell.Surfers@cwctv.net wrote:
>>
>> > Why does the community continue to make pacts with a company that
>> > steals from its rivals, makes pacts with M$, and refuses to clearly GPL
>> > and open source its work on drivers, there is a clear difference between
>> > their use of GPL files, and what the GPL says they can do. You cannot
>> > expect embedded kernel developers to GPL, if you excuse Nvidia, its a
>> > vain hope to grab M$ users, but in the long run it destroys the
>> > community.
>> >
>> > Dean. Three ways to kill yourself, and ive been drove in one...
>>
>> Well let's see:
>>
>> You have no money to hire lawyers.
>> You whine about an issue, that people with lawyers will roast you alive.
>>
>> Are you a customer of Nvidia?
>> If you are not, you have no legal ground to invoke GPL PERIOD!
>> If you are a customer, check to see that they have a GPL/GNU wrapper which
>> is open source and attachs a clean LGPL library object, iirc.
>>
>> Since, there is still a legal and valid LGPL regardless of what FSF has to
>> say, there are revisions of GPL which permit various usages.  Now there
>> are people like yourself who, again have no money, have no lawyers, have
>> a whine, and whimpers over issues that stretch beyond the general scope.
>>
>> Recall the kernel is capable of rejecting non-gpl binary modules; yet it
>> does not!  Regardless of the original intent or scope of the "tainting
>> process", it created more grey than clarity.
>>
>> Now until the kernel forcable rejects loading binary closed source
>> modules, it defaults to quietly approved of the concept regardless what
>> you think, feel, or care.
>>
>> Now what is not clear?
>>
>> If the kernel forces vendors to choose between closed source support or
>> loose the competive edge in their market space, enjoy hunting for the old
>> dusty video cards from the past.  You just limited the scope of hardware
>> which will run on Linux with any usability.
>>
>> Now given the kernel is now so well mixed between people in the past,
>> current, and dead developers (sigh Leonard Z :-(( ), how are you going to
>> hurd all togather to agree on a single point?
>>
>> So you submitted a patch, whippty flip ... neither you or I control the
>> license of the kernel.  If Linus does not like the content of a patch or a
>> file generated, well it is toast.  Also where does it state a patch is
>> defined as "GPL patch"?
>>
>> Think a little harder first, cause I and many others will be on the side
>> of slapping down your arguements about preventing binary modules from
>> being loaded.  Key point! "LOADED" not "LINKED".  For the meatballs who
>> think that dumping /proc/kcore is an effective way of generating a newly
>> linked file, remember you created the file, not the owners of the module.
>>
>> Prove you can boot a cat /proc/kcore > vmlinux and you have now linked a
>> closed source object with an open source kernel.  Using your logic from
>> above, you are now the offending person to GPL.  You committed the act of
>> linking the two permanetly.
>>
>> Time for bed, ranting is over ...
>>
>> Cheers,
>>
>> Andre Hedrick
>> LAD Storage Consulting Group
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>
>--
>Regards,
>Mark Rutherford
>mark@justirc.net
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
