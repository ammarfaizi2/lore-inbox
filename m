Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267553AbUBSU0j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 15:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267555AbUBSU0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 15:26:39 -0500
Received: from a213-22-30-111.netcabo.pt ([213.22.30.111]:16608 "EHLO
	r3pek.homelinux.org") by vger.kernel.org with ESMTP id S267553AbUBSU03
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 15:26:29 -0500
Message-ID: <30562.62.229.71.110.1077222343.squirrel@webmail.r3pek.homelinux.org>
In-Reply-To: <20040219200449.GC5916@hockwold.net>
References: <12608.62.229.71.110.1077197623.squirrel@webmail.r3pek.homelinux.org>
    <Pine.LNX.4.53.0402190845440.30037@chaos>
    <20040219200449.GC5916@hockwold.net>
Date: Thu, 19 Feb 2004 20:25:43 -0000 (WET)
Subject: Re: Hot kernel change
From: "Carlos Silva" <r3pek@r3pek.homelinux.org>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Feb 19, 2004 at 09:05:25AM -0500, Richard B. Johnson wrote:
>>On Thu, 19 Feb 2004, Carlos Silva wrote:
>>
>>> hi,
>>>
>>> i would like to know if isn't it possible to implement a hot kernel
>>> change, i mean, without reboot. i would do it myself if i had the
>>> knoledge
>>> to do it but i'm starting with kernel-level programing now. i think it
>>> would be possible if we make something like M$'s OS do when it
>>> hibernates,
>>> copy all the memory, registers, etc to the disc and then put all back
>>> again.
>>>
>>> am i dreaming or this is possible? :)
>>>
>>> Greetings,
>>>
>>> Carlos "r3pek" Silva
>>
>>Sure it's possible. However, you can't change to a new kernel this
>>way because the addresses of the hardware devices like the PCI bus
>>devices may change with a new kernel. Since the displacements of
>>the kernel's internal workings will change with a new version, there
>>would need to be considerable work done in re-designing the kernel
>>so that it wouldn't matter.
>>
>>The best you can do, right now, is reload the same kernel. It
>>will take about as much time as a reboot, so why bother? Oh, you
>>intend to keep the same processes running, do you? You expect to
>>be writing a letter in X-windows and hit the reset switch, magically
>>returning to the same state after the machine has a new kernel
>>installed? Well, well-written software is indistinguishable from
>>magic, but first you need to find out how to make time run back-
>>wards because, at the very least, the new kernel will be installed
>>in the future which means many things will have changed (like
>>network IP addresses, dynamic routes, remote file discriptors, etc.)
>>Sounds like a neat project for a College Student who wants to
>>learn to solve problems they haven't even dreamed of yet.
>>
>
>
> What you could do, is use MkLinux, (is that still around?) It had the
> ability to run simultaneous kernels, IIRC, then you might be able to
> gradually push over new processess to the new kernel, and eventually,
> kill the old one. It's been quite a while since I used MkLinux, on PPC
> for what it matters, and I could be remembering wrong...
>

well, that's what i had in mind... if this could be possible under x86
would be great. i say x86 'cause for what a read, MkLinux looks like a
MacLinux Distribution, correct me if i am wrong.
like i said in the first place, i don't program for the kernel (yet, i
intend to), so i don't know what are the big/small changes that have to be
made for somthing like this to work. but i would really like to see this
working :D
