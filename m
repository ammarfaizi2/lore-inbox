Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287872AbSBMRQa>; Wed, 13 Feb 2002 12:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287874AbSBMRQN>; Wed, 13 Feb 2002 12:16:13 -0500
Received: from Expansa.sns.it ([192.167.206.189]:50187 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S287865AbSBMRP7>;
	Wed, 13 Feb 2002 12:15:59 -0500
Date: Wed, 13 Feb 2002 18:15:24 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Oleg Drokin <green@namesys.com>
cc: Alex Riesen <fork0@users.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-dev] 2.5.4-pre1: zero-filled files reiserfs
In-Reply-To: <20020213160851.A894@namesys.com>
Message-ID: <Pine.LNX.4.44.0202131811090.21799-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Feb 2002, Oleg Drokin wrote:

> Hello!
>
> On Wed, Feb 13, 2002 at 12:11:14PM +0100, Luigi Genoni wrote:
>
> > > > I run slackware 8.0.49, and there was no log replaying.
> > then I do a normal reboot in 2.4.17, without any fsck,
> > there is log reply, it is a normal reboot.
My fault, I was willing to write there is NO log reply, and I wrote it
without the NO.
> Some confusion is going on.
> So do you have log replay or you do not have log replay?
>
> > Well, some files get corrupted.
> Ok. That's definitely bad. You said you see corruptions on two boxes, right?
> Is it as simple as boot into 2.5.4, reiserfsck (and see no errors),
> mount an fs, do something, type "reboot" and  reboot into 2.5.4 again,
> and viola - here are zeroed files. Right?
It happened when I did  reboot from 2.5.4-pre1 to 2.5.4, and my
/etc/rc.c/rc.local was full of 0s.
And when I did reboot from 2.5.3 to 2.5.3 on the other box and some c
source I was editing three ours before were full of 0s.
>
> > I saw I am not the only one with this kind of corruption, I remember at
> > less one related mail.
> There was flaky hardware on the other report. And I think Alex Riesen
> cannot reproduce zero files anymore.
>
Those two boxes runned from more than 1 year and no HW problems before..

Luigi

