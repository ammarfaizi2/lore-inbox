Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130206AbRBTT6L>; Tue, 20 Feb 2001 14:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130514AbRBTT6B>; Tue, 20 Feb 2001 14:58:01 -0500
Received: from www.pcxperience.com ([199.217.242.242]:10996 "EHLO
	gannon.zelda.pcxperience.com") by vger.kernel.org with ESMTP
	id <S130206AbRBTT5v>; Tue, 20 Feb 2001 14:57:51 -0500
Message-ID: <3A92CBE6.A84B7ED3@pcxperience.com>
Date: Tue, 20 Feb 2001 13:56:22 -0600
From: "James A. Pattie" <james@pcxperience.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Tom Sightler <ttsig@tuxyturvy.com>, linux-kernel@vger.kernel.org
Subject: Re: Reiserfs, 3 Raid1 arrays, 2.4.1 machine locks up
In-Reply-To: <3A91A6E7.1CB805C1@pcxperience.com> <96s93d$hh6$1@lennie.clouddancer.com> <20010220135326.013DF682A@mail.clouddancer.com> <3A92AA23.9A0BAC43@pcxperience.com> <20010220181849.F1C68682B@mail.clouddancer.com> <003701c09b75$59f56ff0$25040a0a@zeusinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Sightler wrote:

> >    > >I'm building a firewall on a P133 with 48 MB of memory using RH 7.0,
> >    > >latest updates, etc. and kernel 2.4.1.
> >    > >I've built a customized install of RH (~200MB)  which I untar onto
> the
> >    > >system after building my raid arrays, etc. via a Rescue CD which I
> >    > >created using Timo's Rescue CD project.  The booting kernel is
> >    > >2.4.1-ac10, no networking, raid compiled in but raid1 as a module
> >    >
> >    > Hmm, raid as a module was always a Bad Idea(tm) in the 2.2 "alpha"
> >    > raid (which was misnamed and is 2.4 raid).  I suggest you change that
> >    > and update, as I had no problems with 2.4.2-pre2/3, nor have any been
> >    > posted to the raid list.
> >
> >    I just tried with 2.4.1-ac14, raid and raid1 compiled in and it did the
> >    same thing.  I'm going to try to compile reiserfs in (if I have enough
> room
> >    to still fit the kernel on the floppy with it's initial ramdisk, etc.)
> and
> >    see what that does.
>
> There seem to be several reports of reiserfs falling over when memory is
> low.  It seems to be undetermined if this problem is actually reiserfs or MM
> related, but there are other threads on this list regarding similar issues.
> This would explain why the same disk would work on a different machine with
> more memory.  Any chance you could add memory to the box temporarily just to
> see if it helps, this may help prove if this is the problem or not.
>
> Later,
> Tom

Out of all the old 72 pin simms we have, we have it maxed out at 48 MB's.  I'm
tempted to take the 2 drives out and put them in the k6-2, but that's too much
of a hassle.  I'm currently going to try 2.4.1-ac19 and see what happens.

The machine does have 128MB of swap space working, and whenever I've checked
memory usage (while the system was still responding), it never went over a
couple megs of swap space used.

--
James A. Pattie
james@pcxperience.com

Linux  --  SysAdmin / Programmer
PC & Web Xperience, Inc.
http://www.pcxperience.com/



