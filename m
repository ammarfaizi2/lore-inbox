Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287158AbSBMNJN>; Wed, 13 Feb 2002 08:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287764AbSBMNJD>; Wed, 13 Feb 2002 08:09:03 -0500
Received: from angband.namesys.com ([212.16.7.85]:5504 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S287158AbSBMNIz>; Wed, 13 Feb 2002 08:08:55 -0500
Date: Wed, 13 Feb 2002 16:08:51 +0300
From: Oleg Drokin <green@namesys.com>
To: Luigi Genoni <kernel@Expansa.sns.it>
Cc: Alex Riesen <fork0@users.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-dev] 2.5.4-pre1: zero-filled files reiserfs
Message-ID: <20020213160851.A894@namesys.com>
In-Reply-To: <20020213085653.A5957@namesys.com> <Pine.LNX.4.44.0202131206190.19885-100000@Expansa.sns.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0202131206190.19885-100000@Expansa.sns.it>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Feb 13, 2002 at 12:11:14PM +0100, Luigi Genoni wrote:

> > > I run slackware 8.0.49, and there was no log replaying.
> then I do a normal reboot in 2.4.17, without any fsck,
> there is log reply, it is a normal reboot.
Some confusion is going on.
So do you have log replay or you do not have log replay?

> Well, some files get corrupted.
Ok. That's definitely bad. You said you see corruptions on two boxes, right?
Is it as simple as boot into 2.5.4, reiserfsck (and see no errors),
mount an fs, do something, type "reboot" and  reboot into 2.5.4 again,
and viola - here are zeroed files. Right?

> I saw I am not the only one with this kind of corruption, I remember at
> less one related mail.
There was flaky hardware on the other report. And I think Alex Riesen
cannot reproduce zero files anymore.

Bye,
    Oleg
