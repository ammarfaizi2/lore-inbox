Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278839AbRJZS4m>; Fri, 26 Oct 2001 14:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278840AbRJZS4d>; Fri, 26 Oct 2001 14:56:33 -0400
Received: from cs181145.pp.htv.fi ([213.243.181.145]:4224 "EHLO
	cs181145.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S278839AbRJZS4W>; Fri, 26 Oct 2001 14:56:22 -0400
Message-ID: <3BD9B066.57EDDDAB@welho.com>
Date: Fri, 26 Oct 2001 21:50:14 +0300
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Golds <jgolds@resilience.com>
CC: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Deadlock with linux kernel
In-Reply-To: <Pine.LNX.4.33L.0110261537170.22127-100000@duckman.distro.conectiva> <3BD9AE9D.53D53936@resilience.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Golds wrote:
> No, it only hung just after boot one time.  However, I was doing a
> kernel build when it hung (I was trying to make a new kernel to try out
> as I had just rebooted).
> 
> Most times, the machine will stay up for a day or two then lock during a
> kernel build.

Hi Jeff,

I have the exact same symptoms on my PII SMP, 440BX chipset machine, and
I believe it started around version 2.4.6 as you say. Prior to that, my
machine would reboot randomly without warning. The latest kernel that
neither reboots nor locks up is 2.4.0-test9. Sometimes it takes two
hours, sometimes it takes two days, sometimes it takes longer.

The machine just freezes solid, nothing appears on the console, sysrq
won't work, leds won't blink, and I suspect the CPUs are spinning (I can
hear the CPU fans pick up speed, when it happens). The lockups don't
seem to have any relation to what the machine is doing at the time. An
idle machine seems to lock up just as readily as a busy one.

Regards,

	MikaL
