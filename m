Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130466AbRBTTn6>; Tue, 20 Feb 2001 14:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130476AbRBTTns>; Tue, 20 Feb 2001 14:43:48 -0500
Received: from [63.95.13.242] ([63.95.13.242]:31254 "EHLO
	zso-powerapp-01.zeusinc.com") by vger.kernel.org with ESMTP
	id <S130466AbRBTTnh>; Tue, 20 Feb 2001 14:43:37 -0500
Message-ID: <003701c09b75$59f56ff0$25040a0a@zeusinc.com>
From: "Tom Sightler" <ttsig@tuxyturvy.com>
To: <klink@clouddancer.com>, <james@pcxperience.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <3A91A6E7.1CB805C1@pcxperience.com> <96s93d$hh6$1@lennie.clouddancer.com> <20010220135326.013DF682A@mail.clouddancer.com> <3A92AA23.9A0BAC43@pcxperience.com> <20010220181849.F1C68682B@mail.clouddancer.com>
Subject: Re: Reiserfs, 3 Raid1 arrays, 2.4.1 machine locks up
Date: Tue, 20 Feb 2001 14:43:07 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

Later,
Tom


