Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288834AbSBMUCf>; Wed, 13 Feb 2002 15:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288821AbSBMUC2>; Wed, 13 Feb 2002 15:02:28 -0500
Received: from dialin-145-254-133-228.arcor-ip.net ([145.254.133.228]:3588
	"EHLO dale.home") by vger.kernel.org with ESMTP id <S288834AbSBMUCM>;
	Wed, 13 Feb 2002 15:02:12 -0500
Date: Wed, 13 Feb 2002 21:01:56 +0100
From: Alex Riesen <fork0@users.sourceforge.net>
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Luigi Genoni <kernel@Expansa.sns.it>
Subject: Re: [reiserfs-dev] 2.5.4-pre1: zero-filled files reiserfs
Message-ID: <20020213210156.A506@steel>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
In-Reply-To: <20020213085653.A5957@namesys.com> <Pine.LNX.4.44.0202131206190.19885-100000@Expansa.sns.it> <20020213160851.A894@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020213160851.A894@namesys.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2002 at 04:08:51PM +0300, Oleg Drokin wrote:
> Hello!
> 
> On Wed, Feb 13, 2002 at 12:11:14PM +0100, Luigi Genoni wrote:
> 
> > > > I run slackware 8.0.49, and there was no log replaying.
> > then I do a normal reboot in 2.4.17, without any fsck,
> > there is log reply, it is a normal reboot.
> Some confusion is going on.
> So do you have log replay or you do not have log replay?
> 
> > Well, some files get corrupted.
> Ok. That's definitely bad. You said you see corruptions on two boxes, right?
> Is it as simple as boot into 2.5.4, reiserfsck (and see no errors),
> mount an fs, do something, type "reboot" and  reboot into 2.5.4 again,
> and viola - here are zeroed files. Right?
> 
> > I saw I am not the only one with this kind of corruption, I remember at
> > less one related mail.
> There was flaky hardware on the other report. And I think Alex Riesen
> cannot reproduce zero files anymore.

Correct. After applying your patch, indeed.
I'm really sorry, i hado no much time to experiment and try
again without the patch. Should i try, btw?

-alex
