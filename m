Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289250AbSA3PRq>; Wed, 30 Jan 2002 10:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289243AbSA3PR1>; Wed, 30 Jan 2002 10:17:27 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:55312 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S289241AbSA3PRG>; Wed, 30 Jan 2002 10:17:06 -0500
Message-ID: <3C580E6B.6080905@namesys.com>
Date: Wed, 30 Jan 2002 18:16:59 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020123
X-Accept-Language: en-us
MIME-Version: 1.0
To: Rob Landley <landley@trommello.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>, Ingo Molnar <mingo@elte.hu>,
        linux-kernel@vger.kernel.org, Rik van Riel <riel@conectiva.com.br>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <Pine.LNX.4.33.0201292326110.1428-100000@penguin.transmeta.com> <20020130092100.KCMT17610.femail45.sdc1.sfba.home.com@there>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:

>
>
>This is eleven "top level" maintainers, one of whom is handling ext3 which 
>sounds kind of odd...  (If David Miller is networking and Jeff Garzik is 
>network drivers, would there be a "filesystem drivers" guy paired off with Al 
>Viro?  Does EXT2 go through Andrew Morton as well?  Would Hans Reiser submit 
>directly to you for ReiserFS patches, or should he get a signoff from...  
>Um...  Andrew?  Al?  Try to get it into the -dj tree first?  Could I have a 
>hint?)
>

There is a maintainers list somewhere in the kernel tree.  I am listed 
there as  the ReiserFS maintainer, and I send our patches directly to 
Linus and Marcelo.  I don't think that a filesystems maintainer would be 
easily achieved, since if we agreed about architecture we would have 
written the same filesystems.   We can't even agree about whether 
streams and extended attributes should be implemented as files, and as 
for whether keyword search and database functionality should go into the 
filesystem namespace.....

So, there is a maintainers list, and for many subsystems it works fairly 
well.  For ReiserFS, while I review and approve all patches we accept, 
Oleg Drokin is my patch whirlwind who does the work of testing and 
inspecting line by line for bugs (I inspect more for desirable 
functionality).

ReiserFS has been well-tended by Marcelo, so things are working well for 
us.  Dave Jones tends to 2.5 ReiserFS patches quite nicely also.  None 
of our 2.5 patches are earth-shattering, so I think it is very 
reasonable for Linus to pay attention to, say,  bio stuff for now rather 
than our patches (I am sure he will eventually fold them in from Dave 
Jones's tree.)  I worry more that I haven't had a few hours to brief 
Linus on the strategic direction of Reiser4, and what I think is needed 
longterm to compete with Longhorn, but this is probably my fault for not 
asking him for it.

I know that others have had real problems in this regard, and I don't 
discount them, but ReiserFS patches are going well at this time.

Hans

