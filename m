Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264359AbRFNBP6>; Wed, 13 Jun 2001 21:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264364AbRFNBPs>; Wed, 13 Jun 2001 21:15:48 -0400
Received: from [213.22.25.8] ([213.22.25.8]:6150 "EHLO vega.net.dhis.org")
	by vger.kernel.org with ESMTP id <S264359AbRFNBPf>;
	Wed, 13 Jun 2001 21:15:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Claudio Martins <ctpm@vega.net.dhis.org>
To: "Daniel" <ddickman@nyc.rr.com>,
        "Linux kernel" <linux-kernel@vger.kernel.org>
Subject: Re: obsolete code must die
Date: Thu, 14 Jun 2001 02:13:29 +0100
X-Mailer: KMail [version 1.2]
In-Reply-To: <01a401c0f46b$20b932e0$480e6c42@almlba4sy7xn6x>
In-Reply-To: <01a401c0f46b$20b932e0$480e6c42@almlba4sy7xn6x>
MIME-Version: 1.0
Message-Id: <01061402132900.00856@vega>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 June 2001 01:44, Daniel wrote:

> -- If someone really needs support for this junk, they will always have the
> option of using the 2.0.x, 2.2.x or 2.4.x series.
>

  You mean you want 2.5+ series to just stop supporting all older hardware?

> So without further ado here're the features I want to get rid of:
>
> i386, i486
> The Pentium processor has been around since 1995. Support for these older
> processors should go so we can focus on optimizations for the pentium and
> better processors.
>

  Allow me to disagree. There are still plenty of those machines around. 
Imagine how many of these are offering some kind of service somewhere on 
Internet... A 100MHz 486 is still a good machine, if your task is computing 
related and not "desktop" related (since most actual desktop systems are not 
happy with less than 64MB RAM and other features no commonly present on 486 
machines ;). I have 486 at home and I intend to continue using it.

> ISA bus, MCA bus, EISA bus
> PCI is the defacto standard. Get rid of CONFIG_BLK_DEV_ISAPNP,
> CONFIG_ISAPNP, etc
>
> ISA, MCA, EISA device drivers
> If support for the buses is gone, there's no point in supporting devices
> for these buses.
>

  Right now I'm listening to my mp3 music in my ESS ISA sound card. If I like 
to listen to music while I work and I have a sound card that works why the 
heck do I need to buy a new PCI one?

>
> parallel/serial/game ports
> More controversial to remove this, since they are *still* in pretty wide
> use -- but USB and IEEE 1394 are the way to go. No ifs ands or buts.
>

   Not so fast with these ones. And serial and parallel ports are sometimes 
very useful, especially if you deal with electronics and/or are involved in 
prototipe electronics and similar (although I'm trying to move to the much 
better USB port :)


> I really think doing a clean up is worthwhile. Maybe while looking for
> stuff to clean up we'll even be able to better comment the existing code.
> Any other features people would like to get rid of? Any comments or
> suggestions? I'd love to start a good discussion about this going so please
> send me your 2 cents.
>


  I surely agree that cleaning up old stuff is very important, but please 
agree that one of the strenghts of Linux is that you don't need so powerfull 
or so advanced hardware to do the jobs, as some commercial alternatives 
require, you can reuse some hardware that would be otherwise obsolete, so YOU 
SAVE SOME BUCKS.
   As a student, Radio Amateur and Electronics entusiast, many times I have 
to rely on old and surplus hardware since money resources are scarce. Linux 
lets me have fun, even with low resources. Thats the key to sucess IMO.

regards

  Claudio
