Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129192AbRBUU0Y>; Wed, 21 Feb 2001 15:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129341AbRBUU0O>; Wed, 21 Feb 2001 15:26:14 -0500
Received: from 64-42-29-14.atgi.net ([64.42.29.14]:36402 "HELO
	mail.clouddancer.com") by vger.kernel.org with SMTP
	id <S129192AbRBUU0H>; Wed, 21 Feb 2001 15:26:07 -0500
From: Colonel <klink@clouddancer.com>
To: ttsig@tuxyturvy.com
Cc: james@pcxperience.com, linux-kernel@vger.kernel.org
In-Reply-To: <003701c09b75$59f56ff0$25040a0a@zeusinc.com>
	(ttsig@tuxyturvy.com)
Subject: Re: Reiserfs, 3 Raid1 arrays, 2.4.1 machine locks up
Reply-To: klink@clouddancer.com
In-Reply-To: <3A91A6E7.1CB805C1@pcxperience.com> <96s93d$hh6$1@lennie.clouddancer.com> <20010220135326.013DF682A@mail.clouddancer.com> <3A92AA23.9A0BAC43@pcxperience.com> <20010220181849.F1C68682B@mail.clouddancer.com> <003701c09b75$59f56ff0$25040a0a@zeusinc.com>
Message-Id: <20010221202602.CC2E5682A@mail.clouddancer.com>
Date: Wed, 21 Feb 2001 12:26:02 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Tom Sightler" <ttsig@tuxyturvy.com>
   Cc: <linux-kernel@vger.kernel.org>
   Date: Tue, 20 Feb 2001 14:43:07 -0500
   Content-Type: text/plain;
	   charset="iso-8859-1"

   >    > >I'm building a firewall on a P133 with 48 MB of memory using RH 7.0,
   >    > >latest updates, etc. and kernel 2.4.1.
   >    > >I've built a customized install of RH (~200MB)  which I untar onto
   the
   >    > >system after building my raid arrays, etc. via a Rescue CD which I
   >    > >created using Timo's Rescue CD project.  The booting kernel is
   >    > >2.4.1-ac10, no networking, raid compiled in but raid1 as a module
   >    >
   >    > Hmm, raid as a module was always a Bad Idea(tm) in the 2.2 "alpha"
   >    > raid (which was misnamed and is 2.4 raid).  I suggest you change that
   >    > and update, as I had no problems with 2.4.2-pre2/3, nor have any been
   >    > posted to the raid list.
   >
   >    I just tried with 2.4.1-ac14, raid and raid1 compiled in and it did the
   >    same thing.  I'm going to try to compile reiserfs in (if I have enough
   room
   >    to still fit the kernel on the floppy with it's initial ramdisk, etc.)
   and
   >    see what that does.

   There seem to be several reports of reiserfs falling over when memory is
   low.  It seems to be undetermined if this problem is actually reiserfs or MM
   related, but there are other threads on this list regarding similar issues.
   This would explain why the same disk would work on a different machine with
   more memory.  Any chance you could add memory to the box temporarily just to
   see if it helps, this may help prove if this is the problem or not.


If you caught the end of the thread, james (the initial poster) added
memory, had no problems, removed the extra memory and still had no
problems.  His spare memory is greater than my memory total.  I too
cannot repeat the freeze.  It makes me wonder if there is some
parameter updating in the kernel somehow.

