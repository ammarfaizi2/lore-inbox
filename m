Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267642AbRG0P3I>; Fri, 27 Jul 2001 11:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268145AbRG0P26>; Fri, 27 Jul 2001 11:28:58 -0400
Received: from [208.187.172.194] ([208.187.172.194]:19994 "HELO
	odin.oce.srci.oce.int") by vger.kernel.org with SMTP
	id <S267642AbRG0P2s>; Fri, 27 Jul 2001 11:28:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Joshua Schmidlkofer <menion@srci.iwpsd.org>
To: linux-kernel@vger.kernel.org
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
Date: Fri, 27 Jul 2001 09:26:07 -0600
X-Mailer: KMail [version 1.2]
In-Reply-To: <E15Q9Bw-0005q5-00@the-village.bc.nu>
In-Reply-To: <E15Q9Bw-0005q5-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <0107270926070B.06707@widmers.oce.srci.oce.int>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Friday 27 July 2001 09:06 am, Alan Cox wrote:
> > Don't use RedHat with ReiserFS, they screw things up so many ways.....
> > For instance, they compile it with the wrong options set, their boot
> > scripts are wrong, they just shovel software onto the CD.
>
> Sorry Hans you can rant all you like but you know you are wrong on most
> of that. RH did weeks of stress testing on multiple systems up to 8Gb 8 way
> and didn't ship until we stopped seeing corruption problems with the mm/fs
> code.
>
> That test suite caught bugs in kernel revisions other vendors shipped
> blindly to their customers without fixing.
>
> That is hardly shovelling software onto the CD.
>
> > Actually, I am curious as to exactly how they manage to make ReiserFS
> > boot longer than ext2.  Do they run fsck or what?
>
> No. The only thing I can think of that might slow it is that we build with
> the reiserfs paranoia/sanity checks on. Thats because at the time 7.1 was
> done the kernel list was awash with reiserfs bug reports and Chris Mason
> tail recursion bug patch of the week.
>
> That might be something to check to get a fair comparison

   I feel that things are actually progressing above my level of perception 
here, however, I would like to mention that since my Redhat 4.x days i have 
feared vendor kernels, and I never use them, for better or worse.   

    Also, maybe I screwed my own system - I don't think so, but maybe.  I 
prefer to stick with Linus's kernels, and sometimes, depending on the 
changlog -ac kernels.  As far as the kernel & init scirpts are concerned, I 
axed any fsck'ing entries for reiserfs.   [I assume that they were 
unnessecary.]  I used kgcc [w/Rh7.1] to compile kernels, until recently.  And 
I stayed current with the lkml, and the namesys page watching for obvious 
updates that I needed. 

    The slowness [seemed] actually [to be] the process of starting & stopping 
daemons.  Almost like there was some sort of stigma about reading shell 
scripts.  All the binaries executed with appropriate haste.

   As far as shoveling code.   Sometimes the options used to compile packages 
leaves me with a large bit of wonder.  Strange and seemingly heinous changes 
to the various utilities, etc.   But, I have never had a cause to fault them 
based on this. [Except that I have never found the magic that causes all the 
SRPMS to be [re]buildable.]

  So to sort it, I don't feel that being a moron caused to boot slow - unless 
there is some wierd filehandling problem in bash2, or something that causes 
severe slow-down when sourcing shell scripts.  ????   However, Hans, I do 
beleive you about Suse, and if I wasn't a cheap bastard I would probably buy 
a copy.  

thanks for all the response, and I am sorry if this does not belong here.
