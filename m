Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289853AbSBNFvZ>; Thu, 14 Feb 2002 00:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289775AbSBNFvQ>; Thu, 14 Feb 2002 00:51:16 -0500
Received: from angband.namesys.com ([212.16.7.85]:39043 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S289850AbSBNFvG>; Thu, 14 Feb 2002 00:51:06 -0500
Date: Thu, 14 Feb 2002 08:50:59 +0300
From: Oleg Drokin <green@namesys.com>
To: Luigi Genoni <kernel@Expansa.sns.it>
Cc: Alex Riesen <fork0@users.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-dev] 2.5.4-pre1: zero-filled files reiserfs
Message-ID: <20020214085059.B5605@namesys.com>
In-Reply-To: <20020213160851.A894@namesys.com> <Pine.LNX.4.44.0202131811090.21799-100000@Expansa.sns.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0202131811090.21799-100000@Expansa.sns.it>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Feb 13, 2002 at 06:15:24PM +0100, Luigi Genoni wrote:
> It happened when I did  reboot from 2.5.4-pre1 to 2.5.4, and my
> /etc/rc.c/rc.local was full of 0s.
> And when I did reboot from 2.5.3 to 2.5.3 on the other box and some c
> source I was editing three ours before were full of 0s.
There was a bug in kernels up to 2.5.4-pre1 (2.5.4-pre2 had a fix),
which had similar symtoms.

> > > I saw I am not the only one with this kind of corruption, I remember at
> > > less one related mail.
> > There was flaky hardware on the other report. And I think Alex Riesen
> > cannot reproduce zero files anymore.
> Those two boxes runned from more than 1 year and no HW problems before..
Great.
Thing is if you able to reproduce on 2.5.4-pre2+ without rebooting into earlier
2.5 kernels in-between tries, then it will mean something is not right even 
in latest kernels.

Bye,
    Oleg
