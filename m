Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130644AbRBTUJm>; Tue, 20 Feb 2001 15:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130646AbRBTUJc>; Tue, 20 Feb 2001 15:09:32 -0500
Received: from [63.95.13.242] ([63.95.13.242]:63039 "EHLO
	zso-powerapp-01.zeusinc.com") by vger.kernel.org with ESMTP
	id <S130644AbRBTUJZ>; Tue, 20 Feb 2001 15:09:25 -0500
Message-ID: <006b01c09b78$f8dd7e20$25040a0a@zeusinc.com>
From: "Tom Sightler" <ttsig@tuxyturvy.com>
To: "James A. Pattie" <james@pcxperience.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <3A91A6E7.1CB805C1@pcxperience.com> <96s93d$hh6$1@lennie.clouddancer.com> <20010220135326.013DF682A@mail.clouddancer.com> <3A92AA23.9A0BAC43@pcxperience.com> <20010220181849.F1C68682B@mail.clouddancer.com> <003701c09b75$59f56ff0$25040a0a@zeusinc.com> <3A92CBE6.A84B7ED3@pcxperience.com>
Subject: Re: Reiserfs, 3 Raid1 arrays, 2.4.1 machine locks up
Date: Tue, 20 Feb 2001 15:09:03 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > There seem to be several reports of reiserfs falling over when memory is
> > low.  It seems to be undetermined if this problem is actually reiserfs
or MM
> > related, but there are other threads on this list regarding similar
issues.
> > This would explain why the same disk would work on a different machine
with
> > more memory.  Any chance you could add memory to the box temporarily
just to
> > see if it helps, this may help prove if this is the problem or not.
> >
>
> Out of all the old 72 pin simms we have, we have it maxed out at 48 MB's.
I'm
> tempted to take the 2 drives out and put them in the k6-2, but that's too
much
> of a hassle.  I'm currently going to try 2.4.1-ac19 and see what happens.
>
> The machine does have 128MB of swap space working, and whenever I've
checked
> memory usage (while the system was still responding), it never went over a
> couple megs of swap space used.

Ah yes, but, from what I've read, the problem seems to occur when
buffer/cache memory is low (<6MB), you could have tons of swap and still
reach this level.

Later,
Tom


