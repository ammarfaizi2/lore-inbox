Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131498AbRCWWph>; Fri, 23 Mar 2001 17:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131495AbRCWWoJ>; Fri, 23 Mar 2001 17:44:09 -0500
Received: from james.kalifornia.com ([208.179.59.2]:12638 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S131489AbRCWWm0>; Fri, 23 Mar 2001 17:42:26 -0500
Message-ID: <3ABBD11D.FE20FB69@blue-labs.org>
Date: Fri, 23 Mar 2001 14:41:33 -0800
From: David Ford <david@blue-labs.org>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: otto.wyss@bluewin.ch
CC: David Balazic <david.balazic@uni-mb.si>, linux-kernel@vger.kernel.org
Subject: Re: Linux should better cope with power failure
In-Reply-To: <3ABB6B82.62293CAD@uni-mb.si> <3ABBA400.2AEC97E8@bluewin.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Otto Wyss wrote:

> > I had a similar experience:
> > X crashed , hosing the console , so I could not initiate
> > a proper shutdown.
> >
> > Here I must note that the response you got on linux-kernel is
> > shameful.
> >
> Thanks, but I expected it a little bit. All around Linux is centered
> around getting the highest performance out of it and very low (to low
> IMHO) is done to have a save system. The attitude "It doesn't matter
> making mistakes, they get fix anyhow" annoys me most, especially if it
> were easy to prevent them.

No, the correct answer is if you want a reliable recovery then run your disks
in non write buffered mode.  I.e. turn on sync in fstab.

It's all about RTFM and knowing the difference between buffered actions and
nonbuffered.

Everything you need to have a safely clean and proper crash recovery system
already is within your power, you just need to read the man pages and fix
your fstab instead of blaming linux-kernel for bad attitudes.

Yes, it's very easy to prevent e2fsck runs.  Run synchronous or journaled
file systems.

> > > Don't we tell children never go close to any abyss or doesn't have
> > > alpinist a saying "never go to the limits"? So why is this simple rule
> > > always broken with computers?
> > >
> Is there a similar expression which could be hammered into any
> developers mind, i.e. "Don't make errors, others already do them for you".

There is also a very common expression...RTFM.

Please understand what you are doing before you do it, particularly before
you bad mouth others for having a bad attitude.  Don't blame race car makers
for destructive engine failure when you expect it to act like a family car.

-d


--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



