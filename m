Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291713AbSBALhn>; Fri, 1 Feb 2002 06:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291714AbSBALhd>; Fri, 1 Feb 2002 06:37:33 -0500
Received: from [195.63.194.11] ([195.63.194.11]:17159 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S291713AbSBALhW>; Fri, 1 Feb 2002 06:37:22 -0500
Message-ID: <3C56A03C.9070107@evision-ventures.com>
Date: Tue, 29 Jan 2002 14:14:36 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: mingo@elte.hu
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@suse.de>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <Pine.LNX.4.33.0201291527310.5560-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>On Tue, 29 Jan 2002, Martin Dalecki wrote:
>
>>Bla bla bla... Just tell how frequenty do I have to tell the world,
>>that the read_ahead array is a write only variable inside the kernel
>>and therefore not used at all?????!!!!!!!!!!
>>
>tell Jens. He goes about fixing it all, not just the most visible pieces
>that showed how much the Linux block IO code sucked. And guess what? His
>patches are being accepted, and the Linux 2.5 block IO code is evolving
>rapidly. Sometimes keeping broken code around as an incentive to fix it
>*for real* is better than trying to massage the broken code somewhat.
>
There is nothing easier to fix then this. You just have to grep for it, 
or just remove the declaration and wait
to be hit by this during the compilation. And most interrestingly this 
is *easier* then sending a patch!
A patch for this particular problem tend't to
1. Touch many things (however in a trivial way!)
2. Have spurious conflicts in terms of synchronization with the overall 
developement tree of the maintainer
in question.

Now dear linus tell me a better way to deal with *this* kind of problem 
then using CVS for example
where not a single man has the overall controll.

Yes my opinnin is indeed that in reality our problem is that Linus just 
doesn't want to give up
some kind of controll - no more no less.

>
>
>a patch penguin doesnt solve this particular problem, by definition he
>just wont fix the block IO code.
>
>any other 'examples'
>


