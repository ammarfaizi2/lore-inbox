Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268132AbRGWDkc>; Sun, 22 Jul 2001 23:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268135AbRGWDkM>; Sun, 22 Jul 2001 23:40:12 -0400
Received: from h-216-81-19-022.fast.escape.ca ([216.81.19.22]:2052 "EHLO
	black.pepper") by vger.kernel.org with ESMTP id <S268132AbRGWDkF>;
	Sun, 22 Jul 2001 23:40:05 -0400
Date: Sun, 22 Jul 2001 22:41:57 -0500 (CST)
From: Daryl F <wyatt@escape.ca>
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.4.6/2.4.7 won't boot ASUS P2-99B
In-Reply-To: <Pine.LNX.4.10.10107220652230.26397-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.32.0107222240030.5430-100000@black.pepper>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Thanks for the suggestions. I should have thought of that first, but
downgrading the CPU didn't help. Turned out to be my use of old devfs
debug options in my lilo configuration when I hadn't configured the kernel
for them.

Daryl.

On Sun, 22 Jul 2001, Mark Hahn wrote:

> > I am at an impasse. I can't get kernel 2.4.6 or 2.4.7 to boot on my ASUS
> > P2-99B. 2.4.5 works fine. Right after I select the boot image from LILO,
>
> very mundane hardware, works for lots of other people.
>
> > message. The screen flashes like it has changed video modes, then the
> > system just reboots itself.
>
> what things do you have configured into your kernel?
> for instance, the framebuffer?  ACPI?
>
> > three different compilers: GCC 2.95.2, GCC 3.0, and EGCS 1.1.2 since my
> > usual GCC 2.95.2 compiler has a caveat in the kernel documentation.
>
> including downgrading your CPU-related CONFIG to 386?
>
>

