Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbVEUUzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVEUUzJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 16:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbVEUUzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 16:55:09 -0400
Received: from smtpout01-04.mesa1.secureserver.net ([64.202.165.79]:16337 "HELO
	smtpout01-04.mesa1.secureserver.net") by vger.kernel.org with SMTP
	id S261596AbVEUUzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 16:55:03 -0400
Message-ID: <428F9FEE.5000003@coyotegulch.com>
Date: Sat, 21 May 2005 16:54:06 -0400
From: Scott Robert Ladd <lkml@coyotegulch.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050512)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: False "lost ticks" on dual-Opteron system (=> timer twice as
 fast)
References: <200505081445.26663.bernd.paysan@gmx.de> <d93f04c705052112426ee35154@mail.gmail.com>
In-Reply-To: <d93f04c705052112426ee35154@mail.gmail.com>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Paysan <bernd.paysan@gmx.de> wrote:
>>I've recently set up a dual Opteron RAID server (AMD-8000-based Tyan
>>Thunder K8S Pro SCSI board, 2 246 Opterons, stepping 10). Kernel is a
>>modified 2.6.11.4-20a from SuSE 9.3 (SMP version, sure). The Opterons
>>are capable of changing the CPU frequency (between 1GHz and 2GHz).
>>
>>What I can't believe is that I'm the only one who has this problem.

Hendrik Visage wrote:
> I'll be delving deeper into this thread soon, but I'm seeing similar
> strangeness
> on a Athlon64 (rated:3G+ real:2009MHz clock), 2.6.11-r8 (gentoo), MSI
> K8N Neo Platinum.
> 
> ntp syncs time, then I start a couple of compiles, and I see ntp
> losing track of time, big jitter etc. (and the one time source is in
> on the local LAN syncing to the same remote servers). openntp I
> noticed it also.
> 
> What I have noticed in my dmesg output is that I see "lost timer ticks
> CPU Frequency change?" messages very early in the boot up.
> 
> I've seen this for about a week or three, and somehow I believe it
> wasn't a problem before 2.6.11.

I *don't* have any timer problems running 2.6.11-r8 (gentoo) on a dual
Opteron 250 system using a Tyan K8W 2885. Perhaps the problem is that
the two of you are running SCSI main drives, and I'm not?

..Scott

