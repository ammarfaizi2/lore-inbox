Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268874AbRG0Ps6>; Fri, 27 Jul 2001 11:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268877AbRG0Pst>; Fri, 27 Jul 2001 11:48:49 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:29964 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S267695AbRG0Psk>; Fri, 27 Jul 2001 11:48:40 -0400
Message-ID: <3B618CF2.5C105903@namesys.com>
Date: Fri, 27 Jul 2001 19:46:58 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Joshua Schmidlkofer <menion@srci.iwpsd.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <E15Q9Bw-0005q5-00@the-village.bc.nu> <0107270926070B.06707@widmers.oce.srci.oce.int>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Well, I am afraid this is much too vague for me to have any understanding of what went wrong on your
system.

Maybe somebody else who is using both ReiserFS and RedHat's boot scripts can comment on whether
things are slow for them and if so, where they get slow.

With this lack of specificity is entirely possible that things went slow for coincidental reasons
unrelated to ReiserFS (waiting for network stuff to timeout, etc.)

Hans

Joshua Schmidlkofer wrote:
> 
> On Friday 27 July 2001 09:06 am, Alan Cox wrote:
> > > Don't use RedHat with ReiserFS, they screw things up so many ways.....
> > > For instance, they compile it with the wrong options set, their boot
> > > scripts are wrong, they just shovel software onto the CD.
> >
> > Sorry Hans you can rant all you like but you know you are wrong on most
> > of that. RH did weeks of stress testing on multiple systems up to 8Gb 8 way
> > and didn't ship until we stopped seeing corruption problems with the mm/fs
> > code.
> >
> > That test suite caught bugs in kernel revisions other vendors shipped
> > blindly to their customers without fixing.
> >
> > That is hardly shovelling software onto the CD.
> >
> > > Actually, I am curious as to exactly how they manage to make ReiserFS
> > > boot longer than ext2.  Do they run fsck or what?
> >
> > No. The only thing I can think of that might slow it is that we build with
> > the reiserfs paranoia/sanity checks on. Thats because at the time 7.1 was
> > done the kernel list was awash with reiserfs bug reports and Chris Mason
> > tail recursion bug patch of the week.
> >
> > That might be something to check to get a fair comparison
> 
>    I feel that things are actually progressing above my level of perception
> here, however, I would like to mention that since my Redhat 4.x days i have
> feared vendor kernels, and I never use them, for better or worse.
> 
>     Also, maybe I screwed my own system - I don't think so, but maybe.  I
> prefer to stick with Linus's kernels, and sometimes, depending on the
> changlog -ac kernels.  As far as the kernel & init scirpts are concerned, I
> axed any fsck'ing entries for reiserfs.   [I assume that they were
> unnessecary.]  I used kgcc [w/Rh7.1] to compile kernels, until recently.  And
> I stayed current with the lkml, and the namesys page watching for obvious
> updates that I needed.
> 
>     The slowness [seemed] actually [to be] the process of starting & stopping
> daemons.  Almost like there was some sort of stigma about reading shell
> scripts.  All the binaries executed with appropriate haste.
> 
>    As far as shoveling code.   Sometimes the options used to compile packages
> leaves me with a large bit of wonder.  Strange and seemingly heinous changes
> to the various utilities, etc.   But, I have never had a cause to fault them
> based on this. [Except that I have never found the magic that causes all the
> SRPMS to be [re]buildable.]
> 
>   So to sort it, I don't feel that being a moron caused to boot slow - unless
> there is some wierd filehandling problem in bash2, or something that causes
> severe slow-down when sourcing shell scripts.  ????   However, Hans, I do
> beleive you about Suse, and if I wasn't a cheap bastard I would probably buy
> a copy.
> 
> thanks for all the response, and I am sorry if this does not belong here.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
