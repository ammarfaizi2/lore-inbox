Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132399AbRCZKXW>; Mon, 26 Mar 2001 05:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132400AbRCZKXN>; Mon, 26 Mar 2001 05:23:13 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:47888 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S132399AbRCZKWy>;
	Mon, 26 Mar 2001 05:22:54 -0500
Date: Mon, 26 Mar 2001 12:22:08 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: Linux should better cope with power failure
To: David Ford <david@blue-labs.org>
Cc: otto.wyss@bluewin.ch, linux-kernel@vger.kernel.org
Message-id: <3ABF1850.669E71C4@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.7 [en] (WinNT; U)
Content-type: text/plain; charset=iso-8859-2
Content-transfer-encoding: 7bit
X-Accept-Language: en
In-Reply-To: <3ABB6B82.62293CAD@uni-mb.si> <3ABBA400.2AEC97E8@bluewin.ch>
 <3ABBD11D.FE20FB69@blue-labs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David ( Ford ) , I think you are misunderstanding a bit here.
The problem here is not that a fsck is needed after an unclean umount,
but that users are forced to corrupt ( by unclean umount due to reset or
poweroff ) their perfectly good file system on a "perfectly" working
system, when their keyboard goes wacko ( happens more often than you might
think, just remember those "log in over net and run 'shutdown -r'" advice's )

David Ford wrote:
> 
> Otto Wyss wrote:
> 
> > > I had a similar experience:
> > > X crashed , hosing the console , so I could not initiate
> > > a proper shutdown.
> > >
> > > Here I must note that the response you got on linux-kernel is
> > > shameful.
> > >
> > Thanks, but I expected it a little bit. All around Linux is centered
> > around getting the highest performance out of it and very low (to low
> > IMHO) is done to have a save system. The attitude "It doesn't matter
> > making mistakes, they get fix anyhow" annoys me most, especially if it
> > were easy to prevent them.
> 
> No, the correct answer is if you want a reliable recovery then run your disks
> in non write buffered mode.  I.e. turn on sync in fstab.
> 
> It's all about RTFM and knowing the difference between buffered actions and
> nonbuffered.
> 
> Everything you need to have a safely clean and proper crash recovery system
> already is within your power, you just need to read the man pages and fix
> your fstab instead of blaming linux-kernel for bad attitudes.
> 
> Yes, it's very easy to prevent e2fsck runs.  Run synchronous or journaled
> file systems.
> 
> > > > Don't we tell children never go close to any abyss or doesn't have
> > > > alpinist a saying "never go to the limits"? So why is this simple rule
> > > > always broken with computers?
> > > >
> > Is there a similar expression which could be hammered into any
> > developers mind, i.e. "Don't make errors, others already do them for you".
> 
> There is also a very common expression...RTFM.
> 
> Please understand what you are doing before you do it, particularly before
> you bad mouth others for having a bad attitude.  Don't blame race car makers
> for destructive engine failure when you expect it to act like a family car.
> 
> -d
> 
> --
>   There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
>   The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum


-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
