Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278892AbRJZTUI>; Fri, 26 Oct 2001 15:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278958AbRJZTTy>; Fri, 26 Oct 2001 15:19:54 -0400
Received: from femail37.sdc1.sfba.home.com ([24.254.60.31]:30198 "EHLO
	femail37.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S278892AbRJZTTn>; Fri, 26 Oct 2001 15:19:43 -0400
Message-ID: <3BD9B688.36E2F08C@home.com>
Date: Fri, 26 Oct 2001 15:16:24 -0400
From: John Gluck <jgluckca@home.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Deadlock with linux kernel
In-Reply-To: <Pine.LNX.4.33L.0110261537170.22127-100000@duckman.distro.conectiva> <3BD9AE9D.53D53936@resilience.com> <3BD9B066.57EDDDAB@welho.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

This is interesting. I've never had a lockup with any kernel.
I wonder if it might be related to the type of uses the machine is put to.

My machine is a Dual PIII based of the intel GX chipset. It serves as
Workstation primarily but also does firewalling and acts as a gateway for my
other PCs. Mostly the load isn't too heavy but I do crank it up a lot when I
compile KDE and have several parts building at the same time.

John


Mika Liljeberg wrote:

> Jeff Golds wrote:
> > No, it only hung just after boot one time.  However, I was doing a
> > kernel build when it hung (I was trying to make a new kernel to try out
> > as I had just rebooted).
> >
> > Most times, the machine will stay up for a day or two then lock during a
> > kernel build.
>
> Hi Jeff,
>
> I have the exact same symptoms on my PII SMP, 440BX chipset machine, and
> I believe it started around version 2.4.6 as you say. Prior to that, my
> machine would reboot randomly without warning. The latest kernel that
> neither reboots nor locks up is 2.4.0-test9. Sometimes it takes two
> hours, sometimes it takes two days, sometimes it takes longer.
>
> The machine just freezes solid, nothing appears on the console, sysrq
> won't work, leds won't blink, and I suspect the CPUs are spinning (I can
> hear the CPU fans pick up speed, when it happens). The lockups don't
> seem to have any relation to what the machine is doing at the time. An
> idle machine seems to lock up just as readily as a busy one.
>
> Regards,
>
>         MikaL
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

