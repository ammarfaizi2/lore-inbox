Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279998AbRJ3QWF>; Tue, 30 Oct 2001 11:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280001AbRJ3QVz>; Tue, 30 Oct 2001 11:21:55 -0500
Received: from [204.179.120.86] ([204.179.120.86]:253 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S279998AbRJ3QVo>;
	Tue, 30 Oct 2001 11:21:44 -0500
User-Agent: Microsoft-Outlook-Express-Macintosh-Edition/5.02.2022
Date: Tue, 30 Oct 2001 08:22:17 -0800
Subject: Re: Nasty suprise with uptime
From: Laurent de Segur <ldesegur@mac.com>
To: Linux kernel <linux-kernel@vger.kernel.org>
Message-ID: <B80413B9.9235%ldesegur@mac.com>
In-Reply-To: <Pine.LNX.4.40.0110301030220.12319-100000@rc.priv.hereintown.net>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NTP? Oh, this thing I once installed and that was hanging my machine at boot
time for a couple of minutes until it timed out when my laptop was not
connected to the network?
Thanks, but no thanks.

Laurent

> From: Chris Meadors <clubneon@hereintown.net>
> Date: Tue, 30 Oct 2001 10:56:30 -0500 (EST)
> To: bert hubert <ahu@ds9a.nl>
> Cc: Linux kernel <linux-kernel@vger.kernel.org>
> Subject: Re: Nasty suprise with uptime
> 
> On Tue, 30 Oct 2001, bert hubert wrote:
> 
>> Having huge uptimes is by the way not adviseable operational policy
>> according to many. Chances are you will be in for a nasty surprise when you
>> reboot - do you remember after a year which daemons you 'started by hand'
>> and how?
> 
> While this isn't exactly on topic for l-k, I just thought that I would
> share my recent pain as it does fit in this thread.
> 
> I had a box that I inherited.  It just did its job.  Actually most of my
> co-workers didn't even know which box performed this function, and when
> they saw the physical box, they didn't know what it did.
> 
> It was running a 2.0.x kernel.  One day after running for a long time (I'm
> guessing close to 500 days) it just went wacky.  I tried getting into the
> machine by ssh, but nothing was really working right at all.  So I figured
> a reboot was in order.
> 
> This was a crappy 486/66, with no reset button.  So a power cycle was
> called for.  When I started the machine back up, it did the file system
> has not been checked in a long time thing, and it started the fsck.
> 
> After a bit I saw read errors start to spew to the screen, tons of bad
> blocks.  Then the machine squealed for a few seconds, clicked, and then
> all was silent, except for the steady stream of errors on the console.
> 
> A second power cycle confermed what I already knew.  The BIOS reported a
> failure in the disk controller (the drive would spin up for 2 seconds
> squeal and click a little bit as it spun back down).
> 
> This machine was configured to do a task, just forward messages to a
> paging terminal.  It's configuration was never changed.  It had a one of
> those floppy-tape drives in it.  I knew were the backup tape was, it was
> made 3 years ago when the machine was first put into action.
> 
> Of course the tape was unreadble at this point.  So the installation and
> configuration was recreated from my memory.  Luckly I have a good memory,
> but it did take me 2 days to get everything running right again.
> 
> So the moral of the story is.  Reboot every-so-often.  Set your fsck to
> run at around 2 months, x number of reboots is good too.  I like to
> stagger my partitions with 5 reboots between each, even on journaled
> filesystems.  And verify your backups even if the machine isn't changing.
> 
> I usually follow those rules, but the cute little 486 in the corner with
> the 240MB hard drive, 16MB of RAM, and the monster uptimes was just too
> much fun to brag about.  I'm not bragging anymore, and it is disassembled
> on the floor in my office.
> 
> -Chris
> -- 
> Two penguins were walking on an iceberg.  The first penguin said to the
> second, "you look like you are wearing a tuxedo."  The second penguin
> said, "I might be..."                         --David Lynch, Twin Peaks
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

