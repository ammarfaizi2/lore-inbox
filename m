Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278701AbRKHXJE>; Thu, 8 Nov 2001 18:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278789AbRKHXIy>; Thu, 8 Nov 2001 18:08:54 -0500
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:26433 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S278755AbRKHXIq>; Thu, 8 Nov 2001 18:08:46 -0500
Posted-Date: Thu, 8 Nov 2001 23:00:21 GMT
Date: Thu, 8 Nov 2001 23:00:20 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: Pavel Machek <pavel@suse.cz>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Linux updates RTC secretly when clock synchronizes
In-Reply-To: <20011108132639.A14160@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.21.0111082252500.14996-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel.

>>>> least as KERN_DEBUG if not as KERN_NOTICE) whenever the RTC is
>>>> written to. It's too important a subsystem to be left hidden like
>>>> it currently is.

>>> This can be as well done in userland, enforced by whoever does rtc
>>> writes, no?

>> If some idiot writes a hwclock replacement that doesn't do logging...

> Then it is *his* problem. That's no excuse for putting it into kernel.

So you believe viruses are a good thing to have? Sorry, I have to
disagree with you.

Take the position of a sysadmin who can't understand why the system
clock on his computer keeps getting randomly changed under Linux, and
has verified using another operating system that it isn't a hardware
problem, then ask yourself what said sysadmin would expect from the
kernel to help him/her track the problem down. Would said sysadmin
prefer to be told...

 1. "Look in the system log - you'll get a message every time any
    program writes to the RTC."

 2. "Sorry, you'll have to go through every piece of software on
    your system and find the one that's updating the system clock
    that shouldn't be."

According to your comments, you prefer (2). I most definitely prefer (1).

Best wishes from Riley.

