Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266606AbRG1Nqe>; Sat, 28 Jul 2001 09:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266641AbRG1NqY>; Sat, 28 Jul 2001 09:46:24 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:5906 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S266606AbRG1NqT>; Sat, 28 Jul 2001 09:46:19 -0400
X-Apparently-From: <kiwiunixman@yahoo.co.nz>
Content-Type: text/plain; charset=US-ASCII
From: Matthew Gardiner <kiwiunixman@yahoo.co.nz>
To: Hans Reiser <reiser@namesys.com>,
        Joshua Schmidlkofer <menion@srci.iwpsd.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
Date: Sun, 29 Jul 2001 01:45:00 +1200
X-Mailer: KMail [version 1.2]
Cc: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0107271515200.10139-100000@devel.blackstar.nl> <0107270818120A.06707@widmers.oce.srci.oce.int> <3B6180CD.9D68CC07@namesys.com>
In-Reply-To: <3B6180CD.9D68CC07@namesys.com>
MIME-Version: 1.0
Message-Id: <01072901450000.02683@kiwiunixman.nodomain.nowhere>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Saturday 28 July 2001 02:55, Hans Reiser wrote:
> Joshua Schmidlkofer wrote:
> > I've almost quit using reiser, because everytime I have a power outage,
> > the last 2 or three files that I've editted, even ones that I haven't
> > touched in a while, will usually be hopelessly corrupted.  The '<file>~'
> > that Emacs makes is usually fine though.   It seems to be that any open
> > file is in danger.  I don't know if this is normal, or not, but I
> > switched to XFS on several machines.  I have nothing against reiser.  I
> > assumed that these problems were due to immaturity....
> >
> >    One more thing - All my computers with Reiser as '/'  on them had a
> > disturbingly long boot time.   From the time when the Redhat startup
> > scripts began, it was.... hideously slow.   I thought nothing of it,
> > blaming bash,
>
> Don't use RedHat with ReiserFS, they screw things up so many ways.....
>
> For instance, they compile it with the wrong options set, their boot
> scripts are wrong, they just shovel software onto the CD.
>
> Use SuSE, and trust me, ReiserFS will boot faster than ext2.
>
> Actually, I am curious as to exactly how they manage to make ReiserFS boot
> longer than ext2.  Do they run fsck or what?
>
> Hans

Regards to the ReiserFS. Something more spookie, OpenLinux (no boos and 
hisses please ;) ), they have ReiserFS as a module, yet, when I have the root 
partition as reiser I have no problems, voo doo magic perhaps? because when I 
compiled 2.4.7 w/ ReiserFS as a module, the boot forks up.

Regarding the last comment, I think Redhat and Caldera have debugging enable 
(God knows why?), well, Caldera definately dones, after having a look at 
their default kernel configuration, hence, when I recompiled my kernel to 
2.4.7, threw the reiserFS into the guts of the kernel with debugging turned 
off, there was a speed increase.

Also, to speed it up, I have heard a urban myth (I am not too sure whether it 
is true), you add the tag notail. A little more disk space is used, however, 
apparently, it is meant to speed up access.

Matthew Gardiner
-- 
WARNING:

This email was written on an OS using the viral 'GPL' as its license.

Please check with Bill Gates before continuing to read this email/posting.

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

