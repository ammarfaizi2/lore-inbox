Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288050AbSBRWDY>; Mon, 18 Feb 2002 17:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288071AbSBRWDO>; Mon, 18 Feb 2002 17:03:14 -0500
Received: from [194.25.47.66] ([194.25.47.66]:36877 "HELO brenner.novaville.de")
	by vger.kernel.org with SMTP id <S288050AbSBRWDK>;
	Mon, 18 Feb 2002 17:03:10 -0500
Date: Mon, 18 Feb 2002 23:03:04 +0100 (CET)
From: Oliver Hillmann <oh@novaville.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: jiffies rollover, uptime etc.
In-Reply-To: <E16cvzs-0006y2-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10202182300110.15215-100000@rimini.novaville.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2002, Alan Cox wrote:

> > counter, and I'm currently digging into that area... Stuff like a pc
> > speaker driver going wild bothers me a bit more...
> 
> Fix the speaker driver I guess is the answer. It shouldnt have done that.

Well, yeah.. So if its just the speaker driver I might sleep better
now :)

> > Could anybody perhaps tell me why he/she doesn't consider this a
> > problem? And is there a fundamental problem with solving this in
> > general? (I do see a problem with defining jiffies long long on x86,
> > because it might break a lot of things and probably wouldnt perform
> > as often as jiffies is touched... And you might sense I haven't
> > been into kernel hacking much...)
> 
> Counting in long long is expensive and the drivers are meant to all use
> roll over safe compares

Yes, that's what I thought of, long long being too expensive. And
since jiffies doesn't seem to have a problem with rolling over, I
might try to hack the uptime-releated code a bit for myself... If
nobody isn't going like "DONT! THAT'S A VERY BAD IDEA FOR THIS AND
THIS REASON!" :)

Thanks

Oliver

