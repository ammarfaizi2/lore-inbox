Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267527AbUBSUD4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 15:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267532AbUBSUD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 15:03:56 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:21381 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267527AbUBSUDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 15:03:50 -0500
Date: Thu, 19 Feb 2004 12:04:49 -0800
To: linux-kernel@vger.kernel.org
Subject: Re: Hot kernel change
Message-ID: <20040219200449.GC5916@hockwold.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <12608.62.229.71.110.1077197623.squirrel@webmail.r3pek.homelinux.org> <Pine.LNX.4.53.0402190845440.30037@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0402190845440.30037@chaos>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Jim Richardson <warlock@eskimo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 09:05:25AM -0500, Richard B. Johnson wrote:
>On Thu, 19 Feb 2004, Carlos Silva wrote:
>
>> hi,
>>
>> i would like to know if isn't it possible to implement a hot kernel
>> change, i mean, without reboot. i would do it myself if i had the knoledge
>> to do it but i'm starting with kernel-level programing now. i think it
>> would be possible if we make something like M$'s OS do when it hibernates,
>> copy all the memory, registers, etc to the disc and then put all back
>> again.
>>
>> am i dreaming or this is possible? :)
>>
>> Greetings,
>>
>> Carlos "r3pek" Silva
>
>Sure it's possible. However, you can't change to a new kernel this
>way because the addresses of the hardware devices like the PCI bus
>devices may change with a new kernel. Since the displacements of
>the kernel's internal workings will change with a new version, there
>would need to be considerable work done in re-designing the kernel
>so that it wouldn't matter.
>
>The best you can do, right now, is reload the same kernel. It
>will take about as much time as a reboot, so why bother? Oh, you
>intend to keep the same processes running, do you? You expect to
>be writing a letter in X-windows and hit the reset switch, magically
>returning to the same state after the machine has a new kernel
>installed? Well, well-written software is indistinguishable from
>magic, but first you need to find out how to make time run back-
>wards because, at the very least, the new kernel will be installed
>in the future which means many things will have changed (like
>network IP addresses, dynamic routes, remote file discriptors, etc.)
>Sounds like a neat project for a College Student who wants to
>learn to solve problems they haven't even dreamed of yet.
>


What you could do, is use MkLinux, (is that still around?) It had the
ability to run simultaneous kernels, IIRC, then you might be able to
gradually push over new processess to the new kernel, and eventually,
kill the old one. It's been quite a while since I used MkLinux, on PPC
for what it matters, and I could be remembering wrong...


-- 
Jim Richardson     http://www.eskimo.com/~warlock
"Microsoft Wheel.  Now with 8 sides for a smoother ride."
	-- The Ghost in the Machine, in COLA
