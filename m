Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264983AbSKOSDO>; Fri, 15 Nov 2002 13:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266844AbSKOSDO>; Fri, 15 Nov 2002 13:03:14 -0500
Received: from [195.39.17.254] ([195.39.17.254]:25860 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S264983AbSKOSDN>;
	Fri, 15 Nov 2002 13:03:13 -0500
Date: Fri, 15 Nov 2002 19:09:25 +0100
From: Pavel Machek <pavel@ucw.cz>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swsuspend and CONFIG_DISCONTIGMEM=y
Message-ID: <20021115180924.GA8763@elf.ucw.cz>
References: <20021115081044.GI18180@conectiva.com.br> <20021115084915.GS23425@holomorphy.com> <20021115094827.GT23425@holomorphy.com> <20021115120233.GC25902@atrey.karlin.mff.cuni.cz> <20021115120920.GV23425@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021115120920.GV23425@holomorphy.com>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> I don't know what to make of highmem on laptops etc., but the VM's
> >> conventions should not be that hard to follow; also, there are uses for
> >> the swsusp functionality on other kinds of machines (e.g. checkpointing).
> >> Pure computationally-oriented systems such as would make use of this
> >> are somewhat different from my primary userbase to support, but I think
> >> it would be valuable to generalize swsusp in this way, and so provide
> >> rudimentary support for such users in addition to some small measure of
> >> cleanup (i.e. the cleanup adds functionality).
> >> Pavel, what do you think?
> 
> On Fri, Nov 15, 2002 at 01:02:33PM +0100, Pavel Machek wrote:
> > I definitely want to support swsusp for server boxes, but I'm not 100%
> > sure how to do that easily.
> 
> I'm not entirely sure either. Mostly I suspect that the deep arch
> issues will be the tough ones, but things like this I can handle. =)

Well, I'd really hate to do 64GB support for swsusp for i386. It would
mean wider pointers in on-disk format and probably would not be
exactly nice.

								Pavel

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
